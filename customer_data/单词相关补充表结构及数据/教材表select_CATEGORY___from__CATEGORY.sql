-- drop table CATEGORY cascade constraints;

/*==============================================================*/
/* Table: CATEGORY                                              */
/*==============================================================*/
create table CATEGORY  (
   ID                   NUMBER(10)                      not null,
   CATEGORY             VARCHAR2(100)                   not null,
   CREATE_TIME          DATE,
   MODIFY_TIME          DATE,
   GRADE_ID             NUMBER(2),
   ENABLE               NUMBER(1)                       not null,
   SEQUENCE             NUMBER(3),
   EDITION_ID           NUMBER(3)                       not null,
   "cover_pic"          VARCHAR2(256),
   constraint PK_CATEGORY primary key (ID),
   constraint UNI_CATEGORY_SEQUENCE unique (SEQUENCE)
);

comment on table CATEGORY is
'教材信息表';

comment on column CATEGORY.ID is
'流水号';

comment on column CATEGORY.CATEGORY is
'书名';

comment on column CATEGORY.CREATE_TIME is
'教材创建时间';

comment on column CATEGORY.MODIFY_TIME is
'教材修改时间';

comment on column CATEGORY.GRADE_ID is
'年级id';

comment on column CATEGORY.ENABLE is
'启用状态：0=未启用，1=启用';

comment on column CATEGORY.SEQUENCE is
'顺序';

comment on column CATEGORY.EDITION_ID is
'版本ID';

comment on column CATEGORY."cover_pic" is
'封面图片';



