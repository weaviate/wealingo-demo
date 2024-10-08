from django.db import models
from django.contrib.postgres.fields import ArrayField
import uuid

class User_Profile(models.Model):
    user_id = models.UUIDField(
        primary_key=True,  
        default=uuid.uuid4,  
        editable=False  
    )
    username = models.CharField(max_length=200)
    email = models.CharField(max_length=100)

class Questions_Inventory(models.Model):
    question_id = models.UUIDField(
        primary_key=True,  
        default=uuid.uuid4,  
        editable=False  
    )
    category = models.CharField(max_length=300)
    question_text = models.CharField(max_length=200)
    options = models.CharField(max_length=500, null=True, blank=True)
    question_type = models.CharField(max_length=200)
    answer = models.CharField(max_length=500, null=True, blank=True)
    instruction = models.CharField(max_length=1000, null=True, blank=True)
    difficulty_rating = models.IntegerField()
    file_path = models.CharField(max_length=500, null=True, blank=True)
    created_at = models.DateTimeField(auto_now_add=True)

    def getQuestion(self, id):
        return self.question_id

class User_Questions(models.Model):
    user_question_id = models.UUIDField(
        primary_key=True,  
        default=uuid.uuid4,  
        editable=False  
    )
    question = models.ForeignKey(Questions_Inventory, on_delete=models.DO_NOTHING)
    user = models.ForeignKey(User_Profile, null=True, blank=True, on_delete=models.DO_NOTHING)
    created_at = models.DateTimeField(auto_now_add=True)

class UserQuiz(models.Model):
    id = models.UUIDField(
        primary_key=True,  
        default=uuid.uuid4,  
        editable=False  
    )
    question = models.ForeignKey(Questions_Inventory, on_delete=models.DO_NOTHING) 
    user = models.ForeignKey(User_Profile, null=True, blank=True, on_delete=models.DO_NOTHING)
    correct_answer = models.BooleanField()
    category = models.CharField(max_length=300, null=True, blank=True)
    created_at = models.DateTimeField(auto_now_add=True)


class Leaderboard(models.Model):
    id = models.UUIDField(
        primary_key=True,  
        default=uuid.uuid4,  
        editable=False  
    )
    user_id=models.ForeignKey(User_Profile, on_delete=models.DO_NOTHING)
    xp=models.IntegerField()
