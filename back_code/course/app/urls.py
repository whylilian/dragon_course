# -*- coding:UTF-8 -*-

from django.urls import path

from . import views

urlpatterns = [
    path('', views.Student_login, name='student_login'),
    
]