INSERT INTO ETT2.CATEGORY (ID, CATEGORY, CREATE_TIME, MODIFY_TIME, GRADE_ID, ENABLE, SEQUENCE, EDITION_ID, COVER_PIC) VALUES (198, '最新北京高考单词过关（考纲）', TO_DATE('2011-05-17 15:21:38', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2019-06-01 18:56:42', 'YYYY-MM-DD HH24:MI:SS'), 0, 1, 252, 1, 'coverpic_198.jpg');
INSERT INTO ETT2.CATEGORY (ID, CATEGORY, CREATE_TIME, MODIFY_TIME, GRADE_ID, ENABLE, SEQUENCE, EDITION_ID, COVER_PIC) VALUES (232, '最新全国高考通用英语词汇', TO_DATE('2013-03-22 08:02:35', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-08-15 14:31:22', 'YYYY-MM-DD HH24:MI:SS'), 0, 1, 285, 22, 'coverpic_232.jpg');
INSERT INTO ETT2.CATEGORY (ID, CATEGORY, CREATE_TIME, MODIFY_TIME, GRADE_ID, ENABLE, SEQUENCE, EDITION_ID, COVER_PIC) VALUES (2, '人教新课标 七年级下', TO_DATE('2009-05-06 17:54:36', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-05-21 15:03:25', 'YYYY-MM-DD HH24:MI:SS'), 6, 1, 2, 1, 'coverpic_2.jpg');
INSERT INTO ETT2.CATEGORY (ID, CATEGORY, CREATE_TIME, MODIFY_TIME, GRADE_ID, ENABLE, SEQUENCE, EDITION_ID, COVER_PIC) VALUES (196, '2011年全国高考单词过关（课标——考纲）', TO_DATE('2011-05-14 16:02:57', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-08-15 10:55:25', 'YYYY-MM-DD HH24:MI:SS'), 0, 0, 251, 22, 'coverpic_196.jpg');
INSERT INTO ETT2.CATEGORY (ID, CATEGORY, CREATE_TIME, MODIFY_TIME, GRADE_ID, ENABLE, SEQUENCE, EDITION_ID, COVER_PIC) VALUES (13, '人教新课标 高中选修7', TO_DATE('2009-05-07 10:17:10', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2013-03-30 09:24:46', 'YYYY-MM-DD HH24:MI:SS'), 2, 1, 12, 2, 'coverpic_13.jpg');
INSERT INTO ETT2.CATEGORY (ID, CATEGORY, CREATE_TIME, MODIFY_TIME, GRADE_ID, ENABLE, SEQUENCE, EDITION_ID, COVER_PIC) VALUES (93, '北师大课改版 8年级上', TO_DATE('2009-06-26 07:53:18', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-09-11 14:46:28', 'YYYY-MM-DD HH24:MI:SS'), 5, 1, 96, 10, 'coverpic_93.jpg');
INSERT INTO ETT2.CATEGORY (ID, CATEGORY, CREATE_TIME, MODIFY_TIME, GRADE_ID, ENABLE, SEQUENCE, EDITION_ID, COVER_PIC) VALUES (128, '人教大纲版　第二册上', TO_DATE('2009-07-04 07:36:40', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2009-07-05 16:11:51', 'YYYY-MM-DD HH24:MI:SS'), 5, 1, 147, 16, 'coverpic_128.jpg');
INSERT INTO ETT2.CATEGORY (ID, CATEGORY, CREATE_TIME, MODIFY_TIME, GRADE_ID, ENABLE, SEQUENCE, EDITION_ID, COVER_PIC) VALUES (133, '人教大纲版(五四制)　第二册上', TO_DATE('2009-07-04 07:40:48', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2009-07-05 16:12:02', 'YYYY-MM-DD HH24:MI:SS'), 6, 1, 157, 17, 'coverpic_133.jpg');
INSERT INTO ETT2.CATEGORY (ID, CATEGORY, CREATE_TIME, MODIFY_TIME, GRADE_ID, ENABLE, SEQUENCE, EDITION_ID, COVER_PIC) VALUES (91, '北师大课改版 7年级上', TO_DATE('2009-06-26 07:51:47', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-11-04 18:07:46', 'YYYY-MM-DD HH24:MI:SS'), 6, 1, 94, 10, 'coverpic_91.jpg');
INSERT INTO ETT2.CATEGORY (ID, CATEGORY, CREATE_TIME, MODIFY_TIME, GRADE_ID, ENABLE, SEQUENCE, EDITION_ID, COVER_PIC) VALUES (7, '人教新课标 高中必修1', TO_DATE('2009-05-07 10:09:45', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2013-03-30 09:18:53', 'YYYY-MM-DD HH24:MI:SS'), 3, 1, 6, 2, 'coverpic_7.jpg');
INSERT INTO ETT2.CATEGORY (ID, CATEGORY, CREATE_TIME, MODIFY_TIME, GRADE_ID, ENABLE, SEQUENCE, EDITION_ID, COVER_PIC) VALUES (113, '外研社(初中起点)　第二册', TO_DATE('2009-07-02 07:54:35', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2009-07-04 14:41:21', 'YYYY-MM-DD HH24:MI:SS'), 6, 1, 124, 13, 'coverpic_113.jpg');
INSERT INTO ETT2.CATEGORY (ID, CATEGORY, CREATE_TIME, MODIFY_TIME, GRADE_ID, ENABLE, SEQUENCE, EDITION_ID, COVER_PIC) VALUES (114, '外研社(初中起点)　第三册', TO_DATE('2009-07-02 07:55:12', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2009-07-05 09:07:29', 'YYYY-MM-DD HH24:MI:SS'), 5, 1, 125, 13, 'coverpic_114.jpg');
INSERT INTO ETT2.CATEGORY (ID, CATEGORY, CREATE_TIME, MODIFY_TIME, GRADE_ID, ENABLE, SEQUENCE, EDITION_ID, COVER_PIC) VALUES (198, '最新北京高考单词过关（考纲）', TO_DATE('2011-05-17 15:21:38', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2019-06-01 18:56:42', 'YYYY-MM-DD HH24:MI:SS'), 0, 1, 252, 1, 'coverpic_198.jpg');
INSERT INTO ETT2.CATEGORY (ID, CATEGORY, CREATE_TIME, MODIFY_TIME, GRADE_ID, ENABLE, SEQUENCE, EDITION_ID, COVER_PIC) VALUES (7, '人教新课标 高中必修1', TO_DATE('2009-05-07 10:09:45', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2013-03-30 09:18:53', 'YYYY-MM-DD HH24:MI:SS'), 3, 1, 6, 2, 'coverpic_7.jpg');
INSERT INTO ETT2.CATEGORY (ID, CATEGORY, CREATE_TIME, MODIFY_TIME, GRADE_ID, ENABLE, SEQUENCE, EDITION_ID, COVER_PIC) VALUES (232, '最新全国高考通用英语词汇', TO_DATE('2013-03-22 08:02:35', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-08-15 14:31:22', 'YYYY-MM-DD HH24:MI:SS'), 0, 1, 285, 22, 'coverpic_232.jpg');
INSERT INTO ETT2.CATEGORY (ID, CATEGORY, CREATE_TIME, MODIFY_TIME, GRADE_ID, ENABLE, SEQUENCE, EDITION_ID, COVER_PIC) VALUES (2, '人教新课标 七年级下', TO_DATE('2009-05-06 17:54:36', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-05-21 15:03:25', 'YYYY-MM-DD HH24:MI:SS'), 6, 1, 2, 1, 'coverpic_2.jpg');
INSERT INTO ETT2.CATEGORY (ID, CATEGORY, CREATE_TIME, MODIFY_TIME, GRADE_ID, ENABLE, SEQUENCE, EDITION_ID, COVER_PIC) VALUES (14, '人教新课标 高中选修8', TO_DATE('2009-05-07 10:17:20', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2009-06-29 16:17:02', 'YYYY-MM-DD HH24:MI:SS'), 2, 1, 13, 2, 'coverpic_14.jpg');
INSERT INTO ETT2.CATEGORY (ID, CATEGORY, CREATE_TIME, MODIFY_TIME, GRADE_ID, ENABLE, SEQUENCE, EDITION_ID, COVER_PIC) VALUES (53, '外研社 高中必修3', TO_DATE('2009-06-22 07:43:59', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2009-06-29 16:22:37', 'YYYY-MM-DD HH24:MI:SS'), 3, 1, 41, 5, 'coverpic_53.jpg');
INSERT INTO ETT2.CATEGORY (ID, CATEGORY, CREATE_TIME, MODIFY_TIME, GRADE_ID, ENABLE, SEQUENCE, EDITION_ID, COVER_PIC) VALUES (116, '外研社(初中起点)　第五册', TO_DATE('2009-07-02 07:56:56', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2009-07-04 14:41:57', 'YYYY-MM-DD HH24:MI:SS'), 4, 1, 127, 13, 'coverpic_116.jpg');
INSERT INTO ETT2.CATEGORY (ID, CATEGORY, CREATE_TIME, MODIFY_TIME, GRADE_ID, ENABLE, SEQUENCE, EDITION_ID, COVER_PIC) VALUES (119, '黑龙江课标版　初一年级下', TO_DATE('2009-07-04 07:21:59', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2009-07-05 09:08:20', 'YYYY-MM-DD HH24:MI:SS'), 7, 1, 134, 15, null);
INSERT INTO ETT2.CATEGORY (ID, CATEGORY, CREATE_TIME, MODIFY_TIME, GRADE_ID, ENABLE, SEQUENCE, EDITION_ID, COVER_PIC) VALUES (84, '人教大纲版　第三册', TO_DATE('2009-06-26 07:39:31', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2009-07-01 14:33:36', 'YYYY-MM-DD HH24:MI:SS'), 1, 1, 79, 8, 'coverpic_84.jpg');
INSERT INTO ETT2.CATEGORY (ID, CATEGORY, CREATE_TIME, MODIFY_TIME, GRADE_ID, ENABLE, SEQUENCE, EDITION_ID, COVER_PIC) VALUES (104, '北师大课改版 高中选修9', TO_DATE('2009-06-26 08:00:26', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2009-07-04 14:41:41', 'YYYY-MM-DD HH24:MI:SS'), 1, 1, 107, 11, 'coverpic_104.jpg');
INSERT INTO ETT2.CATEGORY (ID, CATEGORY, CREATE_TIME, MODIFY_TIME, GRADE_ID, ENABLE, SEQUENCE, EDITION_ID, COVER_PIC) VALUES (81, '人教大纲版　第一册下', TO_DATE('2009-06-26 07:38:15', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2009-07-01 08:03:26', 'YYYY-MM-DD HH24:MI:SS'), 3, 1, 76, 8, 'coverpic_81.jpg');
INSERT INTO ETT2.CATEGORY (ID, CATEGORY, CREATE_TIME, MODIFY_TIME, GRADE_ID, ENABLE, SEQUENCE, EDITION_ID, COVER_PIC) VALUES (120, '黑龙江课标版　初二年级上', TO_DATE('2009-07-04 07:23:08', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2009-07-05 09:08:32', 'YYYY-MM-DD HH24:MI:SS'), 6, 1, 135, 15, null);
INSERT INTO ETT2.CATEGORY (ID, CATEGORY, CREATE_TIME, MODIFY_TIME, GRADE_ID, ENABLE, SEQUENCE, EDITION_ID, COVER_PIC) VALUES (127, '人教大纲版　第一册下', TO_DATE('2009-07-04 07:36:09', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2009-07-05 17:43:17', 'YYYY-MM-DD HH24:MI:SS'), 6, 1, 146, 16, 'coverpic_127.jpg');
INSERT INTO ETT2.CATEGORY (ID, CATEGORY, CREATE_TIME, MODIFY_TIME, GRADE_ID, ENABLE, SEQUENCE, EDITION_ID, COVER_PIC) VALUES (132, '人教大纲版(五四制)　第一册下', TO_DATE('2009-07-04 07:40:28', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2009-07-05 17:44:02', 'YYYY-MM-DD HH24:MI:SS'), 7, 1, 156, 17, 'coverpic_132.jpg');
INSERT INTO ETT2.CATEGORY (ID, CATEGORY, CREATE_TIME, MODIFY_TIME, GRADE_ID, ENABLE, SEQUENCE, EDITION_ID, COVER_PIC) VALUES (138, '上海课标版牛津英语 7B', TO_DATE('2009-07-05 10:26:03', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-02-12 10:53:20', 'YYYY-MM-DD HH24:MI:SS'), 6, 0, 166, 18, null);
INSERT INTO ETT2.CATEGORY (ID, CATEGORY, CREATE_TIME, MODIFY_TIME, GRADE_ID, ENABLE, SEQUENCE, EDITION_ID, COVER_PIC) VALUES (177, '外研新课标　第三册（三年级起始新标准）', TO_DATE('2009-11-30 22:31:21', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2010-03-29 15:58:19', 'YYYY-MM-DD HH24:MI:SS'), 9, 1, 221, 20, 'coverpic_177.jpg');
INSERT INTO ETT2.CATEGORY (ID, CATEGORY, CREATE_TIME, MODIFY_TIME, GRADE_ID, ENABLE, SEQUENCE, EDITION_ID, COVER_PIC) VALUES (192, '新概念英语（1）', TO_DATE('2010-02-06 08:10:38', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2010-03-22 13:50:23', 'YYYY-MM-DD HH24:MI:SS'), 0, 1, 243, 21, 'coverpic_192.jpg');
INSERT INTO ETT2.CATEGORY (ID, CATEGORY, CREATE_TIME, MODIFY_TIME, GRADE_ID, ENABLE, SEQUENCE, EDITION_ID, COVER_PIC) VALUES (212, '牛津上海版七年级第一学期(2012版)', TO_DATE('2012-09-19 14:27:58', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2012-12-13 14:18:19', 'YYYY-MM-DD HH24:MI:SS'), 6, 1, 264, 18, 'coverpic_212.jpg');
INSERT INTO ETT2.CATEGORY (ID, CATEGORY, CREATE_TIME, MODIFY_TIME, GRADE_ID, ENABLE, SEQUENCE, EDITION_ID, COVER_PIC) VALUES (7, '人教新课标 高中必修1', TO_DATE('2009-05-07 10:09:45', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2013-03-30 09:18:53', 'YYYY-MM-DD HH24:MI:SS'), 3, 1, 6, 2, 'coverpic_7.jpg');
INSERT INTO ETT2.CATEGORY (ID, CATEGORY, CREATE_TIME, MODIFY_TIME, GRADE_ID, ENABLE, SEQUENCE, EDITION_ID, COVER_PIC) VALUES (218, '北师大课改版 第五册', TO_DATE('2013-01-27 09:38:32', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2013-01-28 17:21:04', 'YYYY-MM-DD HH24:MI:SS'), 9, 1, 278, 27, 'coverpic_218.jpg');
INSERT INTO ETT2.CATEGORY (ID, CATEGORY, CREATE_TIME, MODIFY_TIME, GRADE_ID, ENABLE, SEQUENCE, EDITION_ID, COVER_PIC) VALUES (101, '北师大课改版 高中选修6', TO_DATE('2009-06-26 07:58:50', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2009-07-03 11:10:19', 'YYYY-MM-DD HH24:MI:SS'), 2, 1, 104, 11, 'coverpic_101.jpg');
INSERT INTO ETT2.CATEGORY (ID, CATEGORY, CREATE_TIME, MODIFY_TIME, GRADE_ID, ENABLE, SEQUENCE, EDITION_ID, COVER_PIC) VALUES (142, '上海课标版牛津英语 9B', TO_DATE('2009-07-05 10:27:24', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-02-12 11:00:15', 'YYYY-MM-DD HH24:MI:SS'), 4, 0, 170, 18, null);
INSERT INTO ETT2.CATEGORY (ID, CATEGORY, CREATE_TIME, MODIFY_TIME, GRADE_ID, ENABLE, SEQUENCE, EDITION_ID, COVER_PIC) VALUES (193, '新概念英语（2）', TO_DATE('2010-02-06 08:11:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2010-03-22 13:50:41', 'YYYY-MM-DD HH24:MI:SS'), 0, 1, 244, 21, 'coverpic_193.jpg');
INSERT INTO ETT2.CATEGORY (ID, CATEGORY, CREATE_TIME, MODIFY_TIME, GRADE_ID, ENABLE, SEQUENCE, EDITION_ID, COVER_PIC) VALUES (196, '2011年全国高考单词过关（课标——考纲）', TO_DATE('2011-05-14 16:02:57', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-08-15 10:55:25', 'YYYY-MM-DD HH24:MI:SS'), 0, 0, 251, 22, 'coverpic_196.jpg');
INSERT INTO ETT2.CATEGORY (ID, CATEGORY, CREATE_TIME, MODIFY_TIME, GRADE_ID, ENABLE, SEQUENCE, EDITION_ID, COVER_PIC) VALUES (198, '最新北京高考单词过关（考纲）', TO_DATE('2011-05-17 15:21:38', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2019-06-01 18:56:42', 'YYYY-MM-DD HH24:MI:SS'), 0, 1, 252, 1, 'coverpic_198.jpg');
INSERT INTO ETT2.CATEGORY (ID, CATEGORY, CREATE_TIME, MODIFY_TIME, GRADE_ID, ENABLE, SEQUENCE, EDITION_ID, COVER_PIC) VALUES (217, '牛津上海版九年级第二学期(2012版)', TO_DATE('2012-09-19 14:40:20', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2013-06-14 17:13:13', 'YYYY-MM-DD HH24:MI:SS'), 4, 1, 269, 18, 'coverpic_217.jpg');
INSERT INTO ETT2.CATEGORY (ID, CATEGORY, CREATE_TIME, MODIFY_TIME, GRADE_ID, ENABLE, SEQUENCE, EDITION_ID, COVER_PIC) VALUES (135, '人教大纲版(五四制)　第三册', TO_DATE('2009-07-04 07:41:58', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2009-07-07 15:16:47', 'YYYY-MM-DD HH24:MI:SS'), 5, 1, 159, 17, 'coverpic_135.jpg');
INSERT INTO ETT2.CATEGORY (ID, CATEGORY, CREATE_TIME, MODIFY_TIME, GRADE_ID, ENABLE, SEQUENCE, EDITION_ID, COVER_PIC) VALUES (232, '最新全国高考通用英语词汇', TO_DATE('2013-03-22 08:02:35', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-08-15 14:31:22', 'YYYY-MM-DD HH24:MI:SS'), 0, 1, 285, 22, 'coverpic_232.jpg');
INSERT INTO ETT2.CATEGORY (ID, CATEGORY, CREATE_TIME, MODIFY_TIME, GRADE_ID, ENABLE, SEQUENCE, EDITION_ID, COVER_PIC) VALUES (7, '人教新课标 高中必修1', TO_DATE('2009-05-07 10:09:45', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2013-03-30 09:18:53', 'YYYY-MM-DD HH24:MI:SS'), 3, 1, 6, 2, 'coverpic_7.jpg');
INSERT INTO ETT2.CATEGORY (ID, CATEGORY, CREATE_TIME, MODIFY_TIME, GRADE_ID, ENABLE, SEQUENCE, EDITION_ID, COVER_PIC) VALUES (41, '湖南仁爱 八年级上', TO_DATE('2009-06-17 14:07:58', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2009-06-29 16:18:13', 'YYYY-MM-DD HH24:MI:SS'), 5, 1, 23, 3, 'coverpic_41.jpg');
INSERT INTO ETT2.CATEGORY (ID, CATEGORY, CREATE_TIME, MODIFY_TIME, GRADE_ID, ENABLE, SEQUENCE, EDITION_ID, COVER_PIC) VALUES (67, '译林新课标 九年级下', TO_DATE('2009-06-24 07:44:13', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2009-06-29 16:33:53', 'YYYY-MM-DD HH24:MI:SS'), 4, 1, 59, 6, 'coverpic_67.jpg');
INSERT INTO ETT2.CATEGORY (ID, CATEGORY, CREATE_TIME, MODIFY_TIME, GRADE_ID, ENABLE, SEQUENCE, EDITION_ID, COVER_PIC) VALUES (111, '北京课改版 第十五册', TO_DATE('2009-07-01 08:00:08', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2009-07-04 14:41:06', 'YYYY-MM-DD HH24:MI:SS'), 4, 1, 118, 12, 'coverpic_111.jpg');
INSERT INTO ETT2.CATEGORY (ID, CATEGORY, CREATE_TIME, MODIFY_TIME, GRADE_ID, ENABLE, SEQUENCE, EDITION_ID, COVER_PIC) VALUES (114, '外研社(初中起点)　第三册', TO_DATE('2009-07-02 07:55:12', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2009-07-05 09:07:29', 'YYYY-MM-DD HH24:MI:SS'), 5, 1, 125, 13, 'coverpic_114.jpg');
INSERT INTO ETT2.CATEGORY (ID, CATEGORY, CREATE_TIME, MODIFY_TIME, GRADE_ID, ENABLE, SEQUENCE, EDITION_ID, COVER_PIC) VALUES (130, '人教大纲版　第三册', TO_DATE('2009-07-04 07:37:53', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2009-07-08 10:28:09', 'YYYY-MM-DD HH24:MI:SS'), 4, 1, 149, 16, 'coverpic_130.jpg');
INSERT INTO ETT2.CATEGORY (ID, CATEGORY, CREATE_TIME, MODIFY_TIME, GRADE_ID, ENABLE, SEQUENCE, EDITION_ID, COVER_PIC) VALUES (135, '人教大纲版(五四制)　第三册', TO_DATE('2009-07-04 07:41:58', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2009-07-07 15:16:47', 'YYYY-MM-DD HH24:MI:SS'), 5, 1, 159, 17, 'coverpic_135.jpg');
INSERT INTO ETT2.CATEGORY (ID, CATEGORY, CREATE_TIME, MODIFY_TIME, GRADE_ID, ENABLE, SEQUENCE, EDITION_ID, COVER_PIC) VALUES (138, '上海课标版牛津英语 7B', TO_DATE('2009-07-05 10:26:03', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-02-12 10:53:20', 'YYYY-MM-DD HH24:MI:SS'), 6, 0, 166, 18, null);
INSERT INTO ETT2.CATEGORY (ID, CATEGORY, CREATE_TIME, MODIFY_TIME, GRADE_ID, ENABLE, SEQUENCE, EDITION_ID, COVER_PIC) VALUES (165, '人教新课标　六年级上（一年级起始　新起点）', TO_DATE('2009-11-30 15:01:43', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2010-03-29 16:04:54', 'YYYY-MM-DD HH24:MI:SS'), 7, 1, 201, 19, 'coverpic_165.jpg');
INSERT INTO ETT2.CATEGORY (ID, CATEGORY, CREATE_TIME, MODIFY_TIME, GRADE_ID, ENABLE, SEQUENCE, EDITION_ID, COVER_PIC) VALUES (196, '2011年全国高考单词过关（课标——考纲）', TO_DATE('2011-05-14 16:02:57', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2014-08-15 10:55:25', 'YYYY-MM-DD HH24:MI:SS'), 0, 0, 251, 22, 'coverpic_196.jpg');