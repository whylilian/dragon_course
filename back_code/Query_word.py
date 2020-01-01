def Query_word(request):
    wordid = request.POST.get('word_id')
    spell = request.POST.get('spell')
    studentid = request.POST.get('student_id')
    # wordid = 1
    # spell = 'azing'
    # studentid = 2
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