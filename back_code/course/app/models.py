# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey and OneToOneField has `on_delete` set to the desired behavior
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from django.db import models


class Calendar(models.Model):
    student = models.ForeignKey('Student', models.DO_NOTHING)
    calendar_time = models.CharField(max_length=2000, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'calendar'


class Category(models.Model):
    category_id = models.AutoField(primary_key=True)
    book_name = models.CharField(max_length=100)
    create_time = models.DateTimeField(blank=True, null=True)
    modify_time = models.DateTimeField(blank=True, null=True)
    grade_id = models.IntegerField(blank=True, null=True)
    enable = models.IntegerField()
    sequence = models.IntegerField(blank=True, null=True)
    cover_pic = models.CharField(max_length=255, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'category'


class Classification(models.Model):
    word = models.ForeignKey('Words', models.DO_NOTHING)
    category = models.ForeignKey(Category, models.DO_NOTHING)
    sequence = models.IntegerField()
    create_time = models.DateTimeField(blank=True, null=True)
    modify_time = models.DateTimeField(blank=True, null=True)
    grade_id = models.IntegerField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'classification'


class Course(models.Model):
    course_id = models.AutoField(primary_key=True)
    teacher_id = models.PositiveIntegerField()
    number = models.IntegerField()
    course_book_id = models.CharField(max_length=100)
    course_name = models.CharField(max_length=50)

    class Meta:
        managed = False
        db_table = 'course'


class Edition(models.Model):
    name = models.CharField(max_length=200)
    create_time = models.DateTimeField()
    modify_time = models.DateTimeField()
    unit_enable = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'edition'


class Match(models.Model):
    match_id = models.AutoField(primary_key=True)
    match_name = models.CharField(max_length=20)
    match_point = models.IntegerField()
    words_id = models.CharField(max_length=1000)
    teacher_id = models.PositiveIntegerField()
    teacher_name = models.CharField(max_length=20)
    start_time = models.DateTimeField()
    end_time = models.DateTimeField()
    match_time = models.TimeField()

    class Meta:
        managed = False
        db_table = 'match'


class Student(models.Model):
    student_id = models.AutoField(primary_key=True)
    student_username = models.CharField(max_length=20)
    student_password = models.CharField(max_length=50)
    student_name = models.CharField(max_length=20)
    student_sex = models.CharField(max_length=2)
    student_age = models.PositiveIntegerField()
    student_email = models.CharField(max_length=20, blank=True, null=True)
    course = models.ForeignKey(Course, models.DO_NOTHING, blank=True, null=True)
    coins = models.PositiveIntegerField(blank=True, null=True)
    word_numbers = models.PositiveIntegerField(blank=True, null=True)
    points = models.PositiveIntegerField(blank=True, null=True)
    study_status = models.PositiveIntegerField()
    create_time = models.CharField(max_length=20, blank=True, null=True)
    lastlogin_time = models.CharField(max_length=20, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'student'


class StudentMatchs(models.Model):
    match_table_id = models.AutoField(primary_key=True)
    match_id = models.PositiveIntegerField()
    student_id = models.PositiveIntegerField()
    match_grade = models.PositiveIntegerField()
    join_time = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'student_matchs'


class StudentWords(models.Model):
    table_id = models.AutoField(primary_key=True)
    student_id = models.PositiveIntegerField()
    words_id = models.PositiveIntegerField()
    counts = models.PositiveIntegerField()
    value = models.PositiveIntegerField()

    class Meta:
        managed = False
        db_table = 'student_words'


class Teacher(models.Model):
    teacher_id = models.AutoField(primary_key=True)
    teacher_username = models.CharField(max_length=20)
    teacher_password = models.CharField(max_length=50)
    teacher_name = models.CharField(max_length=20)
    teacher_sex = models.CharField(max_length=2)
    teacher_age = models.IntegerField()
    teacher_phone = models.CharField(max_length=20)
    teacher_address = models.CharField(max_length=50)
    courses_id = models.CharField(max_length=1000, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'teacher'


class Test(models.Model):
    test_id = models.AutoField(primary_key=True)
    student_id = models.PositiveIntegerField()
    test_type = models.PositiveIntegerField()
    test_grade = models.PositiveIntegerField()

    class Meta:
        managed = False
        db_table = 'test'


class Words(models.Model):
    word_id = models.AutoField(primary_key=True)
    word = models.CharField(max_length=100)
    means = models.CharField(max_length=200)
    voice = models.CharField(max_length=1000, blank=True, null=True)
    value = models.IntegerField()
    property = models.CharField(max_length=20)

    class Meta:
        managed = False
        db_table = 'words'
