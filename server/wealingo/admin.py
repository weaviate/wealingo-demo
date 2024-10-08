from django.contrib import admin

from .models import Questions_Inventory, User_Profile, Leaderboard

import logging

logger = logging.getLogger(__name__)

admin.site.register(Questions_Inventory)
admin.site.register(User_Profile)
admin.site.register(Leaderboard)