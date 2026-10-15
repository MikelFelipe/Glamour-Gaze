-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 17, 2024 at 01:17 PM
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
-- Database: `ecomm`
--

-- --------------------------------------------------------

--
-- Table structure for table `additional_addresses`
--

CREATE TABLE `additional_addresses` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `address` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `carts`
--

CREATE TABLE `carts` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `seller_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `business_name` varchar(255) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `product_image` varchar(255) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `carts`
--

INSERT INTO `carts` (`id`, `user_id`, `seller_id`, `product_id`, `business_name`, `product_name`, `product_image`, `price`, `quantity`) VALUES
(103, 39, 30, 134, 'Beautique Shop', 'Clinique Moisture ', 'Clinique_All_About_Eyes_2.jpg', 4762.38, 1),
(106, 42, 30, 135, 'Beautique Shop', 'Kiehl’s Creamy Eye ', 'Kiehls_Creamy_Eye_Treatment_with_Avocado2.jpg', 2278.00, 1),
(107, 42, 30, 136, 'Beautique Shop', 'Olay Eyes Ultimate Eye Cream', 'Olay_Eyes_Ultimate_Eye_Cream3.jpg', 4231.00, 1),
(108, 42, 30, 137, 'Beautique Shop', 'Tatcha The Silk Peony ', 'Tatcha_The_Silk_Peony_Eye_Cream.jpg', 3441.00, 1),
(109, 42, 30, 138, 'Beautique Shop', 'RoC Retinol Correxion', 'RoC_Retinol_Correxion_Eye_Cream.jpg', 3349.00, 1),
(110, 42, 33, 154, 'BloomWellness', 'Honest Amish Beard Balm', 'Honest_Amish_Beard_Balm4.jpg', 599.00, 1),
(111, 42, 33, 155, 'BloomWellness', 'Ensure Gold', 'Ensure_Gold.jpg', 499.00, 1),
(112, 42, 33, 160, 'BloomWellness', 'T.L.C. Sukari Babyfacial', 'Drunk_Elephant_T.L.C._Sukari_Babyfacial_2.jpg', 325.00, 1),
(113, 42, 33, 162, 'BloomWellness', 'Kate Somerville', 'Kate_Somerville_ExfoliKate_Intensive_Exfoliating_Treatment.jpg', 499.00, 1),
(114, 42, 33, 163, 'BloomWellness', 'Paula\'s Choice', 'Exfoliants.jpg', 450.00, 1),
(115, 42, 33, 164, 'BloomWellness', 'The Ordinary ', 'The_Ordinary_AHA_30___BHA_2__Peeling_Solution.jpg', 399.00, 1),
(116, 42, 33, 165, 'BloomWellness', 'St. Ives Fresh Skin', 'St._Ives_Fresh_Skin_Apricot_Scrub.jpg', 499.00, 1),
(117, 42, 33, 166, 'BloomWellness', 'Goody Ouchless Hair Ties', 'Goody_Ouchless_Hair_Ties.jpg', 39.00, 1),
(118, 42, 33, 167, 'BloomWellness', 'Scunci Scrunchies', 'Scunci_Scrunchies.jpg', 39.00, 1),
(119, 42, 33, 168, 'BloomWellness', 'Wet Brush Original Detangler', 'wet1.jpg', 50.00, 1),
(120, 42, 33, 169, 'BloomWellness', 'Clairol Nice\'n ', 'clairol1.jpg', 199.00, 1),
(121, 42, 33, 170, 'BloomWellness', 'Revlon Colorsilk Beautiful Color', 'revlon1.jpg', 200.00, 1),
(122, 42, 34, 173, 'The Glow Lab', 'Proraso Shaving Foam', 'Proraso_Shaving_Foam.jpg', 399.00, 1),
(123, 42, 34, 182, 'The Glow Lab', 'CeraVe Moisturizing Cream', 'CeraVe_Moisturizing_Cream.jpg', 599.00, 1),
(124, 42, 34, 183, 'The Glow Lab', 'Drunk Elephant', 'Drunk_Elephant_Protini_Polypeptide_Cream.jpg', 599.00, 1),
(125, 42, 34, 184, 'The Glow Lab', 'Clinique Moisture Surge ', 'Clinique_Moisture_Surge_72-Hour_Auto-Replenishing_Hydrator.jpg', 399.00, 1),
(126, 42, 34, 185, 'The Glow Lab', 'Olay Regenerist Micro-Sculpting Cream', 'Olay_Regenerist_Micro-Sculpting_Cream.jpg', 499.00, 1),
(127, 42, 34, 186, 'The Glow Lab', 'Neutrogena Hydro Boost Water Gel', 'Neutrogena_Hydro_Boost_Water_Gel.jpg', 599.00, 119),
(128, 42, 30, 139, 'Beautique Shop', 'Ascorbic Acid', 'Ascorbic_Acid_Cecon.jpg', 244.00, 1),
(130, 42, 30, 144, 'Beautique Shop', 'Briogeo', 'brio1.jpg', 234.00, 1),
(131, 42, 34, 235, 'The Glow Lab', 'Tatcha The Deep Cleanse', 'Tatcha_The_Deep_Cleanse.jpg', 1444.00, 123);

-- --------------------------------------------------------

--
-- Table structure for table `feedback`
--

CREATE TABLE `feedback` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `product_id` int(50) NOT NULL,
  `username` varchar(255) NOT NULL,
  `rating` int(1) NOT NULL,
  `message` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `image_1` varchar(255) DEFAULT NULL,
  `image_2` varchar(255) DEFAULT NULL,
  `image_3` varchar(255) DEFAULT NULL,
  `image_4` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `feedback`
--

INSERT INTO `feedback` (`id`, `order_id`, `user_id`, `product_id`, `username`, `rating`, `message`, `created_at`, `image_1`, `image_2`, `image_3`, `image_4`) VALUES
(10, 155, 42, 132, 'lyndon16', 3, 'fgggggggg', '2024-11-29 03:24:29', 'feedback_images/transport.png', 'feedback_images/edit.png', NULL, NULL),
(11, 155, 42, 132, 'lyndon16', 5, 'ang sarap sa it*** ng product na to napakalamig. Nagustuhan ng misis ko', '2024-11-29 03:26:03', 'feedback_images/transport.png', 'feedback_images/nars1-removebg-preview.png', 'feedback_images/3.4.png', 'feedback_images/1.2.png'),
(12, 155, 42, 132, 'lyndon16', 5, 'fdfdf', '2024-11-29 04:11:52', 'feedback_images/transport.png', 'feedback_images/transport.png', 'feedback_images/features.png', 'feedback_images/transport.png'),
(16, 157, 35, 141, 'jano', 4, 'maayos naman yung pagkaka deliver salamat kay kuya rider walang gasgas overall pangit ng product', '2024-11-29 06:07:16', 'feedback_images/Premium Photo _ Portrait of Indian Male businessman standing over white background.jpg', 'feedback_images/26 Tips For A Great Professional LinkedIn Headshot.jpg', 'feedback_images/Photo & Image Portfolio by Kumpeh_Studio _ Shutterstock Contributor.jpg', 'feedback_images/Why Business Loans are Financially Beneficial.jpg'),
(31, 182, 42, 134, 'lyndon16', 5, 'napakaganda ng product the best', '2024-12-09 09:31:50', 'feedback_images/lupity.jpg', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE `messages` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `seller_id` int(11) NOT NULL,
  `order_id` int(11) DEFAULT NULL,
  `username` varchar(255) NOT NULL,
  `business_name` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `sender_type` enum('buyer','seller','admin') NOT NULL DEFAULT 'buyer',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_read` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `messages`
--

