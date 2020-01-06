# -*- coding:UTF-8 -*-

from django.shortcuts import render
from app.models import *
from django.http import JsonResponse
import random
# Create your views here.

#处理学生登录请求，匹配账户和密码
def Student_login(request):
    try:
        username = request.POST.get('student_username')
        password = request.POST.get('student_password')
        print(username)
        print(password)
        data = {}
        student = Student.objects.get(student_username = username)
        print(student.student_name)
        data['student_id'] = student.student_id
        data['student_name'] = student.student_name
        data['coins'] = student.coins
    except Student.DoesNotExist:
        print('用户名不存在')
        data['login_status'] = 'not_exist'
        return JsonResponse(data, safe=False)
    else:
        if student.student_username==username and student.student_password==password:
            data['login_status'] = 'succeed'
            return JsonResponse(data, safe=False)
        else:
            data['login_status'] = 'failed'
            return JsonResponse(data, safe=False)

#获取学生的学习状态
def Study_status(request):
    try:
        student_id = request.POST.get('student_id')
        student = Student.objects.get(student_id = student_id)
        course = Course.objects.get(course_id = student.course_id)
        data = {}
        data['study_status'] = student.study_status
        data['course_name'] = course.course_name
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
    return JsonResponse({'coin_rank':coins_rank, 'word_rank':words_rank, 'point_rank':points_rank}, json_dumps_params={'ensure_ascii':False})

# 学生单词本
def Word_book(request):
    order = request.POST.get('order')
    student_id = request.POST.get('student_id')

    # 先获得学生的所有单词
    student_words = StudentWords.objects.filter(student_id = student_id)
    words = {}
    for item in student_words:
        word = Words.objects.get(word_id = item.words_id)
        words[word.word] = item.counts/item.value
    # 根据排序方式进行排序
    word_rank = {}
    if order == 'familiarity':
        word_rank = dict(sorted(words.items(), key= lambda kv:(kv[1],kv[0])))
    elif order == 'letter':
        word_rank = dict(sorted(words.items()))

    data = {}
    i = 1
    # 读入数据
    for key,value in word_rank.items():
        word = Words.objects.get(word = key)
        if value == 0:
            value = 1
        elif value == 1:
            value = 3
        else:
            value = 2
        
        data[i] = {
            'spell':key,
            'mean':word.means,
            'degree':value
        }
        i = i + 1
    return JsonResponse(data,json_dumps_params={'ensure_ascii':False})



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

#获取学生的课程课本
def Get_books(request):
    # studentid = Student.POST.get('student_id')
    student_id = 1
    student = Student.objects.get(student_id = student_id)
    course = Course.objects.get(course_id = student.course_id)

    books = course.course_book_id.split('|')
    books_list = {}
    for item in books:
        book_id = int(item)
        book = Category.objects.get(category_id = book_id)
        book_message = {
            'book_name':book.book_name,
            'book_id': book.category_id,
            'enable':book.enable,
            'create_time':book.create_time.strftime("%Y-%m-%d %H:%M:%S")
        }
        books_list[book.sequence] = book_message 

    books_list = dict(sorted(books_list.items()))

    return JsonResponse(books_list,json_dumps_params={'ensure_ascii':False})


# 参加过的比赛
# 只可以参加自己老师的比赛，未参加的比赛
def Match_show(request):
    # studentid = request.POST.get('student_id')
    studentid = 1
    studentmatchs = StudentMatchs.objects.filter(student_id = studentid)

    # 学生参加过的比赛
    commit = {}
    for item in studentmatchs:
        match = Match.objects.get(match_id = item.match_id)
        starttime = match.start_time.strftime("%Y-%m-%d %H:%M:%S")
        endtime = match.end_time.strftime("%Y-%m-%d %H:%M:%S")
        commit[match.match_id] = {
            'match':match.match_name,
            'start_time':starttime,
            'endtime':endtime,
            'join_time':item.join_time,
            'match_grade':item.match_grade
        }

    # 学生未参加过的比赛
    student = Student.objects.get(student_id = studentid)
    course = Course.objects.get(course_id = student.course_id)
    # 检索出所有该课程老师的比赛
    matchs = Match.objects.filter(teacher_id = course.teacher_id)
    unmatchs = set()
    for item in matchs:
        unmatchs.add(item.match_id)
    # 移除参加过的项目
    for item in studentmatchs:
        unmatchs.remove(item.match_id)

    uncommit = {}
    for item in matchs:
        if item.match_id in unmatchs:
            match = Match.objects.get(match_id = item.match_id)
            starttime = match.start_time.strftime("%Y-%m-%d %H:%M:%S")
            endtime = match.end_time.strftime("%Y-%m-%d %H:%M:%S")
            uncommit[match.match_id] = {
                'match':match.match_name,
                'teacher_name':match.teacher_name,
                'start_time':starttime,
                'end_time':endtime,
                'match_time':match.match_time
            }
    data = {'commit':commit,'uncommit':uncommit}
    return JsonResponse(data,json_dumps_params={'ensure_ascii':False})


