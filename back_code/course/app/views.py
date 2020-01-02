

from django.shortcuts import render
from app.models import *
from django.http import JsonResponse
# Create your views here.

#处理学生登录请求，匹配账户和密码
def Student_login(request):
    try:
        username = request.POST.get('student_username')
        password = request.POST.get('student_password')
        print(username)
        print(password)
        student = Student.objects.get(student_username=username)
        print(student.student_name)
        data = {}
        data['student_id'] = student.student_id
        data['student_name'] = student.student_name
    except Student.DoesNotExist:
        print('发生异常')
    else:
        if student.student_username==username and student.student_password==password:
            data['login_status'] = 'succeed'
            return JsonResponse(data, safe=False)
        else:
            data['login_status'] = 'failed'
            return JsonResponse(data, safe=False)

#获取学生的学习状态
def GetStudentStatus(request):
    try:
        student_id = int(request.POST.get('student_id'))
        student = Student.objects.get(student_id=student_id)
        study_status = student.study_status
        data = {}
        data['study_status'] = study_status
    except Student.DoesNotExist:
        print('发生异常')
    else:
        return JsonResponse(data, safe=False)

#获取排行榜信息
def Student_rank(request):
    students = Student.objects.all()
    coin_rank = {}
    for item in students:
        coin_rank[item.student_name] = item.coins
    coins_rank = dict(sorted(coin_rank.items(),key = lambda kv:(kv[1],kv[0]), reverse = True))

    word_rank = {}
    for item in students:
        word_rank[item.student_name] = item.word_numbers
    words_rank = dict(sorted(word_rank.items(),key = lambda kv:(kv[1],kv[0]), reverse = True))

    point_rank = {}
    for item in students:
        point_rank[item.student_name] = item.points
    points_rank = dict(sorted(point_rank.items(),key = lambda kv:(kv[1],kv[0]), reverse = True))

    # 返回给前端一个字典，字典中包括三个排行，每个排行的键值是字典，按照金币数、单词量、积分进行倒序排序。
    return JsonResponse({'coin_rank':coins_rank, 'word_rank':words_rank, 'point_rank':points_rank})

#返回单词本数据
def Word_book(request):
    # order = request.POST.get('review_order')
    # studentid = request.POST.get('student_id')
    # order = 'letter'
    order = 'familiarity'
    studentid = 1

    words = Words.objects.all()
    word_rank = {}
    for item in words:
        studentword = StudentWords.objects.get(student_id = studentid, words_id = item.word_id)
        word_rank[item.word] = studentword.counts/studentword.value

    wordrank = {}
    if order == 'familiarity':
        wordrank = dict(sorted(word_rank.items(), key= lambda kv:(kv[1],kv[0])))
    elif order == 'letter':
        for i in sorted(word_rank):
            wordrank[i] = word_rank[i]

    for key,value in wordrank.items():
        if value == 0:
            wordrank[key] = 1
        elif value == 1:
            wordrank[key] = 3
        else:
            wordrank[key] = 2

    return JsonResponse(wordrank)


#单词拼写检测
def Check_spell(request):
    # wordid = request.POST.get('word_id')
    # spell = request.POST.get('spell')
    # studentid = request.POST.get('student_id')
    wordid = 1
    spell = 'question'
    studentid = 1
    word = Words.objects.get(word_id = wordid)
    student_word = StudentWords.objects.get(student_id = studentid,words_id = wordid)

    if word.word == spell:
        if student_word.counts < student_word.value:
            student_word.counts += 1
            student_word.save()
        # 返回正确的单词（键）和是否正确中文（键值）
        return JsonResponse({word.word:"正确"},json_dumps_params={'ensure_ascii':False})
    else:
        if student_word.counts > 0:
            student_word.counts -= 1
            student_word.save()
        return JsonResponse({word.word:"错误"},json_dumps_params={'ensure_ascii':False})

#获取学生学习状态
def Study_status(request):
    # studentid = request.POST.get('student_id')
    studentid = 1
    student = Student.objects.get(student_id = studentid)
    return JsonResponse({'status':student.study_status}) 