INSERT INTO `messages` (`id`, `user_id`, `seller_id`, `order_id`, `username`, `business_name`, `message`, `sender_type`, `created_at`, `is_read`) VALUES
(137, 42, 30, 155, 'lyndon16', 'Beautique Shop', 'hii', 'buyer', '2024-12-08 09:05:20', 0),
(138, 35, 30, 157, 'jano', 'Beautique Shop', 'hii', 'buyer', '2024-12-08 09:05:36', 0),
(139, 35, 30, 157, 'Eric Oracion', 'Beautique Shop', 'hello', 'seller', '2024-12-08 09:06:03', 0),
(140, 42, 30, 155, 'lyndon16', 'Beautique Shop', 'zczc', 'buyer', '2024-12-08 01:12:59', 0),
(141, 42, 34, 175, 'lyndon16', 'The Glow Lab', 'hi', 'buyer', '2024-12-08 09:19:37', 0),
(142, 42, 30, 155, 'lyndon16', 'Beautique Shop', 'hoyy', 'buyer', '2024-12-08 09:19:55', 0),
(143, 42, 30, 155, 'Eric Oracion', 'Beautique Shop', 'hoyy ka din', 'seller', '2024-12-08 09:24:19', 0),
(144, 42, 30, 155, 'lyndon16', 'Beautique Shop', 'hoy', 'buyer', '2024-12-08 09:35:05', 0),
(145, 42, 30, 158, 'lyndon16', 'Beautique Shop', 'jjj', 'buyer', '2024-12-08 13:01:39', 0),
(146, 42, 30, 155, 'Eric Oracion', 'Beautique Shop', 'chat ni seller to', 'seller', '2024-12-08 13:31:05', 0),
(147, 42, 30, 155, 'lyndon16', 'Beautique Shop', 'dfdf', 'buyer', '2024-12-08 13:37:56', 0),
(148, 42, 30, 155, 'lyndon16', 'Beautique Shop', 'fffffff', 'buyer', '2024-12-08 14:31:39', 0),
(149, 42, 30, 164, 'lyndon16', 'Beautique Shop', 'kumain ka na?', 'buyer', '2024-12-08 14:55:26', 0),
(150, 42, 30, 155, 'Eric Oracion', 'Beautique Shop', 'oo ikaw?', 'seller', '2024-12-08 14:55:43', 0),
(151, 42, 30, 155, 'lyndon16', 'Beautique Shop', 'hehe', 'buyer', '2024-12-08 15:01:13', 0),
(152, 42, 30, 155, 'lyndon16', 'Beautique Shop', 'aba aba', 'buyer', '2024-12-08 15:20:28', 0),
(153, 42, 30, 155, 'lyndon16', 'Beautique Shop', 'somewhere in the haze ', 'buyer', '2024-12-08 15:27:27', 0),
(154, 42, 30, 155, 'lyndon16', 'Beautique Shop', 'hi', 'buyer', '2024-12-08 15:41:09', 0),
(155, 42, 30, 155, 'lyndon16', 'Beautique Shop', 'gugu', 'buyer', '2024-12-08 15:43:03', 0),
(156, 42, 30, 155, 'lyndon16', 'Beautique Shop', 'hi', 'buyer', '2024-12-08 15:43:32', 0),
(157, 42, 30, 155, 'lyndon16', 'Beautique Shop', 'hoy ano oras uwi mo', 'buyer', '2024-12-08 15:45:03', 0),
(158, 42, 30, 155, 'lyndon16', 'Beautique Shop', 'hi', 'buyer', '2024-12-08 15:46:13', 0),
(159, 42, 30, 155, 'lyndon16', 'Beautique Shop', 'hellor', 'buyer', '2024-12-10 00:18:07', 0),
(160, 42, 30, 155, 'lyndon16', 'Beautique Shop', 'mikel', 'buyer', '2024-12-10 00:40:04', 0),
(161, 42, 30, 155, 'Eric Oracion', 'Beautique Shop', 'tanga', 'seller', '2024-12-10 00:40:30', 0),
(162, 35, 30, 157, 'Eric Oracion', 'Beautique Shop', 'houu', 'seller', '2024-12-10 00:54:37', 0),
(163, 42, 30, 155, 'lyndon16', 'Beautique Shop', 'tagal ng order', 'buyer', '2024-12-12 00:23:00', 0),
(164, 1, 30, NULL, 'admin', '', 'fdfdf', 'admin', '2024-12-12 00:48:00', 0),
(165, 42, 34, 191, 'lyndon16', 'The Glow Lab', 'hello', 'buyer', '2024-12-12 01:11:08', 0),
(166, 42, 34, 175, 'Diane Zotomayor', 'The Glow Lab', 'hi', 'seller', '2024-12-12 01:11:28', 0);

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `seller_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `product_name` varchar(255) DEFAULT NULL,
  `product_image` varchar(255) DEFAULT NULL,
  `message` text NOT NULL,
  `status` enum('unread','read') DEFAULT 'unread',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `recipient_type` enum('buyer','seller') NOT NULL DEFAULT 'buyer'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`id`, `user_id`, `seller_id`, `order_id`, `product_name`, `product_image`, `message`, `status`, `created_at`, `recipient_type`) VALUES
(179, 42, 30, 155, 'Palmolive', '/static/upload_images/PALMOLIVE.jpg', 'New order placed for Palmolive by Lyndon Pablo. Quantity: 1, Total: 207.00', 'read', '2024-11-29 02:28:11', 'seller'),
(180, 42, 30, 155, 'Palmolive', '/static/upload_images/PALMOLIVE.jpg', 'Your order is out for delivery. Be ready to pay ₱157.00.', 'read', '2024-11-29 02:28:23', 'buyer'),
(181, 42, 30, 155, 'Palmolive', '/static/upload_images/PALMOLIVE.jpg', 'Order #155 for \'Palmolive\' has been successfully delivered! Please confirm receipt to complete the process.', 'read', '2024-11-29 02:28:46', 'buyer'),
(182, 42, 30, 155, 'Palmolive', '/static/upload_images/PALMOLIVE.jpg', 'The buyer has marked Order #155 for \'Palmolive\' as \'Received\'. Please review and process accordingly.', 'read', '2024-11-29 02:28:56', 'seller'),
(183, 42, 30, 156, 'Fern-C', '/static/upload_images/Fern-C_Sodium_Ascorbate_2.jpg', 'New order placed for Fern-C by Lyndon Pablo. Quantity: 1, Total: 195.00', 'read', '2024-11-29 04:31:16', 'seller'),
(184, 42, 30, 156, 'Fern-C', '/static/upload_images/Fern-C_Sodium_Ascorbate_2.jpg', 'Your order is out for delivery. Be ready to pay ₱145.00.', 'read', '2024-11-29 04:31:24', 'buyer'),
(185, 42, 30, 156, 'Fern-C', '/static/upload_images/Fern-C_Sodium_Ascorbate_2.jpg', 'Order #156 for \'Fern-C\' has been successfully delivered! Please confirm receipt to complete the process.', 'read', '2024-11-29 04:31:59', 'buyer'),
(186, 42, 30, 156, 'Fern-C', '/static/upload_images/Fern-C_Sodium_Ascorbate_2.jpg', 'The buyer has marked Order #156 for \'Fern-C\' as \'Received\'. Please review and process accordingly.', 'read', '2024-11-29 04:32:33', 'seller'),
(187, 35, 30, 157, 'Fern-C', '/static/upload_images/Fern-C_Sodium_Ascorbate_2.jpg', 'New order placed for Fern-C by Daniel Padilla. Quantity: 2, Total: 340.00', 'read', '2024-11-29 06:04:41', 'seller'),
(188, 35, 30, 157, 'Fern-C', '/static/upload_images/Fern-C_Sodium_Ascorbate_2.jpg', 'Your order is out for delivery. Be ready to pay ₱145.00.', 'read', '2024-11-29 06:04:56', 'buyer'),
(189, 35, 30, 157, 'Fern-C', '/static/upload_images/Fern-C_Sodium_Ascorbate_2.jpg', 'Order #157 for \'Fern-C\' has been successfully delivered! Please confirm receipt to complete the process.', 'read', '2024-11-29 06:05:27', 'buyer'),
(190, 35, 30, 157, 'Fern-C', '/static/upload_images/Fern-C_Sodium_Ascorbate_2.jpg', 'The buyer has marked Order #157 for \'Fern-C\' as \'Received\'. Please review and process accordingly.', 'read', '2024-11-29 06:05:37', 'seller'),
(191, 42, 30, 158, ' Hydra Dildo - 5 Inches - Dildo', '/static/upload_images/dildo_1.jpg', 'New order placed for  Hydra Dildo - 5 Inches - Dildo by Lyndon Pablo. Quantity: 1, Total: 449.00', 'read', '2024-11-29 06:51:01', 'seller'),
(192, 42, 30, 158, ' Hydra Dildo - 5 Inches - Dildo', '/static/upload_images/dildo_1.jpg', 'Your order is out for delivery. Be ready to pay ₱399.00.', 'read', '2024-11-29 06:51:13', 'buyer'),
(193, 42, 30, 158, ' Hydra Dildo - 5 Inches - Dildo', '/static/upload_images/dildo_1.jpg', 'Order #158 for \' Hydra Dildo - 5 Inches - Dildo\' has been successfully delivered! Please confirm receipt to complete the process.', 'read', '2024-11-29 06:51:27', 'buyer'),
(194, 42, 30, 158, ' Hydra Dildo - 5 Inches - Dildo', '/static/upload_images/dildo_1.jpg', 'The buyer has marked Order #158 for \' Hydra Dildo - 5 Inches - Dildo\' as \'Received\'. Please review and process accordingly.', 'read', '2024-11-29 06:51:34', 'seller'),
(195, 42, 30, 159, 'Dove Men', '/static/upload_images/Dove_MenCare_Strengthening_Shampoo.jpg', 'New order placed for Dove Men by Lyndon Pablo. Quantity: 1, Total: 385.00', 'read', '2024-11-29 07:19:43', 'seller'),
(196, 42, 30, 160, 'Briogeo', '/static/upload_images/brio1.jpg', 'New order placed for Briogeo by Lyndon Pablo. Quantity: 3, Total: 752.00', 'read', '2024-11-29 07:19:54', 'seller'),
(197, 42, 30, 161, 'Briogeo', '/static/upload_images/brio1.jpg', 'New order placed for Briogeo by Lyndon Pablo. Quantity: 1, Total: 284.00', 'read', '2024-11-29 07:20:02', 'seller'),
(198, 42, 30, 162, 'Redoxon', '/static/upload_images/Redoxon_Double_Action_Vitamin_C__Zinc.jpg', 'New order placed for Redoxon by Lyndon Pablo. Quantity: 1, Total: 372.00', 'read', '2024-11-29 07:20:12', 'seller'),
(199, 42, 30, 163, 'Redoxon', '/static/upload_images/Redoxon_Double_Action_Vitamin_C__Zinc.jpg', 'New order placed for Redoxon by Lyndon Pablo. Quantity: 1, Total: 372.00', 'read', '2024-11-29 07:20:14', 'seller'),
(200, 42, 30, 159, 'Dove Men', '/static/upload_images/Dove_MenCare_Strengthening_Shampoo.jpg', 'Your order is out for delivery. Be ready to pay ₱335.00.', 'read', '2024-11-29 07:20:26', 'buyer'),
(201, 42, 30, 159, 'Dove Men', '/static/upload_images/Dove_MenCare_Strengthening_Shampoo.jpg', 'Order #159 for \'Dove Men\' has been successfully delivered! Please confirm receipt to complete the process.', 'read', '2024-11-29 07:20:27', 'buyer'),
(202, 42, 30, 160, 'Briogeo', '/static/upload_images/brio1.jpg', 'Your order is out for delivery. Be ready to pay ₱234.00.', 'read', '2024-11-29 07:20:28', 'buyer'),
(203, 42, 30, 161, 'Briogeo', '/static/upload_images/brio1.jpg', 'Your order is out for delivery. Be ready to pay ₱234.00.', 'read', '2024-11-29 07:20:32', 'buyer'),
(204, 42, 30, 162, 'Redoxon', '/static/upload_images/Redoxon_Double_Action_Vitamin_C__Zinc.jpg', 'Your order is out for delivery. Be ready to pay ₱322.00.', 'read', '2024-11-29 07:20:34', 'buyer'),
(205, 42, 30, 163, 'Redoxon', '/static/upload_images/Redoxon_Double_Action_Vitamin_C__Zinc.jpg', 'Your order is out for delivery. Be ready to pay ₱322.00.', 'read', '2024-11-29 07:20:37', 'buyer'),
(206, 42, 30, 159, 'Dove Men', '/static/upload_images/Dove_MenCare_Strengthening_Shampoo.jpg', 'The buyer has marked Order #159 for \'Dove Men\' as \'Received\'. Please review and process accordingly.', 'read', '2024-11-29 07:20:57', 'seller'),
(207, 42, 30, 160, 'Briogeo', '/static/upload_images/brio1.jpg', 'Order #160 for \'Briogeo\' has been successfully delivered! Please confirm receipt to complete the process.', 'read', '2024-11-29 07:21:21', 'buyer'),
(208, 42, 30, 161, 'Briogeo', '/static/upload_images/brio1.jpg', 'Order #161 for \'Briogeo\' has been successfully delivered! Please confirm receipt to complete the process.', 'read', '2024-11-29 07:21:21', 'buyer'),
(209, 42, 30, 162, 'Redoxon', '/static/upload_images/Redoxon_Double_Action_Vitamin_C__Zinc.jpg', 'Order #162 for \'Redoxon\' has been successfully delivered! Please confirm receipt to complete the process.', 'read', '2024-11-29 07:21:21', 'buyer'),
(210, 42, 30, 163, 'Redoxon', '/static/upload_images/Redoxon_Double_Action_Vitamin_C__Zinc.jpg', 'Order #163 for \'Redoxon\' has been successfully delivered! Please confirm receipt to complete the process.', 'read', '2024-11-29 07:21:21', 'buyer'),
(211, 42, 30, 160, 'Briogeo', '/static/upload_images/brio1.jpg', 'The buyer has marked Order #160 for \'Briogeo\' as \'Received\'. Please review and process accordingly.', 'read', '2024-11-29 07:21:30', 'seller'),
(212, 42, 30, 161, 'Briogeo', '/static/upload_images/brio1.jpg', 'The buyer has marked Order #161 for \'Briogeo\' as \'Received\'. Please review and process accordingly.', 'read', '2024-11-29 07:21:31', 'seller'),
(213, 42, 30, 162, 'Redoxon', '/static/upload_images/Redoxon_Double_Action_Vitamin_C__Zinc.jpg', 'The buyer has marked Order #162 for \'Redoxon\' as \'Received\'. Please review and process accordingly.', 'read', '2024-11-29 07:21:33', 'seller'),
(214, 42, 30, 163, 'Redoxon', '/static/upload_images/Redoxon_Double_Action_Vitamin_C__Zinc.jpg', 'The buyer has marked Order #163 for \'Redoxon\' as \'Received\'. Please review and process accordingly.', 'read', '2024-11-29 07:21:35', 'seller'),
(215, 42, 30, 164, 'Kiehl’s Creamy Eye ', '/static/upload_images/Kiehls_Creamy_Eye_Treatment_with_Avocado2.jpg', 'New order placed for Kiehl’s Creamy Eye  by Lyndon Pablo. Quantity: 1, Total: 2328.00', 'read', '2024-11-29 07:21:51', 'seller'),
(216, 42, 30, 165, 'Kiehl’s Creamy Eye ', '/static/upload_images/Kiehls_Creamy_Eye_Treatment_with_Avocado2.jpg', 'New order placed for Kiehl’s Creamy Eye  by Lyndon Pablo. Quantity: 1, Total: 2328.00', 'read', '2024-11-29 07:21:54', 'seller'),
(217, 42, 30, 166, 'Kiehl’s Creamy Eye ', '/static/upload_images/Kiehls_Creamy_Eye_Treatment_with_Avocado2.jpg', 'New order placed for Kiehl’s Creamy Eye  by Lyndon Pablo. Quantity: 1, Total: 2328.00', 'read', '2024-11-29 07:21:56', 'seller'),
(218, 42, 30, 164, 'Kiehl’s Creamy Eye ', '/static/upload_images/Kiehls_Creamy_Eye_Treatment_with_Avocado2.jpg', 'Your order is out for delivery. Be ready to pay ₱2278.00.', 'read', '2024-11-29 07:22:06', 'buyer'),
(219, 42, 30, 165, 'Kiehl’s Creamy Eye ', '/static/upload_images/Kiehls_Creamy_Eye_Treatment_with_Avocado2.jpg', 'Your order is out for delivery. Be ready to pay ₱2278.00.', 'read', '2024-11-29 07:22:08', 'buyer'),
(220, 42, 30, 166, 'Kiehl’s Creamy Eye ', '/static/upload_images/Kiehls_Creamy_Eye_Treatment_with_Avocado2.jpg', 'Your order is out for delivery. Be ready to pay ₱2278.00.', 'read', '2024-11-29 07:22:10', 'buyer'),
(221, 42, 30, 164, 'Kiehl’s Creamy Eye ', '/static/upload_images/Kiehls_Creamy_Eye_Treatment_with_Avocado2.jpg', 'Order #164 for \'Kiehl’s Creamy Eye \' has been successfully delivered! Please confirm receipt to complete the process.', 'read', '2024-11-29 07:22:21', 'buyer'),
(222, 42, 30, 165, 'Kiehl’s Creamy Eye ', '/static/upload_images/Kiehls_Creamy_Eye_Treatment_with_Avocado2.jpg', 'Order #165 for \'Kiehl’s Creamy Eye \' has been successfully delivered! Please confirm receipt to complete the process.', 'read', '2024-11-29 07:22:21', 'buyer'),
(223, 42, 30, 166, 'Kiehl’s Creamy Eye ', '/static/upload_images/Kiehls_Creamy_Eye_Treatment_with_Avocado2.jpg', 'Order #166 for \'Kiehl’s Creamy Eye \' has been successfully delivered! Please confirm receipt to complete the process.', 'read', '2024-11-29 07:22:21', 'buyer'),
(224, 42, 30, 164, 'Kiehl’s Creamy Eye ', '/static/upload_images/Kiehls_Creamy_Eye_Treatment_with_Avocado2.jpg', 'The buyer has marked Order #164 for \'Kiehl’s Creamy Eye \' as \'Received\'. Please review and process accordingly.', 'read', '2024-11-29 07:22:28', 'seller'),
(225, 42, 30, 165, 'Kiehl’s Creamy Eye ', '/static/upload_images/Kiehls_Creamy_Eye_Treatment_with_Avocado2.jpg', 'The buyer has marked Order #165 for \'Kiehl’s Creamy Eye \' as \'Received\'. Please review and process accordingly.', 'read', '2024-11-29 07:22:29', 'seller'),
(226, 42, 30, 166, 'Kiehl’s Creamy Eye ', '/static/upload_images/Kiehls_Creamy_Eye_Treatment_with_Avocado2.jpg', 'The buyer has marked Order #166 for \'Kiehl’s Creamy Eye \' as \'Received\'. Please review and process accordingly.', 'read', '2024-11-29 07:22:31', 'seller'),
(227, 42, 30, 167, 'Ascorbic Acid', '/static/upload_images/Ascorbic_Acid_Cecon.jpg', 'New order placed for Ascorbic Acid by Lyndon Pablo. Quantity: 1, Total: 294.00', 'read', '2024-12-02 07:47:11', 'seller'),
(228, 42, 30, 167, 'Ascorbic Acid', '/static/upload_images/Ascorbic_Acid_Cecon.jpg', 'Your order is out for delivery. Be ready to pay ₱244.00.', 'read', '2024-12-02 07:47:28', 'buyer'),
(229, 42, 30, 167, 'Ascorbic Acid', '/static/upload_images/Ascorbic_Acid_Cecon.jpg', 'Order #167 for \'Ascorbic Acid\' has been successfully delivered! Please confirm receipt to complete the process.', 'read', '2024-12-02 07:47:31', 'buyer'),
(230, 42, 30, 167, 'Ascorbic Acid', '/static/upload_images/Ascorbic_Acid_Cecon.jpg', 'The buyer has marked Order #167 for \'Ascorbic Acid\' as \'Received\'. Please review and process accordingly.', 'read', '2024-12-02 07:47:49', 'seller'),
(231, 42, 34, 168, 'L-Carnitine ', '/static/upload_images/L-Carnitine_by_MuscleTech11.jpg', 'New order placed for L-Carnitine  by Lyndon Pablo. Quantity: 1, Total: 549.00', 'read', '2024-12-02 08:34:00', 'seller'),
(232, 42, 34, 168, 'L-Carnitine ', '/static/upload_images/L-Carnitine_by_MuscleTech11.jpg', 'Your order is out for delivery. Be ready to pay ₱499.00.', 'read', '2024-12-02 08:34:12', 'buyer'),
(233, 42, 34, 168, 'L-Carnitine ', '/static/upload_images/L-Carnitine_by_MuscleTech11.jpg', 'Order #168 for \'L-Carnitine \' has been successfully delivered! Please confirm receipt to complete the process.', 'read', '2024-12-02 08:34:44', 'buyer'),
(234, 42, 34, 168, 'L-Carnitine ', '/static/upload_images/L-Carnitine_by_MuscleTech11.jpg', 'The buyer has marked Order #168 for \'L-Carnitine \' as \'Received\'. Please review and process accordingly.', 'read', '2024-12-02 08:35:01', 'seller'),
(235, 42, 30, 173, ' Hydra Dildo - 5 Inches - Dildo', '/static/upload_images/dildo_1.jpg', 'New order placed for  Hydra Dildo - 5 Inches - Dildo by Lyndon Pablo. Quantity: 1, Total: 449.00', 'read', '2024-12-03 13:34:19', 'seller'),
(236, 42, 30, 174, 'Kiehl’s Creamy Eye ', '/static/upload_images/Kiehls_Creamy_Eye_Treatment_with_Avocado2.jpg', 'New order placed for Kiehl’s Creamy Eye  by Lyndon Pablo. Quantity: 2, Total: 3684.80', 'read', '2024-12-03 13:54:09', 'seller'),
(237, 42, 34, 175, 'Drunk Elephant', '/static/upload_images/Drunk_Elephant_Protini_Polypeptide_Cream.jpg', 'New order placed for Drunk Elephant by None None. Quantity: 3, Total: 1797.00', 'read', '2024-12-04 06:45:32', 'seller'),
(238, 42, 34, 175, 'Drunk Elephant', '/static/upload_images/Drunk_Elephant_Protini_Polypeptide_Cream.jpg', 'Your order is out for delivery. Be ready to pay ₱599.00.', 'read', '2024-12-04 06:46:43', 'buyer'),
(239, 42, 34, 175, 'Drunk Elephant', '/static/upload_images/Drunk_Elephant_Protini_Polypeptide_Cream.jpg', 'Order #175 for \'Drunk Elephant\' has been successfully delivered! Please confirm receipt to complete the process.', 'read', '2024-12-04 06:47:04', 'buyer'),
(240, 42, 34, 175, 'Drunk Elephant', '/static/upload_images/Drunk_Elephant_Protini_Polypeptide_Cream.jpg', 'The buyer has marked Order #175 for \'Drunk Elephant\' as \'Received\'. Please review and process accordingly.', 'read', '2024-12-04 06:47:28', 'seller'),
(241, 42, 34, 176, 'Kérastase Specifique Dandruff Shampoo', '/static/upload_images/kerastase3.jpg', 'New order placed for Kérastase Specifique Dandruff Shampoo by Lyndon Pablo. Quantity: 2, Total: 850.00', 'read', '2024-12-04 06:49:17', 'seller'),
(242, 42, 30, 177, 'ImmunPro', '/static/upload_images/ImmunPro.jpg', 'New order placed for ImmunPro by  . Quantity: 3, Total: 375.00', 'read', '2024-12-04 09:18:10', 'seller'),
(243, 42, 30, 177, 'ImmunPro', '/static/upload_images/ImmunPro.jpg', 'Your order is out for delivery. Be ready to pay ₱125.00.', 'read', '2024-12-04 09:18:22', 'buyer'),
(244, 42, 30, 177, 'ImmunPro', '/static/upload_images/ImmunPro.jpg', 'Order #177 for \'ImmunPro\' has been successfully delivered! Please confirm receipt to complete the process.', 'read', '2024-12-04 09:18:27', 'buyer'),
(245, 42, 34, 176, 'Kérastase Specifique Dandruff Shampoo', '/static/upload_images/kerastase3.jpg', 'Your order is out for delivery. Be ready to pay ₱400.00.', 'read', '2024-12-04 09:19:08', 'buyer'),
(246, 42, 34, 176, 'Kérastase Specifique Dandruff Shampoo', '/static/upload_images/kerastase3.jpg', 'Order #176 for \'Kérastase Specifique Dandruff Shampoo\' has been successfully delivered! Please confirm receipt to complete the process.', 'read', '2024-12-04 09:19:27', 'buyer'),
(247, 42, 30, 177, 'ImmunPro', '/static/upload_images/ImmunPro.jpg', 'A refund request has been submitted for Order #177 of \'ImmunPro\'. Please review the details.', 'read', '2024-12-04 10:31:43', 'seller'),
(248, 42, 30, 177, 'ImmunPro', '/static/upload_images/ImmunPro.jpg', 'The refund request for Order #177 of \'ImmunPro\' has been accepted.', 'read', '2024-12-04 10:59:21', 'seller'),
(249, 42, 30, 177, 'ImmunPro', '/static/upload_images/ImmunPro.jpg', 'Your refund request for Order #177 of \'ImmunPro\' has been accepted.', 'read', '2024-12-04 10:59:21', 'buyer'),
(250, 42, 30, 178, 'Clinique Moisture ', 'Clinique_All_About_Eyes_2.jpg', 'New order placed for Clinique Moisture  by  . Quantity: 1, Total: 3849.90', 'read', '2024-12-07 09:29:35', 'seller'),
(251, 42, 48, 179, 'Malupitons', '/static/upload_images/lupity.jpg', 'New order placed for Malupitons by  . Quantity: 21, Total: 252.00', 'read', '2024-12-09 08:47:55', 'seller'),
(252, 42, 48, 179, 'Malupitons', '/static/upload_images/lupity.jpg', 'Your order 179 has been cancelled. Reason: out of stock', 'read', '2024-12-09 08:49:42', 'buyer'),
(253, 42, 30, 180, 'Clinique Moisture ', '/static/upload_images/Clinique_All_About_Eyes_2.jpg', 'New order placed for Clinique Moisture  by None None. Quantity: 1, Total: 4812.38', 'read', '2024-12-09 09:02:14', 'seller'),
(254, 42, 30, 181, 'Clinique Moisture ', '/static/upload_images/Clinique_All_About_Eyes_2.jpg', 'New order placed for Clinique Moisture  by  . Quantity: 1, Total: 4812.38', 'read', '2024-12-09 09:16:47', 'seller'),
(255, 42, 30, 182, 'Clinique Moisture ', '/static/upload_images/Clinique_All_About_Eyes_2.jpg', 'New order placed for Clinique Moisture  by Lyndon  Pablo. Quantity: 1, Total: 4812.38', 'read', '2024-12-09 09:20:15', 'seller'),
(256, 42, 30, 182, 'Clinique Moisture ', '/static/upload_images/Clinique_All_About_Eyes_2.jpg', 'Your order is out for delivery. Be ready to pay ₱4762.38.', 'read', '2024-12-09 09:22:31', 'buyer'),
(257, 42, 30, 182, 'Clinique Moisture ', '/static/upload_images/Clinique_All_About_Eyes_2.jpg', 'Order #182 for \'Clinique Moisture \' has been successfully delivered! Please confirm receipt to complete the process.', 'read', '2024-12-09 09:22:59', 'buyer'),
(258, 42, 30, 182, 'Clinique Moisture ', '/static/upload_images/Clinique_All_About_Eyes_2.jpg', 'The buyer has marked Order #182 for \'Clinique Moisture \' as \'Received\'. Please review and process accordingly.', 'read', '2024-12-09 09:23:46', 'seller'),
(259, 42, 30, 183, 'Cebion Vitamin ', '/static/upload_images/Cebion_Vitamin_C.jpg', 'New order placed for Cebion Vitamin  by Lyndon  Pablo. Quantity: 1, Total: 285.00', 'read', '2024-12-09 09:35:29', 'seller'),
(260, 42, 30, 173, ' Hydra Dildo - 5 Inches - Dildo', '/static/upload_images/dildo_1.jpg', 'Your order 173 has been cancelled. Reason: pangit mo kase', 'read', '2024-12-09 09:35:51', 'buyer'),
(261, 42, 30, 183, 'Cebion Vitamin ', '/static/upload_images/Cebion_Vitamin_C.jpg', 'Your order is out for delivery. Be ready to pay ₱235.00.', 'read', '2024-12-09 09:35:56', 'buyer'),
(262, 42, 30, 183, 'Cebion Vitamin ', '/static/upload_images/Cebion_Vitamin_C.jpg', 'Order #183 for \'Cebion Vitamin \' has been successfully delivered! Please confirm receipt to complete the process.', 'read', '2024-12-09 09:35:59', 'buyer'),
(263, 42, 30, 183, 'Cebion Vitamin ', '/static/upload_images/Cebion_Vitamin_C.jpg', 'A refund request has been submitted for Order #183 of \'Cebion Vitamin \'. Please review the details.', 'read', '2024-12-09 09:36:58', 'seller'),
(264, 42, 30, 183, 'Cebion Vitamin ', '/static/upload_images/Cebion_Vitamin_C.jpg', 'The refund request for Order #183 of \'Cebion Vitamin \' has been accepted.', 'read', '2024-12-09 09:37:40', 'seller'),
(265, 42, 30, 183, 'Cebion Vitamin ', '/static/upload_images/Cebion_Vitamin_C.jpg', 'Your refund request for Order #183 of \'Cebion Vitamin \' has been accepted.', 'read', '2024-12-09 09:37:40', 'buyer'),
(266, 42, 30, 174, 'Kiehl’s Creamy Eye ', '/static/upload_images/Kiehls_Creamy_Eye_Treatment_with_Avocado2.jpg', 'Your order 174 has been cancelled. Reason: bobo ka kase', 'read', '2024-12-09 09:45:36', 'buyer'),
(267, 42, 34, 176, 'Kérastase Specifique Dandruff Shampoo', '/static/upload_images/kerastase3.jpg', 'The refund request for Order #176 of \'Kérastase Specifique Dandruff Shampoo\' has been accepted.', 'read', '2024-12-09 11:31:32', 'seller'),
(268, 42, 34, 176, 'Kérastase Specifique Dandruff Shampoo', '/static/upload_images/kerastase3.jpg', 'Your refund request for Order #176 of \'Kérastase Specifique Dandruff Shampoo\' has been accepted.', 'read', '2024-12-09 11:31:32', 'buyer'),
(269, 42, 30, 184, 'ImmunPro', '/static/upload_images/ImmunPro.jpg', 'New order placed for ImmunPro by Lyndon  Pablo. Quantity: 3, Total: 375.00', 'read', '2024-12-09 11:42:06', 'seller'),
(270, 42, 30, 184, 'ImmunPro', '/static/upload_images/ImmunPro.jpg', 'Your order is out for delivery. Be ready to pay ₱125.00.', 'read', '2024-12-09 11:42:53', 'buyer'),
(271, 42, 30, 184, 'ImmunPro', '/static/upload_images/ImmunPro.jpg', 'Order #184 for \'ImmunPro\' has been successfully delivered! Please confirm receipt to complete the process.', 'read', '2024-12-09 11:43:19', 'buyer'),
(272, 42, 30, 184, 'ImmunPro', '/static/upload_images/ImmunPro.jpg', 'The buyer has marked Order #184 for \'ImmunPro\' as \'Received\'. Please review and process accordingly.', 'read', '2024-12-09 11:43:31', 'seller'),
(273, 42, 30, 184, 'ImmunPro', '/static/upload_images/ImmunPro.jpg', 'A refund request has been submitted for Order #184 of \'ImmunPro\'. Please review the details.', 'read', '2024-12-09 11:44:12', 'seller'),
(274, 42, 30, 184, 'ImmunPro', '/static/upload_images/ImmunPro.jpg', 'The refund request for Order #184 of \'ImmunPro\' has been accepted.', 'read', '2024-12-09 11:44:42', 'seller'),
(275, 42, 30, 184, 'ImmunPro', '/static/upload_images/ImmunPro.jpg', 'Your refund request for Order #184 of \'ImmunPro\' has been accepted.', 'read', '2024-12-09 11:44:42', 'buyer'),
(276, 42, 30, 184, 'ImmunPro', '/static/upload_images/ImmunPro.jpg', 'The refund request for Order #184 of \'ImmunPro\' has been accepted.', 'read', '2024-12-09 11:48:54', 'seller'),
(277, 42, 30, 184, 'ImmunPro', '/static/upload_images/ImmunPro.jpg', 'Your refund request for Order #184 of \'ImmunPro\' has been accepted.', 'read', '2024-12-09 11:48:54', 'buyer'),
(278, 42, 30, 185, 'Dove Men', '/static/upload_images/Dove_MenCare_Strengthening_Shampoo.jpg', 'New order placed for Dove Men by Lyndon  Pablo. Quantity: 21, Total: 7085.00', 'read', '2024-12-09 14:42:09', 'seller'),
(279, 42, 30, 186, 'Tatcha The Silk Peony ', '/static/upload_images/Tatcha_The_Silk_Peony_Eye_Cream.jpg', 'New order placed for Tatcha The Silk Peony  by Lyndon  Pablo. Quantity: 15, Total: 51665.00', 'read', '2024-12-09 15:31:50', 'seller'),
(280, 42, 30, 186, 'Tatcha The Silk Peony ', '/static/upload_images/Tatcha_The_Silk_Peony_Eye_Cream.jpg', 'Your order is out for delivery. Be ready to pay ₱3441.00.', 'read', '2024-12-09 15:32:03', 'buyer'),
(281, 42, 30, 186, 'Tatcha The Silk Peony ', '/static/upload_images/Tatcha_The_Silk_Peony_Eye_Cream.jpg', 'Order #186 for \'Tatcha The Silk Peony \' has been successfully delivered! Please confirm receipt to complete the process.', 'read', '2024-12-09 15:33:01', 'buyer'),
(282, 42, 30, 186, 'Tatcha The Silk Peony ', '/static/upload_images/Tatcha_The_Silk_Peony_Eye_Cream.jpg', 'The buyer has marked Order #186 for \'Tatcha The Silk Peony \' as \'Received\'. Please review and process accordingly.', 'read', '2024-12-09 15:33:14', 'seller'),
(283, 35, 30, 187, 'Tatcha The Silk Peony ', '/static/upload_images/Tatcha_The_Silk_Peony_Eye_Cream.jpg', 'New order placed for Tatcha The Silk Peony  by  . Quantity: 10, Total: 34460.00', 'read', '2024-12-09 15:34:10', 'seller'),
(284, 35, 30, 187, 'Tatcha The Silk Peony ', '/static/upload_images/Tatcha_The_Silk_Peony_Eye_Cream.jpg', 'Your order is out for delivery. Be ready to pay ₱3441.00.', 'read', '2024-12-09 15:34:28', 'buyer'),
(285, 35, 30, 187, 'Tatcha The Silk Peony ', '/static/upload_images/Tatcha_The_Silk_Peony_Eye_Cream.jpg', 'Order #187 for \'Tatcha The Silk Peony \' has been successfully delivered! Please confirm receipt to complete the process.', 'read', '2024-12-09 15:35:01', 'buyer'),
(286, 35, 30, 187, 'Tatcha The Silk Peony ', '/static/upload_images/Tatcha_The_Silk_Peony_Eye_Cream.jpg', 'The buyer has marked Order #187 for \'Tatcha The Silk Peony \' as \'Received\'. Please review and process accordingly.', 'read', '2024-12-09 15:35:38', 'seller'),
(287, 35, 34, 188, 'L-Carnitine ', '/static/upload_images/L-Carnitine_by_MuscleTech11.jpg', 'New order placed for L-Carnitine  by  . Quantity: 60, Total: 29990.00', 'read', '2024-12-09 15:49:22', 'seller'),
(288, 35, 34, 188, 'L-Carnitine ', '/static/upload_images/L-Carnitine_by_MuscleTech11.jpg', 'Your order is out for delivery. Be ready to pay ₱499.00.', 'read', '2024-12-09 15:49:35', 'buyer'),
(289, 35, 34, 188, 'L-Carnitine ', '/static/upload_images/L-Carnitine_by_MuscleTech11.jpg', 'Order #188 for \'L-Carnitine \' has been successfully delivered! Please confirm receipt to complete the process.', 'read', '2024-12-09 15:49:54', 'buyer'),
(290, 35, 34, 188, 'L-Carnitine ', '/static/upload_images/L-Carnitine_by_MuscleTech11.jpg', 'The buyer has marked Order #188 for \'L-Carnitine \' as \'Received\'. Please review and process accordingly.', 'read', '2024-12-09 15:50:01', 'seller'),
(291, 42, 30, 189, 'Ascorbic Acid', '/static/upload_images/Ascorbic_Acid_Cecon.jpg', 'New order placed for Ascorbic Acid by Lyndon  Pablo. Quantity: 3, Total: 625.60', 'read', '2024-12-10 00:20:53', 'seller'),
(292, 42, 30, 190, 'Ascorbic Acid', '/static/upload_images/Ascorbic_Acid_Cecon.jpg', 'New order placed for Ascorbic Acid by Lyndon  Pablo. Quantity: 3, Total: 625.60', 'read', '2024-12-10 00:21:06', 'seller'),
(293, 42, 30, 189, 'Ascorbic Acid', '/static/upload_images/Ascorbic_Acid_Cecon.jpg', 'Your order is out for delivery. Be ready to pay ₱244.00.', 'read', '2024-12-10 00:22:31', 'buyer'),
(294, 42, 30, 189, 'Ascorbic Acid', '/static/upload_images/Ascorbic_Acid_Cecon.jpg', 'Order #189 for \'Ascorbic Acid\' has been successfully delivered! Please confirm receipt to complete the process.', 'read', '2024-12-10 00:23:12', 'buyer'),
(295, 42, 30, 189, 'Ascorbic Acid', '/static/upload_images/Ascorbic_Acid_Cecon.jpg', 'The buyer has marked Order #189 for \'Ascorbic Acid\' as \'Received\'. Please review and process accordingly.', 'read', '2024-12-10 00:24:11', 'seller'),
(296, 42, 34, 191, 'Tatcha The Deep Cleanse', '/static/upload_images/Tatcha_The_Deep_Cleanse.jpg', 'New order placed for Tatcha The Deep Cleanse by Lyndon  Pablo. Quantity: 123, Total: 177612.00', 'unread', '2024-12-12 01:06:52', 'seller'),
(297, 42, 34, 192, 'Tatcha The Deep Cleanse', '/static/upload_images/Tatcha_The_Deep_Cleanse.jpg', 'New order placed for Tatcha The Deep Cleanse by Lyndon  Pablo. Quantity: 123, Total: 177612.00', 'unread', '2024-12-12 01:07:06', 'seller'),
(298, 42, 34, 193, 'Tatcha The Deep Cleanse', '/static/upload_images/Tatcha_The_Deep_Cleanse.jpg', 'New order placed for Tatcha The Deep Cleanse by Lyndon  Pablo. Quantity: 123, Total: 177612.00', 'unread', '2024-12-12 01:07:12', 'seller'),
(299, 42, 34, 191, 'Tatcha The Deep Cleanse', '/static/upload_images/Tatcha_The_Deep_Cleanse.jpg', 'Your order is out for delivery. Be ready to pay ₱1444.00.', 'read', '2024-12-12 01:09:09', 'buyer'),
(300, 42, 34, 191, 'Tatcha The Deep Cleanse', '/static/upload_images/Tatcha_The_Deep_Cleanse.jpg', 'Order #191 for \'Tatcha The Deep Cleanse\' has been successfully delivered! Please confirm receipt to complete the process.', 'read', '2024-12-12 01:09:09', 'buyer'),
(301, 42, 34, 191, 'Tatcha The Deep Cleanse', '/static/upload_images/Tatcha_The_Deep_Cleanse.jpg', 'The buyer has marked Order #191 for \'Tatcha The Deep Cleanse\' as \'Received\'. Please review and process accordingly.', 'unread', '2024-12-12 01:10:02', 'seller');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `seller_id` int(255) NOT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `middle_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `username` varchar(255) NOT NULL,
  `phoneNumber` varchar(50) NOT NULL,
  `address` text NOT NULL,
  `product_image` varchar(255) NOT NULL,
  `business_name` varchar(255) NOT NULL,
  `productName` varchar(255) NOT NULL,
  `productPrice` decimal(10,2) NOT NULL,
  `quantity` int(11) NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `total_gross` decimal(10,2) NOT NULL,
  `total_net` decimal(10,2) NOT NULL,
  `payment_method` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` varchar(50) DEFAULT 'To Pay',
  `product_id` int(11) DEFAULT NULL,
  `cancel_reason` varchar(255) NOT NULL,
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `refund_reason` text NOT NULL,
  `refund_image_1` text DEFAULT NULL,
  `refund_image_2` text DEFAULT NULL,
  `refund_image_3` text DEFAULT NULL,
  `refund_image_4` text DEFAULT NULL,
  `refund_created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `user_id`, `seller_id`, `first_name`, `middle_name`, `last_name`, `username`, `phoneNumber`, `address`, `product_image`, `business_name`, `productName`, `productPrice`, `quantity`, `total`, `total_gross`, `total_net`, `payment_method`, `created_at`, `status`, `product_id`, `cancel_reason`, `updated_at`, `refund_reason`, `refund_image_1`, `refund_image_2`, `refund_image_3`, `refund_image_4`, `refund_created_at`) VALUES