#教师创建比赛
def Create_match(request):
    name = request.POST.get('match_name')
    # name = "一站到底"
    # 比赛总分
    matchpoint = request.POST.get('match_point')
    # matchpoint = 100

    bookname = request.POST.get('book_name')
    # bookname = "七年级英语"
    category = Category.objects.get(book_name = bookname)
    wordids = Classification.objects.filter(
        category_id = category.category_id).order_by('word_id').values('word_id')
    print(wordids,type(wordids))
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
    return JsonResponse(None,safe = False)

#学生端获取学生的学习统计
def Student_statistics(request):
    student_id = request.POST.get('student_id')
    word_numbers = len(StudentWords.objects.filter(student_id = student_id))

    tests = Test.objects.filter(student_id = student_id)

    tests_type = {}
    tests_grade = {}
    
    for i in range(len(tests)):
        tests_type[i] = tests[i].test_type
        tests_grade[i] = tests[i].test_grade
    return JsonResponse({'word_numbers':word_numbers,'tests_type':tests_type,'tests_grade':tests_grade},safe = False) 

#返回比赛详细信息
def Match_message(request):
    matchid = request.POST.get('match_id')
    # matchid = 1
    match = Match.objects.get(match_id = matchid)
    massage = {}
    massage["比赛名字"] = match.match_name
    massage["比赛时间"] = match.start_time.strftime("%Y-%m-%d %H:%M:%S") + ' - ' + match.end_time.strftime("%Y-%m-%d %H:%M:%S")
    
    teacherid = match.teacher_id
    teacher = Teacher.objects.get(teacher_id = teacherid)
    join_range = teacher.teacher_name + "的所有学生"
    massage["参赛范围"] = join_range

    courses = Course.objects.filter(teacher_id = teacherid)
    match_range = str()
    for item in courses:
        match_range = match_range + ' 、' + item.course_name
    match_range = match_range[1:]
    massage["比赛内容"] = match_range

    if match.match_name == "一站到底":
        massage["比赛规则"] = "系统挑选已参赛学员进行两两pk, 轮流答题, 直到有学员错三题定胜负"
    elif match.match_name == "擂台pk":
        massage["比赛规则"] = "7道题, 每道题12s, 题目分数:20*6+40"

    studentmatchs = StudentMatchs.objects.filter(match_id = matchid)
    score_rank = {}
    for item in studentmatchs:
        student = Student.objects.get(student_id = item.student_id)
        score_rank[student.student_name] = item.match_grade
    score_rank = dict(sorted(score_rank.items(),key = lambda kv:(kv[1],kv[0]), reverse = True))


    return JsonResponse({"比赛详细信息":massage, "比赛排行榜":score_rank},json_dumps_params={'ensure_ascii':False})

#学生名册
def Student_list(request):
    # coursename = request.POST.get('course_name')
    coursename = "七年级上册"
    course = Course.objects.get(course_name = coursename)
    students = Student.objects.filter(course_id = course.course_id)
    student_message = {}
    for item in students:
        student_message[item.student_name] = {
            # 'email':item.email,
            'coins':item.coins,
            # 'last_login':item.last_logintime,
            'student_id':item.student_id,
            'course_name':course.course_name,
            "所在组":'xfinit',
            'register_time':'2020-1-3 16:46:30',
            'status':"付费"
        }
    return JsonResponse(student_message,json_dumps_params={'ensure_ascii':False})

