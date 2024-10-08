import logging
import random

logger = logging.getLogger(__name__)

def serialize_users(users_mapping):
    serialized_users = []
    for user_id, user_info in users_mapping.items():
        logger.info(user_info)
        serialized_users.append({
            'id': user_id,
            'username': user_info['username'],
            'profile_pic':user_info['profile_pic'],
        })
    return serialized_users 

def serialize_leaderboard(leaderboard):
    serialize_leaderboard = []
    for position in leaderboard:
        serialize_leaderboard.append({
            'xp' : position.xp,
            'user_id' : str(position.user_id.user_id),
            'username' : position.user_id.username
        })
    return serialize_leaderboard    

def serialize_questions(questions):
    logger.info('in serialise questions')
    serialize_questions = []
    for question in questions:
        serialize_questions.append({
            'question_id': question.question_id,
            'question': question.question_text,
            'options': question.options,
            'instruction' : question.instruction,
            'difficulty_rating': question.difficulty_rating,
            'question_type': question.question_type,
            'answer' : question.answer,
            'file_path' : question.file_path,
            'category' : question.category
        })
    logger.debug(serialize_questions)    
    return serialize_questions
