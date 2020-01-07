/*
 Navicat Premium Data Transfer

 Source Server         : timemachine
 Source Server Type    : MySQL
 Source Server Version : 80016
 Source Host           : localhost:3306
 Source Schema         : word_data

 Target Server Type    : MySQL
 Target Server Version : 80016
 File Encoding         : 65001

 Date: 07/01/2020 16:02:07
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for calendar
-- ----------------------------
DROP TABLE IF EXISTS `calendar`;
CREATE TABLE `calendar`  (
  `student_id` int(7) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '学生编号',
  `calendar_time` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '打卡的时间，使用\'|\'分割成列表',
  INDEX `fk_student_delete`(`student_id`) USING BTREE,
  CONSTRAINT `fk_student_delete` FOREIGN KEY (`student_id`) REFERENCES `student` (`student_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category`  (
  `category_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '教材id',
  `book_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '书名',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `modify_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  `grade_id` int(2) NULL DEFAULT NULL COMMENT '年级id',
  `enable` int(1) NOT NULL COMMENT '启用状态：0=未启用，1=启用',
  `sequence` int(3) NULL DEFAULT NULL COMMENT '顺序',
  `cover_pic` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '封面图片',
  PRIMARY KEY (`category_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES (1, '人教版七年级上册', '2020-01-03 18:36:27', NULL, 7, 1, 1, NULL);
INSERT INTO `category` VALUES (2, '人教版七年级下册', '2020-01-04 18:36:54', NULL, 7, 0, 2, NULL);
INSERT INTO `category` VALUES (3, '人教版八年级上册', '2020-01-05 18:37:18', NULL, 8, 0, 3, NULL);

-- ----------------------------
-- Table structure for classification
-- ----------------------------
DROP TABLE IF EXISTS `classification`;
CREATE TABLE `classification`  (
  `id` int(19) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '流水号',
  `word_id` int(19) UNSIGNED NOT NULL COMMENT '单词id',
  `category_id` int(10) UNSIGNED NOT NULL COMMENT '教材id',
  `sequence` int(6) NOT NULL COMMENT '单词在教材中出现的顺序',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `modify_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  `grade_id` int(2) NULL DEFAULT NULL COMMENT '年级id',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `IDX_CATEGORY_ID_WID`(`word_id`, `category_id`) USING BTREE COMMENT '单词id和教材id的索引',
  INDEX `IDX_CLASSFICATION_WID`(`word_id`, `grade_id`) USING BTREE COMMENT '单词id和年级id的索引',
  INDEX `FK_CLA_CATEGORY`(`category_id`) USING BTREE,
  CONSTRAINT `FK_CLA_CATEGORY` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `FK_CLA_WORD` FOREIGN KEY (`word_id`) REFERENCES `words` (`word_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 28 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of classification
-- ----------------------------
INSERT INTO `classification` VALUES (1, 1, 1, 1, '2020-01-05 21:50:26', NULL, 7);
INSERT INTO `classification` VALUES (2, 2, 1, 2, '2020-01-05 21:50:39', NULL, 7);
INSERT INTO `classification` VALUES (3, 3, 1, 3, '2020-01-05 21:50:55', NULL, 7);
INSERT INTO `classification` VALUES (4, 4, 1, 4, '2020-01-05 21:51:07', NULL, 7);
INSERT INTO `classification` VALUES (5, 5, 1, 5, '2020-01-06 15:44:12', NULL, 7);
INSERT INTO `classification` VALUES (6, 6, 1, 6, '2020-01-06 15:44:24', NULL, 7);
INSERT INTO `classification` VALUES (7, 7, 1, 7, '2020-01-06 20:36:07', NULL, 7);
INSERT INTO `classification` VALUES (8, 8, 1, 8, '2020-01-06 20:36:18', NULL, 7);
INSERT INTO `classification` VALUES (9, 9, 1, 9, '2020-01-06 20:36:29', NULL, 7);
INSERT INTO `classification` VALUES (10, 10, 1, 10, '2020-01-06 20:36:41', NULL, 7);
INSERT INTO `classification` VALUES (11, 11, 2, 1, '2020-01-06 21:05:52', NULL, 7);
INSERT INTO `classification` VALUES (12, 12, 2, 2, '2020-01-06 21:05:52', NULL, 7);
INSERT INTO `classification` VALUES (13, 13, 2, 3, '2020-01-06 21:05:52', NULL, 7);
INSERT INTO `classification` VALUES (14, 14, 2, 4, '2020-01-06 21:05:52', NULL, 7);
INSERT INTO `classification` VALUES (15, 15, 2, 5, '2020-01-06 21:05:52', NULL, 7);
INSERT INTO `classification` VALUES (16, 16, 2, 6, '2020-01-06 21:05:52', NULL, 7);
INSERT INTO `classification` VALUES (17, 17, 2, 7, '2020-01-06 21:05:52', NULL, 7);
INSERT INTO `classification` VALUES (18, 18, 2, 8, '2020-01-06 21:05:52', NULL, 7);
INSERT INTO `classification` VALUES (19, 19, 2, 9, '2020-01-06 21:05:52', NULL, 7);
INSERT INTO `classification` VALUES (20, 20, 2, 10, '2020-01-06 21:05:52', NULL, 7);
INSERT INTO `classification` VALUES (21, 21, 2, 11, '2020-01-06 21:05:52', NULL, 7);
INSERT INTO `classification` VALUES (22, 22, 2, 12, '2020-01-06 21:05:52', NULL, 7);
INSERT INTO `classification` VALUES (23, 23, 2, 13, '2020-01-06 21:05:52', NULL, 7);
INSERT INTO `classification` VALUES (24, 24, 2, 14, '2020-01-06 21:05:52', NULL, 7);
INSERT INTO `classification` VALUES (25, 25, 2, 15, '2020-01-06 21:05:52', NULL, 7);
INSERT INTO `classification` VALUES (26, 26, 2, 16, '2020-01-06 21:05:52', NULL, 7);
INSERT INTO `classification` VALUES (27, 27, 2, 17, '2020-01-06 21:05:52', NULL, 7);
INSERT INTO `classification` VALUES (28, 28, 2, 18, '2020-01-06 21:10:07', NULL, 7);

-- ----------------------------
-- Table structure for course
-- ----------------------------
DROP TABLE IF EXISTS `course`;
CREATE TABLE `course`  (
  `course_id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '课程id',
  `teacher_id` int(4) UNSIGNED NOT NULL COMMENT '老师编号',
  `number` int(5) NOT NULL COMMENT '课程人数',
  `course_book_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '课程的单词书id，使用‘|’分割',
  `course_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '课程名称',
  PRIMARY KEY (`course_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of course
-- ----------------------------
INSERT INTO `course` VALUES (1, 1, 2, '1|2|3', '初一进步班');

-- ----------------------------
-- Table structure for edition
-- ----------------------------
DROP TABLE IF EXISTS `edition`;
CREATE TABLE `edition`  (
  `id` int(3) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '流水号',
  `name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '版本名称',
  `create_time` datetime(0) NOT NULL COMMENT '创建时间',
  `modify_time` datetime(0) NOT NULL COMMENT '修改时间',
  `unit_enable` int(1) NOT NULL COMMENT '单元练习是否可用',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for match
-- ----------------------------
DROP TABLE IF EXISTS `match`;
CREATE TABLE `match`  (
  `match_id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '比赛编号',
  `match_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '比赛名字',
  `match_point` int(4) NOT NULL COMMENT '比赛满分积分',
  `words_id` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '比赛所用单词的编号，使用\'|\'分割',
  `teacher_id` int(4) UNSIGNED NOT NULL COMMENT '开启比赛的老师编号',
  `teacher_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '开启比赛的老师',
  `start_time` datetime(0) NOT NULL COMMENT '比赛开始时间',
  `end_time` datetime(0) NOT NULL COMMENT '比赛截止时间',
  `match_time` time(0) NOT NULL COMMENT '比赛持续时间',
  PRIMARY KEY (`match_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of match
-- ----------------------------
INSERT INTO `match` VALUES (1, '一站到底', 100, '1|2|3|4|5|6|7|8|9|10', 1, '张国力', '2020-01-06 16:44:34', '2020-01-07 16:44:37', '00:30:00');
INSERT INTO `match` VALUES (2, '擂台pk', 100, '2|3', 2, '张三', '2020-01-01 17:02:18', '2020-01-02 17:02:22', '17:02:25');

-- ----------------------------
-- Table structure for student
-- ----------------------------
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student`  (
  `student_id` int(7) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '学生编号',
  `student_username` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '学生账户',
  `student_password` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '账户密码',
  `student_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '学生姓名',
  `student_sex` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '学生性别',
  `student_age` int(3) UNSIGNED NOT NULL COMMENT '学生年龄',
  `student_email` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '学生邮箱',
  `course_id` int(5) UNSIGNED NULL DEFAULT NULL COMMENT '学生加入的课程编号',
  `coins` int(4) UNSIGNED NULL DEFAULT 0 COMMENT '金币数量',
  `word_numbers` int(7) UNSIGNED NULL DEFAULT 0 COMMENT '熟练的单词数',
  `points` int(7) UNSIGNED NULL DEFAULT 0 COMMENT '比赛积累的积分',
  `study_status` int(2) UNSIGNED NOT NULL DEFAULT 1 COMMENT '学习状态，1表示没学过，进行学前测试；2表示学习中；3表示学习完，进行学后测试',
  `create_time` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '学生账户创建时间',
  `lastlogin_time` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '学生上次登录时间',
  PRIMARY KEY (`student_id`) USING BTREE,
  INDEX `fk_course_id`(`course_id`) USING BTREE,
  CONSTRAINT `fk_course_id` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of student
-- ----------------------------
INSERT INTO `student` VALUES (1, 'timemachine', '123456', '罗嵘', '男', 20, NULL, 1, 1, 0, 0, 1, NULL, NULL);
INSERT INTO `student` VALUES (2, 'test1', '12345', '曹勇', '男', 20, NULL, 1, 0, 2, 0, 1, NULL, NULL);

-- ----------------------------
-- Table structure for student_matchs
-- ----------------------------
DROP TABLE IF EXISTS `student_matchs`;
CREATE TABLE `student_matchs`  (
  `match_table_id` int(19) UNSIGNED NOT NULL AUTO_INCREMENT,
  `match_id` int(5) UNSIGNED NOT NULL COMMENT '比赛编号',
  `student_id` int(7) UNSIGNED NOT NULL COMMENT '学生编号',
  `match_grade` int(3) UNSIGNED NOT NULL COMMENT '比赛分数',
  `join_time` datetime(0) NOT NULL COMMENT '参加比赛的时间',
  PRIMARY KEY (`match_table_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of student_matchs
-- ----------------------------
INSERT INTO `student_matchs` VALUES (1, 1, 1, 7, '2020-01-06 17:00:47');

-- ----------------------------
-- Table structure for student_words
-- ----------------------------
DROP TABLE IF EXISTS `student_words`;
CREATE TABLE `student_words`  (
  `table_id` int(19) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '表记录编号',
  `student_id` int(7) UNSIGNED NOT NULL COMMENT '学生编号',
  `words_id` int(19) UNSIGNED NOT NULL COMMENT '学习过的单词id',
  `counts` int(4) UNSIGNED NOT NULL DEFAULT 0 COMMENT '单词熟练度',
  `value` int(4) UNSIGNED NOT NULL COMMENT '单词价值量',
  PRIMARY KEY (`table_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of student_words
-- ----------------------------
INSERT INTO `student_words` VALUES (1, 1, 1, 1, 1);
INSERT INTO `student_words` VALUES (2, 1, 2, 0, 1);
INSERT INTO `student_words` VALUES (3, 1, 3, 2, 5);
INSERT INTO `student_words` VALUES (4, 1, 4, 0, 4);
INSERT INTO `student_words` VALUES (5, 1, 5, 0, 4);
INSERT INTO `student_words` VALUES (6, 1, 6, 0, 5);

-- ----------------------------
-- Table structure for teacher
-- ----------------------------
DROP TABLE IF EXISTS `teacher`;
CREATE TABLE `teacher`  (
  `teacher_id` int(4) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '教师编号',
  `teacher_username` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '教师账户',
  `teacher_password` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '教师账户密码',
  `teacher_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '教师姓名',
  `teacher_sex` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '教师性别',
  `teacher_age` int(3) NOT NULL COMMENT '教师年龄',
  `teacher_phone` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '教师电话',
  `teacher_address` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '教师住址',
  `courses_id` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '教师教授的课程，为一个列表，里面保存着课程id',
  PRIMARY KEY (`teacher_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of teacher
-- ----------------------------
INSERT INTO `teacher` VALUES (1, 'test2', '123', '张国力', '男', 35, '17318588734', '安徽省合肥市蜀山区兴隆小区', '1');
INSERT INTO `teacher` VALUES (2, 'test3', '123', '张三', '男', 23, '123534546634', '安徽', '2');

-- ----------------------------
-- Table structure for test
-- ----------------------------
DROP TABLE IF EXISTS `test`;
CREATE TABLE `test`  (
  `test_id` int(7) UNSIGNED NOT NULL AUTO_INCREMENT,
  `student_id` int(7) UNSIGNED NOT NULL COMMENT '学生编号',
  `test_type` int(2) UNSIGNED NOT NULL COMMENT '测试种类：1代表学前测试，2代表学后测试，3代表单元测试',
  `test_grade` int(3) UNSIGNED NOT NULL COMMENT '测试分数',
  PRIMARY KEY (`test_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of test
-- ----------------------------
INSERT INTO `test` VALUES (1, 1, 1, 80);
INSERT INTO `test` VALUES (2, 1, 2, 90);

-- ----------------------------
-- Table structure for words
-- ----------------------------
DROP TABLE IF EXISTS `words`;
CREATE TABLE `words`  (
  `word_id` int(19) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '单词id',
  `word` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '单词的英文拼写',
  `means` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '单词意思',
  `example` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '单词例句',
  `example_means` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '单词例句的中文意思',
  `voice` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '单词的发音网址链接',
  `value` int(4) NOT NULL COMMENT '单词价值量',
  `property` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '单词词性',
  PRIMARY KEY (`word_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 501 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of words
-- ----------------------------
INSERT INTO `words` VALUES (1, 'Question', '问题；疑问；', '', '', NULL, 1, 'n');
INSERT INTO `words` VALUES (2, 'English', '英语；英文；', '', '', NULL, 1, 'n');
INSERT INTO `words` VALUES (3, 'Sincere', '真诚的；', '', '', NULL, 5, 'n');
INSERT INTO `words` VALUES (4, 'Mood', '情绪；', '', '', NULL, 4, 'n');
INSERT INTO `words` VALUES (5, 'Static', '稳定的；', '', '', NULL, 4, 'n');
INSERT INTO `words` VALUES (6, 'Senator', '议员；', '', '', NULL, 5, 'n');
INSERT INTO `words` VALUES (7, 'Hobby', '兴趣；', '', '', NULL, 5, 'n');
INSERT INTO `words` VALUES (8, 'Lad', '小伙子；', '', '', NULL, 1, 'n');
INSERT INTO `words` VALUES (9, 'Equip', '装备；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (10, 'Fasten', '紧抓；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (11, 'Software', '软件；', '', '', NULL, 4, 'n');
INSERT INTO `words` VALUES (12, 'Stir', '搅拌；', '', '', NULL, 1, 'n');
INSERT INTO `words` VALUES (13, 'Distribution', '分配；', '', '', NULL, 6, 'n');
INSERT INTO `words` VALUES (14, 'Flexible', '可调节的；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (15, 'Solution', '解决办法；', '', '', NULL, 5, 'n');
INSERT INTO `words` VALUES (16, 'Panel', '平板；', '', '', NULL, 4, 'n');
INSERT INTO `words` VALUES (17, 'Ministry', '部门；', '', '', NULL, 4, 'n');
INSERT INTO `words` VALUES (18, 'Supreme', '最高的；', '', '', NULL, 5, 'n');
INSERT INTO `words` VALUES (19, 'Describe', '描述；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (20, 'Limb', '细枝；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (21, 'Circumstance', '环境；', '', '', NULL, 9, 'n');
INSERT INTO `words` VALUES (22, 'Core', '核心；', '', '', NULL, 1, 'n');
INSERT INTO `words` VALUES (23, 'Assistant', '助手；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (24, 'Mess', '乱；', '', '', NULL, 1, 'n');
INSERT INTO `words` VALUES (25, 'Minus', '减去；负', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (26, 'Statistic', '统计数据；', '', '', NULL, 6, 'n');
INSERT INTO `words` VALUES (27, 'Pregnant', '孕妇；', '', '', NULL, 7, 'n');
INSERT INTO `words` VALUES (28, 'Sector', '部门；', '', '', NULL, 4, 'n');
INSERT INTO `words` VALUES (29, 'Detection', '侦查；', '', '', NULL, 5, 'n');
INSERT INTO `words` VALUES (30, 'Statue', '雕像；', '', '', NULL, 4, 'n');
INSERT INTO `words` VALUES (31, 'Bride', '新娘；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (32, 'Cycle', '自行车；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (33, 'Saucer', '酱汁；', '', '', NULL, 4, 'n');
INSERT INTO `words` VALUES (34, 'Skillful', '娴熟的；', '', '', NULL, 4, 'n');
INSERT INTO `words` VALUES (35, 'Civilization', '文明；', '', '', NULL, 7, 'n');
INSERT INTO `words` VALUES (36, 'Overhead', '在头上；经费', '', '', NULL, 6, 'n');
INSERT INTO `words` VALUES (37, 'Clash', '碰；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (38, 'Grant', '授予；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (39, 'Bond', '绑；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (40, 'Staff', '人员；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (41, 'Intermediate', '中部的；', '', '', NULL, 10, 'n');
INSERT INTO `words` VALUES (42, 'Guitar', '吉他；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (43, 'Comprehensive', '综合的；', '', '', NULL, 10, 'n');
INSERT INTO `words` VALUES (44, 'Presence', '出席；', '', '', NULL, 6, 'n');
INSERT INTO `words` VALUES (45, 'Appliance', '器械；', '', '', NULL, 7, 'n');
INSERT INTO `words` VALUES (46, 'Cushion', '垫子；', '', '', NULL, 5, 'n');
INSERT INTO `words` VALUES (47, 'Emergency', '紧急情况；', '', '', NULL, 8, 'n');
INSERT INTO `words` VALUES (48, 'Solve', '解决；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (49, 'Label', '标签；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (50, 'Slim', '瘦的；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (51, 'Status', '地位；', '', '', NULL, 4, 'n');
INSERT INTO `words` VALUES (52, 'Steady', '平稳的；', '', '', NULL, 5, 'n');
INSERT INTO `words` VALUES (53, 'Include', '包括；', '', '', NULL, 6, 'n');
INSERT INTO `words` VALUES (54, 'Resistance', '阻力；', '', '', NULL, 9, 'n');
INSERT INTO `words` VALUES (55, 'Prime', '主要的；', '', '', NULL, 4, 'n');
INSERT INTO `words` VALUES (56, 'Ambassador', '大使；', '', '', NULL, 10, 'n');
INSERT INTO `words` VALUES (57, 'Derive', '起源；', '', '', NULL, 5, 'n');
INSERT INTO `words` VALUES (58, 'Sponsor', '启动者；资助者；', '', '', NULL, 7, 'n');
INSERT INTO `words` VALUES (59, 'Proportion', '比例；', '', '', NULL, 8, 'n');
INSERT INTO `words` VALUES (60, 'Mental', '金属；', '', '', NULL, 5, 'n');
INSERT INTO `words` VALUES (61, 'Punch', '打’', '', '', NULL, 4, 'n');
INSERT INTO `words` VALUES (62, 'Result', '导致；', '', '', NULL, 4, 'n');
INSERT INTO `words` VALUES (63, 'Client', '顾客；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (64, 'Steamer', '蒸汽轮船；', '', '', NULL, 7, 'n');
INSERT INTO `words` VALUES (65, 'Option', '选择；', '', '', NULL, 6, 'n');
INSERT INTO `words` VALUES (66, 'Dormitory', '寝室；', '', '', NULL, 9, 'n');
INSERT INTO `words` VALUES (67, 'Attitude', '态度；', '', '', NULL, 7, 'n');
INSERT INTO `words` VALUES (68, 'Steep', '陡的；', '', '', NULL, 5, 'n');
INSERT INTO `words` VALUES (69, 'Agency', '部；', '', '', NULL, 6, 'n');
INSERT INTO `words` VALUES (70, 'Steer', '掌舵；', '', '', NULL, 4, 'n');
INSERT INTO `words` VALUES (71, 'Scandal', '丑闻；', '', '', NULL, 6, 'n');
INSERT INTO `words` VALUES (72, 'Definite', '当然的；', '', '', NULL, 6, 'n');
INSERT INTO `words` VALUES (73, 'Cautious', '当心的；', '', '', NULL, 8, 'n');
INSERT INTO `words` VALUES (74, 'Prayer', '祈祷；', '', '', NULL, 5, 'n');
INSERT INTO `words` VALUES (75, 'Nest', '巢；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (76, 'Domestic', '本国的；', '', '', NULL, 9, 'n');
INSERT INTO `words` VALUES (77, 'Chest', '箱子；胸部', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (78, 'Airline', '飞机；', '', '', NULL, 4, 'n');
INSERT INTO `words` VALUES (79, 'Rebel', '反叛；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (80, 'Satisfactory', '满意的；', '', '', NULL, 10, 'n');
INSERT INTO `words` VALUES (81, 'Stem', '主干；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (82, 'Render', '给予；', '', '', NULL, 5, 'n');
INSERT INTO `words` VALUES (83, 'Object', '反对；', '', '', NULL, 4, 'n');
INSERT INTO `words` VALUES (84, 'Gardener', '园丁；', '', '', NULL, 8, 'n');
INSERT INTO `words` VALUES (85, 'Shrink', '皱缩；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (86, 'Parade', '检阅；', '', '', NULL, 4, 'n');
INSERT INTO `words` VALUES (87, 'Rumour', '谣言；', '', '', NULL, 6, 'n');
INSERT INTO `words` VALUES (88, 'Rug', '小地毯；', '', '', NULL, 1, 'n');
INSERT INTO `words` VALUES (89, 'Establish', '建立；', '', '', NULL, 8, 'n');
INSERT INTO `words` VALUES (90, 'Primarily', '就要地；', '', '', NULL, 8, 'n');
INSERT INTO `words` VALUES (91, 'Kindness', '好意；', '', '', NULL, 8, 'n');
INSERT INTO `words` VALUES (92, 'Breast', '胸脯；', '', '', NULL, 5, 'n');
INSERT INTO `words` VALUES (93, 'Sticky', '黏的；', '', '', NULL, 4, 'n');
INSERT INTO `words` VALUES (94, 'Boost', '激发；促进', '', '', NULL, 4, 'n');
INSERT INTO `words` VALUES (95, 'Fund', '基金；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (96, 'Incredible', '难以置信的；', '', '', NULL, 9, 'n');
INSERT INTO `words` VALUES (97, 'Abroad', '到国外；', '', '', NULL, 5, 'n');
INSERT INTO `words` VALUES (98, 'Detective', '侦探；', '', '', NULL, 8, 'n');
INSERT INTO `words` VALUES (99, 'Stiff', '僵硬的；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (100, 'Stimulate', '激发；', '', '', NULL, 8, 'n');
INSERT INTO `words` VALUES (101, 'Fame', '名望；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (102, 'Consume', '消费；消化；', '', '', NULL, 7, 'n');
INSERT INTO `words` VALUES (103, 'Accelerate', '加速；', '', '', NULL, 8, 'n');
INSERT INTO `words` VALUES (104, 'Lightning', '闪电；', '', '', NULL, 7, 'n');
INSERT INTO `words` VALUES (105, 'Sting', '刺；叮；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (106, 'Bound', '划界；', '', '', NULL, 4, 'n');
INSERT INTO `words` VALUES (107, 'Rouse', '唤醒；', '', '', NULL, 4, 'n');
INSERT INTO `words` VALUES (108, 'Cultivate', '培养；', '', '', NULL, 6, 'n');
INSERT INTO `words` VALUES (109, 'Material', '材料；', '', '', NULL, 5, 'n');
INSERT INTO `words` VALUES (110, 'Personnel', '人员；', '', '', NULL, 8, 'n');
INSERT INTO `words` VALUES (111, 'Display', '播放；', '', '', NULL, 5, 'n');
INSERT INTO `words` VALUES (112, 'Particle', '粒子；', '', '', NULL, 5, 'n');
INSERT INTO `words` VALUES (113, 'Impression', '深刻印象；', '', '', NULL, 9, 'n');
INSERT INTO `words` VALUES (114, 'Biology', '生物；', '', '', NULL, 6, 'n');
INSERT INTO `words` VALUES (115, 'Drunk', '醉的；', '', '', NULL, 4, 'n');
INSERT INTO `words` VALUES (116, 'Barrier', '障碍；', '', '', NULL, 5, 'n');
INSERT INTO `words` VALUES (117, 'Stock', '存货；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (118, 'Fisherman', '渔夫；', '', '', NULL, 8, 'n');
INSERT INTO `words` VALUES (119, 'Politician', '政客；', '', '', NULL, 7, 'n');
INSERT INTO `words` VALUES (120, 'Royal', '王室的；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (121, 'Barber', '理发师；', '', '', NULL, 4, 'n');
INSERT INTO `words` VALUES (122, 'Stocking', '长袜；', '', '', NULL, 7, 'n');
INSERT INTO `words` VALUES (123, 'Delegate', '代表；', '', '', NULL, 8, 'n');
INSERT INTO `words` VALUES (124, 'Highlight', '突出；', '', '', NULL, 8, 'n');
INSERT INTO `words` VALUES (125, 'Depression', '沮丧；', '', '', NULL, 9, 'n');
INSERT INTO `words` VALUES (126, 'Signature', '签名；', '', '', NULL, 9, 'n');
INSERT INTO `words` VALUES (127, 'Atmosphere', '大气；', '', '', NULL, 10, 'n');
INSERT INTO `words` VALUES (128, 'Evaluate', '估价；', '', '', NULL, 6, 'n');
INSERT INTO `words` VALUES (129, 'Rescue', '救援；', '', '', NULL, 5, 'n');
INSERT INTO `words` VALUES (130, 'Personally', '人格；', '', '', NULL, 8, 'n');
INSERT INTO `words` VALUES (131, 'Latter', '后面的；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (132, 'Parliament', '议会；', '', '', NULL, 8, 'n');
INSERT INTO `words` VALUES (133, 'Input', '输入；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (134, 'Partial', '部分的；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (135, 'Loyalty', '忠诚；', '', '', NULL, 4, 'n');
INSERT INTO `words` VALUES (136, 'Calendar', '日历；历法', '', '', NULL, 5, 'n');
INSERT INTO `words` VALUES (137, 'Overlook', '忽视；', '', '', NULL, 5, 'n');
INSERT INTO `words` VALUES (138, 'Debate', '争论；', '', '', NULL, 4, 'n');
INSERT INTO `words` VALUES (139, 'Stoop', '俯身；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (140, 'Cube', '立方体；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (141, 'Submerge', '沉入；', '', '', NULL, 7, 'n');
INSERT INTO `words` VALUES (142, 'Credit', '信用；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (143, 'Surrounding', '环境；', '', '', NULL, 10, 'n');
INSERT INTO `words` VALUES (144, 'Stove', '电炉；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (145, 'Submit', '屈服；', '', '', NULL, 4, 'n');
INSERT INTO `words` VALUES (146, 'Carrier', '运输工具；', '', '', NULL, 4, 'n');
INSERT INTO `words` VALUES (147, 'Imply', '暗示；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (148, 'Strain', '拉紧；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (149, 'Consist', '组成；', '', '', NULL, 4, 'n');
INSERT INTO `words` VALUES (150, 'Strap', '捆扎；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (151, 'Efficient', '有效率的；', '', '', NULL, 5, 'n');
INSERT INTO `words` VALUES (152, 'Accommodation', '膳宿；', '', '', NULL, 10, 'n');
INSERT INTO `words` VALUES (153, 'Strategic', '战略；', '', '', NULL, 6, 'n');
INSERT INTO `words` VALUES (154, 'Layer', '层；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (155, 'Exclaim', '呼喊；', '', '', NULL, 5, 'n');
INSERT INTO `words` VALUES (156, 'Representative', '有代表性；', '', '', NULL, 10, 'n');
INSERT INTO `words` VALUES (157, 'Forecast', '预报；', '', '', NULL, 6, 'n');
INSERT INTO `words` VALUES (158, 'Discipline', '纪律；', '', '', NULL, 7, 'n');
INSERT INTO `words` VALUES (159, 'Neutral', '中性的；', '', '', NULL, 5, 'n');
INSERT INTO `words` VALUES (160, 'Interpret', '打断；', '', '', NULL, 6, 'n');
INSERT INTO `words` VALUES (161, 'Knot', '结；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (162, 'Desirable', '向往的；', '', '', NULL, 7, 'n');
INSERT INTO `words` VALUES (163, 'Promote', '促进；', '', '', NULL, 6, 'n');
INSERT INTO `words` VALUES (164, 'Acceptance', '接受；', '', '', NULL, 9, 'n');
INSERT INTO `words` VALUES (165, 'Mayor', '市长；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (166, 'Equation', '方程；', '', '', NULL, 6, 'n');
INSERT INTO `words` VALUES (167, 'Routine', '管理；', '', '', NULL, 5, 'n');
INSERT INTO `words` VALUES (168, 'Ripe', '成熟的；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (169, 'Prove', '证明；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (170, 'Likewise', '然而；', '', '', NULL, 6, 'n');
INSERT INTO `words` VALUES (171, 'Chap', '小伙子；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (172, 'Explore', '探险；', '', '', NULL, 5, 'n');
INSERT INTO `words` VALUES (173, 'Overnight', '整夜；', '', '', NULL, 7, 'n');
INSERT INTO `words` VALUES (174, 'Strategy', '策略；', '', '', NULL, 6, 'n');
INSERT INTO `words` VALUES (175, 'Straw', '吸管；', '', '', NULL, 4, 'n');
INSERT INTO `words` VALUES (176, 'Bind', '捆扎；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (177, 'Stream', '溪流；', '', '', NULL, 5, 'n');
INSERT INTO `words` VALUES (178, 'Bearing', '风度；', '', '', NULL, 6, 'n');
INSERT INTO `words` VALUES (179, 'Suppose', '假定；', '', '', NULL, 7, 'n');
INSERT INTO `words` VALUES (180, 'Access', '方式；路；', '', '', NULL, 5, 'n');
INSERT INTO `words` VALUES (181, 'Remain', '保持；', '', '', NULL, 6, 'n');
INSERT INTO `words` VALUES (182, 'Abstract', '抽象；', '', '', NULL, 7, 'n');
INSERT INTO `words` VALUES (183, 'Stretch', '延伸；', '', '', NULL, 5, 'n');
INSERT INTO `words` VALUES (184, 'Approximate', '估计；', '', '', NULL, 9, 'n');
INSERT INTO `words` VALUES (185, 'Striking', '显眼的；', '', '', NULL, 6, 'n');
INSERT INTO `words` VALUES (186, 'Abuse', '滥用；', '', '', NULL, 4, 'n');
INSERT INTO `words` VALUES (187, 'Critic', '批判；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (188, 'Interpretation', '口译；', '', '', NULL, 10, 'n');
INSERT INTO `words` VALUES (189, 'String', '弦；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (190, 'Illustrate', '图示；', '', '', NULL, 8, 'n');
INSERT INTO `words` VALUES (191, 'Helpful', '有帮助的；', '', '', NULL, 6, 'n');
INSERT INTO `words` VALUES (192, 'Leak', '裂缝；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (193, 'Accountant', '会计；', '', '', NULL, 9, 'n');
INSERT INTO `words` VALUES (194, 'Crude', '粗野的；未加工的；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (195, 'Strip', '剥去；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (196, 'stripe', '条纹；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (197, 'Communicate', '交流；', '', '', NULL, 10, 'n');
INSERT INTO `words` VALUES (198, 'Following', '接下来的；', '', '', NULL, 7, 'n');
INSERT INTO `words` VALUES (199, 'Hedge', '篱笆；', '', '', NULL, 4, 'n');
INSERT INTO `words` VALUES (200, 'Consumer', '消费者；', '', '', NULL, 8, 'n');
INSERT INTO `words` VALUES (201, 'Emotional', '情绪化的；', '', '', NULL, 8, 'n');
INSERT INTO `words` VALUES (202, 'Craft', '工艺；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (203, 'Institute', '协会；', '', '', NULL, 5, 'n');
INSERT INTO `words` VALUES (204, 'Indispensable', '不可缺少的；', '', '', NULL, 10, 'n');
INSERT INTO `words` VALUES (205, 'Scheme', '计划；', '', '', NULL, 5, 'n');
INSERT INTO `words` VALUES (206, 'Scale', '比例；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (207, 'Replace', '代替；', '', '', NULL, 5, 'n');
INSERT INTO `words` VALUES (208, 'Bark', '树皮；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (209, 'Gramme', '克（重量单位）；', '', '', NULL, 6, 'n');
INSERT INTO `words` VALUES (210, 'Congress', '国会；', '', '', NULL, 7, 'n');
INSERT INTO `words` VALUES (211, 'Bump', '碰撞；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (212, 'Stroke', '划水；中风；', '', '', NULL, 4, 'n');
INSERT INTO `words` VALUES (213, 'Ingredient', '成分；', '', '', NULL, 9, 'n');
INSERT INTO `words` VALUES (214, 'Arbitrary', '专制的；武断的；', '', '', '', 7, 'n');
INSERT INTO `words` VALUES (215, 'Pinch', '撮；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (216, 'Exploit', '开发；', '', '', NULL, 5, 'n');
INSERT INTO `words` VALUES (217, 'Ash', '灰；', '', '', NULL, 1, 'n');
INSERT INTO `words` VALUES (218, 'Rope', '绳；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (219, 'Bulk', '大宗货物；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (220, 'Strengthen', '巩固；', '', '', NULL, 9, 'n');
INSERT INTO `words` VALUES (221, 'Independent', '独立的；', '', '', NULL, 10, 'n');
INSERT INTO `words` VALUES (222, 'Board', '去国外；', '', '', NULL, 4, 'n');
INSERT INTO `words` VALUES (223, 'Recall', '回忆起；', '', '', NULL, 4, 'n');
INSERT INTO `words` VALUES (224, 'Studio', '工作室；', '', '', NULL, 5, 'n');
INSERT INTO `words` VALUES (225, 'Grave', '坟墓；', '', '', NULL, 4, 'n');
INSERT INTO `words` VALUES (226, 'Formal', '正式的；', '', '', NULL, 5, 'n');
INSERT INTO `words` VALUES (227, 'Absorb', '吸收；', '', '', NULL, 5, 'n');
INSERT INTO `words` VALUES (228, 'Sensitive', '敏感的；', '', '', NULL, 6, 'n');
INSERT INTO `words` VALUES (229, 'Ability', '能力；', '', '', NULL, 5, 'n');
INSERT INTO `words` VALUES (230, 'Fairy', '小仙子；', '', '', NULL, 4, 'n');
INSERT INTO `words` VALUES (231, 'Talent', '天赋；', '', '', NULL, 6, 'n');
INSERT INTO `words` VALUES (232, 'Comparison', '比较；', '', '', NULL, 9, 'n');
INSERT INTO `words` VALUES (233, 'Stuff', '填；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (234, 'Brow', '眉毛；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (235, 'Infer', '推断；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (236, 'Invasion', '侵略；', '', '', NULL, 6, 'n');
INSERT INTO `words` VALUES (237, 'Grand', '极好的；', '', '', NULL, 5, 'n');
INSERT INTO `words` VALUES (238, 'Stress', '压力；', '', '', NULL, 5, 'n');
INSERT INTO `words` VALUES (239, 'Journalist', '记者；', '', '', NULL, 7, 'n');
INSERT INTO `words` VALUES (240, 'Supply', '供给；', '', '', NULL, 6, 'n');
INSERT INTO `words` VALUES (241, 'Penetrate', '刺入；', '', '', NULL, 8, 'n');
INSERT INTO `words` VALUES (242, 'Subject', '主题；', '', '', NULL, 7, 'n');
INSERT INTO `words` VALUES (243, 'Pole', '地极；', '', '', NULL, 1, 'n');
INSERT INTO `words` VALUES (244, 'Raw', '原始的；', '', '', NULL, 1, 'n');
INSERT INTO `words` VALUES (245, 'Embassy', '大使馆；', '', '', NULL, 8, 'n');
INSERT INTO `words` VALUES (246, 'Carpenter', '木匠；', '', '', NULL, 9, 'n');
INSERT INTO `words` VALUES (247, 'Appropriate', '恰当的；', '', '', NULL, 10, 'n');
INSERT INTO `words` VALUES (248, 'Socialist', '社会学家；', '', '', NULL, 6, 'n');
INSERT INTO `words` VALUES (249, 'Protein', '潜在的；', '', '', NULL, 5, 'n');
INSERT INTO `words` VALUES (250, 'Enlarge', '扩充；', '', '', NULL, 5, 'n');
INSERT INTO `words` VALUES (251, 'Inherit', '继承；', '', '', NULL, 4, 'n');
INSERT INTO `words` VALUES (252, 'Chemist', '化学家；', '', '', NULL, 5, 'n');
INSERT INTO `words` VALUES (253, 'Conflict', '冲突；', '', '', NULL, 5, 'n');
INSERT INTO `words` VALUES (254, 'Drain', '排水；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (255, 'Architecture', '建筑学；', '', '', NULL, 10, 'n');
INSERT INTO `words` VALUES (256, 'Charity', '慈善机构；', '', '', NULL, 4, 'n');
INSERT INTO `words` VALUES (257, 'Entitle', '命名；', '', '', NULL, 4, 'n');
INSERT INTO `words` VALUES (258, 'Subsequent', '之后的；', '', '', NULL, 10, 'n');
INSERT INTO `words` VALUES (259, 'Span', '延长；跨度；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (260, 'Instruct', '命令；', '', '', NULL, 5, 'n');
INSERT INTO `words` VALUES (261, 'Spite', '恶意的；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (262, 'Slender', '苗条的；', '', '', NULL, 5, 'n');
INSERT INTO `words` VALUES (263, 'Automobile', '机车；', '', '', NULL, 8, 'n');
INSERT INTO `words` VALUES (264, 'Behavior', '行为；', '', '', NULL, 6, 'n');
INSERT INTO `words` VALUES (265, 'Envy', '羡慕；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (266, 'Substance', '物质；', '', '', NULL, 7, 'n');
INSERT INTO `words` VALUES (267, 'Contest', '竞赛；', '', '', NULL, 5, 'n');
INSERT INTO `words` VALUES (268, 'Spit', '吐；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (269, 'Mutual', '互相；', '', '', NULL, 4, 'n');
INSERT INTO `words` VALUES (270, 'Dorm', '宿舍；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (271, 'Substantial', '丰裕的；', '', '', NULL, 8, 'n');
INSERT INTO `words` VALUES (272, 'Meanwhile', '同时；', '', '', NULL, 8, 'n');
INSERT INTO `words` VALUES (273, 'Desire', '渴望；', '', '', NULL, 6, 'n');
INSERT INTO `words` VALUES (274, 'Conviction', '确信；', '', '', NULL, 7, 'n');
INSERT INTO `words` VALUES (275, 'Blue', '蓝色；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (276, 'Green', '绿色；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (277, 'Red', '红色；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (278, 'Yellow', '黄色；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (279, 'Orange', '橘色；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (280, 'Purple', '紫色；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (281, 'White', '白色；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (282, 'Gym', '体育馆；', '', '', NULL, 1, 'n');
INSERT INTO `words` VALUES (283, 'lightes', '灯；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (284, 'Lesson', '课；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (285, 'Book', '书；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (286, 'Notebook', '笔记本；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (287, 'Pencil', '铅笔；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (288, 'School', '学校；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (289, 'Chair', '椅子；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (290, 'Student', '学生；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (291, 'Teacher', '老师；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (292, 'Office', '办公室；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (293, 'Pen', '钢笔；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (294, 'Eraser', '橡皮；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (295, 'Ruler', '尺子；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (296, 'Marker', '水彩笔；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (297, 'Envelope', '信封；', '', '', NULL, 1, 'n');
INSERT INTO `words` VALUES (298, 'Stamp', '邮票；', '', '', NULL, 1, 'n');
INSERT INTO `words` VALUES (299, 'Glue', '胶水；', '', '', NULL, 1, 'n');
INSERT INTO `words` VALUES (300, 'Number', '数字号码；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (301, 'Zero', '零；', '', '', NULL, 1, 'n');
INSERT INTO `words` VALUES (302, 'One', '一；', '', '', NULL, 1, 'n');
INSERT INTO `words` VALUES (303, 'Four', '四；', '', '', NULL, 1, 'n');
INSERT INTO `words` VALUES (304, 'Seven', '七；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (305, 'Eight', '八；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (306, 'Nine', '九；', '', '', NULL, 1, 'n');
INSERT INTO `words` VALUES (307, 'Eleven', '十一；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (308, 'First', '第一；', '', '', NULL, 1, 'n');
INSERT INTO `words` VALUES (309, 'Second', '第二；', '', '', NULL, 1, 'n');
INSERT INTO `words` VALUES (310, 'Ten', '十；', '', '', NULL, 1, 'n');
INSERT INTO `words` VALUES (311, 'Twelve', '十二；', '', '', NULL, 1, 'n');
INSERT INTO `words` VALUES (312, 'Fourteen', '十四；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (313, 'Fifteen', '十五；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (314, 'Sixteen', '十六；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (315, 'Seventeen', '十七；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (316, 'NIneteen', '十九；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (317, 'Tenthe', '第十；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (318, 'Ninthe', '第十；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (319, 'Family', '家庭；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (320, 'Father', '爸爸；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (321, 'Dad', '爸爸；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (322, 'Mother', '妈妈；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (323, 'Mum', '妈妈；', '', '', NULL, 1, 'n');
INSERT INTO `words` VALUES (324, 'Aunt', '姑妈；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (325, 'Uncle', '舅舅；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (326, 'Cousin', '表兄妹；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (327, 'Nephew', '侄子；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (328, 'Face', '脸；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (329, 'Foot', '脚；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (330, 'Hand', '手；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (331, 'Leg', '腿；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (332, 'Nose', '鼻子；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (333, 'Elbow', '胳膊；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (334, 'Finger', '手指；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (335, 'Shoulder', '肩膀；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (336, 'Stomach', '肚子；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (337, 'Knee', '膝盖；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (338, 'Toe', '脚趾；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (339, 'Arm', '胳膊；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (340, 'Wrist', '手腕；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (341, 'Ear', '耳朵；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (342, 'Eye', '眼睛；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (343, 'Bathroom', '卫生间；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (344, 'Bed', '床；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (345, 'Kitchen', '厨房；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (346, 'Room', '房间；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (347, 'Door', '门；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (348, 'Ceiling', '天花板；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (349, 'Sink', '洗涤槽；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (350, 'Dish', '盘子；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (351, 'Stove', '炉灶；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (352, 'Gloves', '手套；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (353, 'Boots', '靴子；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (354, 'Pajamas', '睡衣裤；', '', '', NULL, 4, 'n');
INSERT INTO `words` VALUES (355, 'Skirt', '短裤；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (356, 'Socks', '袜子；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (357, 'Shower', '淋浴；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (358, 'Dresser', '化妆台；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (359, 'Couch', '长沙发；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (360, 'Time', '时间；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (361, 'Towel', '毛巾；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (362, 'Week', '周；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (363, 'Morning', '早上；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (364, 'Noon', '中午；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (365, 'Holiday', '假日；节日；', '', '', NULL, 4, 'n');
INSERT INTO `words` VALUES (366, 'Spring', '春天；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (367, 'Season', '季节；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (368, 'Summer', '夏天；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (369, 'Fall', '秋天；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (370, 'Winter', '冬天；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (371, 'Doctor', '医生；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (372, 'Friend', '朋友；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (373, 'Line', '直线；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (374, 'Supper', '晚饭；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (375, 'Meat', '肉；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (376, 'Pork', '猪肉；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (377, 'Judge', '法官；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (378, 'Baby', '婴儿；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (379, 'Singer', '歌手；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (380, 'Oil', '油；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (381, 'Salt', '盐；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (382, 'Shape', '形状；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (383, 'Circle', '圆圈；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (384, 'Beach', '海滩；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (385, 'Rock', '岩石；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (386, 'Tree', '树；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (387, 'Flour', '面粉；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (388, 'Egg', '鸡蛋；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (389, 'Sugar', '糖；', '', '', NULL, 1, 'n');
INSERT INTO `words` VALUES (390, 'Snack', '小吃；零食；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (391, 'Lamb', '羔羊肉；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (392, 'Hall', '大厅；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (393, 'Mall', '商业街；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (394, 'Pond', '池塘；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (395, 'Mud', '泥；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (396, 'Market', '市场；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (397, 'Country', '乡村；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (398, 'Short', '矮；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (399, 'Never', '从来没有；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (400, 'Best', '最好的；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (401, 'Right', '正确的；', '', '', NULL, 1, 'n');
INSERT INTO `words` VALUES (402, 'Western', '西方；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (403, 'Quickly', '快速地；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (404, 'Slowly', '缓慢的；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (405, 'Well', '好；', '', '', NULL, 1, 'n');
INSERT INTO `words` VALUES (406, 'Eearly', '早的；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (407, 'Special', '特别的；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (408, 'Last', '上一个；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (409, 'Loud', '响亮的；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (410, 'Hard', '难；困难；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (411, 'Next', '下一个；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (412, 'Cold', '冷的；', '', '', NULL, 1, 'n');
INSERT INTO `words` VALUES (413, 'Hot', '热的；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (414, 'Warm', '温暖的；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (415, 'Snowy', '下雪的；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (416, 'Fast', '快速地；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (417, 'Quiet', '安静的；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (418, 'Soon', '不久；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (419, 'Rainy', '下雨的；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (420, 'Draw', '画；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (421, 'Hear', '听见；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (422, 'Walk', '走；', '', '', NULL, 1, 'n');
INSERT INTO `words` VALUES (423, 'Listen', '听；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (424, 'Meet', '见到；遇到；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (425, 'Miss', '丢掉；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (426, 'Buy', '买；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (427, 'Arrive', '到达；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (428, 'Come', '来；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (429, 'Sleep', '睡；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (430, 'Learn', '学习；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (431, 'Find', '发现；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (432, 'Point', '指出；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (433, 'Send', '寄出；送；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (434, 'Sit', '坐；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (435, 'Run', '跑；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (436, 'Leave', '离开；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (437, 'Hurt', '伤害；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (438, 'Stand', '站；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (439, 'Invite', '邀请；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (440, 'Cook', '做饭；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (441, 'Dry', '擦汗；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (442, 'Fall', '摔倒；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (443, 'Ski', '滑雪；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (444, 'Will', '将来；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (445, 'Visit', '拜访；参观；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (446, 'Think', '想；认为；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (447, 'Watch', '观看；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (448, 'Begin', '开始；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (449, 'Carry', '搬运；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (450, 'Call', '打电话；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (451, 'Fly', '放飞；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (452, 'Forget', '忘记；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (453, 'Lie', '躺；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (454, 'Inside', '里面；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (455, 'Outside', '外面；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (456, 'Top', '顶；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (457, 'Left', '左边；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (458, 'Right', '右边；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (459, 'East', '东；', '', '', NULL, 1, 'n');
INSERT INTO `words` VALUES (460, 'South', '南；', '', '', NULL, 1, 'n');
INSERT INTO `words` VALUES (461, 'West', '西；', '', '', NULL, 1, 'n');
INSERT INTO `words` VALUES (462, 'North', '北；', '', '', NULL, 1, 'n');
INSERT INTO `words` VALUES (463, 'This', '这；这个；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (464, 'Those', '那些；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (465, 'Any', '任何一个；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (466, 'All', '全部；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (467, 'Something', '某物；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (468, 'Every', '每个；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (469, 'Duck', '鸭子；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (470, 'Horse', '马；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (471, 'Fur', '皮毛；', '', '', NULL, 1, 'n');
INSERT INTO `words` VALUES (472, 'Tail', '尾巴；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (473, 'Lion', '狮子；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (474, 'Car', '小汽车；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (475, 'Taxi', '出租车；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (476, 'Airplane', '飞机；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (477, 'Wolf', '狼；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (478, 'Boat', '船；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (479, 'Ship', '轮船；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (480, 'Bell', '铃铛；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (481, 'Chain', '车链；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (482, 'Panda', '熊猫；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (483, 'cat', '猫；', '', '', NULL, 1, 'n');
INSERT INTO `words` VALUES (484, 'Cow', '奶牛；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (485, 'Finally', '最后；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (486, 'Then', '然后；那么；', '', '', NULL, 1, 'n');
INSERT INTO `words` VALUES (487, 'Wrong', '错误的；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (488, 'Beautiful', '漂亮的；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (489, 'Famous', '有名的；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (490, 'Grass', '草；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (491, 'Farm', '农场；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (492, 'Rose', '玫瑰；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (493, 'Actress', '女演员；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (494, 'Waiter', '服务员；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (495, 'Academy', '学院；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (496, 'Hardship', '艰难；困苦；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (497, 'Musical', '音乐的；', '', '', NULL, 2, 'n');
INSERT INTO `words` VALUES (498, 'Sunset', '日落；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (499, 'Probable', '可能的；大概的；', '', '', NULL, 3, 'n');
INSERT INTO `words` VALUES (500, 'Demand', '强烈要求；需要；', '', '', NULL, 4, 'n');

-- ----------------------------
-- Triggers structure for table student
-- ----------------------------
DROP TRIGGER IF EXISTS `t_inst_stu`;
delimiter ;;
CREATE TRIGGER `t_inst_stu` AFTER INSERT ON `student` FOR EACH ROW update course
set number = number+1
where(course.course_id=new.course_id)
;
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table student
-- ----------------------------
DROP TRIGGER IF EXISTS `t_delete_stu`;
delimiter ;;
CREATE TRIGGER `t_delete_stu` AFTER DELETE ON `student` FOR EACH ROW update course
set number = number-1
where(course.course_id=old.course_id)
;
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