(155, 42, 30, 'Lyndon', 'Oway', 'Pablo', 'lyndon16', '09876543211', 'Pinagbayanan Pila Laguna', '/static/upload_images/PALMOLIVE.jpg', 'Beautique Shop', 'Palmolive', 157.00, 20, 207.00, 10.35, 146.65, 'Cash on Delivery', '2024-11-29 02:28:11', 'Completed', 132, '', '2024-12-10 00:01:46', '', NULL, NULL, NULL, NULL, '2024-12-04 09:53:13'),
(157, 35, 30, 'Daniel', 'E', 'Padilla', 'jano', '', 'None', '/static/upload_images/Fern-C_Sodium_Ascorbate_2.jpg', 'Beautique Shop', 'Fern-C', 145.00, 2, 340.00, 17.00, 128.00, 'Cash on Delivery', '2024-11-29 06:04:41', 'Completed', 141, '', '2024-11-29 14:05:37', '', NULL, NULL, NULL, NULL, '2024-12-04 09:53:13'),
(159, 42, 30, 'Lyndon', 'Oway', 'Pablo', 'lyndon16', '09876543211', 'Pinagbayanan Pila Laguna', '/static/upload_images/Dove_MenCare_Strengthening_Shampoo.jpg', 'Beautique Shop', 'Dove Men', 335.00, 1, 385.00, 19.25, 315.75, 'Cash on Delivery', '2024-11-29 07:19:43', 'Completed', 130, '', '2024-11-29 15:20:57', '', NULL, NULL, NULL, NULL, '2024-12-04 09:53:13'),
(160, 42, 30, 'Lyndon', 'Oway', 'Pablo', 'lyndon16', '09876543211', 'Pinagbayanan Pila Laguna', '/static/upload_images/brio1.jpg', 'Beautique Shop', 'Briogeo', 234.00, 3, 752.00, 37.60, 196.40, 'Cash on Delivery', '2024-11-29 07:19:54', 'Completed', 144, '', '2024-11-29 15:21:30', '', NULL, NULL, NULL, NULL, '2024-12-04 09:53:13'),
(161, 42, 30, 'Lyndon', 'Oway', 'Pablo', 'lyndon16', '09876543211', 'Pinagbayanan Pila Laguna', '/static/upload_images/brio1.jpg', 'Beautique Shop', 'Briogeo', 234.00, 1, 284.00, 14.20, 219.80, 'Cash on Delivery', '2024-11-29 07:20:02', 'Completed', 144, '', '2024-11-29 15:21:31', '', NULL, NULL, NULL, NULL, '2024-12-04 09:53:13'),
(162, 42, 30, 'Lyndon', 'Oway', 'Pablo', 'lyndon16', '09876543211', 'Pinagbayanan Pila Laguna', '/static/upload_images/Redoxon_Double_Action_Vitamin_C__Zinc.jpg', 'Beautique Shop', 'Redoxon', 322.00, 1, 372.00, 18.60, 303.40, 'Cash on Delivery', '2024-11-29 07:20:12', 'Completed', 143, '', '2024-11-29 15:21:33', '', NULL, NULL, NULL, NULL, '2024-12-04 09:53:13'),
(163, 42, 30, 'Lyndon', 'Oway', 'Pablo', 'lyndon16', '09876543211', 'Pinagbayanan Pila Laguna', '/static/upload_images/Redoxon_Double_Action_Vitamin_C__Zinc.jpg', 'Beautique Shop', 'Redoxon', 322.00, 1, 372.00, 18.60, 303.40, 'Cash on Delivery', '2024-11-29 07:20:14', 'Completed', 143, '', '2024-11-29 15:21:35', '', NULL, NULL, NULL, NULL, '2024-12-04 09:53:13'),
(164, 42, 30, 'Lyndon', 'Oway', 'Pablo', 'lyndon16', '09876543211', 'Pinagbayanan Pila Laguna', '/static/upload_images/Kiehls_Creamy_Eye_Treatment_with_Avocado2.jpg', 'Beautique Shop', 'Kiehl’s Creamy Eye ', 2278.00, 1, 2328.00, 116.40, 2161.60, 'Cash on Delivery', '2024-11-29 07:21:51', 'Completed', 135, '', '2024-11-29 15:22:28', '', NULL, NULL, NULL, NULL, '2024-12-04 09:53:13'),
(165, 42, 30, 'Lyndon', 'Oway', 'Pablo', 'lyndon16', '09876543211', 'Pinagbayanan Pila Laguna', '/static/upload_images/Kiehls_Creamy_Eye_Treatment_with_Avocado2.jpg', 'Beautique Shop', 'Kiehl’s Creamy Eye ', 2278.00, 1, 2328.00, 116.40, 2161.60, 'Cash on Delivery', '2024-11-29 07:21:54', 'Completed', 135, '', '2024-11-29 15:22:29', '', NULL, NULL, NULL, NULL, '2024-12-04 09:53:13'),
(166, 42, 30, 'Lyndon', 'Oway', 'Pablo', 'lyndon16', '09876543211', 'Pinagbayanan Pila Laguna', '/static/upload_images/Kiehls_Creamy_Eye_Treatment_with_Avocado2.jpg', 'Beautique Shop', 'Kiehl’s Creamy Eye ', 2278.00, 1, 2328.00, 116.40, 2161.60, 'Cash on Delivery', '2024-11-29 07:21:56', 'Completed', 135, '', '2024-11-29 15:22:31', '', NULL, NULL, NULL, NULL, '2024-12-04 09:53:13'),
(167, 42, 30, 'Lyndon', 'Oway', 'Pablo', 'lyndon16', '09876543211', 'Pinagbayanan Pila Laguna', '/static/upload_images/Ascorbic_Acid_Cecon.jpg', 'Beautique Shop', 'Ascorbic Acid', 244.00, 1, 294.00, 14.70, 229.30, 'Cash on Delivery', '2024-12-02 07:47:11', 'Completed', 139, '', '2024-12-02 15:47:49', '', NULL, NULL, NULL, NULL, '2024-12-04 09:53:13'),
(174, 42, 30, 'Lyndon', 'Oway', 'Pablo', 'lyndon16', '09876543211', 'Pinagbayanan Pila Laguna', '/static/upload_images/Kiehls_Creamy_Eye_Treatment_with_Avocado2.jpg', 'Beautique Shop', 'Kiehl’s Creamy Eye ', 2278.00, 2, 3684.80, 230.30, 3684.80, 'Cash on Delivery', '2024-12-03 13:54:09', 'Cancelled', 135, 'bobo ka kase', '2024-12-09 17:45:36', '', NULL, NULL, NULL, NULL, '2024-12-04 09:53:13'),
(176, 42, 34, 'Lyndon', 'Oway', 'Pablo', 'lyndon16', '09876543211', 'Pinagbayanan Pila Laguna', '/static/upload_images/kerastase3.jpg', 'The Glow Lab', 'Kérastase Specifique Dandruff Shampoo', 400.00, 2, 850.00, 42.50, 850.00, 'Cash on Delivery', '2024-12-04 06:49:17', 'Refund', 192, '', '2024-12-09 19:31:32', 'dfdf', NULL, NULL, NULL, NULL, '2024-12-04 09:53:13'),
(182, 42, 30, 'Lyndon ', 'Oway', 'Pablo', 'lyndon16', '09876543211', 'Pinagbayanan Pila Laguna', '/static/upload_images/Clinique_All_About_Eyes_2.jpg', 'Beautique Shop', 'Clinique Moisture ', 4762.38, 1, 4812.38, 240.62, 4812.38, 'Cash on Delivery', '2024-12-09 09:20:15', 'Completed', 134, '', '2024-12-09 17:23:46', '', NULL, NULL, NULL, NULL, '2024-12-09 09:20:15'),
(183, 42, 30, 'Lyndon ', 'Oway', 'Pablo', 'lyndon16', '09876543211', 'Pinagbayanan Pila Laguna', '/static/upload_images/Cebion_Vitamin_C.jpg', 'Beautique Shop', 'Cebion Vitamin ', 235.00, 1, 285.00, 14.25, 285.00, 'Cash on Delivery', '2024-12-09 09:35:29', 'Refund', 140, '', '2024-12-09 17:37:40', 'ang pangit ng seller gusto ko ibalik muka pang manyakis rider', 'static\\refund_request\\lupity.jpg', NULL, NULL, NULL, '2024-12-09 09:35:29'),
(184, 42, 30, 'Lyndon ', 'Oway', 'Pablo', 'lyndon16', '09876543211', 'Pinagbayanan Pila Laguna', '/static/upload_images/ImmunPro.jpg', 'Beautique Shop', 'ImmunPro', 125.00, 3, 375.00, 18.75, 375.00, 'Cash on Delivery', '2024-12-09 11:42:06', 'Refund', 142, '', '2024-12-09 19:48:54', 'pangit mo', 'static\\refund_request\\lupity.jpg', NULL, NULL, NULL, '2024-12-09 11:42:06'),
(185, 42, 30, 'Lyndon ', 'Oway', 'Pablo', 'lyndon16', '09876543211', 'Pinagbayanan Pila Laguna', '/static/upload_images/Dove_MenCare_Strengthening_Shampoo.jpg', 'Beautique Shop', 'Dove Men', 335.00, 21, 7085.00, 354.25, 7085.00, 'Cash on Delivery', '2024-12-09 14:42:09', 'To Pay', 130, '', '2024-12-09 22:42:09', '', NULL, NULL, NULL, NULL, '2024-12-09 14:42:09'),
(186, 42, 30, 'Lyndon ', 'Oway', 'Pablo', 'lyndon16', '09876543211', 'Pinagbayanan Pila Laguna', '/static/upload_images/Tatcha_The_Silk_Peony_Eye_Cream.jpg', 'Beautique Shop', 'Tatcha The Silk Peony ', 3441.00, 15, 51665.00, 2583.25, 51665.00, 'Cash on Delivery', '2024-12-09 15:31:50', 'Completed', 137, '', '2024-12-09 23:33:14', '', NULL, NULL, NULL, NULL, '2024-12-09 15:31:50'),
(188, 35, 34, '', 'None', '', 'jano', '', 'None', '/static/upload_images/L-Carnitine_by_MuscleTech11.jpg', 'The Glow Lab', 'L-Carnitine ', 499.00, 60, 29990.00, 1499.50, 29990.00, 'Cash on Delivery', '2024-12-09 15:49:22', 'Completed', 180, '', '2024-12-09 23:50:01', '', NULL, NULL, NULL, NULL, '2024-12-09 15:49:22'),
(189, 42, 30, 'Lyndon ', 'Oway', 'Pablo', 'lyndon16', '09876543211', 'Pinagbayanan Pila Laguna', '/static/upload_images/Ascorbic_Acid_Cecon.jpg', 'Beautique Shop', 'Ascorbic Acid', 244.00, 3, 625.60, 39.10, 625.60, 'Online Banking', '2024-12-10 00:20:53', 'Completed', 139, '', '2024-12-10 08:24:11', '', NULL, NULL, NULL, NULL, '2024-12-10 00:20:53'),
(190, 42, 30, 'Lyndon ', 'Oway', 'Pablo', 'lyndon16', '09876543211', 'Pinagbayanan Pila Laguna', '/static/upload_images/Ascorbic_Acid_Cecon.jpg', 'Beautique Shop', 'Ascorbic Acid', 244.00, 3, 625.60, 39.10, 625.60, 'Online Banking', '2024-12-10 00:21:06', 'To Pay', 139, '', '2024-12-10 08:21:06', '', NULL, NULL, NULL, NULL, '2024-12-10 00:21:06'),
(191, 42, 34, 'Lyndon ', 'Oway', 'Pablo', 'lyndon16', '09876543211', 'Pinagbayanan Pila Laguna', '/static/upload_images/Tatcha_The_Deep_Cleanse.jpg', 'The Glow Lab', 'Tatcha The Deep Cleanse', 1444.00, 123, 177612.00, 8880.60, 177612.00, 'Cash on Delivery', '2024-12-12 01:06:52', 'Completed', 235, '', '2024-12-12 09:10:02', '', NULL, NULL, NULL, NULL, '2024-12-12 01:06:52'),
(192, 42, 34, 'Lyndon ', 'Oway', 'Pablo', 'lyndon16', '09876543211', 'Pinagbayanan Pila Laguna', '/static/upload_images/Tatcha_The_Deep_Cleanse.jpg', 'The Glow Lab', 'Tatcha The Deep Cleanse', 1444.00, 123, 177612.00, 8880.60, 177612.00, 'Cash on Delivery', '2024-12-12 01:07:06', 'To Pay', 235, '', '2024-12-12 09:07:06', '', NULL, NULL, NULL, NULL, '2024-12-12 01:07:06'),
(193, 42, 34, 'Lyndon ', 'Oway', 'Pablo', 'lyndon16', '09876543211', 'Pinagbayanan Pila Laguna', '/static/upload_images/Tatcha_The_Deep_Cleanse.jpg', 'The Glow Lab', 'Tatcha The Deep Cleanse', 1444.00, 123, 177612.00, 8880.60, 177612.00, 'Cash on Delivery', '2024-12-12 01:07:12', 'To Pay', 235, '', '2024-12-12 09:07:12', '', NULL, NULL, NULL, NULL, '2024-12-12 01:07:12');

-- --------------------------------------------------------

--
-- Table structure for table `seller_add_product`
--

