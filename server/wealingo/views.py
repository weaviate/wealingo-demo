from django.shortcuts import get_object_or_404,render
from django.views.decorators.csrf import csrf_exempt
from django.http import HttpResponse,JsonResponse
from .models import Questions_Inventory, Leaderboard, User_Profile, UserQuiz, User_Questions
from django.db import DatabaseError
from .serializer import serialize_questions, serialize_leaderboard
from .weaviate import perform_search, generate_text_with_prompt
from .util import create_prompt

import logging
import json
import random

logger = logging.getLogger(__name__)

def index(request):
    return HttpResponse("Hello, world. You're at the wealingo simple page.")

def questionsForCategory(request, query):
    try:
        latest_question_list = Questions_Inventory.objects.filter(category=query, 
                                                                difficulty_rating__in=[1,2]).order_by("-created_at")[:5]
        results = {
            "questions" : serialize_questions(latest_question_list)
        }
    except Exception as e:
        logger.error(f"An error occurred: {str(e)}")
    return JsonResponse(results, status=200)

def quizForLevel(request, level):
    if level == 2:
        questions = Questions_Inventory.objects.filter(difficulty_rating__lt=3).order_by('-created_at')[:5]
    elif level == 4:
        questions = Questions_Inventory.objects.filter(difficulty_rating__in=[3, 4]).order_by('-created_at')[:5]
    else:
        questions = Questions_Inventory.objects.filter(difficulty_rating__gte=5).order_by('-created_at')[:5]
    results = {
        "questions" : serialize_questions(questions)
    }
    return JsonResponse(results, status=200)


@csrf_exempt 
def createUser(request):
    if request.method == 'POST':
        try:
            data = json.loads(request.body)
        except json.JSONDecodeError:
            return JsonResponse({"error": "Invalid JSON"}, status=400)        
        username = data.get('username')   
        email = data.get('email') 
        if username is None or email is None:
            return JsonResponse({"error": "username and email are required"}, status=400)

        try:
            user_profile, created = User_Profile.objects.get_or_create(username=username, email=email)

            return JsonResponse({"message": "User updated successfully", 
                                 "username": user_profile.username,
                                 "email": user_profile.email,
                                 'userID': user_profile.user_id}, status=200)
        
        except DatabaseError as e:
            logger.error(f"DatabaseError while creating user : {str(e)}")
            return JsonResponse({"error": "DB error when creating user"})
        except Exception as e:
            logger.error(f"An error occurred: {str(e)}")
            return JsonResponse({"error": "Exception when creating user"})
    else:
        logger.error('error method')
    return HttpResponse(status=405) 

@csrf_exempt 
def submitScore(request):
    if request.method == 'POST':
        try:
            data = json.loads(request.body)
        except json.JSONDecodeError:
            return JsonResponse({"error": "Invalid JSON"}, status=400)        
        user_id = data.get('user_id')
        new_score = data.get('totalScore')
        responses = data.get('responses')
        
        if user_id is None or new_score is None:
            return JsonResponse({"error": "user_id and totalScore are required"}, status=400)
        user_profile = get_object_or_404(User_Profile, pk=user_id)
        logger.info(user_profile)
        leaderboard_entry, created = Leaderboard.objects.get_or_create(
                                        user_id=user_profile,
                                        defaults={'xp': new_score} 
                                    )
        if not created:
            leaderboard_entry.xp = F('xp') + new_score
            leaderboard_entry.save()
            leaderboard_entry.refresh_from_db()
        if created:
            leaderboard_entry.save()
            
        userQuestionResponses = []    
        for userQuestion in responses:             
            userQuestionResponses.append(
                UserQuiz(question_id=userQuestion['question_id'],
                                    correct_answer = userQuestion['isCorrect'],
                                    category = userQuestion.get('category', ""),
                                    user_id=user_id))
        created_questions = UserQuiz.objects.bulk_create(userQuestionResponses)    
        return JsonResponse({"message": "Score updated successfully", "new_total_xp": leaderboard_entry.xp})
    else:
        logger.info('error method')
    return HttpResponse(status=405) 

def showLeaderBoard(request):
    latest_leaderboard = Leaderboard.objects.select_related('user_id').order_by('-xp')[:15]
    results = {
        "leaderboard" : serialize_leaderboard(latest_leaderboard)
    }
    return JsonResponse(results, status=200)        

@csrf_exempt 
def generate_questions(request):
    if request.method == 'POST':
        try:
            data = json.loads(request.body)
        except json.JSONDecodeError:
            return JsonResponse({"error": "Invalid JSON"}, status=400)        
        userID = data.get('user_id', None)
        query = data.get('query', None)
        logger.debug(userID)
        userQuizQuestions = []
        
        if userID:
            try:
                user_profile = User_Profile.objects.get(pk=userID)
                userQuizQuestions = _getQuestions(userID)
            except User_Profile.DoesNotExist:
                user_profile = None
        else:
            user_profile = None        
        
        prompt = create_prompt(userQuizQuestions, query)    
        try:
            response = generate_text_with_prompt(prompt, query=query)
            questions = []
            for question in response:             
                questions.append(
                    Questions_Inventory(question_text=question['question'],
                                        options = question.get('options', ""),
                                        question_type=question.get('question_type', "standard question"),
                                        answer=question['answer'],
                                        difficulty_rating=question.get('difficulty_rating', ""),
                                        category=question.get('category', ""),
                                        instruction=question.get('instruction', "")))
            logger.debug(questions)
            
            with transaction.atomic():
                created_questions = Questions_Inventory.objects.bulk_create(questions)
                if user_profile is not None:
                    user_questions = [
                        User_Questions(question=question, user=user_profile) for question in created_questions
                    ]
                    User_Questions.objects.bulk_create(user_questions)
            
            results = {
                "questions" : response
            }
            logger.debug(response)
            return JsonResponse(results, status=200)
        except Exception as e:
            print(e)
            return JsonResponse({"error": str(e)}, status=500)
 
 
def _getQuestions(userID):
    questions = []
    userQuiz = UserQuiz.objects.filter(user_id=userID).order_by("-created_at")[:5]
    if userQuiz.exists():
        question_ids = userQuiz.values_list('question_id', flat=True)
        questions = Questions_Inventory.objects.filter(question_id__in=question_ids)
    serialized = serialize_questions(questions)
    return serialized          

def search(request, query):    
    try:
        questions = perform_search(query, near_text="")
        results = {
            "questions" : questions
        }
        return JsonResponse(results)
    except Exception as e:
        return JsonResponse({"error": str(e)}, status=500)