#修改密码
def Change_password(request):
    # 存取控制
    student_id = request.POST.get('student_id')
    new_password = request.POST.get('new_password')
    student = Student.objects.get(student_id = student_id)
    student.student_password = new_password
    student.save()
    return JsonResponse({'change_status':'密码修改成功'},safe = False,json_dumps_params={'ensure_ascii':False})

#查看学生学习单词量
def Study_census(request):
    # coursename = request.POST.get('course_name')
    coursename = "七年级上册"
    course = Course.objects.get(course_name = coursename)
    students = Student.objects.filter(course_id = course.course_id)
    student_words = {}
    for item in students:
        student_words[item.student_name] = item.word_numbers
        
    return JsonResponse(student_words,json_dumps_params={'ensure_ascii':False})

#教师端查看比赛信息
def TeacherMatchMessage(request):
    # teacherid = request.POST.get('teacher_id')
    teacherid = 1
    teacher = Teacher.objects.get(teacher_id = teacherid)
    matchs = Match.objects.filter(teacher_id = teacher.teacher_id)

    match_message = {}
    for item in matchs:
        match_message[item.match_id] = {
            'match_name':item.match_name,
            'start_time':item.start_time.strftime("%Y-%m-%d %H:%M:%S"),
            'end_time':item.end_time.strftime("%Y-%m-%d %H:%M:%S"),
            'match_time':item.match_time,
            'join_number':'5000'
        }
    return JsonResponse(match_message,json_dumps_params={'ensure_ascii':False})

# 默认前端首先获得单词书列表，用户选择单词书在返回到后端
def Test_before(request):
    student_id = request.POST.get('student_id')
    # student_id = 1
    student = Student.objects.get(student_id = student_id)
    course = Course.objects.get(course_id = student.course_id)
    books = course.course_book_id.split('|')
    # 用集合保存所有单词
    words = set()
    for item in books:
        book_id = int(item)
        book_words = Classification.objects.filter(category_id = book_id).order_by('word_id')
        for word_item in book_words:
            words.add(word_item.word_id)

    i = 1
    words_list = {}
    # all_words = Words.objects.all()
    for item in words:
        # if item.word_id in words:
        words_list[i] = item
        i = i + 1


    # 从当前单词书中获得随机的n个不重复的单词
    n = 28
    index_list = random.sample(range(1,len(words_list)+1),n)
    # 测试的所有数据
    test_list = {}
    # 错误的三个单词字典
    errorwords = {}
    
    # 获得所有单词的数量，从所有单词里随机抽取，默认单词id自动递增无缺漏
    allwords = Words.objects.all()
    num = len(allwords)

    correct = str()
    # 录入测试单词数据及其选项
    i = 1
    for item in index_list:
        word = Words.objects.get(word_id = words_list[item])
        
        # 随机生成一个正确选项
        correct_id = random.randint(1,4)
        # 随机生成四个错误选项
        for index in range(4):
            random_id = random.randint(1,num)
            while random_id == word.word_id:
                random_id = random.randint(1,num)
            err_word = Words.objects.get(word_id = random_id)
            errorwords[index] = err_word.means

        Aoption = errorwords[0]
        Boption = errorwords[1]
        Coption = errorwords[2]
        Doption = errorwords[3]
        # 根据随机出来的数字 确定正确选项字母
        if correct_id == 1:
            Aoption = word.means
            correct = 'A'
        elif correct_id == 2:
            Boption = word.means
            correct = 'B'
        elif correct_id == 3:
            Coption = word.means
            correct = 'C'
        else:
            Doption = word.means
            correct = 'D'

        test_list[i] = {
            'spell':word.word,
            'A':Aoption,
            'B':Boption,
            'C':Coption,
            'D':Doption,
            'correct':correct,
        }
        i = i + 1
    
    return JsonResponse(test_list,json_dumps_params={'ensure_ascii':False})

