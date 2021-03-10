/*
Navicat MySQL Data Transfer

Source Server         : rainbowcat
Source Server Version : 80015
Source Host           : localhost:3306
Source Database       : twms

Target Server Type    : MYSQL
Target Server Version : 80015
File Encoding         : 65001

Date: 2021-03-10 14:00:13
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `admin`
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `aid` int(4) NOT NULL,
  `aname` varchar(10) NOT NULL,
  `asex` varchar(2) NOT NULL DEFAULT '男',
  `aemail` varchar(20) NOT NULL,
  `apwd` varchar(4) NOT NULL,
  `authority` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`aid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES ('1001', '测试员', '男', 'admin1@163.com', '1001', '1');
INSERT INTO `admin` VALUES ('1002', '管理员2', '女', 'admin2@163.com', '1002', '0');
INSERT INTO `admin` VALUES ('1003', '管理员3', '男', 'admin3@163.com', '1003', '0');
INSERT INTO `admin` VALUES ('1004', '管理员4', '男', 'admin4@163.com', '1004', '0');
INSERT INTO `admin` VALUES ('1005', '管理员5', '女', 'admin5@163.com', '1005', '0');
INSERT INTO `admin` VALUES ('1006', '管理员6', '男', 'admin6@163.com', '1006', '0');
INSERT INTO `admin` VALUES ('1007', '管理员7', '女', 'admin7@163.com', '1007', '0');
INSERT INTO `admin` VALUES ('1008', '管理员8', '男', 'admin8@163.com', '1008', '0');
INSERT INTO `admin` VALUES ('1009', '管理员9', '男', 'admin9@163.com', '1009', '0');
INSERT INTO `admin` VALUES ('1010', '管理员10', '男', 'admin10@163.com', '1010', '0');
INSERT INTO `admin` VALUES ('1011', '管理员11', '女', 'admin@163.com', '1011', '0');

-- ----------------------------
-- Table structure for `teacher`
-- ----------------------------
DROP TABLE IF EXISTS `teacher`;
CREATE TABLE `teacher` (
  `tid` int(4) NOT NULL,
  `tname` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `tsex` varchar(2) NOT NULL DEFAULT '男',
  `tpms` int(4) NOT NULL,
  `tpart` int(4) NOT NULL,
  `tpwd` varchar(4) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`tid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of teacher
-- ----------------------------
INSERT INTO `teacher` VALUES ('2001', '老师1', '男', '1', '12', '2001');
INSERT INTO `teacher` VALUES ('2002', '老师2', '男', '1', '10', '2002');
INSERT INTO `teacher` VALUES ('2003', '老师3', '女', '0', '12', '2003');
INSERT INTO `teacher` VALUES ('2004', '老师4', '女', '1', '10', '2004');
INSERT INTO `teacher` VALUES ('2005', '老师5', '男', '0', '11', '2005');
INSERT INTO `teacher` VALUES ('2006', '老师6', '女', '1', '11', '2006');
INSERT INTO `teacher` VALUES ('2007', '老师7', '男', '1', '12', '2007');
INSERT INTO `teacher` VALUES ('2008', '老师8', '女', '0', '10', '2008');
INSERT INTO `teacher` VALUES ('2009', '老师9', '女', '0', '10', '2009');

-- ----------------------------
-- Table structure for `works`
-- ----------------------------
DROP TABLE IF EXISTS `works`;
CREATE TABLE `works` (
  `wid` int(2) NOT NULL AUTO_INCREMENT,
  `tid` int(4) NOT NULL,
  `cname` varchar(4) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `pro` varchar(8) NOT NULL,
  `hours` int(4) NOT NULL,
  `ech` int(4) NOT NULL,
  `ih` int(4) NOT NULL,
  `works` int(4) DEFAULT '0',
  `state` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`wid`)
) ENGINE=InnoDB AUTO_INCREMENT=50027 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of works
-- ----------------------------
INSERT INTO `works` VALUES ('50001', '2001', '课程1', '必修课', '48', '10', '5', '83', '1');
INSERT INTO `works` VALUES ('50002', '2002', '课程2', '选修课', '32', '12', '6', '74', '1');
INSERT INTO `works` VALUES ('50007', '2004', '课程3', '选修课', '32', '10', '0', '52', '1');
INSERT INTO `works` VALUES ('50008', '2005', '课程4', '选修课', '32', '8', '2', '54', '1');
INSERT INTO `works` VALUES ('50009', '2004', '课程5', '必修课', '48', '4', '4', '68', '1');
INSERT INTO `works` VALUES ('50010', '2001', '课程6', '选修课', '32', '14', '2', '66', '1');
INSERT INTO `works` VALUES ('50011', '2001', '课程7', '选修课', '32', '6', '2', '50', '1');
INSERT INTO `works` VALUES ('50014', '2010', '课程8', '测试', '1', '1', '0', '5', '1');
INSERT INTO `works` VALUES ('50016', '2001', '课程9', '测试课', '2', '1', '0', '4', '1');
INSERT INTO `works` VALUES ('50017', '2001', '课程10', '必修课', '3', '2', '3', '16', '1');
INSERT INTO `works` VALUES ('50018', '2001', '课程11', '选修课', '1', '1', '1', '6', '1');
INSERT INTO `works` VALUES ('50019', '2001', '课程12', '测试课', '1', '1', '1', '6', '1');
INSERT INTO `works` VALUES ('50020', '2001', '课程13', '必修课', '20', '5', '0', '30', '1');
INSERT INTO `works` VALUES ('50021', '2001', '课程2', '选修课', '20', '6', '0', '32', '1');
INSERT INTO `works` VALUES ('50023', '2001', '测试课', '测试课', '2', '2', '2', '12', '1');
INSERT INTO `works` VALUES ('50024', '2001', '测试课', '测试课', '1', '2', '1', '8', '1');
INSERT INTO `works` VALUES ('50025', '2001', '测试课', '测试课', '20', '6', '2', '38', '1');
INSERT INTO `works` VALUES ('50026', '2001', '111', '选修课', '10', '2', '2', '20', '1');
