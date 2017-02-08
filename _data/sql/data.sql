/*
Target Server Type    : MYSQL
Target Server Version : 5.7

Source Server         : localhost
Source Server Version : 5.7
Source Host           : localhost:3306
Source Database       : teac

Create by yangzifeng on 2016/11/11
*/
use teac;
SET FOREIGN_KEY_CHECKS = 0;

-- -------------------
-- 用户：家长／教师
-- -------------------
DROP TABLE IF EXISTS `teac_user`;
CREATE TABLE `teac_user` (
  `user_id` BIGINT PRIMARY KEY ,
  `teacher_id` BIGINT DEFAULT NULL ,
  `organ_id` BIGINT DEFAULT NULL ,
  `nickname` VARCHAR(64) NOT NULL ,
  `telephone` VARCHAR(16) NOT NULL ,
  `password` VARCHAR(64) NOT NULL ,
  `enabled` BOOLEAN NOT NULL DEFAULT TRUE ,
  `group_id` BIGINT DEFAULT '1',
  `avatar` VARCHAR(255) DEFAULT '/static/images/default_avatar.png',
  `surname` VARCHAR(16) NOT NULL ,
  `sex` CHAR DEFAULT 'N' COMMENT 'M,F,N',
  `birthday` DATE DEFAULT NULL ,
  `area_code` VARCHAR(40) DEFAULT '000000',
  `address` VARCHAR(255) DEFAULT '还没有填写地址信息，请电话联系',
  `last_login` TIMESTAMP DEFAULT current_timestamp ON UPDATE current_timestamp,
  `createtime` TIMESTAMP DEFAULT current_timestamp,
  FOREIGN KEY(`teacher_id`) REFERENCES `teac_teacher` (`teacher_id`),
  FOREIGN KEY(`area_code`)  REFERENCES `teac_area` (`area_code`),
  FOREIGN KEY (`organ_id`) REFERENCES `teac_organ` (`organ_id`),
  UNIQUE KEY `UK_teac_unique_key_1` (`telephone`)
)ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8;

INSERT INTO `teac_user` VALUES ('3',null,null,'mary','12345678921','123456',TRUE ,'4',NULL ,'上官','M','1996-10-24',NULL ,'昌平区',NULL ,NULL);

select * from `teac_user`;
-- -------------------
-- 教师认证信息
-- -------------------
DROP TABLE IF EXISTS `teac_teacher`;
CREATE TABLE `teac_teacher`(
  `teacher_id` BIGINT PRIMARY KEY ,
  `subjects_code` VARCHAR(160) NOT NULL COMMENT '擅长科目组',
  `grades_code` VARCHAR(160) NOT NULL COMMENT '擅长年级',
  `school` VARCHAR(100) DEFAULT NULL COMMENT '毕业学校',
  `degree` VARCHAR(32) DEFAULT NULL COMMENT '最高学位',
  `graduate_status` CHAR DEFAULT NULL COMMENT 'y,n',
  `school_class` VARCHAR(9) COMMENT '在读年级',
  `graduate_time` DATE COMMENT '毕业时间',
  `work` VARCHAR(64) DEFAULT NULL COMMENT '工作',
  `qq` VARCHAR(16) DEFAULT NULL,
  `weixin` VARCHAR(32) DEFAULT NULL,
  `empty_time` VARCHAR(64) DEFAULT NULL COMMENT '可工作时间',
  `work_place` VARCHAR(255) DEFAULT '同城' COMMENT '可工作范围',
  `salary` DOUBLE,
  `certified_time` TIMESTAMP DEFAULT current_timestamp COMMENT '认证完成时间',
  `introduce` VARCHAR(255) DEFAULT NULL COMMENT '个人简介',
  `ping` INT DEFAULT 0,
  `avg_stars` DOUBLE DEFAULT 0,
  `busy_time` VARCHAR(64) DEFAULT NULL COMMENT '已接单时间',
  `organ_code` VARCHAR(40) DEFAULT NULL COMMENT '机构代码'
)ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8;



