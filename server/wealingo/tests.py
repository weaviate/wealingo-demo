from django.test import TestCase, RequestFactory
from .models import Questions_Inventory, User_Profile, Leaderboard
from .util import create_prompt
from .views import generate_questions
from django.urls import reverse
import json
import uuid

class QuestionsInventoryTests(TestCase):

    def setUp(self):
        self.qCatergoryID = uuid.uuid4()
        self.qID = uuid.uuid4()  
        self.quizID = uuid.uuid4()
        self.userID = uuid.uuid4()
        self.userID2 = uuid.uuid4()
        self.factory = RequestFactory()    
        self.question = Questions_Inventory.objects.create(question_id=self.qID, 
                                                           category='Navigate a City',
                                                           answer="yes no", 
                                                           options="yes",
                                                           question_text="Good Morning",
                                                           instruction="instr",
                                                           difficulty_rating=2,
                                                           question_type='fill in the blank')
        self.question2 = Questions_Inventory.objects.create(question_id=uuid.uuid4(), 
                                                           category='Order in a restaurant',
                                                           answer="yes no", 
                                                           options="yes",
                                                           question_text="Appetizer",
                                                           instruction="instr",
                                                           difficulty_rating=2,
                                                           question_type='fill in the blank')
        self.question3 = Questions_Inventory.objects.create(question_id=uuid.uuid4(), 
                                                           category='Order in a restaurant',
                                                           answer="bring food", 
                                                           options="yes",
                                                           question_text="Primo",
                                                           instruction="instr",
                                                           difficulty_rating=3,
                                                           question_type='translate')
        self.userProfile = User_Profile.objects.create(user_id=self.userID, 
                                               username="deepT",
                                               email="test.com")
        self.userProfile2 = User_Profile.objects.create(user_id=self.userID2, 
                                               username="deepTrouble",
                                               email="tester.com")
        # self.leaderboardID1 = uuid.uuid4()
        Leaderboard.objects.create(id=uuid.uuid4(), xp=20, user_id_id=self.userID)
        Leaderboard.objects.create(id=uuid.uuid4(), xp=25, user_id_id=self.userID2)

    def test_questions_all_response(self):
        url = reverse('questions_all', args=["Order in a restaurant"])
        response = self.client.get(url)
        self.assertEqual(response['Content-Type'], 'application/json')
        try:
            response_data = json.loads(response.content)
            # print(response_data)
        except json.JSONDecodeError as e:
            self.fail(f"JSON decode error: {e}")   

    def test_quiz_level(self):
        url = reverse("quiz_for_level", args=[2])
        print(url)
        response = self.client.get(url)
        self.assertEqual(response['Content-Type'], 'application/json')  
        try:
            response_data = json.loads(response.content)
            # print(response_data)
        except json.JSONDecodeError as e:
            self.fail(f"JSON decode error: {e}")   

    def test_create_user(self):
        data = {
            'username': 'deedee',
            'email' : 'test@er.com'
        }
        url = reverse("create_user") 
        response = self.client.post(url, data=json.dumps(data), content_type='application/json')
        self.assertEqual(response['Content-Type'], 'application/json')  
        try:
            response_data = json.loads(response.content)
            print(response_data)
        except json.JSONDecodeError as e:
            self.fail(f"JSON decode error: {e}")   

    def test_submit_score(self):
        responses = [{'question_id': str(self.qID), 'isCorrect': False}] 
        data = {
            'user_id': str(self.userID),
            'totalScore' : 12,
            'responses' : responses
        }
        url = reverse("submit_score") 
        response = self.client.post(url, data=json.dumps(data), content_type='application/json')
        self.assertEqual(response['Content-Type'], 'application/json')  
        try:
            response_data = json.loads(response.content)
            print(response_data)
        except json.JSONDecodeError as e:
            self.fail(f"JSON decode error: {e}")    

    def test_show_leaderboard(self):
        url = reverse('show_leaderboard')
        print(url)
        response = self.client.get(url)
        self.assertEqual(response['Content-Type'], 'application/json')  
        try:
            response_data = json.loads(response.content)
            print(response_data)
        except json.JSONDecodeError as e:
            self.fail(f"JSON decode error: {e}")   