CREATE TABLE `seller_add_product` (
  `id` int(11) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `category` varchar(255) NOT NULL,
  `mini_description` text NOT NULL,
  `main_description` text NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `stock_quantity` int(255) NOT NULL,
  `product_image` varchar(255) NOT NULL,
  `sub_image_1` varchar(255) NOT NULL,
  `sub_image_2` varchar(255) NOT NULL,
  `sub_image_3` varchar(255) NOT NULL,
  `seller_id` int(11) NOT NULL,
  `product_status` varchar(255) NOT NULL,
  `business_name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `seller_add_product`
--

INSERT INTO `seller_add_product` (`id`, `product_name`, `category`, `mini_description`, `main_description`, `price`, `stock_quantity`, `product_image`, `sub_image_1`, `sub_image_2`, `sub_image_3`, `seller_id`, `product_status`, `business_name`) VALUES
(130, 'Dove Men', 'Men\'s Grooming', 'Men+Care Strengthening Hair Fall Men Shampoo', 'Dove Men+Care Strengthening Shampoo, the hair fall shampoo men love, is infused with caffeine and Trichazole Actives for stronger hair + less hair fall. Try the best hair fall shampoo for men.', 335.00, 20, 'Dove_MenCare_Strengthening_Shampoo.jpg', 'Dove_MenCare_Strengthening_Shampoo2.jpg', 'Dove_MenCare_Strengthening_Shampoo3.jpg', 'dove4.jpg', 30, 'listed', 'Beautique Shop'),
(131, 'Head & Shoulders Men ', 'Men\'s Grooming', 'Specially formulated for MEN with Cool Menthol, for refreshing scent and 100% dandruff-free.', 'Anti-Dandruff Shampoo\r\n1 in 2 people in the world have suffered from dandruff at some point in their lives. Make sure you’ve got a way to fight back with the Head & Shoulders shampoo collection. Every shampoo is specially formulated to deal with both the symptoms and cause of dandruff. This is made possible due to zinc pyrithione, which research has shown to be among the most effective ways of dealing with dandruff.\r\n', 228.00, 145, 'Head__Shoulders_Men_Ultra_Shampoo.jpg', 'Head__Shoulders_Men_Ultra_Shampoo3.jpg', 'Head__Shoulders_Men_Ultra_Shampoo2.jpg', '11.jpg', 30, 'listed', 'Beautique Shop'),
(132, 'Palmolive', 'Men\'s Grooming', 'Men Anti Dandruff Scalp Cooling Shampoo and Conditioner Eucalyptus CLZ 170ml', 'Product Description Palmolive Men is an exclusive advanced formula made specifically for men. It combines 100 natural eucalyptus extract with CLZ that is clinically proven to effectively combat and remove 100 dandruff. Its specialized formula made with eucalyptus extract refreshingly cools the scalp and comes with an invigorating fragrance to make you feel cool and confident.', 157.00, 117, 'PALMOLIVE.jpg', 'palmolive2.jpg', 'palmolive3.jpg', 'palmolive4.jpg', 30, 'listed', 'Beautique Shop'),
(133, 'Mane ‘n Tail Shampoo', 'Men\'s Grooming', 'Shampoo For shinny and manageable hair With high lathering cleansing agents Fortified with moisturizers and emollients', '16.	Mane ‘n Tail Shampoo\r\nRedefining Clean Beauty\r\nClean up your beauty routine with our new lineup of vegan formulas free from sulfates, parabens, gluten, dye, soy and salt. Choose from the Moisture Balance, Repair \'n Strengthen, or Color Protect to help promote healthier hair growth for beautiful, shiny hair!\r\n', 993.75, 149, 'Mane_n_Tail_Shampoo.jpg', 'Mane_n_Tail_Shampoo2.jpg', 'Mane_n_Tail_Shampoo3.jpg', 'Mane_n_Tail_Shampoo4.jpg', 30, 'listed', 'Beautique Shop'),
(134, 'Clinique Moisture ', 'Skincare Products', 'Clinique Moisture Surge 100H Auto-Replenishing Hydrator', 'Unlocking the Secrets of Skincare Layering Unlocking the Secrets of Skincare Layering Unlock the full potential of your skincare routine by layering skincare products in the correct order. Learn the importance of layering for a youthful, radiant complexion.', 4762.38, 132, 'Clinique_All_About_Eyes_2.jpg', 'Clinique_All_About_Eyes.jpg', 'Clinique_All_About_Eyes_3.jpg', 'Clinique_All_About_Eyes.png', 30, 'listed', 'Beautique Shop'),
(135, 'Kiehl’s Creamy Eye ', 'Skincare Products', 'Avocado Eye Cream\r\nA hydrating eye cream that smooths, de-puffs, and brightens under eyes. Paraben-free and fragrance-free.\r\n', 'A hydrating eye cream that smooths, de-puffs, and brightens under eyes. Paraben-free and fragrance-free.\r\nOur #1 hydrating eye cream delivers a pop of energy for tired, fatigued eyes. Formulated with Avocado Oil, Beta-Carotene, and Sodium & Copper PCA, this brightening eye cream immediately improves the look and feel of under eye texture and dry fine lines through all day hydration.\r\nParaben-free, fragrance-free, silicone-free, mineral oil-free, and synthetic dye-free.\r\n', 2278.00, 145, 'Kiehls_Creamy_Eye_Treatment_with_Avocado2.jpg', 'Kiehls_Creamy_Eye_Treatment_with_Avocado.jpg', 'Kiehls_Creamy_Eye_Treatment_with_Avocado3.jpg', 'Kiehls_Creamy_Eye_Treatment_with_Avocado4.jpg', 30, 'listed', 'Beautique Shop'),
(136, 'Olay Eyes Ultimate Eye Cream', 'Skincare Products', 'Ultimate Eye Cream3-in-1 DeCircler, DeWrinkler & DePuffer', 'Fight dark circles, wrinkles and puffy eyes in an instant with Olay Eyes Ultimate Eye Perfecting Cream. This 3-in-1 Decircler, DeWrinkler & DePuffer instantly reduces the appearance of fine lines and wrinkles. Supercharged with peptides and vitamins, it renews skin\'s surface over time and reduces puffiness by massaging onto skin. Formulated with Olay\'s color-correcting technology, it acts as a touch of concealer that matches all skin tones. The powerful formula hydrates to smooth and brighten the eye area. Give your eyes a boost of beauty and moisture with Ultimate Eye Cream for wrinkles, puffy eyes, and dark circles.', 4231.00, 150, 'Olay_Eyes_Ultimate_Eye_Cream3.jpg', 'Olay_Eyes_Ultimate_Eye_Cream.jpg', 'Olay_Eyes_Ultimate_Eye_Cream4.jpg', 'Olay_Eyes_Ultimate_Eye_Cream_2.jpg', 30, 'listed', 'Beautique Shop'),
(137, 'Tatcha The Silk Peony ', 'Skincare Products', 'Clinical Results\r\nProven to reduce the look of dry, fine lines', 'The Silk PeonyLine-Smoothing Eye Cream\r\nVisibly melt away lines in 1 swipe\r\n•	Visibly firms & smooths lines around eye area\r\n•	Provides long-lasting moisture\r\n•	Primes eye area for makeup\r\n', 3441.00, 124, 'Tatcha_The_Silk_Peony_Eye_Cream.jpg', 'tata.png', 'Tatcha_The_Silk_Peony_Eye_Cream3.jpg', 'Tatcha_The_Silk_Peony_Eye_Cream4.jpg', 30, 'listed', 'Beautique Shop'),
(138, 'RoC Retinol Correxion', 'Skincare Products', 'RETINOL CORREXION® Line Smoothing Eye Cream', 'An eye cream made with pure RoC® Retinol clinically proven to address 3 major eye area concerns: fine lines, dark circles, and puffiness.\r\nAn eye cream with Retinol clinically proven to address 3 major eye area concerns: lines, dark circles, and puffiness.\r\nThis Retinol eye cream is clinically proven to address multiple eye area concerns. Designed with pure RoC® Retinol, America’s #1 Most Awarded Retinol*, RoC’s® best ', 3349.00, 149, 'RoC_Retinol_Correxion_Eye_Cream.jpg', 'RoC_Retinol_Correxion_Eye_Cream2.jpg', 'RoC_Retinol_Correxion_Eye_Cream3.jpg', 'roc.png', 30, 'listed', 'Beautique Shop'),
(139, 'Ascorbic Acid', 'Health Supplements', 'Ascorbic acid is used to treat and prevent vitamin C deficiency.', 'Ascorbic Acid (Cecon) helps adults treat and prevent Vitamin C deficiency, for everyday immunity and protection. It’s a chewable, orange-flavoured tablet that easily fits into your daily routine.', 244.00, 135, 'Ascorbic_Acid_Cecon.jpg', 'Ascorbic_Acid_Cecon2.jpg', 'Ascorbic_Acid_Cecon3.jpg', 'Ascorbic_Acid_Cecon4.jpg', 30, 'listed', 'Beautique Shop'),
(140, 'Cebion Vitamin ', 'Health Supplements', 'Cebion 500 mg Vitamin C 20 Chewable Tablets Orange', 'Vitamin C should be used with caution by people who suffer, or have suffered in the past, from nephrolithiasis (kidney stones) and by those with G6PD (glucose-6-phosphate dehydrogenase) deficiency, hemochromatosis, thalassemia or sideroblastic anemia. Those who suffer from diabetes, or who follow low-calorie diets, should take into account that the 500 mg, 1 g effervescent tablets, the lemon and orange flavored effervescent tablets and the orange flavored granules contain respectively 503, 1005, 810 and 7950 mg. about sucrose; glucose chewable tablets contain approximately 2,962 g of glucose. For these subjects it is recommended to take the drug sweetened with sorbitol, which does not contain glucose and is therefore more manageable. Subjects who follow a low sodium diet should take into account that the chewable tablets contain about 40 mg of sodium corresponding to about 0.1 g of table salt; the effervescent tablets of the drug contain approximately 285 mg of sodium corresponding to approximately 0.7 g of table salt. Ascorbic acid can interfere, at high doses, with the results of some diagnostic tests, in particular the search for glucose in the urine by non-specific means. It is therefore advisable to stop taking vitamin C a few days before proceeding with this examination.', 235.00, 143, 'Cebion_Vitamin_C.jpg', 'Cebion_Vitamin_C2.jpg', 'Cebion_Vitamin_C3.jpg', 'Cebion_Vitamin_C4.jpg', 30, 'listed', 'Beautique Shop'),
(141, 'Fern-C', 'Health Supplements', 'Fern-C Sodium Ascorbate', 'Contains 500mg of Ascorbic Acid (as Sodium Ascorbate equivalent to 568.18mg) for Daily Immunity\r\nNon-acidic, tummy-friendly Vitamin C\r\nVitamin C helps:\r\n  • Boost immunity¹\r\n  • Act as powerful antioxidant\r\n  • Support skin health\r\n  • Enhance iron absorption\r\n', 145.00, 128, 'Fern-C_Sodium_Ascorbate_2.jpg', 'Fern-C_Sodium_Ascorbate_3.jpg', 'Fern-C_Sodium_Ascorbate.jpg', 'Fern-C_Sodium_Ascorbate4.jpg', 30, 'listed', 'Beautique Shop'),
(142, 'ImmunPro', 'Health Supplements', 'ImmunPro Vitamin C + Zinc', 'For increased body resistance and enhanced immune system\r\nImmunPro® contains a formula of vitamin C and zinc that may help strengthen your immune system to better protect your body against diseases. It also has a ZincPlus Tablet Technology that ensures a stabilized combination and absorption of vitamin C and zinc.\r\n', 125.00, 144, 'ImmunPro.jpg', 'ImmunPro2.jpg', 'ImmunPro3.jpg', 'ImmunPro_Vitamin_C__Zinc.jpg', 30, 'listed', 'Beautique Shop'),
(143, 'Redoxon', 'Health Supplements', 'Redoxon Double Action Vitamin C + Zinc\r\nRedoxon® Double Action\r\nVitamin C & Zinc\r\nAdult Chewable Tablet\r\n', 'Double Action Formula for Adult\'s Good Health Support\r\nRedoxon® Double Action Adult Chewable is a combination of Vitamin C and Zinc in chewable format to support general health and well-being.\r\nWhy take Redoxon® Double Action Adult Chewable:\r\nSpecially formulated with Vitamin C and Zinc for adults.\r\nVitamin C and Zinc to support your general health and well-being.\r\nOrange chewable tablets for everyday \r\n', 322.00, 137, 'Redoxon_Double_Action_Vitamin_C__Zinc.jpg', 'Redoxon_Double_Action_Vitamin_C__Zinc2.jpg', 'Redoxon_Double_Action_Vitamin_C__Zinc.png', 'Redoxon_Double_Action_Vitamin_C__Zinc2.png', 30, 'listed', 'Beautique Shop'),
(144, 'Briogeo', 'Haircare Solutions', 'Intense moisture and repair for dry, brittle hair', 'This deep-conditioning mask is packed with natural ingredients that hydrate and repair dry, brittle hair, leaving it soft, shiny, and healthy-looking.', 234.00, 131, 'brio1.jpg', 'brio2.jpg', 'brio3.jpg', 'sda.jpg', 30, 'listed', 'Beautique Shop'),
(145, 'Olaplex ', 'Haircare Solutions', 'Repairs damaged hair by reconnecting broken bonds.  ', 'A treatment that helps repair and strengthen damaged hair by reconnecting broken bonds at the molecular level. Leaves hair healthier and more resilient.  ', 1499.00, 138, 'oplex1.jpg', 'oplex2.jpg', 'oplex3.jpg', 'download.jpg', 30, 'listed', 'Beautique Shop'),
(146, 'SheaMoisture', 'Haircare Solutions', 'Moisturizes and restores health to dry, damaged hair.  ', 'Enriched with shea butter, this restorative hair mask deeply nourishes and hydrates dry and damaged hair, helping to improve strength and shine.  ', 134.00, 139, 'shea1.jpg', 'shea2.jpg', 'shea3.jpg', 'SheaMoisture.jpg', 30, 'listed', 'Beautique Shop'),
(147, 'Garnier ', 'Haircare Solutions', 'Defines curls while reducing frizz.  ', 'Designed for curly hair, this mousse provides definition and hold while keeping curls bouncy and frizz-free.  ', 159.00, 119, 'garnier1.jpg', 'garnier2.jpg', 'gar.jpg', 'garr.jpg', 30, 'listed', 'Beautique Shop'),
(149, 'Redken ', 'Haircare Solutions', 'Flexible, medium-hold hairspray for styling.  ', 'A lightweight, flexible hairspray that provides medium hold for various hair styles. It’s perfect for styling and finishing touches.  ', 199.00, 123, 'redken2.jpg', 'redken1.jpg', 'red.jpg', 'redd.jpg', 30, 'listed', 'Beautique Shop'),
(150, 'Beard and Blade Beard Balm', 'Men\'s Grooming', 'BEARD & BLADE BEARD BALM CEDAR VALLEY 100ML', 'Maintain and shape a tidier, healthier-looking beard with our, Aus made, all-natural beard balm or beard butter as sometimes referred to. It includes natural oils and butters to condition dry, frizzy facial hair and moisturise the underlying skin — complete with a spiced woody cedar scent.', 329.00, 149, 'Beard_and_Blade_Beard_Balm-removebg-preview.png', 'Beard_and_Blade_Beard_Balm2.png', 'Beard_and_Blade_Beard_Balm3.png', 'Beard_and_Blade_Beard_Balm4.png', 33, 'listed', 'BloomWellness'),
(151, 'Jack Black Beard Oil', 'Men\'s Grooming', 'Beard Oil - Jack Black | Sephora', 'This exclusive blend of certified organic natural oils, potent antioxidants and vitamins helps to prevent dry, itchy skin and achieve a conditioned, healthy-looking beard. Fast absorbing natural oils soften and hydrate dry, brittle facial ', 599.00, 150, 'Jack_Black_Beard_Oil2.jpg', 'Jack_Black_Beard_Oil.jpg', 'Jack_Black_Beard_Oil33.jpg', 'Jack_Black_Beard_Oil4.jpg', 33, 'listed', 'BloomWellness'),
(152, 'Lorenti', 'Men\'s Grooming', 'Lorenti Beard Oil Serum 50 Ml | Men Morocco Argan Oil & Vitamin E Soften Beard', 'Lorenti Beard Oil Serum 50 ml | Men Morocco Argan Oil & Vitamin E Soften Beard Beard oil with a fresh scent. Lorenti beard oil is developed together with barbers to be able to give your beard the best possible care. The oil gives a soft comfortable feeling that lasts all day. Beard oil that nourishes and softens beard and skin. Use Apply the desired amount of oil in the palms of the hands and work the oil into the beard or Mustache.   Warning Do not expose to direct sunlight, in case of contact with eyes, rinse immediately with plenty of water, store at room temperature, external use, not food.', 599.00, 150, 'The_Maverick_Beard_Oil.jpg', 'Lorenti_Beard_Oil_Serum6.jpg', 'Lorenti_Beard_Oil_Serum5.jpg', 'Lorenti_Beard_Oil_Serum7.jpg', 33, 'listed', 'BloomWellness'),
(153, 'Mountaineer', 'Men\'s Grooming', 'Beard Wash and Beard Conditioner Combo', 'Elevate your grooming game with our Beard Wash and Beard Conditioner Kit. Nourish and cleanse your beard effortlessly while saving money with this rugged bundle. Embrace the manly journey and unleash your true essence with a beard that demands respect. Now you can enjoy a healthier, softer, and more manageable beard.', 599.00, 120, 'Mountaineer_Brand_Beard_Wash2.jpg', 'Mountaineer_Brand_Beard_Wash.jpg', 'Mountaineer_Brand_Beard_Wash3.jpg', 'Mountaineer_Brand_Beard_Wash4.jpg', 33, 'listed', 'BloomWellness'),
(154, 'Honest Amish Beard Balm', 'Skincare Products', 'Honest Amish Heavy Duty Beard Balm -New Large 4 Ounce Twist Tin', ' We use only the finest organic oils and butters blended to perfection to create this magnificent beard control and conditioning balm. Similar to our other beard balm, but this one gives more control and softening. Tested and approved by beard teams and beard aficionados and across the country! The scent is a blend of all natural essential oils and smells like an old fashioned, pure, light, and crisp. If you like our other products, you\'re going to love this and if you\'ve ever dealt with us before you know that we stand behind our products - Satisfaction guaranteed! One tin of heavy duty beard balm. \"If you re not 100% satisfied with your purchase, please return it for a full refund.\"', 599.00, 120, 'Honest_Amish_Beard_Balm4.jpg', 'Honest_Amish_Beard_Balm3.jpg', 'Honest_Amish_Beard_Balm.jpg', 'asdasd.jpg', 33, 'listed', 'BloomWellness'),
(155, 'Ensure Gold', 'Skincare Products', 'Ensure® Gold™ Powder Vanilla', 'Complete & balanced nutrition with CaHMB to help build and repair muscle tissue and YBG (Yeast Beta Glucan) to support immunity.', 499.00, 120, 'Ensure_Gold.jpg', 'Ensure_Gold2.jpg', 'Ensure_Gold3.jpg', 'Ensure_Gold4.jpg', 33, 'listed', 'BloomWellness'),
(156, 'Stresstabs with Zinc', 'Health Supplements', 'STRESSTABS Stresstabs Multivitamins + Iron 30 Tablets', 'Stresstabs Multivitamins + Iron is used for the prevention nd treatment of Vitamin B-complex, Vitamin C, Vitamin E and Iron deficiencies during periods of stress.\r\nStresstabs helps fight the aging effect of stress with Skin-Repairing Nutrients with proper diet and exercise.\r\nWhat contains Stresstabs?\r\n1. Vitamin C - helps promote collagen\r\n2. Vitamin E - helps protect the skin\r\n3. Vitamin B and Iron - helps preserve skin health\r\n', 299.00, 150, 'Stresstabs_with_Zinc.jpg', 'Stresstabs_with_Zinc2.jpg', 'Stresstabs_with_Zinc4.jpg', 'Stresstabs_with_Zinc3.jpg', 33, 'listed', 'BloomWellness'),
(157, 'MaxVit Plus', 'Health Supplements', 'Multi-benefit vitamin for men\r\nMaxvit® is specially formulated for the Filipino family man so he can have the energy, immunity against illness, and vigor that he needs to fulfill his roles.\r\n', 'Contains the natural substances Ginseng and Royal Jelly, to help build vigor and endurance, and enhance physical performance Packed with vitamins and minerals that help provide energy and strong resistance to illness', 399.00, 150, 'MaxVit_Plus.jpg', 'MaxVit_Plus2.jpg', 'MaxVit_Plus3.jpg', 'MaxVit_Plus4.jpg', 33, 'listed', 'BloomWellness'),
(158, 'Vidaylin', 'Health Supplements', 'Vi-daylin Syrup\r\nVi-Daylin Daily Multivitamin Supplement Syrup is a daily multivitamin supplement that is suitable for children from 1-5 years.\r\n', 'Vi-Daylin Daily Multivitamin Supplement Syrup is specifically made for infants aged from 1-5 years and supplies them with all the essential vitamins and minerals they need for physical and mental development. Completely sugar- and tartrazine-free with no artificial colourants. Vi-Daylin Daily Multivitamin Supplement Syrup also assists in developing a strong immune system.', 399.00, 120, 'Vidaylin.jpg', 'Vidaylin2.jpg', 'Vidaylin3.jpg', 'R.jpg', 33, 'listed', 'BloomWellness'),
(159, 'GNC Mega Men Energy & Metabolism', 'Health Supplements', 'GNC Mega Men Sport Multivitamin | Performance, Muscle Function, and General Health | 180 Count\r\nCLINICALLY PROVEN\r\n', 'GNC\'s premium sport multivitamin is formulated for absorption with high potency, time release nutrients to ensure you receive a steady supply of vitamins and minerals throughout the day. In a ground-breaking clinical study, GNC\'s premium multi blend resulted in improved nutrient levels, working even better than a basic multivitamin,', 599.00, 140, 'GNC.jpg', 'g2.jpg', 'gnc2.jpg', 'gnc3.jpg', 33, 'listed', 'BloomWellness'),
(160, 'T.L.C. Sukari Babyfacial', 'Skincare Products', 'A pro-quality AHA/BHA “facial” that resurfaces skin, revealing greater clarity, improved texture and tone, and a more youthful-looking radiance.', 'Effectively yet gently exfoliates the pore lining, getting rid of built-up dead skin cells.\r\nDramatically smooths texture and improves elasticity.\r\nReveals greater clarity and a more even, radiant, baby-soft complexion. \r\nBabyfacial comes with a friend. Follow with Virgin Marula Oil for best results.\r\nFormulated at a skin-friendly pH of 3.5.\r\n100% free of essential oils, silicones, fragrance/dyes, and solvent alcohols\r\n', 325.00, 120, 'Drunk_Elephant_T.L.C._Sukari_Babyfacial_2.jpg', 'Drunk_Elephant_T.L.C._Sukari_Babyfacial_3.jpg', 'Drunk_Elephant_T.L.C._Sukari_Babyfacial.jpg', 'T.L.C._Sukari_Babyfacial.jpg', 33, 'listed', 'BloomWellness'),
(162, 'Kate Somerville', 'Skincare Products', 'ExfoliKate® Intensive Exfoliating Treatment', 'The iconic cult favorite, ExfoliKate® Intensive Exfoliating Treatment is our clinic-inspired exfoliating scrub. In just 2 minutes twice a week, it delivers smoother texture and minimizes pores, while visibly reducing the appearance of crow’s feet and other lines. Bonus! This gentle resurfacing treatment also preps skin to better absorb the rest of your regimen, making every product and ingredient that follows more effective.', 499.00, 120, 'Kate_Somerville_ExfoliKate_Intensive_Exfoliating_Treatment.jpg', 'Kate_Somerville_ExfoliKate_Intensive_Exfoliating_Treatment2.jpg', 'Kate_Somerville_ExfoliKate_Intensive_Exfoliating_Treatment3.jpg', 'Kate_Somerville_ExfoliKate_Intensive_Exfoliating_Treatment4.jpg', 33, 'listed', 'BloomWellness'),
(163, 'Paula\'s Choice', 'Skincare Products', 'Paula\'s Choice SKIN PERFECTING 2% BHA Liquid Salicylic Acid Exfoliant-Facial Exfoliant for Blackheads, Enlarged Pores, Wrinkles & Fine Lines', 'Our iconic global best seller, this clinically proven daily leave-on liquid exfoliant with salicylic acid quickly unclogs pores and controls oil for clear, glowing skin.', 450.00, 120, 'Exfoliants.jpg', 'Exfoliants2.jpg', 'Exfoliants3.jpg', 'Exfoliants4.jpg', 33, 'listed', 'BloomWellness'),
(164, 'The Ordinary ', 'Skincare Products', 'The Ordinary AHA 30% + BHA 2% Peeling Solution\r\nAHA 30% + BHA 2% Peeling Solution\r\n', 'AHA 30% + BHA 2% Peeling Solution exfoliates multiple layers of the skin for a brighter, more even appearance. With the help of alpha-hydroxy acids (AHA), beta-hydroxy acids (BHA), and a studied Tasmanian pepperberry derivative, which reduces irritation that can be associated with acid use, this at-home peel helps even skin texture, clear pore congestion, and improve uneven pigmentation. The formula is further supported with a crosspolymer form of hyaluronic acid for comfort, pro-vitamin B5 for hydration, and black carrot for added protection', 399.00, 120, 'The_Ordinary_AHA_30___BHA_2__Peeling_Solution.jpg', 'The_Ordinary_AHA_30___BHA_2__Peeling_Solution2.jpg', 'The_Ordinary_AHA_30___BHA_2__Peeling_Solution3.jpg', 'The_Ordinary_AHA_30___BHA_2__Peeling_Solution4.jpg', 33, 'listed', 'BloomWellness'),
(165, 'St. Ives Fresh Skin', 'Skincare Products', 'FRESH SKIN APRICOT SCRUB', 'The icon. The cult classic. The beauty editor favorite. Our deep cleaning apricot face scrub with 100% natural walnut shell powder works to give you soft, smooth, positively glowing skin.', 499.00, 120, 'St._Ives_Fresh_Skin_Apricot_Scrub.jpg', 'St._Ives_Fresh_Skin_Apricot_Scrub2.jpg', 'St._Ives_Fresh_Skin_Apricot_Scrub3.jpg', 'St._Ives_Fresh_Skin_Apricot_Scrub4.jpg', 33, 'listed', 'BloomWellness'),
(166, 'Goody Ouchless Hair Ties', 'Skincare Products', 'Gentle elastic hair ties that prevent damage', 'These elastic hair ties are designed to be gentle on hair, preventing damage and snagging while keeping hair securely in place.  ', 39.00, 120, 'Goody_Ouchless_Hair_Ties.jpg', 'goody1.jpg', 'Goody_Ouchless_Hair_Ties1.jpg', 'Goody_Ouchless_Hair_Ties2.jpg', 33, 'listed', 'BloomWellness'),
(167, 'Scunci Scrunchies', 'Skincare Products', 'Soft, stylish scrunchies that don’t damage hair', 'These soft, fabric-covered scrunchies are perfect for securing hair without causing damage or leaving creases, making them a stylish, gentle alternative to traditional elastics.  ', 39.00, 120, 'Scunci_Scrunchies.jpg', 'Scunci_Scrunchies2.jpg', 'Scunci_Scrunchies3.jpg', 'Scunci_Scrunchies4.jpg', 33, 'listed', 'BloomWellness'),
(168, 'Wet Brush Original Detangler', 'Skincare Products', 'Detangles wet and dry hair with minimal breakage.  ', 'This brush is designed to glide through wet and dry hair, minimizing breakage and pain during detangling, leaving hair smooth and manageable.  ', 50.00, 120, 'wet1.jpg', 'wet2.jpg', 'wet3.jpg', 'brush.jpg', 33, 'listed', 'BloomWellness'),
(169, 'Clairol Nice\'n ', 'Skincare Products', 'Permanent color with conditioning ingredients.  ', 'This permanent hair color provides natural-looking color and gray coverage while conditioning the hair for a healthy, shiny finish.  ', 199.00, 120, 'clairol1.jpg', 'clairol2.jpg', 'clairol3.jpg', 'Clairol_Nicen_Easy_Permanent_Hair_Color.jpg', 33, 'listed', 'BloomWellness'),
(170, 'Revlon Colorsilk Beautiful Color', 'Skincare Products', 'Budget-friendly color with conditioning benefits.  ', 'A permanent hair color that delivers rich, vibrant color with a conditioning formula to improve hair texture and shine.  ', 200.00, 120, 'revlon1.jpg', 'revlon2.jpg', 'revlon3.jpg', 'Revlon_Colorsilk_Beautiful_Color.jpg', 33, 'listed', 'BloomWellness'),
(171, 'Gillette Fusion ProGlide Razor', 'Men\'s Grooming', 'GilletteLabs | Bugatti Special Edition Heated Razor', 'Witness artistry at its finest, as the world’s first heated razor meets an automotive legend. Awaken your senses with the feeling of a hot towel shave. The Heated Razor Starter Kit includes: Heated Razor, 2x GilletteLabs blades, and charging station. Subscribe to save on refills.', 299.00, 120, 'Gillette_Fusion_ProGlide_Razor2.jpg', 'Gillette_Fusion_ProGlide_Razor.jpg', 'Gillette_Fusion_ProGlide_Razor3.jpg', 'Gillette_Fusion_ProGlide_Razor4.jpg', 34, 'listed', 'The Glow Lab'),
(172, 'Nivea Men Shaving Foam', 'Men\'s Grooming', 'Formulated with no drying alcohol.', 'This Shaving Foam formula was specially developed for men with sensitive skin. It\'s extra gentle, and lightly fragranced. Enriched with Vitamin E and natural, soothing Chamomile and Witch Hazel extracts, to care for skin while you shave:', 299.00, 120, 'Nivea_Men_Shaving_Foam.jpg', 'Nivea_Men_Shaving_Foam2.jpg', 'Nivea_Men_Shaving_Foam3.jpg', 'Nivea_Men_Shaving_Foam4.jpg', 34, 'listed', 'The Glow Lab'),
(173, 'Proraso Shaving Foam', 'Skincare Products', 'SHAVE FOAM: REFRESHING', 'The recipe for Proraso\'s Refreshing Shave Foam, based on vegetable stearin, has been enriched with natural ingredients for a particularly rich lather that protects skin and enhances the razor\'s glide. Eucalyptus oil purifies and tones; Menthol refreshes and revitalizes; Glycerin increases razor glide and reduces redness.', 399.00, 120, 'Proraso_Shaving_Foam.jpg', 'Proraso_Shaving_Foam2.jpg', 'Proraso_Shaving_Foam3.jpg', 'Proraso_Shaving_Foam4.jpg', 34, 'listed', 'The Glow Lab'),
(174, 'Schick Hydro 5 Razor', 'Men\'s Grooming', 'Hydro® Sensitive Razor\r\nIt’s okay to be sensitive.\r\n', 'Every guy has a soft side. That’s why we designed a razor to pamper and care for your face. Our Sensitive Razor cushions and protects sensitive skin, so you can shave without having to worry about irritation.', 150.00, 120, 'Schick_Hydro_5_Razor.jpg', 'Schick_Hydro_5_Razor2.jpg', 'Schick_Hydro_5_Razor3.jpg', 'Schick_Hydro_5_Razor4.jpg', 34, 'listed', 'The Glow Lab'),
(175, 'Heritage Face & Beard Oil', 'Men\'s Grooming', 'Caswell-Massey\'s finest all-in-one solution for keeping beards soft and skin properly moisturized, the Heritage Face & Beard Oil improves the look and feel of beards both long and short.', 'As it grows, your beard wicks moisture away from the skin leaving skin dry and prone to irritation. By conditioning the often overlooked skin beneath the beard, the Heritage Face & Beard Oil smoothes skin while promoting healthy hair growth. As hair quickly absorbs the oil, it restores the natural shine to your beard as it tames and smooths your beard for that perfectly groomed appearance. For those seeking an elevated shaving experience, you can also use this oil as a conditioning pre-shave oil to provide sensitive, breakout-prone skin with an added layer of protection against irritation caused by razors.', 399.00, 120, '11.jpg', '12.jpg', '122.jpg', 'qq.jpg', 34, 'listed', 'The Glow Lab'),
(176, 'Garcinia Cambogia', 'Health Supplements', 'Puritan\'s Pride Garcinia Cambogia Vegetable Capsules, 1000mg, 60 Count', 'Garcinia cambogia is a small pumpkin-shaped fruit that is native to indonesia. It is related to the super fruit mangosteen and is sometimes called tamarind, brindleberry or camboge. Garcinia cambogia has been used in ayurvedic practices for hundreds of years. These rapid release capsules are derived from the garcinia cambogia fruit. The rind of this fruit contains the revolutionary ingredient hydroxycitric acid (hca), which is considered the \"active compound\". This formula also contains chromium picolinate to support sugar metabolism. Standardized to contain 500mg hca per serving.', 299.00, 120, 'Garcinia.jpg', 'Garcinia2.jpg', 'Garcinia3.jpg', 'Garcinia4.jpg', 34, 'listed', 'The Glow Lab'),
(177, 'Hydroxycut Hardcore Elite', 'Health Supplements', 'Hydroxycut Hardcore Elite - 100 Rapid-Release Thermo Caps - Energy & Focus - for Men & Women - 50 Servings', 'Hydroxycut Hardcore Elite is an extreme super thermogenic designed to help you reach your goals. Unlike other products, Hydroxycut Hardcore Elite is backed by 2 scientific studies. *Subjects taking the key ingredient in Hydroxycut Hardcore Elite (green coffee extract [C. canephora robusta]) works with a calorie reduced diet and moderate exercise. Most thermogenic formulas don’t have any scientific studies backing their key ingredients, let alone two. Hydroxycut Hardcore Elite also features a supercharged energizing and thermogenic driver (270mg caffeine anhydrous) in combination with other sensory enhancing ingredients, including 110mg Coleus forskohlii and 100mg L theanine and 56.3mg Yohimbe to deliver a one of a kind sensory experience with every dose.', 499.00, 120, '1.jpg', '2.jpg', '3.jpg', '4.jpg', 34, 'listed', 'The Glow Lab'),
(179, 'Leptin Green Coffee', 'Health Supplements', 'Leptin Green Coffee 800, Leptin Slimming Coffee (Rose Curve), Leptin Weight Loss Jelly and Lose Weight Coffee', 'Bruce Imports\r\nProduct description\r\nWeight Loss Products.\r\n\r\nLeptin Green Coffee 800 - 90g box (18 x 5g sachets)\r\nLeptin Slimming Coffee (Rose Curve) - 200g box (20 x 10g sachets)\r\nLeptin Weight Loss Jelly – 560g box (20 x 28g sachets)\r\nLose Weight Coffee - 120g (12 x 10g )\r\n', 299.00, 120, 'Leptin_Green_Coffee_8002.jpg', 'Leptin_Green_Coffee_800.jpg', 'Leptin_Green_Coffee_8003.jpg', 'Leptin_Green_Coffee2.jpg', 34, 'listed', 'The Glow Lab'),
(180, 'L-Carnitine ', 'Health Supplements', 'L Carnitine Liquid | MuscleTech L-Carnitine Supplement | 1500 mg of Acetyl L-Carnitine | Post Workout Muscle Recovery | Amino Acids Supplement | Citrus Splash, 16 fl. Oz', 'The L-carnitine contained in Platinum 100% L-Carnitine 1500 is shown in multiple human clinical studies to support post-workout recovery by reducing muscle tissue damage. Research suggests it also combats free-radical formation, minimizes muscle tissue disruption and promotes recovery. Less post-workout soreness and faster recovery means you can increase your training frequency and push yourself harder the next time you train - resulting in faster progress over time!', 499.00, 59, 'L-Carnitine_by_MuscleTech11.jpg', 'L-Carnitine_by_MuscleTech22.jpg', 'L-Carnitine_by_MuscleTech33.jpg', 'L-Carnitine_by_MuscleTech44.jpg', 34, 'listed', 'The Glow Lab'),
(181, 'Optimum Nutrition Gold Standard Whey Protein', 'Health Supplements', 'Optimum Nutrition Gold Standard 100% Whey Protein Powder, Double Rich Chocolate, 5 Pound (Packaging May Vary)', 'OPTIMUM NUTRITION\'S GOLD STANDARD 100% Whey uses pure Whey Protein Isolates as the primary ingredient. Combined with ultra-filtered whey protein concentrate, each serving provides 24 grams of all-whey protein and 5.5 grams of naturally occurring Branched Chain Amino Acids (BCAAs) which are prized by athletes for their muscle building qualities. With more than 20 tempting flavors to choose from, ON GOLD STANDARD 100% Whey gives you plenty of ways to keep workout recovery interesting. Search \"ON Apparel TRUE STRENGTH\" to see our new ON clothing line!', 1599.00, 120, 'Optimum_Nutrition_Gold_Standard_Whey_Protein1.jpg', 'Optimum_Nutrition_Gold_Standard_Whey_Protein2.jpg', 'Optimum_Nutrition_Gold_Standard_Whey_Protein13.jpg', 'Optimum_Nutrition_Gold_Standard_Whey_Protein4.jpg', 34, 'listed', 'The Glow Lab'),
(182, 'CeraVe Moisturizing Cream', 'Skincare Products', 'CeraVe Moisturizing Cream is a rich, non-greasy, fast-absorbing moisturizer with three essential ceramides that lock in skin\'s moisture and help maintain the skin\'s protective barrier.', 'A compromised skin barrier can lead to skin that looks dry, scaly, rough, or flaky. It might also feel irritated, itchy, or uncomfortable. This is because, when your skin barrier is disrupted, it may be unable to keep essential moisture in (and harmful irritants out). Including a barrier-restoring cream with ingredients like hyaluronic acid and ceramides in your daily skincare routine can help restore the look and feel of smooth, supple, and healthy-looking skin.', 599.00, 120, 'CeraVe_Moisturizing_Cream.jpg', 'CeraVe_Moisturizing_Cream2.jpg', 'CeraVe_Moisturizing_Cream3.jpg', 'CeraVe_Moisturizing_Cream4.jpg', 34, 'listed', 'The Glow Lab'),
(183, 'Drunk Elephant', 'Skincare Products', 'A (refillable!) peptide-packed gel-cream moisturizer that immediately improves the appearance of skin\'s tone, texture, and firmness', 'Delivers daily moisture in a lightweight gel-cream.\r\nVisibly firms skin and supports healthy collagen production, restoring bounce.\r\nReduces the appearance of texture, fine lines, wrinkles, and sun damage.\r\nFormulated at a skin-friendly pH of 4.0.\r\n100% free of essential oils, silicones, fragrance/dyes, and solvent alcohols.\r\n', 599.00, 117, 'Drunk_Elephant_Protini_Polypeptide_Cream.jpg', 'Drunk_Elephant_Protini_Polypeptide_Cream2.jpg', 'Drunk_Elephant_Protini_Polypeptide_Cream5.jpg', 'Drunk_Elephant_Protini_Polypeptide_Cream4.jpg', 34, 'listed', 'The Glow Lab'),
(184, 'Clinique Moisture Surge ', 'Skincare Products', 'Clinique Moisture Surge 72-Hour Auto-Replenishing Hydrator', 'Meet the Moisture Surge team.\r\nOur oil-free hydration specialists refresh in a flash,\r\nproviding instant relief for dehydrated skin.\r\n', 399.00, 120, 'Clinique_Moisture_Surge_72-Hour_Auto-Replenishing_Hydrator.jpg', 'Clinique_Moisture_Surge_72-Hour_Auto-Replenishing_Hydrator_2.jpg', 'Clinique_Moisture_Surge_72-Hour_Auto-Replenishing_Hydrator_3.jpg', 'Clinique_Moisture_Surge_72-Hour_Auto-Replenishing_Hydrator_4.jpg', 34, 'listed', 'The Glow Lab'),
(185, 'Olay Regenerist Micro-Sculpting Cream', 'Skincare Products', 'Regenerist Micro-Sculpting Cream MoisturizerHydrates ', 'for Tighter, Firmer Skin\r\nthrough clinical studies, we seek proof of product performance to ensure that women of all ages, ethnicities, and backgrounds can safely and effectively benefit from using our Olay products.\r\n', 499.00, 120, 'Olay_Regenerist_Micro-Sculpting_Cream.jpg', 'Olay_Regenerist_Micro-Sculpting_Cream2.jpg', 'Olay_Regenerist_Micro-Sculpting_Cream3.jpg', 'Olay_Regenerist_Micro-Sculpting_Cream4.jpg', 34, 'listed', 'The Glow Lab'),
(186, 'Neutrogena Hydro Boost Water Gel', 'Skincare Products', 'Neutrogena® Hydro Boost Water Gel with Hyaluronic Acid', 'Instantly quench dry skin for a healthy-looking glow day after day. This award-winning formula with Hyaluronic Acid absorbs quickly like a gel but has the lasting, intense moisturizing power of a cream.', 599.00, 119, 'Neutrogena_Hydro_Boost_Water_Gel.jpg', 'Neutrogena_Hydro_Boost_Water_Gel2.jpg', 'Neutrogena_Hydro_Boost_Water_Gel3.jpg', 'Neutrogena_Hydro_Boost_Water_Gel4.jpg', 34, 'listed', 'The Glow Lab'),
(187, 'Schwarzkopf Color Ultime', 'Haircare Solutions', 'Vibrant color with long-lasting shine', 'A permanent hair dye that delivers vibrant, intense color and long-lasting shine while protecting the hair during coloring.  ', 150.00, 120, 'schwar1.jpg', 'schwar2.jpg', 'schwar3.jpg', 'Schwarzkopf_Color_Ultime.jpg', 34, 'listed', 'The Glow Lab'),
(188, 'Aussie 3 Minute Miracle Moist Conditioner', 'Haircare Solutions', 'Deeply hydrates and softens in just three minutes.  ', ':** A deep-conditioning treatment that works in just three minutes, providing intense hydration and moisture, leaving hair soft, shiny, and manageable.  ', 150.00, 120, 'aussie1.jpg', 'aussie2.jpg', 'Aussie_3_Minute_Miracle_Moist_Conditioner.jpg', 'Aussie_3_Minute_Miracle_Moist_Conditioner2.jpg', 34, 'listed', 'The Glow Lab'),
(189, 'Herbal Essences bio', 'Haircare Solutions', 'Nourishing conditioner infused with coconut milk.  ', 'This conditioner, infused with coconut milk, helps to hydrate and nourish the hair, leaving it silky, smooth, and smelling fresh with a tropical scent.  ', 299.00, 120, 'herbal1.jpg', 'herbal2.jpg', 'herbal3.jpg', 'ASD.jpg', 34, 'listed', 'The Glow Lab'),
(190, 'Suave Professionals Moisture Conditioner', 'Haircare Solutions', 'Hydrates and detangles hair with a rich blend of ingredients.  ', 'Formulated with a rich blend of moisturizing ingredients, this conditioner provides hydration and detangling benefits while leaving hair soft and smooth.  ', 329.00, 120, 'suave1.jpg', 'suave2.jpg', 'Suave_Professionals_Moisture_Conditioner2.jpg', 'Suave_Professionals_Moisture_Conditioner.jpg', 34, 'listed', 'The Glow Lab'),
(191, 'Dove Dermacare Scalp ', 'Haircare Solutions', 'Soothes scalp while combating dandruff.  ', 'Formulated with pyrithione zinc, this shampoo soothes the scalp while combating dandruff and irritation, leaving the scalp refreshed.  ', 499.00, 120, 'dove1.jpg', 'dove2.jpg', 'dove4.jpg', 'dove3.jpg', 34, 'listed', 'The Glow Lab'),
(192, 'Kérastase Specifique Dandruff Shampoo', 'Haircare Solutions', 'Targets dandruff while maintaining scalp health.  ', 'This dandruff-targeting shampoo helps alleviate flaking and irritation while maintaining overall scalp health and balance.  ', 400.00, 118, 'kerastase3.jpg', 'kerastase1.jpg', 'kerastase2.jpg', 'sadd.jpg', 34, 'listed', 'The Glow Lab'),
(195, 'Fenty Beauty Pro ', 'Makeup & Cosmetics', 'Buildable, soft matte finish for all-day wear.  ', 'Lightweight and highly pigmented, this foundation offers a smooth, soft matte finish. Available in a wide range of shades for all skin tones, it provides great coverage and long-lasting wear.  ', 250.00, 200, 'fenty2.jpg', 'Fenty_Beauty_Pro_Filtr_Soft_Matte_Longwear_Foundation.jpg', 'febty3.jpg', 'fenty1.jpg', 30, 'listed', 'Beautique Shop'),
(196, 'Maybelline Fit Me Matte ', 'Makeup & Cosmetics', 'Matte finish that minimizes pores.  ', 'Ideal for normal to oily skin, this foundation gives a natural matte finish while minimizing the appearance of pores. It offers a seamless, shine-free look that lasts throughout the day.  ', 288.00, 266, 'maybeline1.jpg', 'maybeline2.jpg', 'Maybelline_Fit_Me_Matte.jpg', '2Maybelline_Fit_Me_Matte.jpg', 30, 'listed', 'Beautique Shop'),
(197, 'L\'Oreal Infallible Pro-Matte Foundation', 'Makeup & Cosmetics', 'Long-wearing, lightweight matte formula.  ', 'This foundation offers up to 24 hours of wear with a comfortable matte finish. It controls oil and provides smooth, buildable coverage that feels lightweight on the skin.  ', 244.00, 211, 'loriel2.jpg', 'loriel1.jpg', 'LOreal_Infallible_Pro-Matte_Foundation11.jpg', 'LOreal_Infallible_Pro-Matte_Foundation2.jpg', 30, 'listed', 'Beautique Shop'),
(198, 'Tarte Shape Tape Concealer', 'Makeup & Cosmetics', 'Full-coverage, creamy concealer for under-eye brightness.  ', 'A fan-favorite, this full-coverage concealer covers dark circles, blemishes, and redness with ease. Its creamy formula brightens and smooths the under-eye area while providing long-lasting wear.  ', 233.00, 222, 'tarte1.jpg', 'tarte2.jpg', 'tarte3.jpg', 'Tarte_Shape_Tape_Concealer.jpg', 30, 'listed', 'Beautique Shop'),
(199, 'NARS Radiant Creamy Concealer', 'Makeup & Cosmetics', 'Creamy, buildable concealer with a radiant finish.  ', 'This versatile concealer provides medium-to-full coverage and a radiant finish. It’s infused with skincare ingredients and works beautifully to cover blemishes and dark circles.  ', 255.00, 222, 'nars1.jpg', 'nars2.jpg', 'nars3.jpg', 'NARS_Radiant_Creamy_Concealer.jpg', 30, 'listed', 'Beautique Shop'),
(200, 'Maybelline Instant Age ', 'Makeup & Cosmetics', 'Lightweight formula with sponge applicator.  ', 'A lightweight concealer designed to brighten and smooth under-eye areas. The unique sponge applicator makes it easy to blend, giving a natural, refreshed look. ', 222.00, 112, 'maybeline1.jpg', 'maybeline2.jpg', 'maybeline3.jpg', 'Maybelline_Instant_Age_Rewind_Eraser_Dark_Circles_Concealer.jpg', 34, 'listed', 'The Glow Lab'),
(201, 'Urban Decay Naked Palette', 'Makeup & Cosmetics', '12 neutral shades, from matte to shimmer.  ', 'A classic palette featuring a mix of 12 versatile, highly pigmented shades that range from neutral mattes to bold shimmers. Perfect for both everyday looks and dramatic eye makeup.', 200.00, 233, 'naked2.jpg', 'naked1.jpg', 'Urban_Decay_Naked_Palette2.jpg', 'Urban_Decay_Naked_Palette.jpg', 34, 'listed', 'The Glow Lab'),
(202, 'Huda Beauty Obsessions ', 'Makeup & Cosmetics', 'Compact palette with a mix of mattes and shimmers.  ', 'This travel-friendly palette contains a variety of rich, blendable shades in both matte and shimmer finishes. Ideal for creating a wide range of eye looks, from subtle to bold.', 244.00, 112, 'huda2.jpg', 'huda1.jpg', 'huda3.jpg', 'Huda_Beauty_Obsessions.jpg', 34, 'listed', 'The Glow Lab'),
(203, 'Anastasia Beverly Hills ', 'Makeup & Cosmetics', 'Warm, pigmented shades for versatile looks', 'A palette featuring 14 stunning shades in matte and shimmer finishes. Known for its rich pigment, this palette allows you to create everything from neutral daytime looks to bold, smoky eyes.  ', 115.00, 200, 'natasha1.jpg', 'natasha2.jpg', 'natasha3.jpg', 'Anastasia_Beverly_Hills_Modern_Renaissance_Eyeshadow_Palette.jpg', 34, 'listed', 'The Glow Lab'),
(204, 'Kat Von D Tattoo Liner', 'Makeup & Cosmetics', 'Precise, long-wearing liquid liner.  ', 'A highly pigmented, waterproof liquid eyeliner with a precise brush tip. Perfect for creating bold lines or delicate flicks that stay put all day without smudging.  ', 250.00, 111, 'tatto1.jpg', 'tatto2.jpg', 'tatto3.jpg', 'Kat_Von_D_Tattoo_Liner.jpg', 34, 'listed', 'The Glow Lab'),
(205, 'Maybelline Hyper Easy Liquid Liner', 'Makeup & Cosmetics', 'Smooth, flexible brush for precision.  ', 'Featuring a flexible brush tip for smooth, easy application, this liquid eyeliner offers a waterproof, smudge-proof formula for precise, long-lasting lines.  ', 250.00, 111, 'maybeline1.jpg', 'maybeline2.jpg', 'maybeline3.jpg', 'Maybelline_Hyper_Easy_Liquid_Liner.jpg', 33, 'listed', 'BloomWellness'),
(206, 'Stila Stay All Day Waterproof Liquid Eye Liner', 'Makeup & Cosmetics', 'Waterproof, intense pigmentation for all-day wear.  ', 'Known for its precision, this fine-tipped liquid eyeliner delivers intense color and a waterproof formula. It stays on without smudging, making it perfect for long wear.', 250.00, 111, 'stila1.jpg', 'stilar2.jpg', 'stila3.jpg', 'Stila_Stay_All_Day_Waterproof_Liquid_Eye_Liner.jpg', 33, 'listed', 'BloomWellness'),
(207, 'Too Faced Better Than Sex Mascara', 'Makeup & Cosmetics', 'Volumizing mascara for dramatic lashes. ', 'This mascara offers extreme volume and length, with a unique hourglass-shaped brush to lift and separate lashes. It gives a bold, dramatic look without clumping.', 250.00, 124, 'Too_Faced_Better_Than_Sex_Mascara.jpg', 'sex2.jpg', 'sex3.jpg', 'sexx1.jpg', 33, 'listed', 'BloomWellness'),
(208, 'L\'Oreal Voluminous Lash Paradise Mascara', 'Makeup & Cosmetics', 'Volumizing mascara with a soft bristle brush.  ', 'This mascara delivers long-lasting volume and length. The soft, wavy brush ensures smooth application, preventing clumping and providing a fuller lash look.  ', 150.00, 211, 'loeiel1.jpg', 'loriel2.jpg', 'loriel3.jpg', 'LOreal_Voluminous_Lash_Paradise_Mascara.jpg', 33, 'listed', 'BloomWellness'),
(209, 'Benefit They\'re Real! Lengthening Mascara', 'Makeup & Cosmetics', 'Lengthens and defines lashes with no smudging.  ', 'A lengthening mascara that separates and defines lashes while adding volume. It’s long-wearing and smudge-proof, offering a bold, fluttery effect.  ', 200.00, 111, 'Benefit_Theyre_Real_Lengthening_Mascara.jpg', 'real2.jpg', 'real1.jpg', 'Benefit_Theyre_Real_Lengthening_Mascara2.jpg', 33, 'listed', 'BloomWellness'),
(210, 'Fitbit Charge 5 Fitness Tracker', 'Personal Care Appliances', 'Advanced fitness and health tracker with heart rate monitoring, sleep tracking, and stress management features.', 'The Fitbit Charge 5 offers real-time heart rate monitoring, built-in GPS, and guided breathing exercises. It is perfect for people looking to stay fit and manage their overall health.', 2000.00, 111, '983cf909-25d4-4703-9545-87a820114ef6.864e5566be77593c871393f1935b3c1d.jpg', 'Fitbit_Charge_5__white-200x200w.jpg', 'Fitbit_Charge_5_Fitness_Tracker1.jpg', 'Fitbit_Charge_5_Fitness_Tracker.jpg', 30, 'listed', 'Beautique Shop'),
(211, 'Philips Sonicare DiamondClean Smart Toothbrush', 'Personal Care Appliances', 'A premium electric toothbrush that offers superior cleaning with smart sensor technology.', 'This electric toothbrush uses advanced technology to improve brushing technique and oral health, offering various modes for gum care, plaque control, and whitening.', 1000.00, 122, 'Philips-Sonicare-DiamondClean-Smart-9300-Electric-Toothbrush-in-white-1024x1024.jpg', '71oQAGUaNkL._AC_UF10001000_QL80_.jpg', 'images.jpg', 'Philips_Sonicare_DiamondClean_Smart_Toothbrush.jpg', 30, 'listed', 'Beautique Shop'),
(212, 'Omron Platinum Blood Pressure Monitor', 'Personal Care Appliances', 'Advanced blood pressure monitor with Bluetooth for seamless data syncing to your smartphone.', 'The Omron Platinum BP monitor provides accurate readings and tracks your blood pressure history, helping you manage heart health.', 2500.00, 111, '51uzNjUCC7L.jpg', 'images_1.jpg', 'images.jpg', 'Omron_Platinum_Blood_Pressure_Monitor.jpg', 30, 'listed', 'Beautique Shop'),
(213, 'Withings Body+ Smart Body Scale', 'Personal Care Appliances', 'A high-precision scale that measures weight, body fat percentage, muscle mass, and more.', 'This smart scale is perfect for tracking fitness and health goals, offering an in-depth analysis of body composition to help monitor progress.', 1000.00, 125, '61zdd-9HDnL._AC_UF8941000_QL80_.jpg', 'images_2.jpg', 'images.jpg', 'Withings_Body_Smart_Body_Scale.jpg', 30, 'listed', 'Beautique Shop'),
(214, 'Fitbit Aria 2 Wi-Fi Smart Scale', 'Personal Care Appliances', 'A Wi-Fi enabled smart scale that tracks weight and BMI over time.', 'The Fitbit Aria 2 scale is great for users looking to track their weight and body fat over time. It syncs effortlessly with the Fitbit app for easy tracking.', 2500.00, 123, '71rnw182yuL._AC_UF10001000_QL80_.jpg', 'images_1.jpg', 'images.jpg', 'Fitbit_Aria_2_Wi-Fi_Smart_Scale.jpg', 30, 'listed', 'Beautique Shop'),
(215, 'Dyson Pure Hot + Cool Air Purifier', 'Personal Care Appliances', 'Air purifier that also functions as a fan and heater for year-round comfort.', 'This versatile air purifier removes allergens, pollutants, and bacteria, while keeping your home comfortable with temperature control.', 1500.00, 111, 'DysonHp10AirPureAVSSF24_VND.jpg', 'images.jpg', 'tp07-ws-hepa13-pdp.png', 'Dyson_Pure_Hot__Cool_Air_Purifier.jpg', 34, 'listed', 'The Glow Lab'),
(217, 'Cuisinart Elite 12-Cup Food Processor', 'Haircare Solutions', 'A powerful food processor designed for healthy meal prep and quick chopping.', 'This appliance is perfect for anyone looking to prepare fresh, healthy meals with ease, offering versatility in food prep for a wide variety of recipes.', 3000.00, 125, 'cuisinart-food-processor-7-cup-o.jpg', 'images.jpg', 'Cuisinart_Elite_12-Cup_Food_Processor2.jpg', 'Cuisinart_Elite_12-Cup_Food_Processor.jpg', 34, 'listed', 'The Glow Lab'),
(218, 'Keurig K-Elite Coffee Maker', 'Personal Care Appliances', 'A single-serve coffee maker with strong brew options and iced coffee settings.', 'Ideal for coffee lovers, this Keurig machine allows you to brew coffee quickly with options for a stronger brew or refreshing iced coffee.', 1555.00, 111, 'Keurig_K-Elite_Coffee_Maker.jpg', 'images_1.jpg', 'images.jpg', 'images_2.jpg', 34, 'listed', 'The Glow Lab'),
(219, 'Snoo Smart Sleeper', 'Personal Care Appliances', 'A high-tech bassinet that helps babies sleep better with soothing motions and sounds.', 'The Snoo Smart Sleeper is designed to help babies sleep longer and safer. It uses gentle motions and calming sounds to soothe infants, ensuring a better night\'s rest.', 1500.00, 111, 'images_1.jpg', 'images.jpg', 'snoo-smart-sleeper-bassinet.jpg', '8b558a1620792742493779dbebe3052c.jpg', 34, 'listed', 'The Glow Lab'),
(220, 'Philips Sonicare ProtectiveClean 6100 Electric Toothbrush', 'Personal Care Appliances', '**: Smart electric toothbrush designed to care for gums and reduce plaque build-up.', 'Ideal for users seeking improved oral health, the Sonicare ProtectiveClean 6100 combines effective plaque removal with gum care, providing a gentle yet thorough cleaning.', 1500.00, 222, '61eJaPVMOIL._AC_UF10001000_QL80_.jpg', '61sVQxLgipL._AC_UF8941000_QL80_.jpg', 'images.jpg', 'Philips_Sonicare_ProtectiveClean_6100_Electric_Toothbrush.jpg', 34, 'listed', 'The Glow Lab'),
(221, 'Oster My Blend Personal Blender', 'Personal Care Appliances', 'A personal blender that’s perfect for smoothies and health shakes.', 'This portable blender is designed for health-conscious individuals who want a quick, easy way to make nutritious shakes and smoothies.', 2500.00, 111, 'images_1.jpg', 'images_2.jpg', 'images.jpg', 'Oster_My_Blend_Personal_Blender.jpg', 33, 'listed', 'BloomWellness'),
(222, 'Shark IONRobot Vacuum', 'Personal Care Appliances', 'A robotic vacuum cleaner designed to reduce allergens by picking up dust, dirt, and pet hair.', 'This robotic vacuum is ideal for busy households or anyone with allergies, as it picks up debris, dirt, and pet hair with ease.', 1600.00, 122, 'images_3.jpg', '81ReD1EYw8L._AC_UF8941000_QL80_.jpg', 'images.jpg', 'Shark_IONRobot_Vacuum.jpg', 33, 'listed', 'BloomWellness'),
(223, 'Hydrow Rower', 'Personal Care Appliances', 'A high-tech rowing machine designed for full-body workouts with live and on-demand classes.', 'The Hydrow rowing machine offers a premium experience for fitness enthusiasts, providing realistic rowing with water resistance and engaging workouts led by top trainers.', 5000.00, 124, 'hydrowhi-techdesign.jpg', 'images_1.jpg', 'Standinghydrowroweruprightwhennotinuse.jpg', 'Hydrow_Rower.jpg', 33, 'listed', 'BloomWellness');
INSERT INTO `seller_add_product` (`id`, `product_name`, `category`, `mini_description`, `main_description`, `price`, `stock_quantity`, `product_image`, `sub_image_1`, `sub_image_2`, `sub_image_3`, `seller_id`, `product_status`, `business_name`) VALUES
(224, 'Pure Enrichment MistAire Ultrasonic Humidifier', 'Personal Care Appliances', 'An ultrasonic humidifier that helps improve air quality and moisturize dry skin.', 'This ultrasonic humidifier adds moisture to the air, helping to alleviate dry skin, sinuses, and throat irritation, especially in dry climates or during the winter months.', 4500.00, 123, '51vhTcSKs3L._AC_UF350350_QL80_.jpg', 'images_1.jpg', 'images.jpg', 'Pure_Enrichment_MistAire_Ultrasonic_Humidifier.jpg', 33, 'listed', 'BloomWellness'),
(225, 'Beurer Heating Pad', 'Personal Care Appliances', 'A therapeutic heating pad that provides relief from muscle pain and tension.', 'The Beurer heating pad helps soothe sore muscles and ease tension with adjustable heat settings, making it perfect for pain relief after a workout or long day.', 4500.00, 123, '71CgSYjX5L.jpg', 'images.jpg', '51Yry7wW5HL._AC_UF10001000_QL80_.jpg', 'Beurer_Heating_Pad.jpg', 33, 'listed', 'BloomWellness'),
(226, 'Sunday Riley ', 'Skincare Products', 'SUNDAY RILEY Luna Sleeping Night Oil\r\n', 'Skin Type: Combination, Dry, Normal, Oily, Sensitive\r\nSkin Concerns: Ageing, Dryness, Dullness, Fine Lines & Wrinkles, Firmness & Elasticity, Pigmentation & Dark Spots, Uneven Skin Texture, Uneven Skin Tone, Pores\r\nSkincare By Age: 20s, 30s, 40s, 50+, Under 20\r\n', 3000.00, 145, 'Sunday_Riley_Luna_Sleeping_Night_Oil.jpg', 'Sunday_Riley_Luna_Sleeping_Night_Oil2.jpg', 'Sunday_Riley_Luna_Sleeping_Night_Oil3.jpg', 'Sunday_Riley_Luna_Sleeping_Night_Oil4.jpg', 30, 'listed', 'Beautique Shop'),
(227, 'Squalane ', 'Skincare Products', 'Squalane + Vitamin C Rose Oil ', 'Ideal for: Brightening + Radiance | Dryness | Firming Skin\r\nSkin Type: Benefits all skin types, targets dry skin\r\nVisibly brighten, firm, and lock in moisture with this cult favorite facial oil. Its uniquely oil soluble form of vitamin C weightlessly absorbs to instantly boost radiance while remaining gentle on skin. The result: nourished, glowing, deeply hydrated skin.\r\n', 1500.00, 125, 'Biossance_Squalane__Vitamin_C_Rose_Oil2.jpg', 'Biossance_Squalane__Vitamin_C_Rose_Oil3.jpg', 'Biossance_Squalane__Vitamin_C_Rose_Oil4.jpg', 'Biossance_Squalane__Vitamin_C_Rose_Oil.jpg', 30, 'listed', 'Beautique Shop'),
(228, 'The Ordinary 100% Organic Cold-Pressed Rose Hip Seed Oil', 'Skincare Products', '100% Organic Cold-Pressed Rose Hip Seed Oil', '100% Organic Cold-Pressed Rosehip Seed Oil naturally hydrates skin to help address signs of aging by brightening and balancing uneven skin tone, supporting skin elasticity, and promoting supple, more radiant-looking skin. It’s made of 100% organic rosehip seed oil that is cold-pressed to retain its potency and is gentle enough for daily use.\r\nOur Rose Hip Seed Oil is completely unrefined and imparts a natural scent partly due to its high omega fatty acid content. This scent is not an indication of rancidity.\r\n', 1500.00, 111, 'The_Ordinary_100__Organic_Cold-Pressed_Rose_Hip_Seed_Oil3.jpg', 'The_Ordinary_100__Organic_Cold-Pressed_Rose_Hip_Seed_Oil.jpg', 'The_Ordinary_100__Organic_Cold-Pressed_Rose_Hip_Seed_Oil4.jpg', 'The_Ordinary_100_Organic_Cold-Pressed_Rose_Hip_Seed_Oil.jpg', 30, 'listed', 'Beautique Shop'),
(229, 'Herbivore Botanicals Lapis Facial Oil', 'Skincare Products', 'LAPIS Blue Tansy Face Oil - For Oily & Acne-Prone Skin', 'Lapis Facial Oil contains Blue Tansy, a component called Azulene which is known to soothe dry or irritated skin, reduce the appearance of redness and leave the skin feeling more balanced.', 1500.00, 111, 'Herbivore_Botanicals_Lapis_Facial_Oil.jpg', 'Herbivore_Botanicals_Lapis_Facial_Oil2.jpg', 'Herbivore_Botanicals_Lapis_Facial_Oil3.jpg', 'Herbivore_Botanicals_Lapis_Facial_Oil5.jpg', 30, 'listed', 'Beautique Shop'),
(230, 'Tata Harper Retinoic Nutrient Face Oil', 'Skincare Products', 'Retinoic Nutrient Face Oil', 'This luxurious face oil is your youth restoring booster. Our multitasking complex reduces the look of early wrinkles with retinoic acid-like activity from next generation bioactive botanical retinol alternatives, while omega fatty acids and skin superfoods provide complete skin nourishment for youthful, healthy-looking skin.', 1500.00, 111, 'Tata_Harper_Retinoic_Nutrient_Face_Oil.jpg', 'Tata_Harper_Retinoic_Nutrient_Face_Oil2.jpg', 'Tata_Harper_Retinoic_Nutrient_Face_Oil3.jpg', 'Tata_Harper_Retinoic_Nutrient_Face_Oil4.jpg', 30, 'listed', 'Beautique Shop'),
(231, 'CeraVe Hydrating Cleanser', 'Skincare Products', 'Hydrating Facial Cleanser\r\nCeraVe Hydrating Facial Cleanser was designed to cleanse and refresh the skin without over-stripping it or leaving it feeling tight and dry.\r\n•	Made For: Normal to Dry Skin\r\n•	Helps With: Cleansing\r\n', 'A cleanser can remove dirt, makeup and other debris, but a hydrating cleanser, like CeraVe Hydrating Facial Cleanser, can do all that without disrupting the skin’s natural protective barrier or stripping the skin of its natural moisture. Developed with dermatologists, CeraVe Hydrating Facial Cleanser is a gentle face wash with ingredients like ceramides and hyaluronic acid that work to restore the skin’s natural barrier to help the skin lock in moisture.', 2600.00, 111, 'CeraVe_Hydrating_Cleanser2.jpg', 'CeraVe_Hydrating_Cleanser4.jpg', 'CeraVe_Hydrating_Cleanser.jpg', 'CeraVe_Hydrating_Cleanser3.jpg', 34, 'listed', 'The Glow Lab'),
(232, 'La Roche-Posay ', 'Skincare Products', 'TOLERIANE PURIFYING FOAMING FACE WASH\r\nFACE WASH FOR NORMAL TO OILY SKIN\r\n', 'Toleriane Purifying Foaming Facial Cleanser is a daily face wash for normal to oily, sensitive skin. Formulated with La Roche-Posay prebiotic thermal spring water, niacinamide, and ceramide-3, this face wash gently cleanses skin of dirt, makeup, and impurities while maintaining the skin\'s natural moisture barrier and pH.', 2400.00, 122, 'La_Roche-Posay_Toleriane_Purifying_Foaming_Cleanser.jpg', 'La_Roche-Posay_Toleriane_Purifying_Foaming_Cleanser2.jpg', 'La_Roche-Posay_Toleriane_Purifying_Foaming_Cleanser3.jpg', 'La_Roche-Posay_Toleriane_Purifying_Foaming_Cleanser4.jpg', 34, 'listed', 'The Glow Lab'),
(233, 'Neutrogena Ultra Gentle Hydrating Cleanser', 'Skincare Products', 'Ultra Gentle Hydrating Cleanser', 'Get ready for an effective, yet extra mild facial cleanser that’s free of soap and has no added parabens and dyes. It’s uniquely formulated with minimal ingredients, which helps hydrate and protect skin while it works. It’s fragrance free and so gentle, it can be used with most sensitive skin conditions including eczema and rosacea.', 1500.00, 122, 'Neutrogena_Ultra_Gentle_Hydrating_Cleanser.jpg', 'Neutrogena_Ultra_Gentle_Hydrating_Cleanser2.jpg', 'Neutrogena_Ultra_Gentle_Hydrating_Cleanser3.jpg', 'Neutrogena_Ultra_Gentle_Hydrating_Cleanser4.jpg', 34, 'listed', 'The Glow Lab'),
(234, 'Vanicream Gentle Facial Cleanser', 'Skincare Products', 'VANICREAM\r\nGentle Facial Cleanser\r\n', 'Our mildest cleanser specifically formulated for daily facial use. Helps remove makeup and excess skin oils without drying your skin. Leaves skin feeling clean and soft. Ideal for dry skin. ', 1499.00, 123, 'Vanicream_Gentle_Facial_Cleanser4.jpg', 'Vanicream_Gentle_Facial_Cleanser3.jpg', 'Vanicream_Gentle_Facial_Cleanser2.jpg', 'Vanicream_Gentle_Facial_Cleanser33.jpg', 34, 'listed', 'The Glow Lab'),
(235, 'Tatcha The Deep Cleanse', 'Skincare Products', 'The Deep Cleanse\r\nGentle Exfoliating Cleanser\r\nPurifies & polishes skin in 1 easy step\r\n•	Lifts away dirt and oil without stripping\r\n•	Exfoliates to reveal smooth skin\r\n•	Decongests pores\r\n•	\r\n6.  Paula’s Choice Skin Perfecting 2% BHA Liquid Exfoliant\r\n SKIN PERFECTING\r\n2% BHA Liquid Exfoliant\r\n', 'Our #1 product worldwide + award-winning favorite, this gentle leave-on exfoliant with salicylic acid quickly unclogs pores, smooths wrinkles, brightens, and evens out skin tone.\r\n•	Clears & minimizes enlarged pores\r\n•	BHA (beta hydroxy acid) sheds built-up layers of skin\r\n•	Fluid, lightweight texture absorbs quickly\r\n\r\n', 1444.00, 0, 'Tatcha_The_Deep_Cleanse.jpg', 'Tatcha_The_Deep_Cleanse2.jpg', 'Tatcha_The_Deep_Cleanse3.jpg', 'Tatcha_The_Deep_Cleanse2.jpg', 34, 'listed', 'The Glow Lab'),
(236, 'ROSE PETAL FACIAL TONER', 'Skincare Products', 'Alcohol-free facial toner soothes and hydrates. Rose water brings about a natural glow.', 'Flower Power.  THAYERS Rose Petal Facial Toner visibly improves the quality of skin, revealing glowy, moisturized skin that looks and feels healthier.  Our alcohol-free, gentle, non-drying toner acts like a remedy to hydrate skin all day, helping skin feel purified,  balanced and renewed.  Skin texture is visibly smoother, pores appear smaller, and skin tone looks more even.  Founded by Dr. Henry ', 1150.00, 123, 'Thayers_Witch_Hazel_Alcohol-Free_Toner.jpg', 'Thayers_Witch_Hazel_Alcohol-Free_Toner2.jpg', 'Thayers_Witch_Hazel_Alcohol-Free_Toner3.jpg', 'Thayers_Witch_Hazel_Alcohol-Free_Toner4.jpg', 33, 'listed', 'BloomWellness'),
(237, 'Pixi Glow Tonic', 'Skincare Products', 'Glow Tonic Original Size\r\nAward-winning highly concentrated facial toner, infused with 5% Glycolic Acid, deeply cleanses pores by sweeping away excess oil and impurities for balanced, soothed, prepped and radiant skin.\r\n', 'Exfoliates and purifies the skin with 5% Glycolic Acid.\r\n• Ginseng improves circulation and energizes.\r\n• Removes excess oils and impurities.\r\n• Invigorates and energizes skin.\r\n• Aloe Vera soothes and hydrates.\r\n• Refines the appearance of pores.\r\n• Gently accelerates cell renewal to reveal a brighter, glowing complexion.\r\n• Balances and soothes for radiant, healthier-looking skin.\r\n• Alcohol-free\r\n• Suitable for all skin types\r\n• Paraben-free\r\n• Not tested on animals\r\n• Volume: 250 ml / 8.5 fl oz \r\n', 1444.00, 123, 'Pixi_Glow_Tonic.jpg', 'Pixi_Glow_Tonic2.jpg', 'Pixi_Glow_Tonic4.jpg', 'Pixi_Glow_Tonic5.jpg', 33, 'listed', 'BloomWellness'),
(238, 'Fresh Rose Deep Hydration Facial Toner', 'Skincare Products', 'Rose & Hyaluronic Acid Deep Hydration Toner\r\nA hydrating toner with damask rose and hyaluronic acid that strengthens skin’s barrier & infuses deep hydration for visibly refined pores & soft skin.\r\n', 'This best-selling, alcohol-free toner builds a strong skin barrier and clears skin of impurities for a hydrated, healthy look. Damask rose strengthens skin to lock in deep hydration while rose fruit extract helps to visibly minimize pores for soft, clear skin. And yes, those are real rose petals.\r\n\r\n\r\n•	Strengthens skin’s barrier while deeply hydrating\r\n•	Clears skin of pore-clogging impurities\r\n•	Refines the look of pores for soft skin\r\n', 1233.00, 111, 'Fresh_Rose_Deep_Hydration_Facial_Toner.jpg', 'Fresh_Rose_Deep_Hydration_Facial_Toner2.jpg', 'Fresh_Rose_Deep_Hydration_Facial_Toner3.jpg', 'Fresh_Rose_Deep_Hydration_Facial_Toner4.jpg', 33, 'listed', 'BloomWellness'),
(239, 'Kiehl\'s Calendula Herbal Extract ', 'Skincare Products', 'Calendula Herbal Extract Toner Alcohol Free\r\nTransform your skincare routine with Kiehl’s Calendula Herbal Extract Toner. Alcohol-free and enriched with soothing calendula petals. Buy now!\r\n', 'What It’s Good For\r\nThis facial toner for oily skin and normal skin has been beloved by Kiehl’s customers since the 1960’s. Within our cult-classic formula, hand-picked Calendula flower petals work with other ingredients like Great Burdock Root Extract to create a gentle cleansing and soothing alcohol-free facial toner.\r\n• Gently cleanses and refreshes facial skin without harsh synthetic drying agents\r\n• Soothes and improves the feel of skin\r\n• Formulated with Calendula, Burdock Root Extract and Allantoin\r\n• Alcohol-free\r\n• For normal to oily skin types, including sensitive skin\r\n• A customer favorite\r\n', 1250.00, 122, 'Kiehls_Calendula_Herbal_Extract_Alcohol-Free_Toner.jpg', 'Kiehls_Calendula_Herbal_Extract_Alcohol-Free_Toner2.jpg', 'Kiehls_Calendula_Herbal_Extract_Alcohol-Free_Toner3.jpg', 'Kiehls_Calendula_Herbal_Extract_Alcohol-Free_Toner4.jpg', 33, 'listed', 'BloomWellness'),
(240, 'Neutrogena Alcohol-Free Toner', 'Skincare Products', 'Neutrogena® Alcohol-Free Toner\r\nNeutrogena Alcohol-Free Toner has dual-action, cleans & balances. Special mild purifiers gently remove impurities & recondition your skin. Protects skin\'s mature moisture. Your skin will feel fresh and soft without tightness, dryness or stinging.\r\n', '•	Cleans and refreshes without stripping skin\'s moisture\r\n•	For all skin types\r\n•	Alcohol-free formula cleanses without irritation\r\n•	Non-comedogenic formula won\'t clog pores\r\n•	Hypoallergenic and oil-free\r\n', 1444.00, 122, 'Neutrogena_Alcohol-Free_Toner.jpg', 'Neutrogena_Alcohol-Free_Toner2.jpg', 'Neutrogena_Alcohol-Free_Toner3.jpg', 'Neutrogena_Alcohol-Free_Toner4.jpg', 33, 'listed', 'BloomWellness'),
(241, 'The Ordinary Niacinamide ', 'Skincare Products', 'Niacinamide 10% + Zinc 1%\r\nA universal serum for blemish-prone skin that smooths, brightens, and supports.\r\nTargetsTextural Irregularities, Dryness, Dullness, Visible Shine, Signs of Congestion\r\n', 'Our Niacinamide 10% + Zinc 1% formula is a water-based serum that boosts skin brightness, improves skin smoothness and reinforces the skin barrier over time. It contains a high 10% concentration of Niacinamide (vitamin b3) and zinc PCA.\r\n\r\nNote: Niacinamide and Zinc PCA is not a treatment for acne. For persistent acne-related conditions, we recommend speaking to your health care provider regarding treatment options. This formulation can be used alongside acne treatments if desired for added visible skin benefits.\r\n', 1440.00, 234, 'The_Ordinary_Niacinamide_10__Zinc_1.jpg', 'The_Ordinary_Niacinamide_10__Zinc_12.jpg', 'The_Ordinary_Niacinamide_10__Zinc_15.jpg', 'The_Ordinary_Niacinamide_10__Zinc_14.jpg', 48, 'listed', 'BidaGlow'),
(242, 'Skinceuticals C E Ferulic Serum', 'Skincare Products', 'C E Ferulic® with 15% L-Ascorbic Acid', 'The #1 dermatologist recommended vitamin C serum among medical aesthetic skincare brands, this patented daytime vitamin C serum for the face that delivers advanced environmental protection and clinically improves the 8 signs of aging, including the appearance of fine lines and wrinkles, discoloration, loss of firmness, and brightness. Clinically proven to reduce up to 48% of potential damage from free radicals formed by pollution, the sun, and metals for up to 8x stronger skin against environmental aggressors. U.S. Patent No. 7,179,841.', 1442.00, 123, 'Skinceuticals_C_E_Ferulic_Serum.jpg', 'Skinceuticals_C_E_Ferulic_Serum3.jpg', 'Skinceuticals_C_E_Ferulic_Serum4.jpg', 'Skinceuticals_C_E_Ferulic_Serum2.jpg', 48, 'listed', 'BidaGlow'),
(243, 'Vichy Mineral 89 Hyaluronic Acid Serum', 'Skincare Products', 'MINÉRAL 89 HYALURONIC ACID SERUM', 'ur best-selling hyaluronic acid booster, Mineral 89 Serum is formulated with Pure Hyaluronic Acid and 15 Mineral-Rich Vichy Volcanic Water to strengthen & repair your skin barrier. This daily hydrating and plumping booster serum for your face has been clinically tested by 175 dermatologists on 1600 women worldwide. Safe and effective for all skin types, in a minimalist, fragrance free formula with only 11 ingredients.\r\nBenefits of Minéral 89 Serum\r\n•	Strengthens & repairs skin barrier\r\n•	Hylauronic acid helps hydrate & plumps skin\r\n•	Makes skin more resistant to visible signs of aging by exposome factors (UV, pollution, stress)\r\n•	Lightweight, fast-absorbing translucent booster\r\n•	Accepted by the National Eczema Association\r\nSkin Type: All skin types\r\nSkin Concern: Dry Skin\r\n', 1556.00, 123, 'Vichy_Mineral_89_Hyaluronic_Acid_Serum.jpg', 'Vichy_Mineral_89_Hyaluronic_Acid_Serum_4.jpg', 'Vichy_Mineral_89_Hyaluronic_Acid_Serum_5.jpg', 'Vichy_Mineral_89_Hyaluronic_Acid_Serum_3.jpg', 48, 'listed', 'BidaGlow'),
(244, 'Estée Lauder Advanced Night Repair Serum', 'Skincare Products', 'Advanced Night Repair SerumSynchronized Multi-Recovery Complex', 'Deep nightly renewal. Unfiltered morning radiance.\r\nThis deep- and fast-penetrating face serum, with our exclusive 1-in-60-million Night Peptide, harnesses 40 years of pioneering Night Science Research.\r\nSkin looks smoother and less lined, younger, healthier—more radiant and even toned.\r\n', 1233.00, 111, 'Estee_Lauder_Advanced_Night_Repair_Serum.jpg', 'Estee_Lauder_Advanced_Night_Repair_Serum2.jpg', 'Estee_Lauder_Advanced_Night_Repair_Serum3.jpg', 'Estee_Lauder_Advanced_Night_Repair_Serum4.jpg', 48, 'listed', 'BidaGlow'),
(245, 'L\'Oréal Paris Revitalift ', 'Skincare Products', 'The #1 Serum in the World* is finally here. Instantly hydrates, refines pores, and reduces fine lines. Get #YouthfulGlassSkin with the Revitalift 1.5% Hyaluronic Acid Serum 30mL!', 'This facial serum contains 1.5% of pure hyaluronic acid (HA) — 0.5% high molecular weight (macro HA) that intensely hydrates to smooth skin surface and 1% low molecular weight (micro HA) that deeply penetrates to re-plump lines from within. Your most visible, youthful transformation comes in this hydrating and anti-aging serum that reduces fine lines. A little goes a long way with the L\'Oreal Paris Revitalift 1.5% Hyaluronic Acid Serum. *Worldwide #1 Female Face Care Anti-Aging Serum', 1550.00, 222, 'LOreal_Paris_Revitalift_1.5_Pure_Hyaluronic_Acid_Serum.jpg', 'LOreal_Paris_Revitalift_1.5_Pure_Hyaluronic_Acid_Serum2.jpg', 'LOreal_Paris_Revitalift_1.5_Pure_Hyaluronic_Acid_Serum3.jpg', 'LOreal_Paris_Revitalift_1.5_Pure_Hyaluronic_Acid_Serum4.jpg', 48, 'listed', 'BidaGlow'),
(246, 'EltaMD UV Clear Broad-Spectrum SPF 46', 'Skincare Products', 'SKIN TYPES - COMBINATION | DRY | OILY', 'EltaMD UV Clear Broad Spectrum SPF 46 is formulated with 5% Niacinamide (Vitamin B3) to help reduce the appearance of blemishes and discoloration on your skin. This broad spectrum sunscreen contains micronized zinc oxide to protect your skin from damaging UVA (aging) and UVB (burning) rays.', 1123.00, 122, 'EltaMD_UV_Clear_Broad-Spectrum_SPF_46.jpg', 'EltaMD_UV_Clear_Broad-Spectrum_SPF_462.jpg', 'EltaMD_UV_Clear_Broad-Spectrum_SPF_463.jpg', 'EltaMD_UV_Clear_Broad-Spectrum_SPF_464.jpg', 48, 'listed', 'BidaGlow'),
(247, 'Neutrogena Ultra Sheer ', 'Skincare Products', 'Neutrogena® Ultra Sheer® Dry-Touch Sunscreen SPF 50 PA+++\r\nThe sun can make your skin age prematurely. Step out worry-free with protection against harmful UV rays. Its ultra-light texture makes you feel like you have nothing on.\r\n', 'Helioplex™ Technology ensures that sun protection doesn\'t break down, effectively blocking damaging UVA and UVB rays. Dry-Touch Technology keeps your skin shine-free and clog-free. Neutrogena® Ultra Sheer® Dry Touch Sunscreen protects the integrity of your skin barrier by shielding it from UV-induced damage, helping your skin stay youthful.\r\n•	Broad Spectrum UVA-UVB\r\n•	Non-comedogenic\r\n•	Oil-free\r\n•	PABA-free\r\n•	Water resistant (for up to 80 minutes)\r\n', 1233.00, 112, 'Neutrogena_Ultra_Sheer_Dry-Touch_Sunscreen_SPF_100.jpg', 'Neutrogena_Ultra_Sheer_Dry-Touch_Sunscreen_SPF_1002.jpg', 'Neutrogena_Ultra_Sheer_Dry-Touch_Sunscreen_SPF_1003.jpg', 'Neutrogena_Ultra_Sheer_Dry-Touch_Sunscreen_SPF_100.jpg', 48, 'listed', 'BidaGlow'),
(248, 'La Roche-Posay Anthelios', 'Skincare Products', 'ANTHELIOS MELT-IN MILK SUNSCREEN FOR FACE & BODY SPF 100', 'SPF 100 sunscreen for face and body, specifically formulated to help protect skin that burns easily. Ideal for: face + ears, nose, scalp + hairline, arms + hands, full body, neck + chest. The only oxybenzone-free SPF 100 Sunscreen with Cell-Ox Shield® Technology: broad spectrum UVA/UVB protection with antioxidants.', 1233.00, 111, 'La_Roche-Posay_Anthelios_Melt-in_Milk_Sunscreen_SPF_100.jpg', 'La_Roche-Posay_Anthelios_Melt-in_Milk_Sunscreen_SPF_1002.jpg', 'La_Roche-Posay_Anthelios_Melt-in_Milk_Sunscreen_SPF_1003.jpg', 'La_Roche-Posay_Anthelios_Melt-in_Milk_Sunscreen_SPF_100.jpg', 48, 'listed', 'BidaGlow'),
(249, 'Supergoop! ', 'Skincare Products', 'Unseen Sunscreen SPF 40', 'The original 100% invisible, weightless, scentless sunscreen with broad spectrum SPF protection, skincare benefits & a natural finish.', 1552.00, 211, 'Supergoop_Unseen_Sunscreen_SPF_40.jpg', 'Supergoop_Unseen_Sunscreen_SPF_402.jpg', 'Supergoop_Unseen_Sunscreen_SPF_403.jpg', 'Supergoop_Unseen_Sunscreen_SPF_404.jpg', 48, 'listed', 'BidaGlow'),
(250, 'Blue Lizard Australian ', 'Skincare Products', 'Face Mineral-Based Sunscreen\r\nSPF 30+ | 3 oz Tube\r\n', 'Blue Lizard Australian Sunscreen’s mineral-based Face sunscreen is designed for daily wear. The lightweight water gel formula works double duty to protect you from 97% of UV rays while hydrating skin with Hyaluronic Acid and nourishing skin with antioxidants. Our Face sunscreen won’t clog pores, and it contains no parabens or fragrances, making it ideal for sensitive skin. Slip the bottle or tube into your purse or backpack, and with our Smart Bottle and Smart Cap Technology, you’ll always know when harmful UV rays are present. Watch the bottle or cap turn blue in sunlight as a reminder to stay sun safe wherever you go. Blue Lizard Australian Sunscreen has been trusted by dermatologists for over 20 years.', 1222.00, 122, 'Blue_Lizard_Australian_Sunscreen_SPF_30.jpg', 'Blue_Lizard_Australian_Sunscreen_SPF_302.jpg', 'Blue_Lizard_Australian_Sunscreen_SPF_303.jpg', 'Blue_Lizard_Australian_Sunscreen_SPF_304.jpg', 48, 'listed', 'BidaGlow'),
(251, 'Laneige Water Sleeping Mask', 'Skincare Products', 'Water Sleeping MaskBrighten & Hydrate', 'An overnight, hydrating gel mask that quickly absorbs while you sleep to deeply hydrate skin.\r\nCosmopolitan 2024 Reader\'s Choice Beauty Awards Winner\r\n', 2122.00, 111, 'Laneige_Water_Sleeping_Mask.jpg', 'Laneige_Water_Sleeping_Mask2.jpg', 'Laneige_Water_Sleeping_Mask3.jpg', 'Laneige_Water_Sleeping_Mask4.jpg', 48, 'listed', 'BidaGlow'),
(252, 'AZTEC 1LB JAR', 'Skincare Products', 'AZTEC SECRET INDIAN HEALING CLAY is bentonite clay from Death Valley, California, where it is sun- dried for up to six months in temperatures that sometimes reach 134 degrees.', 'Deep pore cleaning with 100% natural calcium bentonite clay\r\nDoes not contain: Additives, fragrances, animal products\r\nImportant Note: Do not leave clay mask on skin longer than 5-10 mins for delicate skin; this will prevent redness/drying\r\nImportant Note 2: Please read and follow all manufacturer directions before using. Slight redness of the skin is normal and will disappear in about 30 minutes after use.\r\n', 1222.00, 111, 'Aztec_Secret_Indian_Healing_Clay.jpg', 'Aztec_Secret_Indian_Healing_Clay2.jpg', 'AZTEC_1LB_JAR.jpg', 'AZTEC_1LB_JAR3.jpg', 48, 'listed', 'BidaGlow'),
(253, 'Glow Recipe Watermelon Glow Sleeping Mask', 'Skincare Products', 'Watermelon Glow AHA Night Treatment', 'A powerful, overnight resurfacing treatment that gently exfoliates, hydrates, and brightens with a 2.5% pH-balanced AHA complex for dramatically smoother, brighter, firmer-looking skin. ', 1444.00, 121, 'Glow_Recipe_Watermelon_Glow_Sleeping_Mask.jpg', 'Glow_Recipe_Watermelon_Glow_Sleeping_Mask2.jpg', 'Glow_Recipe_Watermelon_Glow_Sleeping_Mask3.jpg', 'Glow_Recipe_Watermelon_Glow_Sleeping_Mask.jpg', 48, 'listed', 'BidaGlow'),
(254, 'Fresh Black Tea Instant Perfecting Mask', 'Skincare Products', 'Black Tea Instant Perfecting Mask', 'An ultra-hydrating face mask famous for its cloud-like whipped texture that leaves skin nourished, smooth, and dewy long after you rinse it off', 1888.00, 122, 'Fresh_Black_Tea_Instant_Perfecting_Mask.jpg', 'Fresh_Black_Tea_Instant_Perfecting_Mask2.jpg', 'Fresh_Black_Tea_Instant_Perfecting_Mask3.jpg', 'Fresh_Black_Tea_Instant_Perfecting_Mask4.jpg', 48, 'listed', 'BidaGlow'),
(255, 'GlamGlow Supermud Clearing Treatment', 'Skincare Products', 'Instant Clearing Treatment Mask', 'SUPERMUD® is our most advanced clearing treatment and #1 best-selling charcoal mud mask. Fights problem skin and skin imperfections with charcoal, a blend of six acids, and K-17 clay. The activated-x charcoal helps lift dirt, toxins and excess oil from the deepest and toughest areas to purify pores. The SUPER 6 Acid Blend helps loosen dead skin cells to exfoliate and sweep them away, leaving fresh, smooth skin behind.', 1555.00, 111, 'GlamGlow_Supermud_Clearing_Treatment.jpg', 'GlamGlow_Supermud_Clearing_Treatment2.jpg', 'GlamGlow_Supermud_Clearing_Treatment3.jpg', 'GlamGlow_Supermud_Clearing_Treatment4.jpg', 48, 'listed', 'BidaGlow'),
(256, 'Differin Adapalene Gel ', 'Skincare Products', 'Take a different approach to clearing—and preventing—your acne. Non-comedogenic, fragrance-free Differin® Gel contains the retinoid adapalene, the first over-the-counter active ingredient for acne in more than 30 years. It’s what you and your skin have been waiting for. Use daily. Get consistently clear', '•	Clears acne with the power of Rx, without a prescription needed\r\n•	Prevents breakouts, blackheads, whiteheads, blemishes and clogged pores\r\n•	Restores skin tone and texture by clearing acne\r\n•	Available in 15g (up to 30-day supply) and 45g (up to 90-day supply)\r\n•	Find it in the original tube, and now in an easy-to-use new pump\r\n•	Differin® Gel can be used to effectively treat acne or “maskne” caused by wearing face masks or facial coverings\r\n', 150.00, 122, 'Differin_Adapalene_Gel_0.1_Acne_Treatment.jpg', 'Differin_Adapalene_Gel_0.1_Acne_Treatment2.jpg', 'Differin_Adapalene_Gel_0.1_Acne_Treatment3.jpg', 'Differin_Adapalene_Gel_0.1_Acne_Treatment.jpg', 48, 'listed', 'BidaGlow'),
(257, 'La Roche-Posay Effaclar ', 'Skincare Products', 'EFFACLAR DUO ACNE SPOT TREATMENT', 'Our best spot treatment for acne reduces the number and severity of acne blemishes, pimples, blackheads and whiteheads. Formulated with 5.5% micronized benzoyl peroxide and micro-exfoliating lipo-hydroxy acid, this acne spot treatment provides fast and visible results in less than 3 days.\r\nHow To Apply\r\n', 1343.00, 111, 'La_Roche-Posay_Effaclar_Duo_Dual_Action_Acne_Treatment.jpg', 'La_Roche-Posay_Effaclar_Duo_Dual_Action_Acne_Treatment2.jpg', 'La_Roche-Posay_Effaclar_Duo_Dual_Action_Acne_Treatment3.jpg', 'La_Roche-Posay_Effaclar_Duo_Dual_Action_Acne_Treatment.jpg', 48, 'listed', 'BidaGlow'),
(258, 'Mario Badescu Drying Lotion', 'Skincare Products', 'DRYING LOTION\r\nMario Badescu Drying Lotion is a legendary on-the-spot solution that helps dry up surface blemishes overnight.\r\n', 'This fast-acting, effective spot treatment contains the following highly effective ingredients:\r\n- Salicylic Acid: reduces the appearance of redness of blemishes\r\n- Sulfur: unclog pores\r\n- Zinc Oxide: absorbs excess oil\r\n', 1233.00, 111, 'Mario_Badescu_Drying_Lotion.jpg', 'Mario_Badescu_Drying_Lotion2.jpg', 'Mario_Badescu_Drying_Lotion3.jpg', 'Mario_Badescu_Drying_Lotion.jpg', 48, 'listed', 'BidaGlow'),
(259, 'The Ordinary Azelaic Acid ', 'Skincare Products', 'Azelaic Acid Suspension', 'Azelaic Acid Suspension 10% is a cream-like formula that brightens skin tone and visibly improves skin texture due to a high concentration of azelaic acid—a natural and effective antioxidant found in grains. It has a lower irritation potential than other direct acids, which means it’s gentle enough for daily use as part of your skincare regimen.', 1212.00, 11, 'The_Ordinary_Azelaic_Acid_Suspension_10.jpg', 'The_Ordinary_Azelaic_Acid_Suspension_102.jpg', 'The_Ordinary_Azelaic_Acid_Suspension_103.jpg', 'The_Ordinary_Azelaic_Acid_Suspension_10.jpg', 48, 'listed', 'BidaGlow'),
(260, 'COSRX Acne Pimple Master Patch', 'Skincare Products', 'Acne Pimple Master Patch', 'Hydrocolloid patches that protect wounded or troubled area from getting worse while maintaining humidity of skin to prevent further breakouts.', 115.00, 122, 'COSRX_Acne_Pimple_Master_Patch.jpg', 'COSRX_Acne_Pimple_Master_Patch2.jpg', 'COSRX_Acne_Pimple_Master_Patch3.jpg', 'COSRX_Acne_Pimple_Master_Patch.jpg', 48, 'listed', 'BidaGlow'),
(261, 'Bench Fix Clay Doh', 'Men\'s Grooming', 'Hair Wax in Clay Doh\r\nSKU \r\nTCR1000E\r\n', 'BENCH/ Clay Doh Molding Clay\r\n\r\n- FIX Professional Hairlastic are flexible fibers that create free-forming shapes and styles to your hair.\r\n', 125.00, 111, 'Bench_Fix_Clay_Doh.jpg', 'Bench_Fix_Clay_Doh2.jpg', 'Bench_Fix_Clay_Doh3.jpg', 'Bench_Fix_Clay_Doh.jpg', 48, 'listed', 'BidaGlow'),
(262, 'Baxter of California Clay Pomade', 'Skincare Products', 'Baxter of California Cream Pomade for Men ', 'Natural Finish | Light Hold | Hair Pomade\r\nLight hold, natural finish pomade. Men\'s styling formula helps manage hair without weighing it down.\r\n', 342.00, 22, 'Baxter_of_California_Clay_Pomade.jpg', 'Baxter_of_California_Clay_Pomade2.jpg', 'Baxter_of_California_Clay_Pomade3.jpg', 'Baxter_of_California_Clay_Pomade.jpg', 48, 'listed', 'BidaGlow'),
(263, 'Hairbond Moulder ', 'Men\'s Grooming', 'Hairbond\r\nMoulder Professional Hair Shaper 100ml\r\n', '•	Creates separations with a matte finish.\r\n•	Strong flexible hold gives immediate grab and high density texture while thickening hair\'s appearance.\r\n•	Gives the effect of wax but without the shiny greasy look.\r\n', 150.00, 11, 'Hairbond_Moulder_Professional_Hair_Shaper.jpg', 'Hairbond_Moulder_Professional_Hair_Shaper2.jpg', 'Hairbond_Moulder_Professional_Hair_Shaper3.jpg', 'Hairbond_Moulder_Professional_Hair_Shaper.jpg', 48, 'listed', 'BidaGlow'),
(264, 'Slick Gorilla Hair ', 'Men\'s Grooming', 'Hair Styling Powder Sale price', 'OUR HAIR POWDER IS OUR BESTSELLER FOR A REASON. THE TEXTURISING FORMULA IS LIKE NO ONE ELSE\'S ON THE MARKET.', 165.00, 11, 'Slick_Gorilla_Hair_Styling_Powder.jpg', 'Slick_Gorilla_Hair_Styling_Powder2.jpg', 'Slick_Gorilla_Hair_Styling_Powder3.jpg', 'Slick_Gorilla_Hair_Styling_Powder.jpg', 48, 'listed', 'BidaGlow'),
(265, 'Suavecito Pomade', 'Skincare Products', 'ORIGINAL HOLD POMADE', 'Our awesome smelling water based pomades are made to keep your hair in place for the full day and into the night if need be. They apply effortlessly with their creamy consistency and provide a fierce grip for slickbacks, pompadours, side parts or any hairstyle you need. They wash out with just water and no extra effort leaving your hair feeling just as it did before you put it in.', 175.00, 11, 'Suavecito_Pomade.jpg', 'Suavecito_Pomade2.jpg', 'Suavecito_Pomade3.jpg', 'Suavecito_Pomade.jpg', 48, 'listed', 'BidaGlow'),
(266, 'Master Facial Wash ', 'Men\'s Grooming', 'Master Anti Pimple Facial Scrub helps prevent pimple breakouts with Dermaclear Formula. ', 'It removes deep-seated dirt and excess oil, with anti-bacterial agents to help prevent pimples. With cooling ZEROil, it controls oil for up to 8 hours, and leaves skin feeling cool and refreshed. *Removes excess oil, based on clinical test', 165.00, 11, 'Master_Facial_Wash_Oil_Control_Max.jpg', 'Master_Facial_Wash_Oil_Control_Max1.jpg', 'Master_Facial_Wash_Oil_Control_Max2.jpg', 'Master_Facial_Wash_Oil_Control_Max3.jpg', 48, 'listed', 'BidaGlow'),
(267, 'Nivea Men Oil Control Moisturizer', 'Skincare Products', 'Get ready for nourished and smooth skin with NIVEA Extra Brightening Radiant & Smooth Lotion. ', '8 Super Foods and 40X* Vitamin C will help plump up your skin and give it a radiant glow. Try it now and even out your skin tone!', 165.00, 11, 'Nivea_Men_Oil_Control_Moisturizer5.jpg', 'Nivea_Men_Oil_Control_Moisturizer2.jpg', 'Nivea_Men_Oil_Control_Moisturizer3.jpg', 'Nivea_Men_Oil_Control_Moisturizer4.jpg', 48, 'listed', 'BidaGlow'),
(268, 'Pond\'s Men Energy Charge Face Wash', 'Men\'s Grooming', 'PONDS Men Facial Wash Energy Charge 100gPond?s Men Facial Wash Energy Charge is the men facial wash you need for healthy skin. Pond?s Men understands your need to have a skin care regimen that is uniquely for men and caters to men?s special skin care needs.', 'Thus, Pond?s Energy Charge Men Facial Wash is the Pond?s Men facial wash that can turn your haggard look into the look of energy thanks to its coffee bean extracts that are packed with anti-oxidants to repair your skin?s damage caused by sun exposure.', 531.00, 1222, 'Ponds_Men_Energy_Charge_Face_Wash.jpg', 'Ponds_Men_Energy_Charge_Face_Wash2.jpg', 'Ponds_Men_Energy_Charge_Face_Wash3.jpg', 'Ponds_Men_Energy_Charge_Face_Wash2.jpg', 48, 'listed', 'BidaGlow'),
(269, 'Belo Men Whitening Facial Wash', 'Men\'s Grooming', 'Beauty is for everyone – yes, even men', 'Belo Men Whitening Body Bar is engineered with powerful ingredients to visibly brighten skin. It also contains jojoba beads that easily remove deep-seated dirt while smoothening your skin.', 1422.00, 11, 'Belo_Men_Whitening_Facial_Wash.jpg', 'Belo_Men_Whitening_Facial_Wash2.jpg', 'Belo_Men_Whitening_Facial_Wash22.png', 'Belo_Men_Whitening_Facial_Wash3.jpg', 48, 'listed', 'BidaGlow'),
(270, 'Celeteque Hydration Facial Moisturizer', 'Men\'s Grooming', 'A water-based and oil-free moisturizer with unique hydrogel formula that moisturizes the skin without the greasy after-feel. --With Triple Moisturizing System that contains Glycerin, Pro-Vitamin B5, and Aloe Vera', 'It works deep down to provide lasting relief from skin dryness.\r\n- Dermatologist tested\r\n- Hypoallergenic\r\n- Water-based and oil-free\r\n- Non-comedogenic\r\n- Paraben-free\r\n- Cruelty-free\r\n- Fragance-free\\\r\n', 1323.00, 11, 'Celeteque_Hydration_Facial_Moisturizer2.jpg', 'Celeteque_Hydration_Facial_Moisturizer3.jpg', 'Celeteque_Hydration_Facial_Moisturizer.jpg', 'Celeteque_Hydration_Facial_Moisturizer3.jpg', 48, 'listed', 'BidaGlow'),
(271, 'Dove Men+Care Clean Comfort Body Wash', 'Men\'s Grooming', 'Men+Care Hydrating Clean Comfort Body + Face Wash', 'Dove Men+Care Hydrating Clean Comfort Body + Face Wash is a classic for a reason.\r\nWhile typical soap for men strips away oil and moisture, which can leave your skin feeling dry, flaky or irritated, this gentle body and face wash helps protect against dry skin after showering.\r\n\r\nInfused with plant-based moisturizers, MicroMoisture technology and 50% more skin-strengthening nutrients than our previous formula, our hydrating body wash keeps your skin feeling healthy and smooth with 24-hour continuous nourishment.\r\nJust lather up to nourish skin and enjoy that crisp and refreshing lemon and cedarwood scent. No shower routine is complete without it. \r\n', 156.00, 111, 'Dove_MenCare_Clean_Comfort_Body_Wash.jpg', 'Dove_MenCare_Clean_Comfort_Body_Wash3.jpg', 'Dove_MenCare_Clean_Comfort_Body_Wash2.jpg', 'Dove_MenCare_Clean_Comfort_Body_Wash3.jpg', 48, 'listed', 'BidaGlow'),
(272, 'Nivea Men Body Lotion', 'Men\'s Grooming', 'The non greasy formula enriched with SEA MINERALS AND HYDRA IQ, works with your skin to provide it with burst of hydration for all day defense against dry skin.', 'NIVEA Men Max Hydration Body Lotion provides intensive 24h moisture care for skin prone to dryness. The innovative formula enriched with Aloe Vera, works with your skin to relive the feeling of dryness and provide it with intensive nourishment. This daily moisturiser absorbs in seconds, has no sticky feeling and is suited for normal to dry skin. Skin compatibility dermatologically approved. Use daily for best results.', 533.00, 11, 'Nivea_Men_Body_Lotion.jpg', 'Nivea_Men_Body_Lotion2.jpg', 'Nivea_Men_Body_Lotion2.jpg', 'Nivea_Men_Body_Lotion.jpg', 48, 'listed', 'BidaGlow'),
(273, 'Old Spice High Endurance Deodorant', 'Men\'s Grooming', 'OLD SPICE\r\nHigh Endurance Pure Sport 45g\r\n', 'Old Spice High Endurance Dry Cream in Pure Sport scent gives you 24 hr protection from odor.\r\n\r\nBenefits:\r\n-Overpower even the burliest stink with the original manly deodorant, Old Spice. Smell like a man who knows how to smell manly\r\n-The ultra-manly citrus and clove scent of Old Spice Original is often imitated but never duplicated\r\n-Our High Endurance deodorant for men intensifies your man-smell and prepares you for victory\r\n-Provides 24-hour odor protection so you can climb a mountain, fight off a bear and ride an elevator all in the same day\r\n', 544.00, 22, 'Old_Spice_High_Endurance_Deodorant.jpg', 'Old_Spice_High_Endurance_Deodorant2.jpg', 'Old_Spice_High_Endurance_Deodorant3.jpg', 'Old_Spice_High_Endurance_Deodorant.jpg', 48, 'listed', 'BidaGlow'),
(274, 'Every Man Jack Body Wash', 'Men\'s Grooming', 'Body Wash\r\nOur body wash deep cleans and moisturizes, leaving you smelling fresh and feeling hydrated.', ' We stacked our formula with naturally-derived ingredients like Coconut-Derived Surfactants and Glycerin to give you a classic clean with a rugged, outdoor twist.\r\n', 343.00, 22, 'Every_Man_Jack_Body_Wash.jpg', 'Every_Man_Jack_Body_Wash2.jpg', 'Every_Man_Jack_Body_Wash3.jpg', 'Every_Man_Jack_Body_Wash2.jpg', 48, 'listed', 'BidaGlow'),
(275, 'Molton Brown Re-charge Black Pepper Body Wash', 'Men\'s Grooming', 'Molton Brown Re-Charge Black Pepper Bath & Shower Gel', 'Awaken the senses with our award-winning woody-citrus body; a long-lasting, energising fusion of piquant black pepper, spicy coriander and earthy vetiver.', 265.00, 11, 'Molton_Brown_Re-charge_Black_Pepper_Body_Wash.jpg', 'Molton_Brown_Re-charge_Black_Pepper_Body_Wash2.jpg', 'Molton_Brown_Re-charge_Black_Pepper_Body_Wash3.jpg', 'Molton_Brown_Re-charge_Black_Pepper_Body_Wash.jpg', 48, 'listed', 'BidaGlow'),
(276, 'Dior Sauvage Eau de Toilette', 'Men\'s Grooming', 'Sauvage Eau de Toilette\r\nEau de Toilette - Fresh, Citrus and Woody Notes – Refillable\r\n', 'Sauvage is an act of creation inspired by wide-open spaces. An ozone blue sky that dominates a white-hot rocky landscape. The strong gust of citrus in Sauvage Eau de Toilette is powerfully anchored by the ambery nobleness of ambroxan, resinous elemi and woods.\r\n', 555.00, 22, 'Dior_Sauvage_Eau_de_Toilette.jpg', 'Dior_Sauvage_Eau_de_Toilette2.jpg', 'Dior_Sauvage_Eau_de_Toilette3.jpg', 'Dior_Sauvage_Eau_de_Toilette4.jpg', 48, 'listed', 'BidaGlow'),
(277, 'Tom Ford Noir Extreme', 'Men\'s Grooming', 'Noir Extreme by Tom Ford is a Oriental Woody fragrance for men. Noir Extreme was launched in 2015. The nose behind this fragrance is Sonia Constant. ', 'Top notes are Cardamom, Nutmeg, Saffron, Mandarin Orange and Neroli; middle notes are Kulfi, Rose, Mastic or Lentisque, Orange Blossom and Jasmine; base notes are Vanilla, Amber, Woody Notes and Sandalwood.', 533.00, 22, 'Tom_Ford_Noir_Extreme_2.jpg', 'Tom_Ford_Noir_Extreme_3.jpg', 'Tom_Ford_Noir_Extreme.jpg', 'Tom_Ford_Noir_Extreme_2.jpg', 48, 'listed', 'BidaGlow'),
(278, 'Creed Aventus', 'Men\'s Grooming', 'Aventus\r\nDry Woods, Fresh, Citrus & Fruity\r\n', 'Audacious, confident and powerful, this signature fragrance from The House of Creed has been delicately crafted to create a true contemporary classic.', 521.00, 111, 'Creed_Aventus.jpg', 'Creed_Aventus2.jpg', 'Creed_Aventus3.jpg', 'Creed_Aventus.jpg', 48, 'listed', 'BidaGlow'),
(279, 'Giorgio Armani Acqua Di Gio', 'Men\'s Grooming', 'GIORGIO ARMANI\r\nAcqua Di Giò Homme by Giorgio Armani\r\n', 'Acqua Di Giò opens with a splash of fresh, Calabrian bergamot, neroli, and green tangerine. Light, aquatic nuances mix with rosemary, sweet persimmon, and warm Indonesian patchouli to create a fresh cologne for men.\r\nIt is a fresh and aquatic fragrance that captures the full power of the sea in an iconic glass bottle, in crystal and frosted transparent glass.\r\n', 766.00, 22, 'Giorgio_Armani_Acqua_Di_Gio.jpg', 'Giorgio_Armani_Acqua_Di_Gio2.jpg', 'Giorgio_Armani_Acqua_Di_Gio3.jpg', 'Giorgio_Armani_Acqua_Di_Gio4.jpg', 48, 'listed', 'BidaGlow'),
(280, 'BLEU DE CHANEL', 'Men\'s Grooming', 'Unexpected and undeniably bold. Fresh, clean and profoundly sensual, the woody, aromatic fragrance reveals the spirit of a man who chooses his own destiny with independence and determination—a man who defies convention.', 'The fragrance features a fresh citrus accord followed by ambery cedar. Woody notes are amplified by tonka bean and vanilla for heightened sensuality. New Caledonian sandalwood unfolds at the base for greater depth, leaving a captivating trail.', 599.00, 444, 'Bleu_de_Chanel.jpg', 'Bleu_de_Chanel2.jpg', 'Bleu_de_Chanel3.jpg', 'Bleu_de_Chanel4.jpg', 48, 'listed', 'BidaGlow'),
(281, 'Degree Men Cool Rush Antiperspirant', 'Men\'s Grooming', 'Degree, 48 Hour Antiperspirant Deodorant, Cool Comfort, 2.7 oz (76 g)', 'Degree Men Cool Comfort Antiperspirant Deodorant delivers 48-hour sweat and odor protection to keep you feeling dry and fresh. This antiperspirant deodorant for men works as hard as you do and offers 48-hour protection, so you can take on the day.\r\nOur Cool Comfort Antiperspirant Deodorant features a smooth, energizing citrus scent to keep you feeling fresh. This powerful antiperspirant deodorant responds when you need it most, so you can ', 532.00, 22, 'Degree_Men_Cool_Rush_Antiperspirant.jpg', 'Degree_Men_Cool_Rush_Antiperspirant2.jpg', 'Degree_Men_Cool_Rush_Antiperspirant3.jpg', 'Degree_Men_Cool_Rush_Antiperspirant.jpg', 48, 'listed', 'BidaGlow'),
(282, 'Nivea Men Invisible Black & White', 'Men\'s Grooming', 'NIVEA\r\nNIVEA Men Deodorant Black & White Original Anti-Perspirant Roll-on 25ml\r\n', 'NIVEA MEN Black & White Original Deodorant Roll On offers white mark protection on black clothes and anti-yellow staining on white clothes, thanks to its unique formula with no Ethyl Alcohol, while providing you reliable 48-hour protection from sweat and odor. It is also anti-bacterial, leaving your skin feeling clean and fresh. This anti-perspirant deodorant for men does not irritate and is gentle on skin with its skin tolerance dermatologically-proven.', 655.00, 11, 'Nivea_Men_Invisible_Black__White.jpg', 'Nivea_Men_Invisible_Black__White2.jpg', 'Nivea_Men_Invisible_Black__White3.jpg', 'Nivea_Men_Invisible_Black__White3.jpg', 48, 'listed', 'BidaGlow'),
(283, 'Old Spice Aluminum ', 'Skincare Products', 'for Men, High Endurance Sport Scent, 24/7 Odor Protection, 3 oz', 'Old Spice High Endurance Sport brings superior protection power to a higher level with a new formula for generating greatness. High Endurance for men confidently delivers 48 proven hours of odor protection. Because it goes on clear, it reduces those annoying white marks on clothes. High endurance is formulated to keep you smelling great with a longer-lasting scent. So when you stand out in a crowd, it\'s because of how good you smell. Old Spice is a good offense without smelling offensive. Grab Old Spice today, because anything less than Old Spice isn\'t Old Spice.', 532.00, 22, 'Old_Spice_Deodorant.jpg', 'Old_Spice_Deodorant2.jpg', 'Old_Spice_Deodorant2.jpg', 'Old_Spice_Deodorant.jpg', 48, 'listed', 'BidaGlow'),
(284, 'Gillette Clinical Strength Antiperspirant', 'Men\'s Grooming', 'Gillette Men’s Clinical Strength Antiperspirant and Deodorant, 72-Hour Sweat Protection, #1 Clinical Brand for Men, Soft Solid, Ultimate Fresh Scent, 1.7 oz\r\nGillette antiperspirant and deodorant for men has one singular-focused goal, and that is to deliver the best a man can get, one swipe at a time. ', 'Precision-formulated, Gillette Clinical Protection soft solid antiperspirant and deodorant provides all day fast-acting sweat protection. Gillette Clinical soft solid is highlighted by a fresh, subtle scent that goes easy on your senses. Engineered with skin care conditioning ingredients, Gillette Clinical soft solid goes on smooth. Gillette provides the protection you need, so you can be the best man you can be.', 111.00, 111, 'Gillette_Clinical_Strength_Antiperspirant.jpg', 'Gillette_Clinical_Strength_Antiperspirant2.jpg', 'Gillette_Clinical_Strength_Antiperspirant3.jpg', 'Gillette_Clinical_Strength_Antiperspirant.jpg', 48, 'listed', 'BidaGlow'),
(285, 'Every Man Jack Deodorant', 'Men\'s Grooming', 'Every Man Jack, Deodorant, Aluminum Free, Sea Salt, 2.7 oz (76.5 g)', '•	No Propylene Glycol\r\n•	No Baking Soda\r\n•	98% Naturally Derived\r\n•	100% Aluminum Free\r\n•	100% Cruelty Free\r\n•	100% Gluten Free\r\n•	100% Vegan\r\nProtect.\r\nGet long-lasting protection with our naturally derived deodorant made with corn-derived propanediol. Coconut Oil helps rejuvenate and moisturize skin. Sea Mineral and Citron fragrance, with essential oils of Bergamot and Rosemary, refreshes.\r\n', 522.00, 22, 'Every_Man_Jack_Deodorant.jpg', 'Every_Man_Jack_Deodorant2.jpg', 'Every_Man_Jack_Deodorant2.jpg', 'Every_Man_Jack_Deodorant.jpg', 48, 'listed', 'BidaGlow'),
(286, 'Fenty Beauty Pro Filt\'r Soft Matte Longwear Foundation', 'Makeup & Cosmetics', 'Buildable, soft matte finish for all-day wear.  ', 'Lightweight and highly pigmented, this foundation offers a smooth, soft matte finish. Available in a wide range of shades for all skin tones, it provides great coverage and long-lasting wear.  ', 234.00, 22, 'fenty2.jpg', 'fenty1.jpg', 'febty3.jpg', 'febty34.jpg', 48, 'listed', 'BidaGlow'),
(287, 'Maybelline Fit Me Matte + Poreless Foundation', 'Makeup & Cosmetics', 'Matte finish that minimizes pores.  ', ':** Ideal for normal to oily skin, this foundation gives a natural matte finish while minimizing the appearance of pores. It offers a seamless, shine-free look that lasts throughout the day.  ', 432.00, 22, 'Maybelline_Fit_Me_Matte__Poreless_Foundation.jpg', 'Maybelline_Fit_Me_Matte__Poreless_Foundation2.jpg', 'maybeline1.jpg', 'maybeline2.jpg', 48, 'listed', 'BidaGlow'),
(288, 'L\'Oreal Infallible Pro-Matte Foundation', 'Makeup & Cosmetics', 'Long-wearing, lightweight matte formula.  ', 'This foundation offers up to 24 hours of wear with a comfortable matte finish. It controls oil and provides smooth, buildable coverage that feels lightweight on the skin.  ', 655.00, 11, 'LOreal_Infallible_Pro-Matte_Foundation.jpg', 'loriel1.jpg', 'LOreal_Infallible_Pro-Matte_Foundation.jpg', 'loriel2.jpg', 48, 'listed', 'BidaGlow'),
(289, 'Tarte Shape Tape Concealer', 'Makeup & Cosmetics', 'Full-coverage, creamy concealer for under-eye brightness.  ', ':** A fan-favorite, this full-coverage concealer covers dark circles, blemishes, and redness with ease. Its creamy formula brightens and smooths the under-eye area while providing long-lasting wear.  ', 123.00, 111, 'tarte1.jpg', 'tarte2.jpg', 'tarte3.jpg', 'tarte1.jpg', 48, 'listed', 'BidaGlow'),
(290, 'NARS Radiant Creamy Concealer', 'Makeup & Cosmetics', 'Creamy, buildable concealer with a radiant finish.  ', 'This versatile concealer provides medium-to-full coverage and a radiant finish. It’s infused with skincare ingredients and works beautifully to cover blemishes and dark circles.  ', 144.00, 111, 'nars1.jpg', 'nars2.jpg', 'nars3.jpg', 'nars1.jpg', 48, 'listed', 'BidaGlow'),
(291, 'Maybelline Instant Age', 'Skincare Products', 'Lightweight formula with sponge applicator', 'A lightweight concealer designed to brighten and smooth under-eye areas. The unique sponge applicator makes it easy to blend, giving a natural, refreshed look.  ', 655.00, 22, 'maybeline1.jpg', 'maybeline2.jpg', 'maybeline3.jpg', 'maybeline1.jpg', 48, 'listed', 'BidaGlow'),
(292, 'NARS Blush in Orgasm', 'Makeup & Cosmetics', 'Iconic peachy-pink blush with golden shimmer.  ', 'A cult-favorite blush with a peachy-pink shade and a golden shimmer that adds a natural flush to the cheeks. Works beautifully for various skin tones.  ', 141.00, 11, 'nars1.jpg', 'nars2.jpg', 'nars3.jpg', 'nars2.jpg', 48, 'listed', 'BidaGlow'),
(293, 'Milani Baked Blush in Luminoso', 'Makeup & Cosmetics', 'Radiant peach blush with a buildable formula.  ', 'A baked blush that delivers a radiant, glowing finish. The warm peach shade is flattering on all skin tones, and it can be built up for a custom intensity.  ', 654.00, 22, 'milani2.jpg', 'milani3.jpg', 'milani1.jpg', 'Milani_Baked_Blush_in_Luminoso.jpg', 48, 'listed', 'BidaGlow'),
(294, 'Tarte Amazonian Clay 12-Hour Blush', 'Makeup & Cosmetics', 'Long-wearing blush with Amazonian clay.  ', 'Infused with Amazonian clay, this blush lasts for up to 12 hours. It gives a natural-looking flush to the cheeks and is available in a variety of shades to suit every skin tone.  ', 634.00, 223, 'tarte1.jpg', 'tarte2.jpg', 'tarte3.jpg', 'tarte2.jpg', 48, 'listed', 'BidaGlow'),
(295, 'Becca Shimmering Skin Perfector', 'Makeup & Cosmetics', 'Liquid highlighter for a natural glow.  ', 'This liquid highlighter gives a luminous, natural-looking glow to the skin. It can be used alone or mixed with foundation to enhance your complexion.  ', 322.00, 12, 'Becca_Shimmering_Skin_Perfector.jpg', 'becca2.jpg', 'Becca_Shimmering_Skin_Perfector2.jpg', 'becca1.jpg', 48, 'listed', 'BidaGlow'),
(296, 'The Balm Mary-Lou Manizer', 'Makeup & Cosmetics', 'Versatile, golden highlighter with a radiant finish.  ', 'This golden highlighter can be used on the cheeks, brow bones, and inner corners of the eyes. It offers a warm, radiant glow that enhances any makeup look.  ', 546.00, 232, 'merit2.jpg', 'merit2.jpg', 'merit3.jpg', 'merit1.jpg', 48, 'listed', 'BidaGlow'),
(297, 'Anastasia Beverly Hills Amrezy Highlighter', 'Makeup & Cosmetics', 'Intense luminosity with a smooth application.  ', 'This highlighter offers an intense, reflective glow. Its champagne gold shade is flattering on a variety of skin tones, giving a stunning, radiant finish.  ', 654.00, 32, 'anastasia1.jpg', 'anastasia2.jpg', 'anastasia3.jpg', 'anastasia1.jpg', 48, 'listed', 'BidaGlow'),
(298, 'MAC Lipstick in Ruby Woo', 'Makeup & Cosmetics', 'Iconic red lipstick with a matte finish.  ', 'A classic red lipstick with a retro matte finish. Ruby Woo is known for its rich color and long-lasting wear, flattering a wide range of skin tones.  ', 244.00, 223, 'mac1.jpg', 'mac2.jpg', 'mac3.jpg', 'mac1.jpg', 48, 'listed', 'BidaGlow'),
(299, 'Maybelline SuperStay Matte Ink Liquid Lipstick', 'Makeup & Cosmetics', 'Long-wearing liquid lipstick with intense color.  ', 'This liquid lipstick offers intense color payoff with a matte finish. Known for its longevity, it lasts up to 16 hours without fading or transferring.  ', 346.00, 34, 'maybeline1.jpg', 'maybeline2.jpg', 'maybeline3.jpg', 'maybeline2.jpg', 48, 'listed', 'BidaGlow');
INSERT INTO `seller_add_product` (`id`, `product_name`, `category`, `mini_description`, `main_description`, `price`, `stock_quantity`, `product_image`, `sub_image_1`, `sub_image_2`, `sub_image_3`, `seller_id`, `product_status`, `business_name`) VALUES
(300, 'Charlotte Tilbury Matte Revolution Lipstick in Pillow Talk', 'Makeup & Cosmetics', 'Creamy nude-pink lipstick for everyday wear.  ', 'A creamy, comfortable matte lipstick that enhances the natural color of your lips. Pillow Talk is an iconic nude-pink shade perfect for day-to-day wear.  ', 3224.00, 23, 'tilbury3.jpg', 'tilbury1.jpg', 'tilbury2.jpg', 'tilbury3.jpg', 48, 'listed', 'BidaGlow'),
(301, 'Urban Decay All Nighter Setting Spray', 'Makeup & Cosmetics', 'Long-lasting setting spray for 16-hour wear.  ', 'This cult-favorite setting spray locks makeup in place for up to 16 hours controlling shine and keeping makeup fresh all day.  \r\n', 523.00, 22, 'urban3.jpg', 'urban2.jpg', 'urban1.jpg', 'urban3.jpg', 48, 'listed', 'BidaGlow'),
(302, 'e.l.f. Matte Magic Mist & Set', 'Makeup & Cosmetics', 'Affordable setting spray with a matte finish.  ', 'This affordable setting spray helps to keep makeup in place while providing a matte finish, ideal for oily skin types.  ', 534.00, 22, 'elf1.jpg', 'elf3.jpg', 'elf2.jpg', 'elf1.jpg', 48, 'listed', 'BidaGlow'),
(303, 'Mac Prep + Prime Fix+**  ', 'Makeup & Cosmetics', 'Versatile spray that hydrates and sets makeup.  ', 'A hydrating mist that sets makeup and enhances its longevity. It can also intensify the pigment of eyeshadows when sprayed directly onto brushes.  ', 654.00, 22, 'fix2.jpg', 'fix2.jpg', 'fix3.jpg', 'fix1.jpg', 48, 'listed', 'BidaGlow'),
(304, 'Bose QuietComfort 45 Noise Cancelling Headphones', 'Personal Care Appliances', 'Over-ear headphones that provide noise cancellation for better focus and relaxation.', 'Ideal for anyone needing a calm environment to focus or relax, these headphones block out ambient noise and deliver high-quality sound for music, podcasts, or calls.', 6444.00, 122, 'cq5da92020.jpeg', 'cq5dam.web.320.320.png', 's-l1200.jpg', 'cq5da92020.jpeg', 48, 'listed', 'BidaGlow'),
(305, 'Revlon One-Step Hair Dryer & Volumizer', 'Skincare Products', 'A hot air brush that combines drying and styling in one tool for healthy, shiny hair.', 'This hair tool simplifies your routine by drying and styling your hair simultaneously, reducing heat damage and delivering a smooth, voluminous finish.', 544.00, 33, '51MtdcVsRZL._UL500_.jpg', 'images_1.jpg', 'images.jpg', 'images_1.jpg', 48, 'listed', 'BidaGlow'),
(306, 'iHealth Thermometer', 'Personal Care Appliances', 'A contactless infrared thermometer for quick and accurate temperature readings.', 'This digital thermometer is perfect for families, providing a fast and non-invasive way to check temperatures for all ages.', 6555.00, 23, '1c0e1d45c698d34d86e1a32544889932.jpg', '51lYa92EldL._AC_UL210_SR210210_.jpg', 'images.jpg', '1c0e1d45c698d34d86e1a32544889932.jpg', 48, 'listed', 'BidaGlow'),
(307, 'Philips Sonicare AirFloss Ultra', 'Personal Care Appliances', 'A flossing device that uses air and microdroplets to clean between teeth.', 'This air flossing device makes it easier for individuals who struggle with traditional flossing to maintain good oral hygiene.', 6555.00, 23, 'images_1.jpg', 'images_2.jpg', 'images.jpg', 'images_1.jpg', 48, 'listed', 'BidaGlow'),
(308, 'Honeywell QuietClean Tower Air Purifier', 'Personal Care Appliances', 'A compact air purifier designed for medium to large rooms, reducing allergens and odors.', 'The Honeywell QuietClean Tower Air Purifier is ideal for those who want to breathe cleaner air at home, capturing dust, pollen, and other airborne particles.', 2355.00, 232, '41BkMJsPQgL._AC_UF8941000_QL80_.jpg', 'HFD-110-1.jpg', 'images_3.jpg', 'images_3.jpg', 48, 'listed', 'BidaGlow'),
(309, 'Citracal Calcium + D3', 'Health Supplements', 'CITRACAL® MAXIMUM', '•	650 mg of calcium per serving in the form of calcium citrate to help support bone health*\r\n•	25 mcg (1000 IU) of Vitamin D3 per serving to help your body absorb calcium*\r\n•	Essential micronutrients to support bone health: Contains zinc, copper and manganese*\r\n•	Easily absorbed\r\n•	Gentle on your digestive system\r\n•	Can be taken with or without food\r\n•	Adults and children 12 years of age and older\r\n', 655.00, 22, 'Citracal_Calcium__D3.jpg', 'Citracal_Calcium__D32.jpg', 'Citracal_Calcium__D33.jpg', 'Citracal_Calcium__D34.jpg', 48, 'listed', 'BidaGlow'),
(310, 'Bonakid Pre-School 3+', 'Health Supplements', 'BONAKID PRE-SCHOOL® 3+ \r\n| Wyeth Nutrition\r\n', 'BONAKID PRE-SCHOOL® 3+ is a powdered milk drink with Triple Boost Formula which is specially designed with immunity, growth and energy nutrients to help support the nutritional needs of children 3+', 6433.00, 213, 'Bonakid_Pre-School_3.jpg', 'Bonakid_Pre-School_32.jpg', 'Bonakid_Pre-School_33.jpg', 'Bonakid_Pre-School_34.jpg', 48, 'listed', 'BidaGlow'),
(311, 'Caltrate Plus', 'Health Supplements', 'ImmunPro®\r\nFor increased body resistance and enhanced immune system\r\n', 'ImmunPro® contains a formula of vitamin C and zinc that may help strengthen your immune system to better protect your body against diseases. It also has a ZincPlus Tablet Technology that ensures a stabilized combination and absorption of vitamin C and zinc.', 3232.00, 121, 'Caltrate_Plus.jpg', 'caltrate_plus2.jpg', 'Caltrate_Plus3.jpg', 'Caltrate_Plus.jpg', 48, 'listed', 'BidaGlow'),
(312, 'Anlene Gold 5X', 'Health Supplements', 'As we age, moving might feel harder. Our bones, joints and muscles may become weaker and affect our strength and flexibility to perform daily activities.\r\n\r\n', 'Anlene Gold 5X is scientifically formulated with 100% Calcium & Vitamin D, High Protein, Collagen, MFGM Active and 17 Vitamins & Minerals.\r\nNow available in 2 new delicious flavours - Café Latte & Dark Choc!\r\nLet’s support our bones, joints, muscles, strength & flexibility today!\r\n', 5235.00, 22, 'Anlene_Gold_5X.jpg', 'Anlene_Gold_5X2.jpg', 'Anlene_Gold_5X3.jpg', 'Anlene_Gold_5X3.jpg', 48, 'listed', 'BidaGlow'),
(313, 'Osteocare Calcium Magnesium', 'Health Supplements', 'Osteocare Original', 'The UK’s No.1 calcium formula for women and men of all ages. Developed on the basis of the very latest research to provide a rich source of calcium and co-factors including vitamin D.', 523.00, 22, 'Osteocare_Calcium_Magnesium.jpg', 'Osteocare_Calcium_Magnesium2.png', 'Osteocare_Calcium_Magnesium3.jpg', 'Osteocare_Calcium_Magnesium.jpg', 48, 'listed', 'BidaGlow'),
(314, 'Kirkland Signature Fish Oil', 'Health Supplements', 'Kirkland Signature Fish Oil 1000 mg, 400 Softgels (2 Pack)', 'Taking Kirkland Signature Omega-3 Fish Oil is a convenient, easy, natural way to help support your heart health.? Kirkland Signature Fish Oil supply comes from deep ocean water fish - not farm-raised fish. State-of-the-art purification processes are used to remove mercury', 6445.00, 43, 'Kirkland_Signature_Fish_Oil23.jpg', 'Kirkland_Signature_Fish_Oil4.jpg', 'Kirkland_Signature_Fish_Oil2.jpg', 'Kirkland_Signature_Fish_Oil.jpg', 48, 'listed', 'BidaGlow'),
(315, 'Puritan’s Pride Omega-3 Fish Oil', 'Health Supplements', 'NOW Foods, Omega-3 Fish Oil, 1000 mg, 30 Softgels (1,000 mg per Softgel)', 'Supportive but not conclusive research shows that consumption of EPA and DHA omega-3 fatty acids may reduce the risk of coronary heart disease.\r\nThis fish oil concentrate is manufactured under strict quality control standards. It is tested to be free of potentially harmful levels of contaminants such as PCBs, dioxins, mercury and other heavy metals.\r\n', 6343.00, 32, 'Puritans_Pride_Omega-3_Fish_Oil.jpg', 'Puritans_Pride_Omega-3_Fish_Oil3.jpg', 'Puritans_Pride_Omega-3_Fish_Oil2.jpg', 'Puritans_Pride_Omega-3_Fish_Oil.jpg', 48, 'listed', 'BidaGlow'),
(316, 'Blackmores Omega Daily', 'Health Supplements', 'Omega Daily', 'Each capsules contains double the Omega-3 fatty acid (600 mg EPA & DHA) for enhanced protection to brain, eye and heart health', 634.00, 32, 'Blackmores_Omega_Daily2.jpg', 'Blackmores_Omega_Daily3.jpg', 'Blackmores_Omega_Daily4.jpg', 'Blackmores_Omega_Daily2.jpg', 48, 'listed', 'BidaGlow'),
(317, 'Nature Made Fish Oil', 'Health Supplements', 'Nature Made Fish Oil 1200 mg Softgels, Fish Oil Supplements, Omega 3 Fish Oil for Healthy Heart Support, Omega 3 Supplement with 230 Softgels, 115 Day Supply', 'Nature Made Fish Oil 1200 mg is a dietary supplement that provides 360 mg Omega-3 fatty acids per softgel to help support a healthy heart. A serving of two Nature Made Omega 3 Fish Oil 1200 mg softgels provides 2400 mg Fish Oil with 720 mg Omega 3s (600 mg EPA and DHA). Sourced from high quality ingredients, these gluten free Nature Made Fish Oil 1200 mg 360 mg Omega-3 supplements have no color added and no artificial flavors. These Fish Oil supplements for women and men are purified to remove mercury (2) from wild-caught ocean fish, not farm-', 523.00, 223, 'Nature_Made_Fish_Oila.jpg', 'Nature_Made_Fish_Oila.jpg', 'Nature_Made_Fish_Oild.jpg', 'Nature_Made_Fish_Oilf.jpg', 48, 'listed', 'BidaGlow'),
(318, 'Nordic Naturals Ultimate Omega', 'Health Supplements', 'Nordic Naturals Ultimate Omega, Lemon Flavor - 210 Soft Gels - 1280 mg Omega-3 - High-Potency Omega-3 Fish Oil with EPA & DHA - Promotes Brain & Heart Health - Non-GMO - 105 Servings', 'The Ultimate Omega-3 Fish Oil\r\nUltimate Omega products deliver outrageously fresh, pure, and effective concentrated omega-3 fish oil to support the heart, brain, and immune system at the cellular level.* Choose from soft gels, mini soft gels, liquid, and tasty gummy chews.\r\n', 6346.00, 32, 'Nordic_Naturals_Ultimate_Omega12.jpg', 'Nordic_Naturals_Ultimate_Omega13.jpg', 'Nordic_Naturals_Ultimate_Omega14.jpg', 'Nordic_Naturals_Ultimate_Omega5.jpg', 48, 'listed', 'BidaGlow'),
(319, 'Yakult Probiotic Drink', 'Health Supplements', 'Yakult is a delicious probiotic drink with a refreshing citrus taste that can be enjoyed by the whole family.\r\nMillions of people around the world drinks Yakult every day.\r\n', 'Yakult Original\r\n•	Contains 50 calories per bottle and 10 grams of sugar.\r\n•	No Fat. No Gluten. No Cholesterol\r\n', 500.00, 212, 'Yakult_Probiotic_Drink.jpg', 'Yakult_Probiotic_Drink2.jpg', 'Yakult_Probiotic_Drink3.jpg', 'Yakult_Probiotic_Drink4.jpg', 48, 'listed', 'BidaGlow'),
(320, 'Erceflora ProbiBears', 'Health Supplements', 'Erceflora® Gut Defense\r\n\r\nAdult / Children\r\nTreatment\r\n', 'A ready-to-drink vial containing 2 billion Bacillus clausii Intelli-spores® that are favorable to the enhancement of intestinal bacterial flora, preventing symptoms of gut imbalance, including diarrhea.', 6523.00, 23, 'Erceflora_ProbiBears.jpg', 'Erceflora_ProbiBears2.jpg', 'Erceflora_ProbiBears3.jpg', 'Erceflora_ProbiBears.jpg', 48, 'listed', 'BidaGlow'),
(321, 'Culturelle Daily Probiotic', 'Health Supplements', 'Culturelle Bloating & Gas Defense, Digestive Enzymes & Probiotics for Digestive Health, 30 Capsules, Supports Occasional Indigestion & Discomfort', 'Culturelle Bloating & Gas Defense, Digestive Enzymes & Probiotics for Digestive Health, Supports Occasional Indigestion & Discomfort* Experience relief from digestive discomfort with Culturelle Bloating & Gas Defense, a powerful probiotic and digestive enzyme supplement. This unique formula works in harmony with your body to naturally alleviate occasional bloating, gas and digestive discomfort. Powered by the #1 clinically studied probiotic, Lactobacillus Rhamnosus ', 643.00, 23, 'Culturelle_Daily_Probiotic.jpg', 'Culturelle_Daily_Probiotic2.jpg', 'Culturelle_Daily_Probiotic3.jpg', 'Culturelle_Daily_Probiotic.jpg', 48, 'listed', 'BidaGlow'),
(322, 'Florajen Probiotics', 'Health Supplements', 'Florajen Digestion Probiotics, Gut Health Supplement with Constipation and Bloating Relief for Adults, 60 Count (Refrigerated)', 'Floragen Digestion is a multiculture blend of probiotic strains that aid in the healthy functioning of the digestive tract. It naturally regulates the digestive system and provides increased levels of healthy bacteria in the gut. FLORAJEN PROBIOTICS help restore the good flora and maintain the natural balance the body needs to stay healthy. Bacteriologists founded Florajen over 25 years ago with the intent of providing safe, effective and affordable options to help people avoid unpleasant antibiotic side effects and maintain everyday health. Florajen guarantees potency and consistency of our probiotics due to our Cold Chain Commitment meaning that from the time our probiotics are manufactured and delivered to you, Florajen is kept cold. ', 532.00, 12, 'Florajen_Probiotics2.jpg', 'Florajen_Probiotics.jpg', 'Florajen_Probiotics_3.jpg', 'Florajen_Probiotics_2.jpg', 48, 'listed', 'BidaGlow'),
(323, 'Nexabiotic Probiotics', 'Health Supplements', 'DrFormulas\' Best Probiotics for Women & Men | Nexabiotic Multi Probiotic with Saccharomyces Boulardii, Lactobacillus Acidophilus, B. infantis, Prebiotic 60 Count Capsules (Not Pearls)', '- Doctor researched and formulated.\r\n\r\n- Features probiotic strains studied and published in peer-reviewed scientific journals.\r\n\r\n- Utilizes one of a kind acid resistant capsules that are more effective than pearls, enteric coated capsules, and powders!\r\n\r\nNexabiotic helps support:\r\n\r\nGastrointestinal Health\r\nImmune Health\r\nSkin Health\r\nMood\r\nAnd much more!\r\n', 6222.00, 32, 'Nexabiotic_Probiotics4.jpg', 'Nexabiotic_Probiotics5.jpg', 'Nexabiotic_Probiotics5.jpg', 'Nexabiotic_Probiotics4.jpg', 48, 'listed', 'BidaGlow'),
(324, 'Conzace Multivitamins', 'Health Supplements', 'Conzace®\r\nProven to help promote immunity, healthy skin and hair\r\n', 'Conzace® has the highest levels of Zinc, Vitamins A, C, and E-proven to help immunity & the looks, like no other. This superior formulation combines all the molecules needed to give you healthy skin & hair. It also helps strengthen the immune system by 140% more vs. no supplementation.', 325.00, 23, 'conzace_multivitamins.jpg', 'conzace_multivitamins2.jpg', 'conzace_multivitamins3.jpg', 'conzace_multivitamins.jpg', 48, 'listed', 'BidaGlow'),
(325, 'Neurobion ', 'Health Supplements', 'Vitamins B1 + B6 + B12\r\nFor relief from tusok-tusok (tingling) and pamamanhid (numbness)\r\n', 'Vitamins B1+B6+B12 (NEUROBION® FORTE) contains an optimal combination of nerve nourishing B vitamins for relief from neuropathy symptoms, helps treat nerve damage and regenerates the nerves with proper diet and exercise. ¹', 532.00, 12, 'Neurobion_Provides_B.jpg', 'Neurobion_Provides_B3.jpg', 'Neurobion_Provides_B2.jpg', 'Neurobion_Provides_B4.jpg', 48, 'listed', 'BidaGlow'),
(326, 'Moringa Malunggay Capsule', 'Health Supplements', 'MORINGA Oleifera Malunggay Capsule 500mg Capsule 1\'s', 'Indication\r\nAs supplement to help increase the natural flow of milk needed by breastfeeding mothers for their babies. Helps boost the immune system.\r\n', 643.00, 123, 'Moringa_Malunggay_Capsule.jpg', 'Moringa_Malunggay_Capsule2.jpg', 'Moringa_Malunggay_Capsule2.jpg', 'Moringa_Malunggay_Capsule.jpg', 48, 'listed', 'BidaGlow');

-- --------------------------------------------------------

--
-- Table structure for table `seller_unlisted_products`
--

CREATE TABLE `seller_unlisted_products` (
  `id` int(11) NOT NULL,
  `product_name` varchar(255) DEFAULT NULL,
  `category` varchar(255) NOT NULL,
  `mini_description` text DEFAULT NULL,
  `main_description` text DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `stock_quantity` int(11) DEFAULT NULL,
  `product_image` varchar(255) DEFAULT NULL,
  `sub_image_1` varchar(255) DEFAULT NULL,
  `sub_image_2` varchar(255) DEFAULT NULL,
  `sub_image_3` varchar(255) DEFAULT NULL,
  `seller_id` int(11) DEFAULT NULL,
  `product_status` varchar(50) DEFAULT NULL,
  `business_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `seller_unlisted_products`
--

INSERT INTO `seller_unlisted_products` (`id`, `product_name`, `category`, `mini_description`, `main_description`, `price`, `stock_quantity`, `product_image`, `sub_image_1`, `sub_image_2`, `sub_image_3`, `seller_id`, `product_status`, `business_name`) VALUES
(129, 'Clear', 'Men\'s Grooming', 'CLEAR Men Anti Dandruff Shampoo Cool Sport Menthol Buy 1 Get 2nd Bottle At 50% Off 170ML', 'CLEAR MEN COOL SPORT MENTHOL SHAMPOO - Engineered specially for men, Clear Cool Sport Menthol Shampoo has TRIPLE ANTI-DANDRUFF TECHNOLOGY plus TAURINE AND VITAMIN B3 that effectively removes up to 100% of dandruff (*No visible flakes seen with regular use) and provides 24 hour freshness with its INTENSE COOLING POWER. With regular product use, Clear removes dandruff and prevents it from coming back.', 285.00, 101, 'CLEAR.jpg', 'CLEAR2.jpg', 'clear3.jpg', 'clear4.jpg', 30, 'unlisted', 'Beautique Shop'),
(193, ' Hydra Dildo - 5 Inches - Dildo', 'Personal Care Appliances', 'Practice your sensual moves and let the wet and wild sessions begin with the DAKILA Hydra Dildo 5 Inches! This beast works with new and experienced players, featuring a ribbed shaft, suction base, and tapered tip.', 'Introducing The Smooth Operator—because sometimes, you just need a little more than your regular Netflix and chill. This bad boy isn’t just a toy, it’s an experience. Crafted with premium, body-safe silicone, it’s smoother than your last pick-up line and harder than... well, let’s not get carried away.\r\n\r\nWith its perfectly curved design, it knows exactly where to go—no GPS needed. Whether you\'re exploring solo or inviting a partner to join the fun, The Smooth Operator is always down for the adventure. It features multiple vibration settings, from “gentle purr” to “I can’t believe this is happening,” so you can tailor your experience to your mood—because who doesn\'t love options?\r\n\r\nWaterproof? Check. Easy to clean? Double check. Sleek and discreet enough to hide in your drawer... unless you want to display it as the conversation starter it clearly is.\r\n\r\nPerfect for beginners, experts, or anyone who just wants to add a little vroom-vroom to their life, The Smooth Operator is here to make sure you never look at your bedside table the same way again.', 399.00, 99, 'dildo_1.jpg', 'dildo_2.jpg', 'dildo_3.jpg', 'dildo_4.jpg', 30, 'unlisted', 'Beautique Shop'),
(194, 'Malupitons', 'Health Supplements', 'asasfad', 'sdfsdfsdf', 12.00, 20, 'lupity.jpg', 'lupity.jpg', 'lupity.jpg', 'lupity.jpg', 48, 'unlisted', 'BidaGlow'),
(216, 'Keurig K-Elite Coffee Maker', 'Personal Care Appliances', ' A single-serve coffee maker with strong brew options and iced coffee settings.', 'Ideal for coffee lovers, this Keurig machine allows you to brew coffee quickly with options for a stronger brew or refreshing iced coffee.', 1450.00, 111, 'cuisinart-food-processor-7-cup-o.jpg', 'images_3.jpg', 'images.jpg', 'Keurig_K-Elite_Coffee_Maker.jpg', 34, 'unlisted', 'The Glow Lab');

-- --------------------------------------------------------

--
-- Table structure for table `user_info`
--

CREATE TABLE `user_info` (
  `ID` int(255) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) NOT NULL,
  `Username` varchar(255) NOT NULL,
  `Email` varchar(255) NOT NULL,
  `Password` varchar(255) NOT NULL,
  `Roles` varchar(255) NOT NULL,
  `Status` enum('pending','approved') DEFAULT 'pending',
  `Business_name` varchar(255) NOT NULL,
  `Phone_number` varchar(255) NOT NULL,
  `Business_permit` varchar(255) DEFAULT NULL,
  `Upload_id` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `gender` varchar(10) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `profile_picture` varchar(255) NOT NULL,
  `Address` varchar(255) DEFAULT NULL,
  `ban_reason` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_info`
--

INSERT INTO `user_info` (`ID`, `first_name`, `middle_name`, `last_name`, `Username`, `Email`, `Password`, `Roles`, `Status`, `Business_name`, `Phone_number`, `Business_permit`, `Upload_id`, `created_at`, `gender`, `date_of_birth`, `profile_picture`, `Address`, `ban_reason`) VALUES
(1, '', NULL, '', 'Jhon Mikel Felipe', 'jhonmikelfelipe20@gmail.com', '1234', 'admin', 'approved', '', '09761271972', 'static\\uploads\\Jhon Mikel Felipe\\images.png', 'static\\uploads\\Jhon Mikel Felipe\\6142245.png', '2024-10-20 15:22:00', NULL, NULL, '', NULL, ''),
(30, 'Diyan', 'Irik', 'Orasiyon', 'Eric Oracion', 'joracion42@gmail.com', 'ericoracion', 'seller', 'approved', 'Beautique Shop', '09705942383', 'registration_uploads/joracion42@gmail.com/business_permit.jpg', 'registration_uploads/joracion42@gmail.com/upload_id.jpg', '2024-11-14 04:15:45', 'male', '0000-00-00', '', NULL, ''),
(33, 'Jhon', NULL, 'Felipe', 'jm_pipls', 'Jhonmikel@gmail.com', 'Jhonmikel123', 'seller', 'approved', 'BloomWellness', '09285689091', NULL, NULL, '2024-11-14 06:34:31', NULL, NULL, '', NULL, ''),
(34, 'Diane', NULL, 'Zotomayor', 'Diane Zotomayor', 'Diane@gmail.com', 'diane123', 'seller', 'approved', 'The Glow Lab', '09877654312', NULL, NULL, '2024-11-14 08:13:09', NULL, NULL, '', NULL, ''),
(35, 'eric', 'None', 'oracion', 'jano', 'janooracion@gmail.com', '123', 'buyer', 'approved', '', '09108243535', NULL, NULL, '2024-11-14 09:38:12', 'male', '2024-12-11', 'Sunday_Riley_Luna_Sleeping_Night_Oil4.jpg', NULL, 'Spam or Fraudulent Activity'),
(42, 'Lyndon ', 'Oway', 'Pablo', 'lyndon16', 'owaylyndon@gmail.com', '12345678', 'buyer', 'approved', '', '09876543211', NULL, 'registration_uploads/owaylyndon@gmail.com/upload_id.png', '2024-11-21 02:24:00', 'male', '2024-11-29', 'mikil.jpg', 'Pinagbayanan Pila Laguna', 'Unauthorized Access'),
(48, 'Daniel ', '', 'Padilla', 'supremo_dp', 'lyndonoway16@gmail.com', '12345678', 'seller', 'approved', 'BidaGlow', '09876543211', 'registration_uploads/lyndonoway16@gmail.com/business_permit.jpg', 'registration_uploads/lyndonoway16@gmail.com/upload_id.jpg', '2024-12-09 08:41:42', NULL, NULL, '', NULL, ''),
(49, 'Kathryn', '', 'Bernardo', 'kathh_', 'zotomayosdiane@gmail.com', '12345678', 'seller', 'pending', 'BidaGlow', '09876543211', 'registration_uploads/zotomayosdiane@gmail.com/business_permit.jpg', 'registration_uploads/zotomayosdiane@gmail.com/upload_id.jpg', '2024-12-10 00:49:28', NULL, NULL, '', NULL, ''),
(50, 'Ipe', '', 'Felipe', 'natoy_', 'felipe.jhonmikel13@gmail.com', 'Jm!12345678', 'seller', 'pending', 'BidaGlow', '09876543211', 'C:\\Users\\lyndon Pablo\\OneDrive\\Documents\\Web Development\\E-COMMERCE KAILAN MO KO UUPDATE\\static\\registration_uploads\\felipe.jhonmikel13@gmail.com\\business_permit.jpg', 'C:\\Users\\lyndon Pablo\\OneDrive\\Documents\\Web Development\\E-COMMERCE KAILAN MO KO UUPDATE\\static\\registration_uploads\\felipe.jhonmikel13@gmail.com\\upload_id.jpg', '2024-12-11 23:58:58', NULL, NULL, '', NULL, '');

-- --------------------------------------------------------

--
-- Table structure for table `user_info_banned`
--

CREATE TABLE `user_info_banned` (
  `ID` int(255) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) NOT NULL,
  `Username` varchar(255) NOT NULL,
  `Email` varchar(255) NOT NULL,
  `Password` varchar(255) NOT NULL,
  `Roles` varchar(255) NOT NULL,
  `Status` enum('pending','approved') DEFAULT 'pending',
  `Business_name` varchar(255) NOT NULL,
  `Phone_number` varchar(255) NOT NULL,
  `Business_permit` varchar(255) DEFAULT NULL,
  `Upload_id` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `gender` varchar(10) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `profile_picture` varchar(255) DEFAULT NULL,
  `Address` varchar(255) DEFAULT NULL,
  `ban_reason` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `voucher`
--

CREATE TABLE `voucher` (
  `ID` int(255) NOT NULL,
  `Voucher_name` varchar(255) NOT NULL,
  `Voucher_code` varchar(255) NOT NULL,
  `Voucher_function` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `voucher`
--

INSERT INTO `voucher` (`ID`, `Voucher_name`, `Voucher_code`, `Voucher_function`) VALUES
(1, 'Glam', 'Glamourfect', '20%'),
(2, 'GlamFree', 'FREESHIP50', '50');

-- --------------------------------------------------------

--
-- Table structure for table `wishlist`
--

CREATE TABLE `wishlist` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `seller_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_name` varchar(100) DEFAULT NULL,
  `product_image` varchar(100) DEFAULT NULL,
  `product_price` decimal(10,2) DEFAULT NULL,
  `business_name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `wishlist`
--

INSERT INTO `wishlist` (`id`, `user_id`, `seller_id`, `product_id`, `product_name`, `product_image`, `product_price`, `business_name`) VALUES
(53, 42, 34, 174, 'Schick Hydro 5 Razor', 'Schick_Hydro_5_Razor.jpg', 150.00, 'The Glow Lab');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `additional_addresses`
--
ALTER TABLE `additional_addresses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `carts`
--
ALTER TABLE `carts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `feedback`
--
ALTER TABLE `feedback`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`);

--
-- Indexes for table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `seller_add_product`
--
ALTER TABLE `seller_add_product`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `seller_unlisted_products`
--
ALTER TABLE `seller_unlisted_products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_info`
--
ALTER TABLE `user_info`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `voucher`
--
ALTER TABLE `voucher`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `wishlist`
--
ALTER TABLE `wishlist`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `additional_addresses`
--
ALTER TABLE `additional_addresses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `carts`
--
ALTER TABLE `carts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=132;

--
-- AUTO_INCREMENT for table `feedback`
--
ALTER TABLE `feedback`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=167;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=302;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=194;

--
-- AUTO_INCREMENT for table `seller_add_product`
--
ALTER TABLE `seller_add_product`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=327;

--
-- AUTO_INCREMENT for table `seller_unlisted_products`
--
ALTER TABLE `seller_unlisted_products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=217;

--
-- AUTO_INCREMENT for table `user_info`
--
ALTER TABLE `user_info`
  MODIFY `ID` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT for table `voucher`
--
ALTER TABLE `voucher`
  MODIFY `ID` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `wishlist`
--
ALTER TABLE `wishlist`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `additional_addresses`
--
ALTER TABLE `additional_addresses`
  ADD CONSTRAINT `additional_addresses_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user_info` (`ID`) ON DELETE CASCADE;

--
-- Constraints for table `feedback`
--
ALTER TABLE `feedback`
  ADD CONSTRAINT `feedback_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
