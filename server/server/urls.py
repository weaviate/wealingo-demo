from django.contrib import admin
from django.urls import include, path

urlpatterns = [
    path("admin/", admin.site.urls),
    path("wealingo/v1/", include("wealingo.urls")),
    
    
]
