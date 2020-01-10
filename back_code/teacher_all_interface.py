# 教师:教师登录
def Teacher_login(request):
    try:
        # username = request.POST.get('teacher_username')
        # password = request.POST.get('teacher_password')
        username = 'test2'
        password = '123'
        data = {}
        teacher = Teacher.objects.get(teacher_username=username)
        data['teacher_id'] = teacher.teacher_id
        data['teacher_name'] = teacher.teacher_name
    except Teacher.DoesNotExist:
        data['login_status'] = 'error：用户名或密码错误'
        return JsonResponse(data, safe=False,json_dumps_params={'ensure_ascii':False})
    else:
        if student.student_password == password:
            data['login_status'] = 'succeed'
            return JsonResponse(data, safe=False,json_dumps_params={'ensure_ascii':False})
        else:
            data['login_status'] = '登录失败：用户名或密码错误'
            return JsonResponse(data, safe=False,json_dumps_params={'ensure_ascii':False})

# 教师:教师修改密码
def Teacher_changepsw(request):
    # 存取控制
    # teacherid = request.POST.get('student_id')
    # oldpassword = request.POST.get('old_password')
    # newpassword = request.POST.get('new_password')
    teacherid = 2
    oldpassword = '456'
    newpassword = '374563'
    teacher = Teacher.objects.get(teacher_id = teacherid)
    data = {}
    if teacher.teacher_password == oldpassword:
        teacher.teacher_password = newpassword
        teacher.save()
        data['change_status'] = 'succeed'
        return JsonResponse(data,safe = False)
    else:
        data['change_status'] = 'failed'
        return JsonResponse(data,safe = False)

# 教师:教师详细信息
def Teacher_message(request): 
    # teacher_id = request.POST.get('teacher_id')
    teacher_id = 1
    teacher = Teacher.objects.get(teacher_id = teacher_id)
    courses_id = teacher.courses_id.split('|')
    data = {
        "用户id":teacher.teacher_id,
        "用户名":teacher.teacher_username,
        "教师姓名":teacher.teacher_name,
        "教师性别":teacher.teacher_sex,
        "教师年龄":teacher.teacher_age,
        "教师电话":teacher.teacher_phone,
        "教师住址":teacher.teacher_address,
        "所带班级ID列表":courses_id
    }
    return JsonResponse(data,json_dumps_params={'ensure_ascii':False})

# 教师:创建比赛
def Create_match(request):
    name = request.POST.get('match_name')
    matchpoint = request.POST.get('match_point')
    # name = "一站到底"
    # matchpoint = 100
    bookname = request.POST.get('book_id')

    category = Category.objects.get(category_id = book_id)
    wordids = Classification.objects.filter(
        category_id = category.category_id).order_by('word_id').values('word_id')

    words = str()
    for item in wordids:
        words = words + '|' +str(item['word_id'])
    words = words[1:]
    
    teacherid = request.POST.get('teacher_id')
    # teacherid = 2
    teacher = Teacher.objects.get(teacher_id = teacherid)
    teachername = teacher.teacher_name
    starttime = request.POST.get('start_time').strftime("%Y-%m-%d %H:%M:%S")
    endtime = request.POSt.get('end_time').strftime("%Y-%m-%d %H:%M:%S")
    matchtime = request.POST.get('match_time').strftime("%Y-%m-%d %H:%M:%S")
    # starttime = "2020-01-01 15:09:17"
    # endtime = "2020-01-01 15:09:17"
    # matchtime = "00:10:00"
    m = Match(
        match_name = name, 
        match_point = matchpoint,
        words_id = words,
        teacher_id = teacherid,
        teacher_name = teachername,
        start_time = starttime,
        end_time = endtime,
        match_time = matchtime
    )
    m.save()
    data = {}
    data['status'] = 'succeed'
    return JsonResponse(data,safe = False)

# 教师:学生名册
def Student_list(request):
    # course_id = request.POST.get('course_id')
    course_id = 1
    course = Course.objects.get(course_id = course_id)
    students = Student.objects.filter(course_id = course_id)
    student_message = {}
    i = 1
    for item in students:
        student_message[i] = {
            'student_name':item.student_name,
            'email':item.email,
            'coins':item.coins,
            'last_login':item.lastlogin_time,
            'student_id':item.student_id,
            'course_name':course.course_name,
            "所在组":'xfinit',
            'register_time':'2020-1-3 16:46:30',
            'status':"付费"
        }
        i = i + 1
    return JsonResponse(student_message,json_dumps_params={'ensure_ascii':False})

# 教师:班级列表
def Course_list(request):
    # teacherid = request.POST.get('teacher_id')
    teacherid = 2
    teacher = Teacher.objects.get(teacher_id = teacherid)
    courses = teacher.courses_id.split('|')
    courses_list = {}
    i = 1
    for item in courses:
        courseid = int(item)
        course = Course.objects.get(course_id = courseid)
        courses_list[i] = {
            'course_id':course.course_id,
            'course_name':course.course_name,
            'course_student_number':course.number
        }
    return JsonResponse(courses_list,json_dumps_params={'ensure_ascii':False})

# 教师:开通课程
def Open_book(request):
    # book_id = request.POST.get('book_id')
    # student_id = request.POST.get('student_id')
    book_id = 3
    student_id = 2
    data = {}
    student = Student.objects.get(student_id = student_id)
    # 获得该课程的单词书和开通状况
    books_id = student.books_id.split('|')
    enable = student.books_enable.split('|')
    for index,item in enumerate(books_id):
        if item == str(book_id):
            enable[index] = '1'
            student.books_enable = '|'.join(enable)
            student.save()
            data['status'] = 'open succeed'
            return JsonResponse(data)
    data['status'] = 'open fail'
    return JsonResponse(data)
   
# 教师:学习统计每个学生单词量
def Study_census(request):
    # course_id = request.POST.get('course_id')
    course_id = 1
    students = Student.objects.filter(course_id = course_id)
    student_words = {}
    i = 1
    for item in students:
        student_words[i] = {
            'word_number':item.word_numbers,
            'student_name':item.student_name
        }
        i = i + 1
    return JsonResponse(student_words,json_dumps_params={'ensure_ascii':False})

# 教师:比赛详细信息
def Teacher_match(request):
    # teacher_id = request.POST.get('teacher_id')
    teacher_id = 1
    matchs = Match.objects.filter(teacher_id = teacher_id)
    match_message = {}
    i = 1
    for item in matchs:
        match_message[i] = {
            'match_id':item.match_id,
            'match_name':item.match_name,
            'start_time':item.start_time.strftime("%Y-%m-%d %H:%M:%S"),
            'end_time':item.end_time.strftime("%Y-%m-%d %H:%M:%S"),
            'match_time':item.match_time,
            'join_number':'5000'
        }
        i = i + 1
    return JsonResponse(match_message,json_dumps_params={'ensure_ascii':False})

