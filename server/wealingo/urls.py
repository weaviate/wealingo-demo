from django.urls import path

from . import views

urlpatterns = [
    path("index", views.index, name="index"),
    path("questions/all/<str:query>", views.questionsForCategory, name="questions_all"),
    path("questions/create", views.generate_questions, name="generate_questions"),
    path("questions/search/<str:query>", views.search, name="search"),
    path("quiz/level/<int:level>", views.quizForLevel, name="quiz_for_level" ),
    path('quiz/score', views.submitScore, name='submit_score'),
    path('user/new', views.createUser, name='create_user'),
    path('leaderboard', views.showLeaderBoard, name='show_leaderboard')
]