# 默认前端首先获得单词书列表，用户选择单词书，第几单元再返回到后端
# 后端返回这个单元的所有单词
def Unit_learn(request):
    # unit = int(request.POST.get('Unit_number'))
    # bookname = request.POST.get('book_name')
    unit = 2
    bookname = '八年级上册英语'
    unit_num = 10  # 单元单词数量

    category = Category.objects.get(book_name = bookname)
    # 按单词ID进行排序，规定好一个单元的数量
    words = Classification.objects.filter(category_id = category.category_id).order_by('word_id')
    word_message = {}
    
    start = (unit-1)*unit_num
    end = unit*unit_num
    i = 1
    for item in words[start:end]:
        word = Words.objects.get(word_id = item.word_id)
        word_message[i] = {
            'word_id':word.word_id,
            'spell':word.word,
            'mean':word.means
        }
        i += 1
    return JsonResponse(word_message,json_dumps_params={'ensure_ascii':False})


# 学生单词学习拼写  只有拼写形式，加熟练度
def Word_spell(request):
    # 前端传入单词ID，学生拼写，学生ID
    # wordid = request.POST.get('word_id')
    # spell = request.POST.get('spell')
    # studentid = request.POST.get('student_id')
    wordid = 5
    spell = 'AmAzing'
    studentid = 1
    word = Words.objects.get(word_id = wordid)
    student_word = StudentWords.objects.get(student_id = studentid,words_id = word.word_id)

    data = {}
    if word.word == spell.lower():
        if student_word.counts < student_word.value:
            student_word.counts += 1
            student_word.save()
        # 返回正确的单词（键）和是否正确中文（键值）
        data[word.word] = "正确"
        return JsonResponse(data,json_dumps_params={'ensure_ascii':False})
    else:
        if student_word.counts > 0:
            student_word.counts -= 1
            student_word.save()
        data[word.word] = "错误"
        return JsonResponse(data,json_dumps_params={'ensure_ascii':False})

# 默认前端首先获得单词书列表，用户选择单词书和第几单元在返回到后端
# 学生单词单元测试  只有选择题，包含该单元所有单词，不加熟练度
def Unit_test(request):
    # bookname = request.POST.get('book_name')
    # unit = request.POST.get('unit')
    bookname = "八年级上册英语"
    unit = 2
    category = Category.objects.get(book_name = bookname)
    # 按单词ID进行排序，规定好一个单元的数量
    words = Classification.objects.filter(category_id = category.category_id).order_by('word_id')

    # 单元单词数量
    unit_num = 10
    start = (unit-1)*unit_num
    end = unit*unit_num
  
    # 单元测试的所有数据
    test_list = {}
    # 错误的三个单词字典
    errorwords = {}
    # 获得所有单词的数量，从所有单词里随机抽取，默认单词id自动递增无缺漏
    allwords = Words.objects.all()
    num = len(allwords)

    correct = str()
    # 录入测试单词数据及其选项
    i = 1
    for item in words[start:end]:
        word = Words.objects.get(word_id = item.word_id)
        
        # 随机生成一个正确选项
        correct_id = random.randint(1,4)
        # 随机生成四个错误选项
        for index in range(4):
            random_id = random.randint(1,num)
            while random_id == word.word_id:
                random_id = random.randint(1,num)
            err_word = Words.objects.get(word_id = random_id)
            errorwords[index] = err_word.means

        Aoption = errorwords[0]
        Boption = errorwords[1]
        Coption = errorwords[2]
        Doption = errorwords[3]
        # 根据随机出来的数字 确定正确选项字母
        if correct_id == 1:
            Aoption = word.means
            correct = 'A'
        elif correct_id == 2:
            Boption = word.means
            correct = 'B'
        elif correct_id == 3:
            Coption = word.means
            correct = 'C'
        else:
            Doption = word.means
            correct = 'D'

        test_list[i] = {
            'spell':word.word,
            'A':Aoption,
            'B':Boption,
            'C':Coption,
            'D':Doption,
            'correct':correct,
        }
        i = i + 1
    
    return JsonResponse(test_list,json_dumps_params={'ensure_ascii':False})

# 录入测试成绩
def Input_test(request):
    studentid = request.POST.get('student_id')
    test_type = request.POST.get('test_type')
    test_grade = request.POST.get('test_grade')
    test = Test(student_id= studentid,test_type = test_type,test_grade = test_grade)
    test.save()
    data = {}
    data['status'] = 'succeed'
    return JsonResponse(data)