

from django.shortcuts import render
from app.models import *
from django.http import JsonResponse
# Create your views here.

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
        