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

 Date: 31/12/2019 14:42:56
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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for course
-- ----------------------------
DROP TABLE IF EXISTS `course`;
CREATE TABLE `course`  (
  `course_id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '课程id',
  `number` int(5) NOT NULL COMMENT '课程人数',
  `course_book_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '课程的单词书id，使用‘|’分割',
  PRIMARY KEY (`course_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of course
-- ----------------------------
INSERT INTO `course` VALUES (1, 1, '12|34|2');

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
  `teacher_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '开启比赛的老师',
  `start_time` datetime(0) NOT NULL COMMENT '比赛开始时间',
  `end_time` datetime(0) NOT NULL COMMENT '比赛截止时间',
  `match_time` time(0) NOT NULL COMMENT '比赛持续时间',
  PRIMARY KEY (`match_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for means
-- ----------------------------
DROP TABLE IF EXISTS `means`;
CREATE TABLE `means`  (
  `word_id` int(19) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '单词id',
  `pos_id` int(2) NOT NULL,
  `means` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  INDEX `fk_means_1_idx`(`pos_id`) USING BTREE,
  INDEX `fk_means_1_idx1`(`word_id`) USING BTREE,
  CONSTRAINT `fk_means_1` FOREIGN KEY (`word_id`) REFERENCES `words` (`word_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_means_2` FOREIGN KEY (`pos_id`) REFERENCES `pos` (`pos_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for pos
-- ----------------------------
DROP TABLE IF EXISTS `pos`;
CREATE TABLE `pos`  (
  `pos_id` int(2) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `means` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`pos_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 77 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pos
-- ----------------------------
INSERT INTO `pos` VALUES (1, 'n.', '名词');
INSERT INTO `pos` VALUES (2, 'pron.', '代词');
INSERT INTO `pos` VALUES (3, 'adj.', '形容词');
INSERT INTO `pos` VALUES (4, 'adv.', '副词');
INSERT INTO `pos` VALUES (5, 'vi.', '不及无动词');
INSERT INTO `pos` VALUES (6, 'vt.', '及无动词');
INSERT INTO `pos` VALUES (7, 'num.', '数词');
INSERT INTO `pos` VALUES (8, 'art.', '冠词');
INSERT INTO `pos` VALUES (9, 'prep. ', '介词');
INSERT INTO `pos` VALUES (10, 'conj.', '连词');
INSERT INTO `pos` VALUES (11, 'int.', '感叹词');
INSERT INTO `pos` VALUES (21, 'aux.', NULL);
INSERT INTO `pos` VALUES (22, 'v.', NULL);
INSERT INTO `pos` VALUES (23, 'det.', NULL);
INSERT INTO `pos` VALUES (24, 'prep.', NULL);
INSERT INTO `pos` VALUES (25, 'vt.& vi.', NULL);
INSERT INTO `pos` VALUES (26, '', NULL);
INSERT INTO `pos` VALUES (27, 'abbr.', NULL);
INSERT INTO `pos` VALUES (28, 'adj.& pron.', NULL);
INSERT INTO `pos` VALUES (29, 'vt.& vi.& link-v.', NULL);
INSERT INTO `pos` VALUES (30, 'vt.&vi.', NULL);
INSERT INTO `pos` VALUES (31, 'n. &adj.', NULL);
INSERT INTO `pos` VALUES (32, 'vi.& link-v.', NULL);
INSERT INTO `pos` VALUES (33, 'adj.& adv.', NULL);
INSERT INTO `pos` VALUES (34, 'link-v.', NULL);
INSERT INTO `pos` VALUES (35, 'vi.&vt.', NULL);
INSERT INTO `pos` VALUES (36, 'prep.&conj.', NULL);
INSERT INTO `pos` VALUES (37, 'quant.', NULL);
INSERT INTO `pos` VALUES (38, 'na.', NULL);
INSERT INTO `pos` VALUES (39, 'pref.', NULL);
INSERT INTO `pos` VALUES (40, 'adj.& n.', NULL);
INSERT INTO `pos` VALUES (41, 'v.& n.', NULL);
INSERT INTO `pos` VALUES (42, 'vi.& vt.', NULL);
INSERT INTO `pos` VALUES (43, 'adv.& adj.', NULL);
INSERT INTO `pos` VALUES (44, 'n.& v.', NULL);
INSERT INTO `pos` VALUES (45, 'n.& adj.', NULL);
INSERT INTO `pos` VALUES (46, 'adv.& prep.', NULL);
INSERT INTO `pos` VALUES (47, 'n.&v.', NULL);
INSERT INTO `pos` VALUES (48, 'v. .', NULL);
INSERT INTO `pos` VALUES (49, 'a.', NULL);
INSERT INTO `pos` VALUES (50, 'vi.& n.', NULL);
INSERT INTO `pos` VALUES (51, 'adj.&adv.', NULL);
INSERT INTO `pos` VALUES (52, 'adj. .', NULL);
INSERT INTO `pos` VALUES (53, 'col.', NULL);
INSERT INTO `pos` VALUES (54, 'vt.& adj.', NULL);
INSERT INTO `pos` VALUES (55, 'exclam.', NULL);
INSERT INTO `pos` VALUES (56, 'n.& vi.', NULL);
INSERT INTO `pos` VALUES (57, 'n.& vt.', NULL);
INSERT INTO `pos` VALUES (58, 'n.& adv.', NULL);
INSERT INTO `pos` VALUES (59, 'n.&adj.', NULL);
INSERT INTO `pos` VALUES (60, 'vt.& n.', NULL);
INSERT INTO `pos` VALUES (61, 'adv.& conj.', NULL);
INSERT INTO `pos` VALUES (62, 'adj.&n.', NULL);
INSERT INTO `pos` VALUES (63, 'int.& n.& vi.', NULL);
INSERT INTO `pos` VALUES (64, 'n.&vt.', NULL);
INSERT INTO `pos` VALUES (65, 'int.& n.', NULL);
INSERT INTO `pos` VALUES (66, 'int.&n.', NULL);
INSERT INTO `pos` VALUES (67, 'adj.& v.', NULL);
INSERT INTO `pos` VALUES (68, 'suf.', NULL);
INSERT INTO `pos` VALUES (69, 'adv.& int.', NULL);
INSERT INTO `pos` VALUES (70, 'v.&n.', NULL);
INSERT INTO `pos` VALUES (71, 'prep.& adv.', NULL);
INSERT INTO `pos` VALUES (72, 'interj.', NULL);
INSERT INTO `pos` VALUES (73, 'phr.', NULL);
INSERT INTO `pos` VALUES (74, 'adv.&adj.', NULL);
INSERT INTO `pos` VALUES (75, 'n.& int.', NULL);
INSERT INTO `pos` VALUES (76, 'n.& adv.& adj.', NULL);

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
  `course_id` int(5) UNSIGNED NULL DEFAULT NULL COMMENT '学生加入的课程编号',
  `coins` int(4) UNSIGNED NULL DEFAULT 0 COMMENT '金币数量',
  `word_numbers` int(7) UNSIGNED NULL DEFAULT 0 COMMENT '熟练的单词数',
  `points` int(7) UNSIGNED NULL DEFAULT 0 COMMENT '比赛积累的积分',
  PRIMARY KEY (`student_id`) USING BTREE,
  INDEX `fk_course_id`(`course_id`) USING BTREE,
  CONSTRAINT `fk_course_id` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of student
-- ----------------------------
INSERT INTO `student` VALUES (1, 'timemachine', '123', 'luorong', '男', 20, 1, 0, 0, 0);

-- ----------------------------
-- Table structure for teacher
-- ----------------------------
DROP TABLE IF EXISTS `teacher`;
CREATE TABLE `teacher`  (
  `teacher_id` int(4) NOT NULL AUTO_INCREMENT COMMENT '教师编号',
  `teacher_username` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '教师账户',
  `teacher_password` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '教师账户密码',
  `teacher_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '教师姓名',
  `teacher_sex` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '教师性别',
  `teacher_age` int(3) NOT NULL COMMENT '教师年龄',
  `teacher_phone` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '教师电话',
  `teacher_address` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '教师住址',
  `courses_id` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '教师教授的课程，为一个列表，里面保存着课程id',
  PRIMARY KEY (`teacher_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for words
-- ----------------------------
DROP TABLE IF EXISTS `words`;
CREATE TABLE `words`  (
  `word_id` int(19) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '单词id',
  `word` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '单词的英文拼写',
  `exchange` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '单词的变化',
  `voice` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '单词的发音网址链接',
  `value` int(4) NOT NULL COMMENT '单词价值量',
  PRIMARY KEY (`word_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Triggers structure for table student
-- ----------------------------
DROP TRIGGER IF EXISTS `t_inst_stu`;
delimiter ;;
CREATE TRIGGER `t_inst_stu` AFTER INSERT ON `student` FOR EACH ROW update course
set number = number+1
where(course.course_id=new.course_id)
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
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
