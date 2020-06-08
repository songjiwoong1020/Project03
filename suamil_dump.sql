-- --------------------------------------------------------
-- 호스트:                          127.0.0.1
-- 서버 버전:                        10.5.3-MariaDB - mariadb.org binary distribution
-- 서버 OS:                        Win64
-- HeidiSQL 버전:                  11.0.0.5919
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- songjiwoong1020 데이터베이스 구조 내보내기
DROP DATABASE IF EXISTS `songjiwoong1020`;
CREATE DATABASE IF NOT EXISTS `songjiwoong1020` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `songjiwoong1020`;

-- 테이블 songjiwoong1020.membership 구조 내보내기
DROP TABLE IF EXISTS `membership`;
CREATE TABLE IF NOT EXISTS `membership` (
  `memberlv` tinyint(4) NOT NULL DEFAULT 1,
  `name` varchar(30) NOT NULL,
  `id` varchar(30) NOT NULL,
  `pass` varchar(30) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `cellphone` varchar(20) NOT NULL,
  `email` varchar(40) NOT NULL,
  `address` varchar(300) NOT NULL,
  `regdate` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 테이블 데이터 songjiwoong1020.membership:~15 rows (대략적) 내보내기
DELETE FROM `membership`;
/*!40000 ALTER TABLE `membership` DISABLE KEYS */;
INSERT INTO `membership` (`memberlv`, `name`, `id`, `pass`, `phone`, `cellphone`, `email`, `address`, `regdate`) VALUES
	(1, '123', '123123', '123123123', '', '111', '123@naver.com', '28562충북 청주시 서원구 1순환로 627123', '2020-06-01 12:56:41'),
	(1, '123', '222222', '1234', '', '456', '1@naver.com', '01179서울 강북구 미아동 329-311', '2020-06-03 16:58:18'),
	(5, '관리자', 'admin', '1234', '01047398061', '01047398061', 'songjiwoong1020@gmail.com', '.', '2020-05-28 11:54:59'),
	(1, '더미회원1', 'dummy1', '1234', '-', '-', '-', '-', '2020-05-28 16:48:05'),
	(1, '더미회원10', 'dummy10', '1234', '-', '-', '-', '-', '2020-05-28 16:49:07'),
	(1, '더미회원11', 'dummy11', '1234', '-', '-', '-', '-', '2020-05-28 16:49:08'),
	(1, '더미회원2', 'dummy2', '1234', '-', '-', '-', '-', '2020-05-28 16:48:07'),
	(1, '더미회원3', 'dummy3', '1234', '-', '-', '-', '-', '2020-05-28 16:48:09'),
	(1, '더미회원4', 'dummy4', '1234', '-', '-', '-', '-', '2020-05-28 16:48:10'),
	(1, '더미회원5', 'dummy5', '1234', '-', '-', '-', '-', '2020-05-28 16:48:11'),
	(1, '더미회원6', 'dummy6', '1234', '-', '-', '-', '-', '2020-05-28 16:48:13'),
	(1, '더미회원7', 'dummy7', '1234', '-', '-', '-', '-', '2020-05-28 16:48:14'),
	(1, '더미회원8', 'dummy8', '1234', '-', '-', '-', '-', '2020-05-28 16:49:04'),
	(1, '더미회원9', 'dummy9', '1234', '-', '-', '-', '-', '2020-05-28 16:49:05'),
	(1, 'ㅁㄴㅇ', 'user01', '1234', '', '010123123', 'songjiwoong1020@gmail.com', '14539경기 부천시 계남로 196626 103', '2020-06-03 11:35:39');
/*!40000 ALTER TABLE `membership` ENABLE KEYS */;

-- 테이블 songjiwoong1020.multi_board 구조 내보내기
DROP TABLE IF EXISTS `multi_board`;
CREATE TABLE IF NOT EXISTS `multi_board` (
  `idx` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `content` text NOT NULL,
  `postdate` datetime DEFAULT current_timestamp(),
  `id` varchar(10) NOT NULL,
  `visitcount` mediumint(9) NOT NULL DEFAULT 0,
  `bname` varchar(30) NOT NULL,
  `ofile` varchar(100) DEFAULT NULL,
  `sfile` varchar(30) DEFAULT NULL,
  `thumbnail` longtext DEFAULT NULL,
  PRIMARY KEY (`idx`),
  KEY `fk_board_member` (`id`),
  CONSTRAINT `fk_board_member` FOREIGN KEY (`id`) REFERENCES `membership` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=122 DEFAULT CHARSET=utf8;

-- 테이블 데이터 songjiwoong1020.multi_board:~34 rows (대략적) 내보내기
DELETE FROM `multi_board`;
/*!40000 ALTER TABLE `multi_board` DISABLE KEYS */;
INSERT INTO `multi_board` (`idx`, `title`, `content`, `postdate`, `id`, `visitcount`, `bname`, `ofile`, `sfile`, `thumbnail`) VALUES
	(88, 'asd', 'Hello Summernote', '2020-06-04 12:36:09', 'admin', 2, 'freeboard', NULL, NULL, 'non'),
	(89, '공지 테스트 1', 'ㅎㅇㅎㅇ', '2020-06-04 12:38:02', 'admin', 0, 'notice', NULL, NULL, 'non'),
	(90, '공지 테스트 2', 'ㅀㅎ', '2020-06-04 12:38:12', 'admin', 0, 'notice', NULL, NULL, 'non'),
	(91, 'ㄱ', 'ㅁㄴㅇ', '2020-06-04 15:03:07', 'admin', 1, 'notice', NULL, NULL, 'non'),
	(92, '공지테스트공지테스트공지테스트', 'ㅁㄴㅇㅁㄴㅇ', '2020-06-04 15:03:16', 'admin', 5, 'notice', NULL, NULL, 'non'),
	(93, '공지테스트공지테스트공지테스트공지테스트', 'ㅁㄴㅇㅁㄴㅇㄴㅁㅇ', '2020-06-04 15:03:21', 'admin', 2, 'notice', NULL, NULL, 'non'),
	(94, 'bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb', 'bbbbbbbb', '2020-06-04 15:03:29', 'admin', 2, 'notice', NULL, NULL, 'non'),
	(95, 'bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb', 'asdasd', '2020-06-04 15:03:35', 'admin', 9, 'notice', NULL, NULL, 'non'),
	(96, '아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아', '아아아아아아아아아아아아아아아', '2020-06-04 15:43:48', 'admin', 4, 'freeboard', NULL, NULL, 'non'),
	(97, '45', '5656', '2020-06-04 15:56:45', 'admin', 12, 'notice', NULL, NULL, 'non'),
	(99, '123', 'Hello Summernote', '2020-06-05 10:08:32', 'admin', 1, 'freeboard', '고양이.jpg', '2020_08_05_10_8_32_960.jpg', 'non'),
	(100, '56', 'Hello Summernote', '2020-06-05 10:13:57', 'admin', 3, 'freeboard', NULL, NULL, 'non'),
	(101, '123', 'Hello Summernote', '2020-06-05 10:37:18', 'admin', 13, 'freeboard', '아이유_하루끝.jpg', '2020_37_05_10_37_18_410.jpg', 'non'),
	(102, '123', 'Hello Summernote12', '2020-06-05 10:37:24', 'admin', 15, 'freeboard', NULL, NULL, 'non'),
	(107, '경우1', '1수정', '2020-06-05 12:38:41', 'admin', 3, 'freeboard', NULL, NULL, 'non'),
	(108, '경우2', '2수정', '2020-06-05 12:38:49', 'admin', 2, 'freeboard', '아이유_하루끝.jpg', '2020_40_05_12_40_2_9.jpg', 'non'),
	(109, '경우3', '3수정', '2020-06-05 12:38:58', 'admin', 3, 'freeboard', NULL, NULL, 'non'),
	(110, '경우4', '5678754545', '2020-06-05 12:39:05', 'admin', 9, 'freeboard', NULL, NULL, 'non'),
	(111, '경우5', '5', '2020-06-05 12:39:14', 'admin', 4, 'freeboard', '고양이.jpg', '2020_07_05_13_7_12_945.jpg', 'non'),
	(112, '경우3 리트', '수정23', '2020-06-05 12:41:34', 'admin', 6, 'freeboard', NULL, NULL, 'non'),
	(113, '경우3 리리트', 'Hello Summernote수정', '2020-06-05 12:45:19', 'admin', 5, 'freeboard', NULL, NULL, 'non'),
	(114, '경우3 리리리트', 'Hello Summernote수정7567657', '2020-06-05 12:55:18', 'admin', 2, 'freeboard', '스무살의 봄3.jpg', '2020_55_05_12_55_18_126.jpg', 'non'),
	(115, '경우 1', '1수정', '2020-06-05 13:07:34', 'admin', 2, 'freeboard', NULL, NULL, 'non'),
	(116, '경우 2', '2', '2020-06-05 13:07:41', 'admin', 2, 'freeboard', '스무살의 봄3.jpg', '2020_09_05_13_9_16_69.jpg', 'non'),
	(117, '경우 3', '3수정', '2020-06-05 13:07:49', 'admin', 2, 'freeboard', '스무살의 봄3.jpg', '2020_07_05_13_7_49_929.jpg', 'non'),
	(118, '경우 4', '4수정', '2020-06-05 13:07:58', 'admin', 2, 'freeboard', NULL, NULL, 'non'),
	(119, '경우 5', '5수정', '2020-06-05 13:08:06', 'admin', 2, 'freeboard', 'maxresdefault.jpg', '2020_10_05_13_10_30_248.jpg', 'non'),
	(120, '글', '글', '2020-06-05 13:11:13', 'admin', 0, 'dataroom', '고양이.jpg', '2020_11_05_13_11_13_228.jpg', 'non'),
	(121, '123123', '<p>Hello Summernote123123</p><p><br></p><p><br></p>', '2020-06-05 16:53:43', 'admin', 1, 'dataroom', '고양이.jpg', '2020_53_05_16_53_43_446.jpg', 'non'),
	(122, '123', '<p>Hello, world12<img src="/Project03/summernoteImg/스무살의 봄31.jpg" style="width: 607px;">3123<br></p>', '2020-06-08 12:46:18', 'admin', 3, 'photo', NULL, NULL, '/Project03/summernoteImg/스무살의 봄31.jpg'),
	(123, 'kjk', '<p>Hello, world123123<br></p>', '2020-06-08 13:05:31', 'admin', 1, 'photo', NULL, NULL, 'non'),
	(124, 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa', '<p>Hello, world123123<img src="/Project03/summernoteImg/아이유_하루끝.jpg" style="width: 540px;"><br></p>', '2020-06-08 13:11:18', 'admin', 0, 'photo', NULL, NULL, '/Project03/summernoteImg/아이유_하루끝.jpg'),
	(125, '아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아', '<p>Hello, world123123<img src="/Project03/summernoteImg/고양이1.jpg" style="width: 607px;"><br></p>', '2020-06-08 13:11:37', 'admin', 1, 'photo', NULL, NULL, '/Project03/summernoteImg/고양이1.jpg'),
	(126, 'ㅁㅁㅁㅁㅁaaaaaaaaaaaaa', '<p>Hello, world123123<img src="/Project03/summernoteImg/20120511122620_198390_511_274.jpg" style="width: 477px;"><br></p>', '2020-06-08 13:11:54', 'admin', 0, 'photo', NULL, NULL, '/Project03/summernoteImg/20120511122620_198390_511_274.jpg'),
	(127, 'aaaaㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁ', '<p>Hello, world123123<img src="/Project03/summernoteImg/스무살의 봄32.jpg" style="width: 607px;"><br></p>', '2020-06-08 13:12:10', 'admin', 0, 'photo', NULL, NULL, '/Project03/summernoteImg/스무살의 봄32.jpg'),
	(128, '123', '<p>Hello, world123123<img src="/Project03/summernoteImg/아이유_하루끝1.jpg" style="width: 540px;"><img src="/Project03/summernoteImg/스무살의 봄33.jpg" style="width: 607px;"><br></p>', '2020-06-08 13:16:43', 'admin', 0, 'photo', NULL, NULL, '/Project03/summernoteImg/스무살의 봄33.jpg'),
	(129, 'test', '<p>Hello, world123123<br></p>', '2020-06-08 13:18:16', 'admin', 1, 'photo', NULL, NULL, '/Project03/summernoteImg/스무살의 봄34.jpg');
/*!40000 ALTER TABLE `multi_board` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
