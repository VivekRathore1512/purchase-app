-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 12, 2026 at 08:03 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `purchase_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `created_at`) VALUES
(1, 'Grains', '2025-12-18 06:16:01'),
(2, 'Vegetables', '2025-12-18 06:16:01'),
(3, 'Pulses', '2025-12-18 06:16:01');

-- --------------------------------------------------------

--
-- Table structure for table `companies`
--

CREATE TABLE `companies` (
  `id` int(11) NOT NULL,
  `company_name` varchar(255) NOT NULL,
  `gst_number` varchar(50) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `companies`
--

INSERT INTO `companies` (`id`, `company_name`, `gst_number`, `phone`, `address`, `created_at`) VALUES
(1, 'AgroCorp India', '27AAACA1234B1Z5', '9876543210', 'Mumbai, Maharashtra', '2025-12-18 06:16:01'),
(2, 'FreshFoods Ltd', '29ABCDE5678F1Z9', '9123456789', 'Delhi', '2025-12-18 06:16:01');

-- --------------------------------------------------------

--
-- Table structure for table `defects`
--

CREATE TABLE `defects` (
  `id` int(11) NOT NULL,
  `subcategory_id` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `defects`
--

INSERT INTO `defects` (`id`, `subcategory_id`, `name`) VALUES
(8, 35, 'Bruised'),
(9, 35, 'Rotten'),
(10, 35, 'Sprouted'),
(11, 36, 'Discolored'),
(12, 36, 'Moldy'),
(13, 36, 'Wilted'),
(14, 37, 'Shriveled'),
(15, 37, 'Insect Damage'),
(16, 37, 'Soft'),
(17, 39, 'Broken'),
(18, 39, 'Discolored'),
(19, 39, 'Weevils'),
(20, 40, 'Chalky'),
(21, 40, 'Damaged'),
(22, 40, 'Foreign Matter'),
(23, 59, 'Cracked'),
(24, 59, 'Shriveled'),
(25, 59, 'Insect Infested'),
(26, 60, 'Split'),
(27, 60, 'Discolored'),
(28, 60, 'Moldy'),
(29, 38, 'Bruised'),
(30, 38, 'Rotten'),
(31, 38, 'Sprouted'),
(32, 41, 'Discolored'),
(33, 41, 'Moldy'),
(34, 41, 'Wilted'),
(35, 42, 'Broken'),
(36, 42, 'Discolored'),
(37, 42, 'Weevils'),
(38, 43, 'Chalky'),
(39, 43, 'Damaged'),
(40, 43, 'Foreign Matter'),
(41, 51, 'Excess Moisture'),
(42, 51, 'Fungus / Mold'),
(43, 51, 'Excess Moisture (अधिक नमी)'),
(44, 51, 'Fungus / Mold (फफूंद)'),
(45, 51, 'Insect Infestation (कीट प्रकोप)'),
(46, 51, 'Broken Grains (टूटे दाने)'),
(47, 51, 'Shrinked Seeds (सिकुड़े दाने)'),
(48, 51, 'Discoloration (रंग परिवर्तन)'),
(49, 51, 'Foreign Matter (कचरा / पत्थर)'),
(50, 51, 'Bad Odor (खराब गंध)'),
(51, 53, 'Moisture Damage (नमी से खराब)'),
(52, 53, 'Fungal Growth (फफूंद लगना)'),
(53, 53, 'Insect Damage (कीट क्षति)'),
(54, 53, 'Broken Seeds (टूटे दाने)'),
(55, 53, 'Discolored Seeds (रंग बदले दाने)'),
(56, 53, 'Foreign Matter (मिलावट / कचरा)'),
(57, 53, 'Bad Smell (दुर्गंध)'),
(58, 48, 'High Moisture (अधिक नमी)'),
(59, 48, 'Fungus (फफूंद)'),
(60, 48, 'Insect Infestation (कीड़े लगना)'),
(61, 48, 'Broken Seeds (टूटे दाने)'),
(62, 48, 'Immature Seeds (अधपके दाने)'),
(63, 48, 'Discoloration (रंग परिवर्तन)'),
(64, 48, 'Dust / Impurities (धूल / गंदगी)'),
(65, 50, 'Excess Moisture (अधिक नमी)'),
(66, 50, 'Mold / Fungus (फफूंद)'),
(67, 50, 'Insect Damage (कीट क्षति)'),
(68, 50, 'Broken Seeds (टूटे दाने)'),
(69, 50, 'Shrinked Grains (सिकुड़े दाने)'),
(70, 50, 'Foreign Matter (पत्थर / कचरा)'),
(71, 50, 'Bad Odor (खराब गंध)'),
(72, 49, 'Moisture Content High (नमी अधिक)'),
(73, 49, 'Fungus (फफूंद)'),
(74, 49, 'Insect Infestation (कीट प्रकोप)'),
(75, 49, 'Broken Grains (टूटे दाने)'),
(76, 49, 'Immature Seeds (अधपके दाने)'),
(77, 49, 'Discoloration (रंग बदलना)'),
(78, 49, 'Foreign Matter (मिलावट)'),
(79, 44, 'Moisture Damage (नमी से खराब)'),
(80, 44, 'Fungus / Ergot Infection (फफूंद / अर्गट रोग)'),
(81, 44, 'Insect Damage (कीट क्षति)'),
(82, 44, 'Broken Grains (टूटे दाने)'),
(83, 44, 'Discolored Grains (रंग बदले दाने)'),
(84, 44, 'Foreign Matter (पत्थर / कचरा)'),
(85, 44, 'Bad Odor (दुर्गंध)'),
(86, 54, 'Excess Moisture (अधिक नमी)'),
(87, 54, 'Fungus / Mold (फफूंद)'),
(88, 54, 'Insect Infestation (कीट प्रकोप)'),
(89, 54, 'Broken Seeds (टूटे दाने)'),
(90, 54, 'Shrinked Seeds (सिकुड़े दाने)'),
(91, 54, 'Discoloration (रंग परिवर्तन)'),
(92, 54, 'Foreign Matter (stone, dust, husk) (पत्थर / धूल / कचरा)'),
(93, 54, 'Bad Odor (खराब गंध)'),
(94, 54, 'Immature Seeds (अधपके दाने)'),
(96, 42, 'Excess Moisture (अधिक नमी)'),
(97, 42, 'Fungus / Mold (फफूंद)'),
(98, 42, 'Insect Infestation (कीट प्रकोप)'),
(99, 42, 'Broken Grains (टूटे दाने)'),
(100, 42, 'Shrinked Grains (सिकुड़े दाने)'),
(101, 42, 'Discoloration (रंग परिवर्तन)'),
(102, 42, 'Foreign Matter (stone, dust, husk) (पत्थर / धूल / कचरा)'),
(103, 42, 'Bad Odor (खराब गंध)'),
(104, 42, 'Immature Grains (अधपके दाने)'),
(105, 42, 'Over-dried Grains (अत्यधिक सूखे दाने)'),
(106, 56, 'Excess Moisture (अधिक नमी)'),
(107, 56, 'Fungus / Mold (फफूंद)'),
(108, 56, 'Insect Infestation (कीट प्रकोप)'),
(109, 56, 'Broken Rice (टूटे चावल)'),
(110, 56, 'Discolored Grains (रंग बदले दाने)'),
(111, 56, 'Chalky Grains (चूने जैसे दाने)'),
(112, 56, 'Foreign Matter (stone, dust, husk) (पत्थर / धूल / कचरा)'),
(113, 56, 'Bad Odor (खराब गंध)'),
(114, 56, 'Immature Grains (अधपके दाने)'),
(115, 56, 'Over-aged Rice (पुराना चावल)'),
(116, 58, 'Excess Moisture (अधिक नमी)'),
(117, 58, 'Fungus / Mold (फफूंद)'),
(118, 58, 'Insect Infestation (कीट प्रकोप)'),
(119, 58, 'Broken Rice (टूटे चावल)'),
(120, 58, 'Discolored Grains (रंग बदले दाने)'),
(121, 58, 'Chalky Grains (चूने जैसे दाने)'),
(122, 58, 'Foreign Matter (stone, dust, husk) (पत्थर / धूल / कचरा)'),
(123, 58, 'Bad Odor (खराब गंध)'),
(124, 58, 'Immature Grains (अधपके दाने)'),
(125, 58, 'Over-aged Rice (पुराना चावल)'),
(126, 47, 'Excess Moisture (अधिक नमी)'),
(127, 47, 'Fungus / Mold (फफूंद)'),
(128, 47, 'Insect Infestation (कीट प्रकोप)'),
(129, 47, 'Broken Grains (टूटे दाने)'),
(130, 47, 'Shrinked Grains (सिकुड़े दाने)'),
(131, 47, 'Discoloration (रंग परिवर्तन)'),
(132, 47, 'Foreign Matter (stone, dust, husk) (पत्थर / धूल / कचरा)'),
(133, 47, 'Bad Odor (खराब गंध)'),
(134, 47, 'Immature Grains (अधपके दाने)'),
(135, 47, 'Over-dried Grains (अत्यधिक सूखे दाने)'),
(136, 41, 'Excess Moisture (अधिक नमी)'),
(137, 41, 'Fungus / Mold (फफूंद)'),
(138, 41, 'Insect Infestation (कीट प्रकोप)'),
(139, 41, 'Broken Kernels (टूटे दाने)'),
(140, 41, 'Discolored Kernels (रंग बदले दाने)'),
(141, 41, 'Moldy Kernels (फफूंद लगे दाने)'),
(142, 41, 'Foreign Matter (stone, dust, husk) (पत्थर / धूल / कचरा)'),
(143, 41, 'Bad Odor (खराब गंध)'),
(144, 41, 'Immature Kernels (अधपके दाने)'),
(145, 41, 'Over-dried Kernels (अत्यधिक सूखे दाने)'),
(146, 43, 'Excess Moisture (अधिक नमी)'),
(147, 43, 'Fungus / Mold (फफूंद)'),
(148, 43, 'Insect Infestation (कीट प्रकोप)'),
(149, 43, 'Broken Grains (टूटे दाने)'),
(150, 43, 'Shrinked Grains (सिकुड़े दाने)'),
(151, 43, 'Discoloration (रंग परिवर्तन)'),
(152, 43, 'Foreign Matter (stone, dust, husk) (पत्थर / धूल / कचरा)'),
(153, 43, 'Bad Odor (खराब गंध)'),
(154, 43, 'Immature Grains (अधपके दाने)'),
(155, 43, 'Over-dried Grains (अत्यधिक सूखे दाने)'),
(156, 46, 'Insect Infestation (कीट संक्रमण)'),
(157, 46, 'Damaged Grains (टूटे हुए अनाज)'),
(158, 46, 'Discoloration (रंग बदलना / धब्बेदार अनाज)'),
(159, 46, 'Excess Moisture (अधिक नमी)'),
(160, 46, 'Fungus / Mold (फफूंद)'),
(161, 46, 'Broken Kernels (टूटे दाने)'),
(162, 46, 'Foreign Matter (stone, dust, husk) (पत्थर / धूल / कचरा)'),
(163, 46, 'Bad Odor (खराब गंध)'),
(164, 46, 'Immature Kernels (अधपके दाने)'),
(165, 46, 'Over-dried Kernels (अत्यधिक सूखे दाने)'),
(166, 52, 'Excess Moisture (अधिक नमी)'),
(167, 52, 'Fungus / Mold (फफूंद)'),
(168, 52, 'Insect Infestation (कीट प्रकोप)'),
(169, 52, 'Broken Kernels (टूटे दाने)'),
(170, 52, 'Discolored Kernels (रंग बदले दाने)'),
(171, 52, 'Moldy Kernels (फफूंद लगे दाने)'),
(172, 52, 'Foreign Matter (stone, dust, husk) (पत्थर / धूल / कचरा)'),
(173, 52, 'Bad Odor (खराब गंध)'),
(174, 52, 'Immature Kernels (अधपके दाने)'),
(175, 52, 'Over-dried Kernels (अत्यधिक सूखे दाने)'),
(176, 45, 'Excess Moisture (अधिक नमी)'),
(177, 45, 'Fungus / Mold (फफूंद)'),
(178, 45, 'Insect Infestation (कीट प्रकोप)'),
(179, 45, 'Broken Kernels (टूटे दाने)'),
(180, 45, 'Discolored Kernels (रंग बदले दाने)'),
(181, 45, 'Moldy Kernels (फफूंद लगे दाने)'),
(182, 45, 'Foreign Matter (stone, dust, husk) (पत्थर / धूल / कचरा)'),
(183, 45, 'Bad Odor (खराब गंध)'),
(184, 45, 'Immature Kernels (अधपके दाने)'),
(185, 45, 'Over-dried Kernels (अत्यधिक सूखे दाने)'),
(186, 39, 'Excess Moisture (अधिक नमी)'),
(187, 39, 'Fungus / Mold (फफूंद)'),
(188, 39, 'Insect Infestation (कीट प्रकोप)'),
(189, 39, 'Broken Kernels (टूटे दाने)'),
(190, 39, 'Discolored Kernels (रंग बदले दाने)'),
(191, 39, 'Moldy Kernels (फफूंद लगे दाने)'),
(192, 39, 'Foreign Matter (stone, dust, husk) (पत्थर / धूल / कचरा)'),
(193, 39, 'Bad Odor (खराब गंध)'),
(194, 39, 'Immature Kernels (अधपके दाने)'),
(195, 39, 'Over-dried Kernels (अत्यधिक सूखे दाने)'),
(196, 55, 'Excess Moisture (अधिक नमी)'),
(197, 55, 'Broken Kernels (टूटे दाने)'),
(198, 55, 'Insect Infestation (कीट प्रकोप)'),
(199, 55, 'Fungus / Mold (फफूंद)'),
(200, 55, 'Discolored Kernels (रंग बदले दाने)'),
(201, 55, 'Foreign Matter (stone, dust, husk) (पत्थर / धूल / कचरा)'),
(202, 55, 'Bad Odor (खराब गंध)'),
(203, 55, 'Immature Kernels (अधपके दाने)'),
(204, 55, 'Over-dried Kernels (अत्यधिक सूखे दाने)'),
(205, 57, 'Excess Moisture (अधिक नमी)'),
(206, 57, 'Fungus / Mold (फफूंद)'),
(207, 57, 'Insect Infestation (कीट प्रकोप)'),
(208, 57, 'Broken Kernels (टूटे दाने)'),
(209, 57, 'Discolored Kernels (रंग बदले दाने)'),
(210, 57, 'Moldy Kernels (फफूंद लगे दाने)'),
(211, 57, 'Foreign Matter (stone, dust, husk) (पत्थर / धूल / भूसी / कचरा)'),
(212, 57, 'Bad Odor (खराब गंध)'),
(213, 57, 'Immature Kernels (अधपके दाने)'),
(214, 57, 'Over-dried Kernels (अत्यधिक सूखे दाने)'),
(215, 80, 'Excess Moisture (अधिक नमी)'),
(216, 80, 'Fungus / Mold (फफूंद)'),
(217, 80, 'Insect Infestation (कीट प्रकोप / घुन लगना)'),
(218, 80, 'Broken Pulses (टूटी दालें)'),
(219, 80, 'Discolored Pulses (रंग बदली दालें)'),
(220, 80, 'Moldy Pulses (फफूंद लगी दालें)'),
(221, 80, 'Foreign Matter (stone, dust, husk) (पत्थर / धूल / भूसी / कचरा)'),
(222, 80, 'Bad Odor (खराब गंध)'),
(223, 80, 'Immature Pulses (अधपकी दालें)'),
(224, 80, 'Shriveled Pulses (सिकुड़ी हुई दालें)'),
(226, 61, 'Excess Moisture (अधिक नमी)'),
(227, 61, 'Fungus / Mold (फफूंद)'),
(228, 61, 'Insect Infestation (कीट प्रकोप / घुन लगना)'),
(229, 61, 'Broken Pulses (टूटी दालें)'),
(230, 61, 'Discolored Pulses (रंग बदली दालें)'),
(231, 61, 'Moldy Pulses (फफूंद लगी दालें)'),
(232, 61, 'Foreign Matter (stone, dust, husk) (पत्थर / धूल / भूसी / कचरा)'),
(233, 61, 'Bad Odor (खराब गंध)'),
(234, 61, 'Immature Pulses (अधपकी दालें)'),
(235, 59, 'Excess Moisture (अधिक नमी)'),
(236, 59, 'Fungus / Mold (फफूंद)'),
(237, 59, 'Insect Infestation (कीट प्रकोप / घुन लगना)'),
(238, 59, 'Broken Seeds (टूटे दाने)'),
(239, 59, 'Discolored Seeds (रंग बदले दाने)'),
(240, 59, 'Moldy Seeds (फफूंद लगे दाने)'),
(241, 59, 'Foreign Matter (stone, dust, husk) (पत्थर / धूल / भूसी / कचरा)'),
(242, 59, 'Bad Odor (खराब गंध)'),
(243, 59, 'Immature Seeds (अधपके दाने)'),
(244, 59, 'Shriveled Seeds (सिकुड़े हुए दाने)'),
(245, 59, 'Over-dried Seeds (अत्यधिक सूखे दाने)'),
(246, 64, 'Excess Moisture (अधिक नमी)'),
(247, 64, 'Fungus / Mold (फफूंद)'),
(248, 64, 'Insect Infestation (कीट प्रकोप / घुन लगना)'),
(249, 64, 'Broken Seeds (टूटे दाने)'),
(250, 64, 'Discolored Seeds (रंग बदले दाने)'),
(251, 64, 'Moldy Seeds (फफूंद लगे दाने)'),
(252, 64, 'Foreign Matter (stone, dust, husk) (पत्थर / धूल / भूसी / कचरा)'),
(253, 64, 'Bad Odor (खराब गंध)'),
(254, 64, 'Immature Seeds (अधपके दाने)'),
(255, 64, 'Shriveled Seeds (सिकुड़े हुए दाने)'),
(256, 64, 'Over-dried Seeds (अत्यधिक सूखे दाने)'),
(257, 60, 'Excess Moisture (अधिक नमी)'),
(258, 60, 'Fungus / Mold (फफूंद)'),
(259, 60, 'Insect Infestation (कीट प्रकोप / घुन लगना)'),
(260, 60, 'Broken Seeds (टूटे दाने)'),
(261, 60, 'Discolored Seeds (रंग बदले दाने)'),
(262, 60, 'Moldy Seeds (फफूंद लगे दाने)'),
(263, 60, 'Foreign Matter (stone, dust, husk) (पत्थर / धूल / भूसी / कचरा)'),
(264, 60, 'Bad Odor (खराब गंध)'),
(265, 60, 'Immature Seeds (अधपके दाने)'),
(266, 60, 'Shriveled Seeds (सिकुड़े हुए दाने)'),
(267, 60, 'Over-dried Seeds (अत्यधिक सूखे दाने)'),
(268, 65, 'Excess Moisture (अधिक नमी)'),
(269, 65, 'Fungus / Mold (फफूंद)'),
(270, 65, 'Insect Infestation (कीट प्रकोप / घुन लगना)'),
(271, 65, 'Broken Seeds (टूटे दाने)'),
(272, 65, 'Discolored Seeds (रंग बदले दाने)'),
(273, 65, 'Moldy Seeds (फफूंद लगे दाने)'),
(274, 65, 'Foreign Matter (stone, dust, husk) (पत्थर / धूल / भूसी / कचरा)'),
(275, 65, 'Bad Odor (खराब गंध)'),
(276, 65, 'Immature Seeds (अधपके दाने)'),
(277, 65, 'Shriveled Seeds (सिकुड़े हुए दाने)'),
(278, 65, 'Over-dried Seeds (अत्यधिक सूखे दाने)'),
(279, 67, 'Excess Moisture (अधिक नमी)'),
(280, 67, 'Fungus / Mold (फफूंद)'),
(281, 67, 'Insect Infestation (कीट प्रकोप / घुन लगना)'),
(282, 67, 'Broken Seeds (टूटे दाने)'),
(283, 67, 'Discolored Seeds (रंग बदले दाने)'),
(284, 67, 'Moldy Seeds (फफूंद लगे दाने)'),
(285, 67, 'Foreign Matter (stone, dust, husk) (पत्थर / धूल / भूसी / कचरा)'),
(286, 67, 'Bad Odor (खराब गंध)'),
(287, 67, 'Immature Seeds (अधपके दाने)'),
(288, 67, 'Shriveled Seeds (सिकुड़े हुए दाने)'),
(289, 67, 'Over-dried Seeds (अत्यधिक सूखे दाने)'),
(290, 63, 'Excess Moisture (अधिक नमी)'),
(291, 63, 'Fungus / Mold (फफूंद)'),
(292, 63, 'Insect Infestation (कीट प्रकोप / घुन लगना)'),
(293, 63, 'Broken Seeds (टूटे दाने)'),
(294, 63, 'Discolored Seeds (रंग बदले दाने)'),
(295, 63, 'Moldy Seeds (फफूंद लगे दाने)'),
(296, 63, 'Foreign Matter (stone, dust, husk) (पत्थर / धूल / भूसी / कचरा)'),
(297, 63, 'Bad Odor (खराब गंध)'),
(298, 63, 'Immature Seeds (अधपके दाने)'),
(299, 63, 'Shriveled Seeds (सिकुड़े हुए दाने)'),
(300, 63, 'Over-dried Seeds (अत्यधिक सूखे दाने)'),
(301, 81, 'Excess Moisture (अधिक नमी)'),
(302, 81, 'Fungus / Mold (फफूंद)'),
(303, 81, 'Insect Infestation (कीट प्रकोप / घुन लगना)'),
(304, 81, 'Broken Seeds (टूटे दाने)'),
(305, 81, 'Discolored Seeds (रंग बदले दाने)'),
(306, 81, 'Moldy Seeds (फफूंद लगे दाने)'),
(307, 81, 'Foreign Matter (stone, dust, husk) (पत्थर / धूल / भूसी / कचरा)'),
(308, 81, 'Bad Odor (खराब गंध)'),
(309, 81, 'Immature Seeds (अधपके दाने)'),
(310, 81, 'Shriveled Seeds (सिकुड़े हुए दाने)'),
(311, 81, 'Over-dried Seeds (अत्यधिक सूखे दाने)'),
(312, 76, 'Excess Moisture (अधिक नमी)'),
(313, 76, 'Fungus / Mold (फफूंद)'),
(314, 76, 'Insect Infestation (कीट प्रकोप / घुन लगना)'),
(315, 76, 'Broken Splits (टूटे टुकड़े)'),
(316, 76, 'Discolored Splits (रंग बदले टुकड़े)'),
(317, 76, 'Moldy Splits (फफूंद लगे टुकड़े)'),
(318, 76, 'Foreign Matter (stone, dust, husk) (पत्थर / धूल / भूसी / कचरा)'),
(319, 76, 'Bad Odor (खराब गंध)'),
(320, 76, 'Over-polished Dal (अत्यधिक पॉलिश की हुई दाल)'),
(321, 76, 'Under-polished Dal (कम पॉलिश की हुई दाल)'),
(322, 76, 'Over-dried Splits (अत्यधिक सूखे टुकड़े)'),
(323, 74, 'Excess Moisture (अधिक नमी)'),
(324, 74, 'Fungus / Mold (फफूंद)'),
(325, 74, 'Broken Splits (टूटे टुकड़े)'),
(326, 74, 'Discolored Splits (रंग बदले टुकड़े)'),
(327, 74, 'Moldy Splits (फफूंद लगे टुकड़े)'),
(328, 74, 'Foreign Matter (stone, dust, husk) (पत्थर / धूल / भूसी / कचरा)'),
(329, 74, 'Bad Odor (खराब गंध)'),
(330, 74, 'Over-polished Dal (अत्यधिक पॉलिश की हुई दाल)'),
(331, 74, 'Under-polished Dal (कम पॉलिश की हुई दाल)'),
(332, 74, 'Over-dried Splits (अत्यधिक सूखे टुकड़े)'),
(333, 66, 'Excess Moisture (अधिक नमी)'),
(334, 66, 'Fungus / Mold (फफूंद)'),
(335, 66, 'Insect Infestation (कीट प्रकोप / घुन लगना)'),
(336, 66, 'Broken Seeds (टूटे दाने)'),
(337, 66, 'Discolored Seeds (रंग बदले दाने)'),
(338, 66, 'Moldy Seeds (फफूंद लगे दाने)'),
(339, 66, 'Foreign Matter (stone, dust, husk) (पत्थर / धूल / भूसी / कचरा)'),
(340, 66, 'Bad Odor (खराब गंध)'),
(341, 66, 'Immature Seeds (अधपके दाने)'),
(342, 66, 'Shriveled Seeds (सिकुड़े हुए दाने)'),
(343, 66, 'Over-dried Seeds (अत्यधिक सूखे दाने)'),
(344, 62, 'Excess Moisture (अधिक नमी)'),
(345, 62, 'Fungus / Mold (फफूंद)'),
(346, 62, 'Insect Infestation (कीट प्रकोप / घुन लगना)'),
(347, 62, 'Broken Seeds (टूटे दाने)'),
(348, 62, 'Discolored Seeds (रंग बदले दाने)'),
(349, 62, 'Moldy Seeds (फफूंद लगे दाने)'),
(350, 62, 'Foreign Matter (stone, dust, husk) (पत्थर / धूल / भूसी / कचरा)'),
(351, 62, 'Bad Odor (खराब गंध)'),
(352, 62, 'Immature Seeds (अधपके दाने)'),
(353, 62, 'Shriveled Seeds (सिकुड़े हुए दाने)'),
(354, 62, 'Over-dried Seeds (अत्यधिक सूखे दाने)'),
(355, 72, 'Excess Moisture (अधिक नमी)'),
(356, 72, 'Fungus / Mold (फफूंद)'),
(357, 72, 'Insect Infestation (कीट प्रकोप / घुन लगना)'),
(358, 72, 'Broken Splits (टूटे टुकड़े)'),
(359, 72, 'Discolored Splits (रंग बदले टुकड़े)'),
(360, 72, 'Moldy Splits (फफूंद लगे टुकड़े)'),
(361, 72, 'Foreign Matter (stone, dust, husk) (पत्थर / धूल / भूसी / कचरा)'),
(362, 72, 'Bad Odor (खराब गंध)'),
(363, 72, 'Over-polished Dal (अत्यधिक पॉलिश की हुई दाल)'),
(364, 72, 'Under-polished Dal (कम पॉलिश की हुई दाल)'),
(365, 72, 'Over-dried Splits (अत्यधिक सूखे टुकड़े)'),
(366, 68, 'Excess Moisture (अधिक नमी)'),
(367, 68, 'Fungus / Mold (फफूंद)'),
(368, 68, 'Insect Infestation (कीट प्रकोप / घुन लगना)'),
(369, 68, 'Broken Splits (टूटे टुकड़े)'),
(370, 68, 'Discolored Splits (रंग बदले टुकड़े)'),
(371, 68, 'Moldy Splits (फफूंद लगे टुकड़े)'),
(372, 68, 'Foreign Matter (stone, dust, husk) (पत्थर / धूल / भूसी / कचरा)'),
(373, 68, 'Bad Odor (खराब गंध)'),
(374, 68, 'Over-polished Dal (अत्यधिक पॉलिश की हुई दाल)'),
(375, 68, 'Under-polished Dal (कम पॉलिश की हुई दाल)'),
(376, 68, 'Over-dried Splits (अत्यधिक सूखे टुकड़े)'),
(377, 71, 'Excess Moisture (अधिक नमी)'),
(378, 71, 'Fungus / Mold (फफूंद)'),
(379, 71, 'Insect Infestation (कीट प्रकोप / घुन लगना)'),
(380, 71, 'Broken Splits (टूटे टुकड़े)'),
(381, 71, 'Discolored Splits (रंग बदले टुकड़े)'),
(382, 71, 'Moldy Splits (फफूंद लगे टुकड़े)'),
(383, 71, 'Foreign Matter (stone, dust, husk) (पत्थर / धूल / भूसी / कचरा)'),
(384, 71, 'Bad Odor (खराब गंध)'),
(385, 71, 'Over-polished Dal (अत्यधिक पॉलिश की हुई दाल)'),
(386, 71, 'Under-polished Dal (कम पॉलिश की हुई दाल)'),
(387, 71, 'Over-dried Splits (अत्यधिक सूखे टुकड़े)'),
(388, 73, 'Excess Moisture (अधिक नमी)'),
(389, 73, 'Fungus / Mold (फफूंद)'),
(390, 73, 'Insect Infestation (कीट प्रकोप / घुन लगना)'),
(391, 73, 'Broken Splits (टूटे टुकड़े)'),
(392, 73, 'Discolored Splits (रंग बदले टुकड़े)'),
(393, 73, 'Moldy Splits (फफूंद लगे टुकड़े)'),
(394, 73, 'Foreign Matter (stone, dust, husk) (पत्थर / धूल / भूसी / कचरा)'),
(395, 73, 'Bad Odor (खराब गंध)'),
(396, 73, 'Over-polished Dal (अत्यधिक पॉलिश की हुई दाल)'),
(397, 73, 'Under-polished Dal (कम पॉलिश की हुई दाल)'),
(398, 73, 'Over-dried Splits (अत्यधिक सूखे टुकड़े)'),
(399, 70, 'Excess Moisture (अधिक नमी)'),
(400, 70, 'Fungus / Mold (फफूंद)'),
(401, 70, 'Insect Infestation (कीट प्रकोप / घुन लगना)'),
(402, 70, 'Broken Splits (टूटे टुकड़े)'),
(403, 70, 'Discolored Splits (रंग बदले टुकड़े)'),
(404, 70, 'Moldy Splits (फफूंद लगे टुकड़े)'),
(405, 70, 'Foreign Matter (stone, dust, husk) (पत्थर / धूल / भूसी / कचरा)'),
(406, 70, 'Bad Odor (खराब गंध)'),
(407, 70, 'Over-polished Dal (अत्यधिक पॉलिश की हुई दाल)'),
(408, 70, 'Under-polished Dal (कम पॉलिश की हुई दाल)'),
(409, 70, 'Over-dried Splits (अत्यधिक सूखे टुकड़े)'),
(410, 78, 'Excess Moisture (अधिक नमी)'),
(411, 78, 'Fungus / Mold (फफूंद)'),
(412, 78, 'Insect Infestation (कीट प्रकोप / घुन लगना)'),
(413, 78, 'Broken Seeds (टूटे दाने)'),
(414, 78, 'Discolored Seeds (रंग बदले दाने)'),
(415, 78, 'Moldy Seeds (फफूंद लगे दाने)'),
(416, 78, 'Foreign Matter (stone, dust, husk) (पत्थर / धूल / भूसी / कचरा)'),
(417, 78, 'Bad Odor (खराब गंध)'),
(418, 78, 'Immature Seeds (अधपके दाने)'),
(419, 78, 'Shriveled Seeds (सिकुड़े हुए दाने)'),
(420, 78, 'Over-dried Seeds (अत्यधिक सूखे दाने)'),
(421, 79, 'Excess Moisture (अधिक नमी)'),
(422, 79, 'Fungus / Mold (फफूंद)'),
(423, 79, 'Insect Infestation (कीट प्रकोप / घुन लगना)'),
(424, 79, 'Broken Seeds (टूटे दाने)'),
(425, 79, 'Discolored Seeds (रंग बदले दाने)'),
(426, 79, 'Moldy Seeds (फफूंद लगे दाने)'),
(427, 79, 'Foreign Matter (stone, dust, husk) (पत्थर / धूल / भूसी / कचरा)'),
(428, 79, 'Bad Odor (खराब गंध)'),
(429, 79, 'Immature Seeds (अधपके दाने)'),
(430, 79, 'Shriveled Seeds (सिकुड़े हुए दाने)'),
(431, 79, 'Over-dried Seeds (अत्यधिक सूखे दाने)'),
(432, 77, 'Excess Moisture (अधिक नमी)'),
(433, 77, 'Fungus / Mold (फफूंद)'),
(434, 77, 'Insect Infestation (कीट प्रकोप / घुन लगना)'),
(435, 77, 'Broken Seeds (टूटे दाने)'),
(436, 77, 'Discolored Seeds (रंग बदले दाने)'),
(437, 77, 'Moldy Seeds (फफूंद लगे दाने)'),
(438, 77, 'Foreign Matter (stone, dust, husk) (पत्थर / धूल / भूसी / कचरा)'),
(439, 77, 'Bad Odor (खराब गंध)'),
(440, 77, 'Immature Seeds (अधपके दाने)'),
(441, 77, 'Shriveled Seeds (सिकुड़े हुए दाने)'),
(442, 77, 'Over-dried Seeds (अत्यधिक सूखे दाने)'),
(443, 75, 'Excess Moisture (अधिक नमी)'),
(444, 75, 'Fungus / Mold (फफूंद)'),
(445, 75, 'Insect Infestation (कीट प्रकोप / घुन लगना)'),
(446, 75, 'Broken Splits (टूटे टुकड़े)'),
(447, 75, 'Discolored Splits (रंग बदले टुकड़े)'),
(448, 75, 'Discolored Splits (रंग बदले टुकड़े)'),
(449, 75, 'Foreign Matter (stone, dust, husk) (पत्थर / धूल / भूसी / कचरा)'),
(450, 75, 'Bad Odor (खराब गंध)'),
(451, 75, 'Over-polished Dal (अत्यधिक पॉलिश की हुई दाल)'),
(452, 75, 'Under-polished Dal (कम पॉलिश की हुई दाल)'),
(453, 75, 'Over-dried Splits (अत्यधिक सूखे टुकड़े)'),
(454, 87, 'Excess Moisture / Waterlogging (अधिक नमी / पानी जम जाना)'),
(455, 87, 'Wilting / Loss of Turgidity (मुरझाना / पत्तियों की नर्मपन खोना)'),
(456, 87, 'Discoloration (रंग बदलना / पीला या भूरा होना)'),
(457, 87, 'Fungus / Mold (फफूंद / सड़ा हुआ हिस्सा)'),
(458, 87, 'Insect Infestation / Pest Damage (कीट / कीट का नुकसान)'),
(459, 87, 'Leaf Spots / Lesions (पत्तियों पर दाग या छाले)'),
(460, 87, 'Foreign Matter (मिट्टी, पत्थर, धूल) (मिट्टी / पत्थर / कचरा)'),
(461, 87, 'Bad Odor (खराब गंध / सड़ा हुआ महसूस होना)'),
(462, 87, 'Immature / Small Leaves (अधपकी / छोटी पत्तियां)'),
(463, 87, 'Over-mature / Tough Leaves (अत्यधिक बड़ी / कड़ी पत्तियां)'),
(464, 91, 'Excess Moisture / Waterlogging (अधिक नमी / पानी जम जाना)'),
(465, 91, 'Soft Rot / Decay (नरम सड़न / गलना)'),
(466, 91, 'Fungus / Mold (फफूंद लगना)'),
(467, 91, 'Insect Damage / Pest Holes (कीट क्षति / छेद होना)'),
(468, 91, 'Cracking / Splitting (फटना / दरार पड़ना)'),
(469, 91, 'Discoloration (रंग बदलना / काला या भूरा धब्बा)'),
(470, 91, 'Shriveling / Dehydration (सिकुड़ना / नमी की कमी)'),
(471, 91, 'Mechanical Damage (कट या चोट लगना)'),
(472, 91, 'Foreign Matter (मिट्टी, पत्थर, धूल) (मिट्टी / पत्थर / कचरा)'),
(473, 91, 'Bad Odor (खराब गंध / सड़ा हुआ गंध)'),
(474, 91, 'Immature Roots (अधपके / छोटे आकार के कंद)'),
(475, 91, 'Over-mature / Woody Roots (अत्यधिक पके / कठोर कंद)'),
(476, 98, 'Excess Moisture / Water-soaked Areas (अधिक नमी / पानी भरे धब्बे)'),
(477, 98, 'Soft Rot / Decay (नरम सड़न / गलना)'),
(478, 98, 'Fungus / Mold (फफूंद लगना)'),
(479, 98, 'Insect Damage / Bore Holes (कीट क्षति / छेद होना)'),
(480, 98, 'Skin Scars / Bruising (छिलके पर खरोंच / चोट)'),
(481, 98, 'Discoloration (रंग बदलना / भूरे या काले धब्बे)'),
(482, 98, 'Shriveling / Dehydration (सिकुड़ना / नमी की कमी)'),
(483, 98, 'Mechanical Damage (कट, दबाव से नुकसान)'),
(484, 98, 'Foreign Matter (मिट्टी, धूल, कचरा)'),
(485, 98, 'Bad Odor (खराब गंध / सड़ा हुआ)'),
(486, 98, 'Immature Fruits (अधपके / छोटे बैंगन)'),
(487, 98, 'Over-mature / Spongy Texture (अत्यधिक पके / स्पंजी बनावट)'),
(488, 89, 'Excess Moisture / Waterlogging (अधिक नमी / पानी जमा होना)'),
(489, 89, 'Soft Rot / Decay (नरम सड़न / गलना)'),
(490, 89, 'Fungus / Mold (फफूंद लगना)'),
(491, 89, 'Insect Damage / Pest Holes (कीट क्षति / छेद होना)'),
(492, 89, 'Cracking / Splitting (फटना / दरार पड़ना)'),
(493, 89, 'Discoloration / Green Top (रंग बदलना / ऊपर हरा पड़ना)'),
(494, 89, 'Forking / Misshapen Roots (टेढ़ी-मेढ़ी / शाखायुक्त गाजर)'),
(495, 89, 'Shriveling / Dehydration (सिकुड़ना / नमी की कमी)'),
(496, 89, 'Mechanical Damage (कट, चोट या दबाव से नुकसान)'),
(497, 89, 'Foreign Matter (मिट्टी, पत्थर, धूल) (मिट्टी / पत्थर / कचरा)'),
(498, 89, 'Foreign Matter (मिट्टी, पत्थर, धूल) (मिट्टी / पत्थर / कचरा)'),
(499, 89, 'Bad Odor (खराब गंध / सड़ा हुआ)'),
(500, 89, 'Immature Roots (अधपकी / छोटी गाजर)'),
(501, 89, 'Over-mature / Woody Texture (अत्यधिक पकी / कड़ी गाजर)'),
(502, 36, 'Excess Moisture / Water-soaked Pods (अधिक नमी / पानी भरी फलियां)'),
(503, 36, 'Wilting / Loss of Freshness (मुरझाना / ताजगी कम होना)'),
(504, 36, 'Fungus / Mold (फफूंद लगना)'),
(505, 36, 'Insect Damage / Pest Attack (कीट क्षति / कीट प्रकोप)'),
(506, 36, 'Pod Discoloration (फलियों का रंग बदलना)'),
(507, 36, 'Soft Rot / Decay (नरम सड़न / गलना)'),
(508, 36, 'Broken Pods / Split Seeds (टूटी फलियां / फटे दाने)'),
(509, 36, 'Foreign Matter (मिट्टी, धूल, कचरा)'),
(510, 36, 'Bad Odor (खराब गंध / सड़ा हुआ)'),
(511, 36, 'Immature Pods / Seeds (अधपकी फलियां / दाने)'),
(512, 36, 'Over-mature / Hard Seeds (अत्यधिक पके / सख्त दाने)'),
(513, 84, 'Excess Moisture / Water-soaked Leaves (अधिक नमी / पानी भरे पत्ते)'),
(514, 84, 'Wilting / Loss of Freshness (मुरझाना / ताजगी कम होना)'),
(515, 84, 'Yellowing / Discoloration (पीला पड़ना / रंग बदलना)'),
(516, 84, 'Fungus / Mold (फफूंद लगना)'),
(517, 84, 'Insect Infestation / Leaf Damage (कीट प्रकोप / पत्तियों का नुकसान)'),
(518, 84, 'Leaf Spots / Black Patches (पत्तियों पर दाग / काले धब्बे)'),
(519, 84, 'Mechanical Damage (कुचलना / टूटना)'),
(520, 84, 'Foreign Matter (मिट्टी, धूल, कचरा)'),
(521, 84, 'Bad Odor (खराब गंध / सड़ा हुआ)'),
(522, 84, 'Over-mature Leaves (अत्यधिक बड़े / कड़े पत्ते)'),
(523, 84, 'Immature / Very Small Leaves (बहुत छोटे / अधपके पत्ते)'),
(524, 100, 'Excess Moisture / Water-soaked Areas (अधिक नमी / पानी भरे हिस्से)'),
(525, 100, 'Soft Rot / Watery Decay (नरम सड़न / पानी जैसा गलना)'),
(526, 100, 'Fungus / Mold (फफूंद लगना)'),
(527, 100, 'Insect Damage / Pest Bites (कीट क्षति / काटने के निशान)'),
(528, 100, 'Surface Scars / Scratches (छिलके पर खरोंच / दाग)'),
(529, 100, 'Yellowing / Discoloration (पीला पड़ना / रंग बदलना)'),
(530, 100, 'Shriveling / Dehydration (सिकुड़ना / नमी की कमी)'),
(531, 100, 'Bitter Taste (कड़वाहट – quality defect)'),
(532, 100, 'Mechanical Damage (दबाव, कट या चोट)'),
(533, 100, 'Bad Odor (खराब गंध / सड़ा हुआ)'),
(534, 100, 'Foreign Matter (मिट्टी, )'),
(535, 100, 'Immature Fruits (अधपके / छोटे खीरे)'),
(536, 100, 'Over-mature / Seedy Texture (अत्यधिक पके / बीज ज्यादा होना)'),
(537, 96, 'Excess Moisture / Water-soaked Areas (अधिक नमी / पानी भरे हिस्से)'),
(538, 96, 'Soft Rot / Tuber Decay (नरम सड़न / कंद का गलना)'),
(539, 96, 'Fungus / Mold (फफूंद लगना)'),
(540, 96, 'Insect Damage / Borer Attack (कीट क्षति / सुराख होना)'),
(541, 96, 'Cuts / Mechanical Damage (कट, चोट या दबाव से नुकसान)'),
(542, 96, 'Discoloration / Black Patches (रंग बदलना / काले धब्बे)'),
(543, 96, 'Shriveling / Dehydration (सिकुड़ना / नमी की कमी)'),
(544, 96, 'Foreign Matter (मिट्टी, पत्थर, धूल) (मिट्टी / पत्थर / कचरा)'),
(545, 96, 'Bad Odor (खराब गंध / सड़ा हुआ)'),
(546, 96, 'Immature Corms (अधपके / छोटे कंद)'),
(547, 96, 'Over-mature / Fibrous Texture (अत्यधिक पके / रेशेदार बनावट)'),
(548, 96, 'Skin Peeling / Cracks (छिलका उतरना / दरारें)'),
(549, 83, 'Excess Moisture / Water-soaked Leaves (अधिक नमी / पानी भरे पत्ते)'),
(550, 83, 'Wilting / Loss of Freshness (मुरझाना / ताजगी कम होना)'),
(551, 83, 'Yellowing / Discoloration (पीला पड़ना / रंग बदलना)'),
(552, 83, 'Fungus / Mold (फफूंद लगना)'),
(553, 83, 'Insect Infestation / Leaf Damage (कीट प्रकोप / पत्तियों का नुकसान)'),
(554, 83, 'Leaf Spots / Black Patches (पत्तियों पर दाग / काले धब्बे)'),
(555, 83, 'Mechanical Damage (कुचलना / टूटना)'),
(556, 83, 'Foreign Matter (मिट्टी, धूल, कचरा)'),
(557, 83, 'Bad Odor (खराब गंध / सड़ा हुआ)'),
(558, 83, 'Over-mature Leaves (अत्यधिक बड़े / कड़े पत्ते)'),
(559, 83, 'Immature / Very Small Leaves (बहुत छोटे / अधपके पत्ते)'),
(560, 94, 'Excess Moisture / Water-soaked Rhizomes (अधिक नमी / पानी भरे कंद)'),
(561, 94, 'Soft Rot / Rhizome Decay (नरम सड़न / गलना)'),
(562, 94, 'Fungus / Mold (फफूंद लगना)'),
(563, 94, 'Insect Damage / Borer Attack (कीट क्षति / छेद होना)'),
(564, 94, 'Cuts / Mechanical Damage (कट या चोट लगना)'),
(565, 94, 'Shriveling / Dehydration (सिकुड़ना / नमी की कमी)'),
(566, 94, 'Discoloration / Dark Patches (रंग बदलना / काले धब्बे)'),
(567, 94, 'Sprouting (अंकुर निकलना)'),
(568, 94, 'Foreign Matter (मिट्टी, धूल, कचरा)'),
(569, 94, 'Bad Odor (खराब गंध / सड़ा हुआ)'),
(570, 94, 'Immature Rhizomes (अधपके / छोटे कंद)'),
(571, 94, 'Over-mature / Fibrous Texture (अत्यधिक पके / रेशेदार बनावट)'),
(572, 85, 'Excess Moisture / Water-soaked Leaves (अधिक नमी / पानी भरे पत्ते)'),
(573, 85, 'Wilting / Loss of Crispness (मुरझाना / कुरकुरापन खत्म होना)'),
(574, 85, 'Tip Burn / Edge Browning (किनारों का जलना / भूरा होना)'),
(575, 85, 'Fungus / Mold (फफूंद लगना)'),
(576, 85, 'Insect Infestation / Leaf Damage (कीट प्रकोप / पत्तियों का नुकसान)'),
(577, 85, 'Discoloration / Yellowing (पीला पड़ना / रंग बदलना)'),
(578, 85, 'Leaf Spots / Black Patches (पत्तियों पर दाग / काले धब्बे)'),
(579, 85, 'Mechanical Damage (कुचलना / टूटना)'),
(580, 85, 'Foreign Matter (मिट्टी, धूल, कचरा)'),
(581, 85, 'Bad Odor (खराब गंध / सड़ा हुआ)'),
(582, 85, 'Immature Heads / Leaves (अधपके / छोटे पत्ते)'),
(583, 85, 'Over-mature / Bitter Taste (अत्यधिक पका / कड़वाहट)'),
(584, 35, 'Excess Moisture / Water-soaked Pods (अधिक नमी / पानी भरी फलियां)'),
(585, 35, 'Wilting / Loss of Freshness (मुरझाना / ताजगी कम होना)'),
(586, 35, 'Fungus / Mold (फफूंद लगना)'),
(587, 35, 'Insect Damage / Pod Borer (कीट क्षति / फलियों में छेद)'),
(588, 35, 'Pod Discoloration (फलियों का रंग बदलना)'),
(589, 35, 'Split / Broken Pods (फटी या टूटी फलियां)'),
(590, 35, 'Soft Rot / Decay (नरम सड़न / गलना)'),
(591, 35, 'Foreign Matter (मिट्टी, धूल, कचरा)'),
(592, 35, 'Bad Odor (खराब गंध / सड़ा हुआ)'),
(593, 35, 'Immature Seeds (अधपके / छोटे मटर)'),
(594, 35, 'Over-mature / Hard Seeds (अत्यधिक पके / सख्त दाने)'),
(595, 35, 'Shriveled Seeds (सिकुड़े हुए दाने)'),
(596, 38, 'Excess Moisture / Slimy Surface (अधिक नमी / चिपचिपी सतह)'),
(597, 38, 'Soft Rot / Decay (नरम सड़न / गलना)'),
(598, 38, 'Fungus / Mold Growth (फफूंद लगना)'),
(599, 38, 'Discoloration / Browning (रंग बदलना / भूरा पड़ना)'),
(600, 38, 'Shriveling / Dehydration (सिकुड़ना / सूखना)'),
(601, 38, 'Bruising / Mechanical Damage (चोट के निशान / दबाव से नुकसान)'),
(602, 38, 'Insect Contamination (कीट / लार्वा की उपस्थिति)'),
(603, 38, 'Foreign Matter (मिट्टी, भूसा, कचरा)'),
(604, 38, 'Bad Odor (खराब गंध / सड़ा हुआ)'),
(605, 38, 'Immature Mushrooms (अधपके / बहुत छोटे मशरूम)'),
(606, 38, 'Over-mature / Open Caps (अत्यधिक पके / खुले हुए कैप)'),
(607, 86, 'Excess Moisture / Water-soaked Leaves (अधिक नमी / पानी भरे पत्ते)'),
(608, 86, 'Wilting / Loss of Freshness (मुरझाना / ताजगी कम होना)'),
(609, 86, 'Yellowing / Discoloration (पीला पड़ना / रंग बदलना)'),
(610, 86, 'Fungus / Mold (फफूंद लगना)'),
(611, 86, 'Insect Infestation / Leaf Damage (कीट प्रकोप / पत्तियों का नुकसान)'),
(612, 86, 'Leaf Spots / Black Patches (पत्तियों पर दाग / काले धब्बे)'),
(613, 86, 'Mechanical Damage (कुचलना / टूटना)'),
(614, 86, 'Foreign Matter (मिट्टी, धूल, कचरा)'),
(615, 86, 'Bad Odor (खराब गंध / सड़ा हुआ)'),
(616, 86, 'Over-mature / Tough Leaves (अत्यधिक बड़े / कड़े पत्ते)'),
(617, 86, 'Immature / Small Leaves (बहुत छोटे / अधपके पत्ते)'),
(618, 99, 'Excess Moisture / Slimy Surface (अधिक नमी / चिपचिपी सतह)'),
(619, 99, 'Soft Rot / Decay (नरम सड़न / गलना)'),
(620, 99, 'Fungus / Mold (फफूंद लगना)'),
(621, 99, 'Insect Damage / Borer Holes (कीट क्षति / छेद होना)'),
(622, 99, 'Discoloration / Dark Spots (रंग बदलना / काले धब्बे)'),
(623, 99, 'Shriveling / Dehydration (सिकुड़ना / नमी की कमी)'),
(624, 99, 'Foreign Matter (मिट्टी,  कचरा)'),
(625, 99, 'Bad Odor (खराब गंध / सड़ा हुआ)'),
(626, 99, 'Immature Pods (अधपकी / बहुत छोटी भिंडी)'),
(627, 99, 'Over-mature / Fibrous Pods (अत्यधिक पकी / रेशेदार भिंडी)'),
(628, 88, 'Excess Moisture / Wet Tubers (अधिक नमी / गीले कंद)'),
(629, 88, 'Soft Rot / Tuber Decay (नरम सड़न / गलना)'),
(630, 88, 'Fungus / Mold (फफूंद लगना)'),
(631, 88, 'Sprouting (अंकुर निकलना)'),
(632, 88, 'Greenish Skin / Greening (हरा पड़ना)'),
(633, 88, 'Cuts / Bruises / Mechanical Damage (कट, चोट या दबाव के निशान)'),
(634, 88, 'Insect Damage / Holes (कीट क्षति / छेद)'),
(635, 88, 'Shriveling / Dehydration (सिकुड़ना / सूखना)'),
(636, 88, 'Discoloration / Black Spots (रंग बदलना / काले धब्बे)'),
(637, 88, 'Foreign Matter (मिट्टी, धूल, कचरा)'),
(638, 88, 'Bad Odor (खराब गंध / सड़ा हुआ)'),
(639, 88, 'Immature / Very Small Tubers (अधपके / बहुत छोटे आलू)'),
(640, 90, 'Excess Moisture / Water-soaked Roots (अधिक नमी / पानी भरी जड़ें)'),
(641, 90, 'Soft Rot / Root Decay (नरम सड़न / गलना)'),
(642, 90, 'Fungus / Mold (फफूंद लगना)'),
(643, 90, 'Cracking / Splitting (फटना / दरारें पड़ना)'),
(644, 90, 'Discoloration / Brown or Black Spots (रंग बदलना / भूरे या काले धब्बे)'),
(645, 90, 'Pithiness / Spongy Texture (अंदर से खोखली / स्पंजी बनावट)'),
(646, 90, 'Insect Damage / Borer Holes (कीट क्षति / छेद)'),
(647, 90, 'Mechanical Damage (कट, चोट या दबाव)'),
(648, 90, 'Shriveling / Dehydration (सिकुड़ना / सूखना)'),
(649, 90, 'Foreign Matter (मिट्टी, धूल)'),
(650, 90, 'Bad Odor (खराब गंध / सड़ा हुआ)'),
(651, 90, 'Over-mature / Bitter Taste (अत्यधिक पकी / कड़वाहट)'),
(652, 37, 'Excess Moisture (अधिक नमी)'),
(653, 37, 'Fungus / Mold (फफूंद)'),
(654, 37, 'Insect Infestation (कीट प्रकोप / घुन लगना)'),
(655, 37, 'Broken Seeds (टूटे दाने)'),
(656, 37, 'Discolored Seeds (रंग बदले दाने)'),
(657, 37, 'Moldy Seeds (फफूंद लगे दाने)'),
(658, 37, 'Bad Odor (खराब गंध)'),
(659, 37, 'Immature Seeds (अधपके दाने)'),
(660, 37, 'Over-dried Seeds (अत्यधिक सूखे दाने)'),
(661, 37, 'Shriveled / Wrinkled Seeds (सिकुड़े / झुर्रियों वाले दाने)'),
(662, 37, 'Overheated / Split Seeds (अत्यधिक गर्म / फटे दाने)'),
(663, 82, 'Excess Moisture / Water-soaked Leaves (अधिक नमी / पानी भरे पत्ते)'),
(664, 82, 'Wilting / Loss of Freshness (मुरझाना / ताजगी कम होना)'),
(665, 82, 'Yellowing / Discoloration (पीला पड़ना / रंग बदलना)'),
(666, 82, 'Fungus / Mold (फफूंद लगना)'),
(667, 82, 'Insect Infestation / Leaf Damage (कीट प्रकोप / पत्तियों का नुकसान)'),
(668, 82, 'Leaf Spots / Black Patches (पत्तियों पर दाग / काले धब्बे)'),
(669, 82, 'Mechanical Damage (कुचलना / टूटना)'),
(670, 82, 'Foreign Matter (मिट्टी, धूल, कचरा)'),
(671, 82, 'Bad Odor (खराब गंध / सड़ा हुआ)'),
(672, 82, 'Over-mature Leaves (अत्यधिक बड़े / कड़े पत्ते)'),
(673, 82, 'Immature / Very Small Leaves (बहुत छोटे / अधपके पत्ते)'),
(674, 93, 'Excess Moisture / Water-soaked Roots (अधिक नमी / पानी भरी जड़ें)'),
(675, 93, 'Soft Rot / Root Decay (नरम सड़न / गलना)'),
(676, 93, 'Fungus / Mold (फफूंद लगना)'),
(677, 93, 'Insect Damage / Borer Holes (कीट क्षति / सुराख होना)'),
(678, 93, 'Cuts / Mechanical Damage (कट, चोट या दबाव से नुकसान)'),
(679, 93, 'Discoloration / Dark Spots (रंग बदलना / काले धब्बे)'),
(680, 93, 'Sprouting (अंकुर निकलना)'),
(681, 93, 'Shriveling / Dehydration (सिकुड़ना / नमी की कमी)'),
(682, 93, 'Fibrous Texture / Woody Roots (रेशेदार / कठोर बनावट)'),
(683, 93, 'Foreign Matter (मिट्टी, धूल, कचरा)'),
(684, 93, 'Bad Odor (खराब गंध / सड़ा हुआ)'),
(685, 93, 'Immature Roots (अधपके / छोटे कंद)'),
(686, 97, 'Excess Moisture / Water-soaked Fruits (अधिक नमी / पानी भरे टमाटर)'),
(687, 97, 'Soft Rot / Decay (नरम सड़न / गलना)'),
(688, 97, 'Fungus / Mold (फफूंद लगना)'),
(689, 97, 'Insect Damage / Pest Holes (कीट क्षति / छेद होना)'),
(690, 97, 'Cracking / Splitting (फटना / दरार पड़ना)'),
(691, 97, 'Discoloration / Uneven Ripening (रंग बदलना / असमान पकना)'),
(692, 97, 'Mechanical Damage / Bruises (कट, चोट या दबाव के निशान)'),
(693, 97, 'Shriveling / Dehydration (सिकुड़ना / नमी की कमी)'),
(694, 97, 'Blotchy Skin / Spots (धब्बेदार छिलका / दाग)'),
(695, 97, 'Foreign Matter (मिट्टी, धूल, कचरा)'),
(696, 97, 'Bad Odor (खराब गंध / सड़ा हुआ)'),
(697, 97, 'Immature Fruits (अधपके / छोटे टमाटर)'),
(698, 97, 'Over-mature / Soft Texture (अत्यधिक पके / नरम बनावट)'),
(699, 92, 'Excess Moisture / Water-soaked Roots (अधिक नमी / पानी भरी जड़ें)'),
(700, 92, 'Soft Rot / Root Decay (नरम सड़न / गलना)'),
(701, 92, 'Fungus / Mold (फफूंद लगना)'),
(702, 92, 'Insect Damage / Borer Holes (कीट क्षति / सुराख होना)'),
(703, 92, 'Cuts / Mechanical Damage (कट, चोट या दबाव से नुकसान)'),
(704, 92, 'Discoloration / Dark Spots (रंग बदलना / काले धब्बे)'),
(705, 92, 'Shriveling / Dehydration (सिकुड़ना / नमी की कमी)'),
(706, 92, 'Fibrous / Woody Texture (रेशेदार / कठोर बनावट)'),
(707, 92, 'Foreign Matter (मिट्टी, धूल, कचरा)'),
(708, 92, 'Bad Odor (खराब गंध / सड़ा हुआ)'),
(709, 92, 'Immature Roots (अधपके / छोटे कंद)'),
(710, 92, 'Immature Roots (अधपके / छोटे कंद)'),
(711, 92, 'Over-mature Roots (अत्यधिक पके / बहुत बड़े या रेशेदार कंद)'),
(712, 95, 'Excess Moisture / Water-soaked Corms (अधिक नमी / पानी भरे कंद)'),
(713, 95, 'Soft Rot / Corm Decay (नरम सड़न / गलना)'),
(714, 95, 'Fungus / Mold (फफूंद लगना)'),
(715, 95, 'Insect Damage / Borer Holes (कीट क्षति / छेद होना)'),
(716, 95, 'Cuts / Mechanical Damage (कट, चोट या दबाव से नुकसान)'),
(717, 95, 'Discoloration / Dark Spots (रंग बदलना / काले धब्बे)'),
(718, 95, 'Shriveling / Dehydration (सिकुड़ना / नमी की कमी)'),
(719, 95, 'Fibrous / Woody Texture (रेशेदार / कठोर बनावट)'),
(720, 95, 'Foreign Matter (मिट्टी,  धूल, कचरा)'),
(721, 95, 'Bad Odor (खराब गंध / सड़ा हुआ)'),
(722, 95, 'Immature Corms (अधपके / छोटे कंद)'),
(723, 95, 'Over-mature / Fibrous Corms (अत्यधिक पके / रेशेदार कंद)');

-- --------------------------------------------------------

--
-- Table structure for table `purchases`
--

CREATE TABLE `purchases` (
  `id` int(11) NOT NULL,
  `purchase_date` date NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `company_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `purchases`