-- -------------------
-- 地域
-- -------------------
DROP TABLE IF EXISTS `teac_area`;
CREATE TABLE `teac_area`(
  `area_id` INT PRIMARY KEY ,
  `area_code` VARCHAR(40) DEFAULT '000000',
  `province` VARCHAR(40),
  `city` VARCHAR(40),
  `district` VARCHAR(40),
  `parent` VARCHAR(40),
  UNIQUE KEY `UK_teac_unique_key_2` (`area_code`)
)ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

INSERT INTO `teac_area` VALUES (1 ,'000000',NULL ,'北京',NULL ,NULL );

-- -------------------
-- 科目
-- -------------------
DROP TABLE IF EXISTS `teac_subject`;
CREATE TABLE `teac_subject` (
  `subject_id` INT PRIMARY KEY ,
  `subject_code` VARCHAR(40),
  `subject_name` VARCHAR(40),
  UNIQUE KEY `UK_teac_unique_key_3` (`subject_code`)
)ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8;




-- -------------------
-- 年级
-- -------------------
DROP TABLE IF EXISTS `teac_grade`;
CREATE TABLE `teac_grade` (
  `grade_id` BIGINT PRIMARY KEY ,
  `grade_code` VARCHAR(40),
  `grade_name` VARCHAR(40),
  UNIQUE KEY `UK_teac_unique_key_4` (`grade_code`)
)ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8;


-- -------------------
-- 家教经历
-- -------------------
DROP TABLE IF EXISTS `teac_experience`;
CREATE TABLE `teac_experience` (
  `experience_id` BIGINT PRIMARY KEY ,
  `teacher_id` BIGINT,
  `begin_time` DATE,
  `finish_time` DATE,
  `content` VARCHAR(255),
  FOREIGN KEY (`teacher_id`) REFERENCES `teac_teacher` (`teacher_id`)
)ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8;


-- -------------------
-- 消息数
-- -------------------
DROP TABLE IF EXISTS `teac_msgcount`;
CREATE TABLE `teac_msgcount` (
  `msg_count_id` BIGINT PRIMARY KEY ,
  `user_id` BIGINT,
  `sysmsg_count` INT DEFAULT '0',
  `comment_count` INT DEFAULT '0',
  FOREIGN KEY (`user_id`) REFERENCES `teac_user` (`user_id`)
)ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8;


-- -------------------
-- 系统消息
-- -------------------
DROP TABLE IF EXISTS `teac_sysmsg`;
CREATE TABLE `teac_sysmsg`(
  `msg_id` BIGINT PRIMARY KEY ,
  `user_id` BIGINT NOT NULL ,
  `msg_status` CHAR DEFAULT 'y' COMMENT 'y,n',
  `msg_title` VARCHAR(100) DEFAULT NULL ,
  `msg_type` INT DEFAULT 0,
  `msg_content` VARCHAR(255) NOT NULL
)ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;


-- -------------------
-- 需求
-- -------------------
DROP TABLE IF EXISTS `teac_demand`;
CREATE TABLE `teac_demand` (
  `demand_id` BIGINT PRIMARY KEY ,
  `user_id` BIGINT NOT NULL ,
  `area_code` VARCHAR(40) NOT NULL ,
  `demand_subjects` VARCHAR(160) NOT NULL ,
  `grade_id` VARCHAR(40) DEFAULT NULL ,
  `demand_sex` CHAR DEFAULT 'n' COMMENT 'm,f,n',
  `demand_place` VARCHAR(255) DEFAULT '电话了解',
  `demand_telephone` VARCHAR(16) NOT NULL ,
  `demand_time` VARCHAR(64) COMMENT '每周补习时段',
  `total_time` DOUBLE COMMENT '补习天数',
  `salary` DOUBLE,
  `demand_remark` VARCHAR(255),
  `createtime` TIMESTAMP DEFAULT current_timestamp,
  `demand_teachers` VARCHAR(255) DEFAULT NULL ,
  `teacher_id` BIGINT DEFAULT NULL ,
  `status` CHAR DEFAULT 'y',
  FOREIGN KEY (`user_id`) REFERENCES `teac_user` (`user_id`),
  FOREIGN KEY (`teacher_id`) REFERENCES `teac_teacher` (`teacher_id`)
)ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8;



