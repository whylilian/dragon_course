# -*- coding:UTF-8 -*-

from django.urls import path

from . import views

urlpatterns = [
    path('', views.Student_login, name='student_login'),
    path('getstudentstatus', views.GetStudentStatus, name='getStudentStatus'),
    path('getrank', views.Student_rank, name='getrank'),
    path('checkspell', views.Check_spell, name='checkspell'),
    path('wordbook', views.Word_book, name='workbook'),
    path('studystatus', views.Study_status, name='studystatus'),
    path('matchcommit', views.Match_commit, name='matchcommit'),
    path('matchuncommit', views.Match_uncommit, name='matchuncommit'),
    path('creatematch', views.Create_match, name='creatematch'),
    path('learnstatistics', views.Learn_statistics, name='learnstatistics'),
    path('matchmessage', views.Match_message, name='matchmessage'),
    path('studentlist', views.Student_list, name='studentlist'),
    path('changepassword', views.Change_password, name='changepassword'),
    path('studycensus', views.Study_census, name='studycensus'),
]