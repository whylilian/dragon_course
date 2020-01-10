# -*- coding:UTF-8 -*-

from django.urls import path

from . import views

urlpatterns = [
    path('', views.Student_login, name='student_login'),
    path('getrank', views.Student_rank, name='getrank'),
    path('checkspell', views.Check_spell, name='checkspell'),
    path('wordbook', views.Word_book, name='workbook'),
    path('studystatus', views.Study_status, name='studystatus'),
    path('match', views.Match_show, name='match'),
    path('creatematch', views.Create_match, name='creatematch'),
    path('studentstatistics', views.Student_statistics, name='studentstatistics'),
    path('matchmessage', views.Match_message, name='matchmessage'),
    path('studentlist', views.Student_list, name='studentlist'),
    path('changepassword', views.Change_password, name='changepassword'),
    path('studycensus', views.Study_census, name='studycensus'),
    path('getbooks', views.Get_books, name='getbooks'),
    path('testall', views.Test_all, name='testall'),
    path('inputtest', views.Input_test, name='inputtest'),
    path('daka', views.daka, name='daka'),
    path('unit', views.Unit, name='unit'),
    path('wordpk', views.Word_pk, name='wordpk'),
    path('unitlearn', views.Unit_learn, name='unitlearn'),
    path('recall_word', views.Recall_word, name='recall_word'),
    path('beforetestgrade', views.Beforetest_grade, name='beforetestgrade'),
    path('enablejoin', views.Enable_join, name='enablejoin'),
    path('joinmatch', views.Join_match, name='joinmatch'),
    path('inputmatch', views.Input_match, name='inputmatch'),
    path('gonggutest', views.Consolidate_test, name='gonggutest'),
    # 
    path('teacherlogin', views.Teacher_login, name='teacherlogin'),
    path('teacherchange', views.Teacher_changepsw, name='teacherchange'),
    path('teachermessage', views.Teacher_message, name='teachermessage'),
    path('courselist', views.Course_list, name='courselist'),
    path('studentlist', views.Student_list, name='studentlist'),
    path('openbook', views.Open_book, name='openbook'),
]