--

INSERT INTO `purchases` (`id`, `purchase_date`, `total_amount`, `company_id`, `user_id`, `created_at`) VALUES
(28, '2025-12-30', 14760.00, 1, NULL, '2025-12-30 04:38:28'),
(29, '2025-12-31', 360.00, 1, NULL, '2025-12-31 08:36:47'),
(30, '2025-12-31', 240.00, 1, NULL, '2025-12-31 08:41:31'),
(31, '2026-01-01', 159900.00, 1, NULL, '2026-01-01 09:46:42'),
(32, '2026-01-02', 144.00, 2, NULL, '2026-01-02 07:28:34'),
(33, '2026-01-07', 5000.00, 1, 3, '2026-01-07 08:06:35'),
(34, '2026-01-08', 12000.00, 1, 3, '2026-01-08 12:35:20'),
(35, '2026-01-08', 156000.00, 1, 3, '2026-01-08 12:37:43'),
(36, '2026-01-08', 12300.00, 1, 3, '2026-01-08 12:38:50'),
(37, '2026-01-09', 1225.00, 1, 3, '2026-01-09 09:53:37');

-- --------------------------------------------------------

--
-- Table structure for table `purchase_items`
--

CREATE TABLE `purchase_items` (
  `id` int(11) NOT NULL,
  `purchase_id` int(11) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `subcategory_id` int(11) NOT NULL,
  `defect_id` int(11) DEFAULT NULL,
  `quantity` decimal(10,2) NOT NULL,
  `price_per_unit` decimal(10,2) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `purchase_items`
--

INSERT INTO `purchase_items` (`id`, `purchase_id`, `category_id`, `subcategory_id`, `defect_id`, `quantity`, `price_per_unit`, `subtotal`) VALUES
(33, 33, 1, 54, NULL, 500.00, 10.00, 5000.00),
(34, 34, 2, 95, NULL, 1.20, 10.00, 12000.00),
(35, 35, 2, 95, NULL, 12.00, 13.00, 156000.00),
(36, 36, 3, 68, NULL, 1.23, 100.00, 12300.00),
(37, 37, 1, 54, 93, 0.98, 1250.00, 1225.00);

-- --------------------------------------------------------

--
-- Table structure for table `subcategories`
--

CREATE TABLE `subcategories` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `category_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `subcategories`
--

INSERT INTO `subcategories` (`id`, `name`, `category_id`, `created_at`) VALUES
(35, 'Matar', 2, '2026-01-02 08:58:58'),
(36, 'Chana (hara)', 2, '2026-01-02 08:59:44'),
(37, 'Soybean', 2, '2026-01-02 09:00:22'),
(38, 'Mushroom', 2, '2026-01-02 09:01:03'),
(39, 'Wheat (गेहूं)', 1, '2026-01-02 09:20:35'),
(40, 'Rice (चावल)', 1, '2026-01-02 09:21:05'),
(41, 'Maize / Corn (मक्का)', 1, '2026-01-02 09:22:03'),
(42, 'Barley (जौ)', 1, '2026-01-02 09:22:46'),
(43, 'Oats (जई)', 1, '2026-01-02 09:23:25'),
(44, 'Rye (राई)', 1, '2026-01-02 09:23:44'),
(45, 'Sorghum (ज्वार)', 1, '2026-01-02 09:24:22'),
(46, 'Pearl Millet (बाजरा)', 1, '2026-01-02 09:24:43'),
(47, 'Finger Millet (रागी)', 1, '2026-01-02 09:25:14'),
(48, 'Foxtail Millet (कंगनी)', 1, '2026-01-02 09:26:12'),
(49, 'Little Millet (कुटकी)', 1, '2026-01-02 09:26:55'),
(50, 'Kodo Millet (कोदो)', 1, '2026-01-02 09:29:01'),
(51, 'Barnyard Millet (सांवा)', 1, '2026-01-02 09:29:46'),
(52, 'Quinoa (कीनुआ)', 1, '2026-01-02 09:31:16'),
(53, 'Buckwheat (कुट्टू)', 1, '2026-01-02 09:32:24'),
(54, 'Amaranth (राजगीरा)', 1, '2026-01-02 09:33:52'),
(55, 'Whole Wheat (साबुत गेहूं)', 1, '2026-01-02 09:35:23'),
(56, 'Brown Rice (ब्राउन राइस)', 1, '2026-01-02 09:35:51'),
(57, 'Whole Oats (साबुत जई)', 1, '2026-01-02 09:36:16'),
(58, 'White Rice (सफेद चावल)', 1, '2026-01-02 09:42:58'),
(59, 'Chickpeas (साबुत चना)', 3, '2026-01-02 09:52:34'),
(60, 'Green Gram (साबुत मूंग)', 3, '2026-01-02 09:53:46'),
(61, 'Black Gram (साबुत उड़द)', 3, '2026-01-02 09:54:56'),
(62, 'Pigeon Pea (साबुत अरहर)', 3, '2026-01-02 09:56:17'),
(63, 'Lentils Whole (साबुत मसूर)', 3, '2026-01-02 09:59:48'),
(64, 'Cowpea (लोबिया)', 3, '2026-01-02 10:00:58'),
(65, 'Horse Gram (कुल्थी)', 3, '2026-01-02 10:02:33'),
(66, 'Moth Bean (मटकी)', 3, '2026-01-02 10:03:24'),
(67, 'Kidney Beans (राजमा)', 3, '2026-01-02 10:04:04'),
(68, 'Split Chickpeas (चना दाल)', 3, '2026-01-02 10:04:43'),
(70, 'Split Pigeon Pea (तूर दाल)', 3, '2026-01-02 10:15:50'),
(71, 'Split Green Gram (मूंग दाल)', 3, '2026-01-02 10:16:58'),
(72, 'Split Black Gram (उड़द दाल)', 3, '2026-01-02 10:18:12'),
(73, 'Split Lentils (मसूर दाल)', 3, '2026-01-02 10:19:12'),
(74, 'Moong Dal Dhuli (धुली मूंग दाल)', 3, '2026-01-02 10:20:17'),
(75, 'Urad Dal Dhuli (धुली उड़द दाल)', 3, '2026-01-02 10:20:40'),
(76, 'Masoor Dal Dhuli (धुली मसूर दाल)', 3, '2026-01-02 10:21:19'),
(77, 'Unpolished Toor Dal (बिना पॉलिश तूर)', 3, '2026-01-02 10:23:44'),
(78, 'Unpolished Chana Dal (बिना पॉलिश चना)', 3, '2026-01-02 10:24:11'),
(79, 'Unpolished Moong Dal (बिना पॉलिश मूंग)', 3, '2026-01-02 10:25:16'),
(80, 'Black Eyed Peas (चवली)', 3, '2026-01-02 10:28:26'),
(81, 'Lima Beans (लीमा बीन्स)', 3, '2026-01-02 10:30:31'),
(82, 'Spinach / Palak (पालक)', 2, '2026-01-02 11:33:16'),
(83, 'Fenugreek Leaves (मेथी)', 2, '2026-01-02 11:33:54'),
(84, 'Coriander Leaves (धनिया)', 2, '2026-01-02 11:47:19'),
(85, 'Lettuce (लेट्यूस)', 2, '2026-01-02 11:47:53'),
(86, 'Mustard Greens (सरसों)', 2, '2026-01-02 11:48:36'),
(87, 'Bathua (बथुआ)', 2, '2026-01-02 11:49:04'),
(88, 'Potato (आलू)', 2, '2026-01-02 11:49:38'),
(89, 'Carrot (गाजर)', 2, '2026-01-02 11:50:26'),
(90, 'Radish (मूली)', 2, '2026-01-02 11:51:02'),
(91, 'Beetroot (चुकंदर)', 2, '2026-01-02 11:51:37'),
(92, 'Turnip (शलगम)', 2, '2026-01-02 11:53:38'),
(93, 'Sweet Potato (शकरकंद)', 2, '2026-01-02 11:54:10'),
(94, 'Ginger (अदरक)', 2, '2026-01-02 11:55:15'),
(95, 'Yam (अरबी)', 2, '2026-01-02 11:56:27'),
(96, 'Elephant Foot Yam (सुरन)', 2, '2026-01-02 11:56:58'),
(97, 'Tomato (टमाटर)', 2, '2026-01-02 11:58:29'),
(98, 'Brinjal / Baingan (बैंगन)', 2, '2026-01-02 12:46:45'),
(99, 'Okra (भिंडी)', 2, '2026-01-02 12:47:19'),
(100, 'Cucumber (खीरा)', 2, '2026-01-02 12:48:00');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `phone`, `password`, `created_at`) VALUES
(1, 'Amit Kumar', 'amit@example.com', NULL, '$2a$10$wr/pTiHzkazKaJwxHbaUueFV9kD7HuBkFplqP2Idwb9vIrkQgzWvK', '2025-12-18 02:51:46'),
(3, 'Vivek', 'vivek@gmail.com', NULL, '$2a$10$6G9s84Mad56TVSGo6QmhDuPMQzoovDZINlrJOEVEisKAdRxsaM9S.', '2025-12-18 02:55:27'),
(4, 'Praveen', 'praveen@gmail.com', '9171391302', '$2b$10$NZnz7yUDtuGHgigAt9xmGOGVzNCNlmNK9mezH.BPO27wg2Y1.XHja', '2025-12-18 08:55:38');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_name` (`name`);

--
-- Indexes for table `companies`
--
ALTER TABLE `companies`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_company_name` (`company_name`);

--
-- Indexes for table `defects`
--
ALTER TABLE `defects`
  ADD PRIMARY KEY (`id`),
  ADD KEY `subcategory_id` (`subcategory_id`);

--
-- Indexes for table `purchases`
--
ALTER TABLE `purchases`
  ADD PRIMARY KEY (`id`),
  ADD KEY `company_id` (`company_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `purchase_items`
--
ALTER TABLE `purchase_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `purchase_id` (`purchase_id`),
  ADD KEY `category_id` (`category_id`),
  ADD KEY `defect_id` (`defect_id`),
  ADD KEY `subcategory_id` (`subcategory_id`);

--
-- Indexes for table `subcategories`
--
ALTER TABLE `subcategories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_name_per_category` (`name`,`category_id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `companies`
--
ALTER TABLE `companies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `defects`
--
ALTER TABLE `defects`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=724;

--
-- AUTO_INCREMENT for table `purchases`
--
ALTER TABLE `purchases`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT for table `purchase_items`
--
ALTER TABLE `purchase_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT for table `subcategories`
--
ALTER TABLE `subcategories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=101;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `defects`
--
ALTER TABLE `defects`
  ADD CONSTRAINT `fk_defects_subcategory` FOREIGN KEY (`subcategory_id`) REFERENCES `subcategories` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `purchases`
--
ALTER TABLE `purchases`
  ADD CONSTRAINT `purchases_ibfk_1` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`),
  ADD CONSTRAINT `purchases_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `purchase_items`
--
ALTER TABLE `purchase_items`
  ADD CONSTRAINT `fk_purchase_items_subcategory` FOREIGN KEY (`subcategory_id`) REFERENCES `subcategories` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `purchase_items_ibfk_1` FOREIGN KEY (`purchase_id`) REFERENCES `purchases` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `purchase_items_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `purchase_items_ibfk_3` FOREIGN KEY (`defect_id`) REFERENCES `defects` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `subcategories`
--
ALTER TABLE `subcategories`
  ADD CONSTRAINT `subcategories_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