-- -------------------
-- 预约表
-- -------------------
DROP TABLE IF EXISTS `teac_order`;
CREATE TABLE `teac_order`(
  `order_id` BIGINT PRIMARY KEY ,
  `user_id` BIGINT NOT NULL ,
  `teacher_id` BIGINT NOT NULL ,
  `order_subjects` VARCHAR(160),
  `grade_code` VARCHAR(40),
  `order_telephone` VARCHAR(16) NOT NULL COMMENT '家长手机号确认',
  `order_time` VARCHAR(64) COMMENT '每周补习时段',
  `order_place` VARCHAR(255) DEFAULT '电话咨询' COMMENT '详细地址确认',
  `total_time` DOUBLE DEFAULT NULL ,
  `salary` DOUBLE,
  `order_remark` VARCHAR(255) DEFAULT NULL ,
  `createtime` TIMESTAMP DEFAULT current_timestamp,
  `status` CHAR DEFAULT 'y' COMMENT 'y,n',
  FOREIGN KEY (`user_id`) REFERENCES `teac_user` (`user_id`),
  FOREIGN KEY (`teacher_id`) REFERENCES `teac_teacher` (`teacher_id`)
)ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8;


-- -------------------
-- 成功服务表
-- -------------------
DROP TABLE IF EXISTS `teac_success`;
CREATE TABLE `teac_success`(
  `success_id` BIGINT PRIMARY KEY ,
  `user_id` BIGINT NOT NULL ,
  `teacher_id` BIGINT NOT NULL ,
  `subjects_code` VARCHAR(160) NOT NULL ,
  `grade_code` VARCHAR(40),
  `begin_time` DATE DEFAULT NULL ,
  `finish_time` DATE DEFAULT NULL ,
  `salary` DOUBLE NOT NULL ,
  FOREIGN KEY (`user_id`) REFERENCES `teac_user` (`user_id`),
  FOREIGN KEY (`teacher_id`) REFERENCES `teac_teacher` (`teacher_id`)
)ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8;


-- -------------------
-- 评论表
-- -------------------
DROP TABLE IF EXISTS `teac_comment`;
CREATE TABLE `teac_comment`(
  `comment_id` BIGINT PRIMARY KEY ,
  `user_id` BIGINT NOT NULL ,
  `to_user_id` BIGINT NOT NULL ,
  `success_id` BIGINT ,
  `parent` BIGINT COMMENT '父评论id',
  `content` VARCHAR(255) DEFAULT '估计不错，用户没有写',
  `stars` INT DEFAULT 5,
  `createtime` TIMESTAMP DEFAULT current_timestamp,
  FOREIGN KEY (`user_id`) REFERENCES `teac_user` (`user_id`)
)ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8;


-- -------------------
--        后台
-- -------------------
-- 机构表
DROP TABLE IF EXISTS `teac_organ`;
CREATE TABLE `teac_organ`(
  `organ_id` BIGINT PRIMARY KEY ,
  `organ_name` VARCHAR(100) NOT NULL
)ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;


-- 用户组表
DROP TABLE IF EXISTS `groups`;
CREATE TABLE `groups` (
  `id` BIGINT PRIMARY KEY ,
  `group_name` VARCHAR(50) NOT NULL
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `groups` VALUES ('1','用户');
INSERT INTO `groups` VALUES ('2','机构');
INSERT INTO `groups` VALUES ('3','运营');
INSERT INTO `groups` VALUES ('4','管理');
INSERT INTO `groups` VALUES ('5','超级管理');


-- 用户权限表
DROP TABLE IF EXISTS `group_authorities`;
CREATE TABLE `group_authorities` (
  `group_id` BIGINT PRIMARY KEY,
  `authority` VARCHAR(50) NOT NULL ,
  CONSTRAINT `fk_group_authorities_group` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `group_authorities` VALUES ('1','ROLE_USER');
INSERT INTO `group_authorities` VALUES ('2','ROLE_ORGAN');
INSERT INTO `group_authorities` VALUES ('3','ROLE_RUN');
INSERT INTO `group_authorities` VALUES ('4','ROLE_ADMIN');
INSERT INTO `group_authorities` VALUES ('5','ROLE_SUPER');
