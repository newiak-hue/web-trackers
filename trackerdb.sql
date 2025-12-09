-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 09, 2025 at 04:46 PM
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
-- Database: `trackerdb`
--
CREATE DATABASE IF NOT EXISTS `trackerdb` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
CREATE USER 'trackeruser'@'localhost' IDENTIFIED BY 'trackerpass';
GRANT ALL PRIVILEGES ON trackerdb.* TO 'trackeruser'@'localhost';
FLUSH PRIVILEGES;
USE `trackerdb`;

-- --------------------------------------------------------

--
-- Table structure for table `bitcoin_price`
--

CREATE TABLE `bitcoin_price` (
  `id` bigint(20) NOT NULL,
  `scrape_time` datetime NOT NULL,
  `price_usd` decimal(12,2) NOT NULL,
  `high_24` decimal(12,2) DEFAULT NULL,
  `low_24` decimal(12,2) DEFAULT NULL,
  `notes` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bitcoin_price`
--

INSERT INTO `bitcoin_price` (`id`, `scrape_time`, `price_usd`, `high_24`, `low_24`, `notes`) VALUES
(1, '2025-12-01 00:06:18', 91480.69, 91965.04, 90260.19, 'https://coinmarketcap.com/currencies/bitcoin/'),
(2, '2025-12-01 10:16:39', 87495.38, 91965.04, 87033.91, 'https://coinmarketcap.com/currencies/bitcoin/'),
(3, '2025-12-01 12:00:16', 86317.30, 91965.04, 86225.62, 'https://coinmarketcap.com/currencies/bitcoin/'),
(4, '2025-12-01 12:09:47', 86226.09, 91965.04, 86225.62, 'https://coinmarketcap.com/currencies/bitcoin/'),
(5, '2025-12-01 12:56:20', 85861.04, 91965.04, 85712.11, 'https://coinmarketcap.com/currencies/bitcoin/'),
(6, '2025-12-01 12:58:35', 85782.35, 91965.04, 85712.11, 'https://coinmarketcap.com/currencies/bitcoin/'),
(7, '2025-12-01 18:00:15', 86713.28, 91965.04, 85653.11, 'https://coinmarketcap.com/currencies/bitcoin/'),
(8, '2025-12-02 00:00:08', 84656.22, 91874.79, 83862.25, 'https://coinmarketcap.com/currencies/bitcoin/'),
(9, '2025-12-02 06:00:15', 86437.60, 91337.16, 83862.25, 'https://coinmarketcap.com/currencies/bitcoin/'),
(10, '2025-12-02 10:18:43', 86558.46, 87325.31, 83862.25, 'https://coinmarketcap.com/currencies/bitcoin/'),
(11, '2025-12-02 12:00:11', 86923.60, 87325.31, 83862.25, 'https://coinmarketcap.com/currencies/bitcoin/'),
(12, '2025-12-02 18:10:07', 86865.48, 87325.31, 83862.25, 'https://coinmarketcap.com/currencies/bitcoin/'),
(13, '2025-12-03 00:00:16', 90924.15, 91193.79, 84071.67, 'https://coinmarketcap.com/currencies/bitcoin/'),
(14, '2025-12-03 06:00:15', 91609.75, 92316.63, 86202.19, 'https://coinmarketcap.com/currencies/bitcoin/'),
(15, '2025-12-03 12:00:24', 92756.65, 93003.31, 86404.40, 'https://coinmarketcap.com/currencies/bitcoin/'),
(16, '2025-12-03 22:13:43', 92096.06, 93965.10, 89155.00, 'https://coinmarketcap.com/currencies/bitcoin/'),
(17, '2025-12-03 22:14:56', 92096.06, 93965.10, 89155.00, 'https://coinmarketcap.com/currencies/bitcoin/'),
(18, '2025-12-03 22:19:55', 92074.91, 93965.10, 89155.00, 'https://coinmarketcap.com/currencies/bitcoin/'),
(19, '2025-12-04 00:00:14', 92477.33, 93965.10, 90288.98, 'https://coinmarketcap.com/currencies/bitcoin/'),
(20, '2025-12-04 06:00:15', 93619.99, 93965.10, 91056.39, 'https://coinmarketcap.com/currencies/bitcoin/'),
(21, '2025-12-04 12:00:13', 93544.01, 94060.77, 91782.96, 'https://coinmarketcap.com/currencies/bitcoin/'),
(22, '2025-12-04 18:00:19', 93487.88, 94060.77, 91782.96, 'https://coinmarketcap.com/currencies/bitcoin/'),
(23, '2025-12-05 00:51:33', 92650.59, 94060.77, 91880.22, 'https://coinmarketcap.com/currencies/bitcoin/'),
(24, '2025-12-05 06:00:15', 92156.43, 94060.77, 90976.10, 'https://coinmarketcap.com/currencies/bitcoin/'),
(25, '2025-12-05 12:00:14', 92343.96, 93620.95, 90976.10, 'https://coinmarketcap.com/currencies/bitcoin/'),
(26, '2025-12-05 18:00:14', 91086.65, 93567.09, 90976.10, 'https://coinmarketcap.com/currencies/bitcoin/'),
(27, '2025-12-06 00:00:28', 90588.07, 93175.36, 90004.33, 'https://coinmarketcap.com/currencies/bitcoin/'),
(28, '2025-12-06 06:00:16', 89206.96, 92702.64, 88152.14, 'https://coinmarketcap.com/currencies/bitcoin/'),
(29, '2025-12-06 12:00:06', 89735.70, 92498.17, 88152.14, 'https://coinmarketcap.com/currencies/bitcoin/'),
(30, '2025-12-06 18:00:15', 89654.95, 91553.78, 88152.14, 'https://coinmarketcap.com/currencies/bitcoin/'),
(31, '2025-12-07 00:00:09', 89873.95, 90489.16, 88152.14, 'https://coinmarketcap.com/currencies/bitcoin/'),
(32, '2025-12-07 06:00:18', 89470.20, 90267.46, 88942.10, 'https://coinmarketcap.com/currencies/bitcoin/'),
(33, '2025-12-07 12:34:15', 89632.82, 90267.46, 88951.67, 'https://coinmarketcap.com/currencies/bitcoin/'),
(34, '2025-12-07 18:00:09', 89098.27, 90267.46, 88951.67, 'https://coinmarketcap.com/currencies/bitcoin/'),
(35, '2025-12-08 00:00:09', 89216.36, 89999.84, 87799.56, 'https://coinmarketcap.com/currencies/bitcoin/'),
(36, '2025-12-08 06:00:14', 90096.38, 91740.85, 87799.56, 'https://coinmarketcap.com/currencies/bitcoin/'),
(37, '2025-12-08 12:00:21', 91076.04, 91740.85, 87799.56, 'https://coinmarketcap.com/currencies/bitcoin/'),
(38, '2025-12-08 18:00:21', 91952.17, 92267.11, 87799.56, 'https://coinmarketcap.com/currencies/bitcoin/'),
(39, '2025-12-09 00:00:15', 90180.36, 92267.11, 89068.19, 'https://coinmarketcap.com/currencies/bitcoin/'),
(40, '2025-12-09 06:00:16', 91304.51, 92267.11, 89068.19, 'https://coinmarketcap.com/currencies/bitcoin/'),
(41, '2025-12-09 12:00:12', 90357.02, 92267.11, 89644.89, 'https://coinmarketcap.com/currencies/bitcoin/'),
(42, '2025-12-09 18:00:20', 90188.25, 92220.86, 89586.98, 'https://coinmarketcap.com/currencies/bitcoin/'),
(43, '2025-12-09 23:44:32', 91595.22, 91381.70, 89586.98, 'https://coinmarketcap.com/currencies/bitcoin/');

-- --------------------------------------------------------

--
-- Table structure for table `ethereum_price`
--

CREATE TABLE `ethereum_price` (
  `id` int(11) NOT NULL,
  `scrape_time` datetime NOT NULL,
  `price_usd` decimal(12,2) NOT NULL,
  `high_24` decimal(12,2) DEFAULT NULL,
  `low_24` decimal(12,2) DEFAULT NULL,
  `notes` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ethereum_price`
--

INSERT INTO `ethereum_price` (`id`, `scrape_time`, `price_usd`, `high_24`, `low_24`, `notes`) VALUES
(1, '2025-12-01 00:06:37', 3031.90, 3051.60, 2966.85, 'https://coinmarketcap.com/currencies/ethereum/'),
(2, '2025-12-01 10:16:58', 2863.45, 3051.60, 2835.24, 'https://coinmarketcap.com/currencies/ethereum/'),
(3, '2025-12-01 12:00:16', 2824.50, 3051.60, 2819.54, 'https://coinmarketcap.com/currencies/ethereum/'),
(4, '2025-12-01 12:09:47', 2824.16, 3051.60, 2819.54, 'https://coinmarketcap.com/currencies/ethereum/'),
(5, '2025-12-01 12:56:21', 2814.57, 3051.60, 2807.80, 'https://coinmarketcap.com/currencies/ethereum/'),
(6, '2025-12-01 12:58:36', 2816.16, 3051.60, 2807.80, 'https://coinmarketcap.com/currencies/ethereum/'),
(7, '2025-12-01 18:00:16', 2837.50, 3051.60, 2807.80, 'https://coinmarketcap.com/currencies/ethereum/'),
(8, '2025-12-02 00:00:08', 2750.66, 3049.96, 2720.44, 'https://coinmarketcap.com/currencies/ethereum/'),
(9, '2025-12-02 06:00:16', 2789.99, 3034.88, 2720.44, 'https://coinmarketcap.com/currencies/ethereum/'),
(10, '2025-12-02 10:18:44', 2797.56, 2848.97, 2720.44, 'https://coinmarketcap.com/currencies/ethereum/'),
(11, '2025-12-02 12:00:12', 2806.84, 2848.97, 2720.44, 'https://coinmarketcap.com/currencies/ethereum/'),
(12, '2025-12-02 18:10:08', 2800.88, 2847.84, 2720.44, 'https://coinmarketcap.com/currencies/ethereum/'),
(13, '2025-12-03 00:00:17', 3007.84, 3018.28, 2722.35, 'https://coinmarketcap.com/currencies/ethereum/'),
(14, '2025-12-03 06:00:14', 2997.20, 3032.76, 2784.39, 'https://coinmarketcap.com/currencies/ethereum/'),
(15, '2025-12-03 12:00:25', 3033.93, 3046.22, 2784.39, 'https://coinmarketcap.com/currencies/ethereum/'),
(16, '2025-12-03 22:13:45', 3050.27, 3094.04, 2893.85, 'https://coinmarketcap.com/currencies/ethereum/'),
(17, '2025-12-03 22:14:57', 3050.27, 3094.04, 2893.85, 'https://coinmarketcap.com/currencies/ethereum/'),
(18, '2025-12-03 22:19:55', 3058.19, 3094.04, 2893.85, 'https://coinmarketcap.com/currencies/ethereum/'),
(19, '2025-12-04 00:00:15', 3082.16, 3141.51, 2976.18, 'https://coinmarketcap.com/currencies/ethereum/'),
(20, '2025-12-04 06:00:15', 3150.99, 3154.08, 2988.14, 'https://coinmarketcap.com/currencies/ethereum/'),
(21, '2025-12-04 12:00:14', 3210.25, 3238.56, 3031.33, 'https://coinmarketcap.com/currencies/ethereum/'),
(22, '2025-12-04 18:00:21', 3203.63, 3238.56, 3034.76, 'https://coinmarketcap.com/currencies/ethereum/'),
(23, '2025-12-05 00:51:34', 3186.92, 3238.56, 3087.04, 'https://coinmarketcap.com/currencies/ethereum/'),
(24, '2025-12-05 06:00:16', 3122.95, 3238.56, 3071.31, 'https://coinmarketcap.com/currencies/ethereum/'),
(25, '2025-12-05 12:00:14', 3172.36, 3223.17, 3071.31, 'https://coinmarketcap.com/currencies/ethereum/'),
(26, '2025-12-05 18:00:14', 3117.21, 3223.17, 3071.31, 'https://coinmarketcap.com/currencies/ethereum/'),
(27, '2025-12-06 00:00:29', 3109.78, 3223.17, 3071.31, 'https://coinmarketcap.com/currencies/ethereum/'),
(28, '2025-12-06 06:00:17', 3020.68, 3192.46, 2989.83, 'https://coinmarketcap.com/currencies/ethereum/'),
(29, '2025-12-06 12:00:07', 3038.94, 3182.35, 2989.83, 'https://coinmarketcap.com/currencies/ethereum/'),
(30, '2025-12-06 18:00:16', 3031.18, 3154.09, 2989.83, 'https://coinmarketcap.com/currencies/ethereum/'),
(31, '2025-12-07 00:00:09', 3045.75, 3107.17, 2989.83, 'https://coinmarketcap.com/currencies/ethereum/'),
(32, '2025-12-07 06:00:19', 3043.28, 3067.66, 3009.09, 'https://coinmarketcap.com/currencies/ethereum/'),
(33, '2025-12-07 12:34:15', 3050.92, 3067.66, 3015.27, 'https://coinmarketcap.com/currencies/ethereum/'),
(34, '2025-12-07 18:00:09', 3029.43, 3067.66, 3026.47, 'https://coinmarketcap.com/currencies/ethereum/'),
(35, '2025-12-08 00:00:10', 3014.86, 3065.33, 2930.65, 'https://coinmarketcap.com/currencies/ethereum/'),
(36, '2025-12-08 06:00:15', 3079.59, 3148.77, 2930.65, 'https://coinmarketcap.com/currencies/ethereum/'),
(37, '2025-12-08 12:00:22', 3110.27, 3148.77, 2930.65, 'https://coinmarketcap.com/currencies/ethereum/'),
(38, '2025-12-08 18:00:22', 3157.67, 3177.87, 2930.65, 'https://coinmarketcap.com/currencies/ethereum/'),
(39, '2025-12-09 00:00:16', 3109.06, 3177.87, 3002.96, 'https://coinmarketcap.com/currencies/ethereum/'),
(40, '2025-12-09 06:00:16', 3147.43, 3177.87, 3023.94, 'https://coinmarketcap.com/currencies/ethereum/'),
(41, '2025-12-09 12:00:13', 3122.97, 3177.87, 3083.34, 'https://coinmarketcap.com/currencies/ethereum/'),
(42, '2025-12-09 18:00:21', 3107.70, 3174.83, 3083.34, 'https://coinmarketcap.com/currencies/ethereum/'),
(43, '2025-12-09 23:44:32', 3167.94, 3163.50, 3083.34, 'https://coinmarketcap.com/currencies/ethereum/');

-- --------------------------------------------------------

--
-- Table structure for table `gold_price`
--

CREATE TABLE `gold_price` (
  `id` int(11) NOT NULL,
  `scrape_time` datetime NOT NULL,
  `price_usd` decimal(12,2) NOT NULL,
  `high_24` decimal(12,2) DEFAULT NULL,
  `low_24` decimal(12,2) DEFAULT NULL,
  `notes` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `gold_price`
--

INSERT INTO `gold_price` (`id`, `scrape_time`, `price_usd`, `high_24`, `low_24`, `notes`) VALUES
(1, '2025-12-01 00:06:58', 4218.40, 4226.50, 4154.20, 'https://kitco.com/charts/gold/'),
(2, '2025-12-01 10:17:18', 4247.10, 4257.10, 4206.20, 'https://kitco.com/charts/gold/'),
(3, '2025-12-01 12:00:17', 4236.40, 4257.10, 4206.20, 'https://kitco.com/charts/gold/'),
(4, '2025-12-01 12:09:49', 4236.80, 4257.10, 4206.20, 'https://kitco.com/charts/gold/'),
(5, '2025-12-01 12:56:23', 4245.50, 4257.10, 4206.20, 'https://kitco.com/charts/gold/'),
(6, '2025-12-01 12:58:38', 4244.00, 4257.10, 4206.20, 'https://kitco.com/charts/gold/'),
(7, '2025-12-01 18:00:18', 4247.80, 4257.10, 4206.20, 'https://kitco.com/charts/gold/'),
(8, '2025-12-02 00:00:10', 4229.50, 4265.40, 4206.20, 'https://kitco.com/charts/gold/'),
(9, '2025-12-02 06:00:17', 4231.00, 4265.40, 4206.20, 'https://kitco.com/charts/gold/'),
(10, '2025-12-02 10:18:45', 4219.30, 4237.10, 4199.90, 'https://kitco.com/charts/gold/'),
(11, '2025-12-02 12:00:13', 4216.70, 4237.10, 4199.90, 'https://kitco.com/charts/gold/'),
(12, '2025-12-02 18:10:10', 4189.60, 4237.10, 4180.60, 'https://kitco.com/charts/gold/'),
(13, '2025-12-03 00:00:18', 4171.90, 4237.10, 4171.50, 'https://kitco.com/charts/gold/'),
(14, '2025-12-03 06:00:15', 4204.90, 4237.10, 4165.00, 'https://kitco.com/charts/gold/'),
(15, '2025-12-03 12:00:27', 4219.40, 4229.70, 4201.90, 'https://kitco.com/charts/gold/'),
(16, '2025-12-03 22:13:45', 4223.10, 4241.60, 4193.70, 'https://kitco.com/charts/gold/'),
(17, '2025-12-03 22:14:58', 4224.50, 4241.60, 4193.70, 'https://kitco.com/charts/gold/'),
(18, '2025-12-03 22:19:57', 4221.70, 4241.60, 4193.70, 'https://kitco.com/charts/gold/'),
(19, '2025-12-04 00:00:16', 4218.90, 4242.60, 4193.70, 'https://kitco.com/charts/gold/'),
(20, '2025-12-04 06:00:17', 4202.10, 4242.60, 4193.70, 'https://kitco.com/charts/gold/'),
(21, '2025-12-04 12:00:13', 4194.80, 4217.70, 4188.30, 'https://kitco.com/charts/gold/'),
(22, '2025-12-04 18:00:20', 4198.80, 4217.70, 4175.20, 'https://kitco.com/charts/gold/'),
(23, '2025-12-05 00:51:35', 4211.80, 4220.10, 4175.20, 'https://kitco.com/charts/gold/'),
(24, '2025-12-05 06:00:17', 4207.70, 4220.10, 4175.20, 'https://kitco.com/charts/gold/'),
(25, '2025-12-05 12:00:15', 4207.30, 4211.90, 4194.10, 'https://kitco.com/charts/gold/'),
(26, '2025-12-05 18:00:16', 4223.10, 4231.70, 4194.10, 'https://kitco.com/charts/gold/'),
(27, '2025-12-06 00:00:31', 4241.20, 4260.20, 4194.10, 'https://kitco.com/charts/gold/'),
(28, '2025-12-06 06:00:18', 4197.30, 4260.20, 4191.40, 'https://kitco.com/charts/gold/'),
(29, '2025-12-06 12:00:08', 4197.30, 4260.20, 4191.40, 'https://kitco.com/charts/gold/'),
(30, '2025-12-06 18:00:18', 4197.30, 4260.20, 4191.40, 'https://kitco.com/charts/gold/'),
(31, '2025-12-07 00:00:11', 4197.30, 4260.20, 4191.40, 'https://kitco.com/charts/gold/'),
(32, '2025-12-07 06:00:21', 4197.30, 4260.20, 4191.40, 'https://kitco.com/charts/gold/'),
(33, '2025-12-07 12:34:16', 4197.30, 4260.20, 4191.40, 'https://kitco.com/charts/gold/'),
(34, '2025-12-07 18:00:10', 4197.30, 4260.20, 4191.40, 'https://kitco.com/charts/gold/'),
(35, '2025-12-08 00:00:11', 4197.30, 4260.20, 4191.40, 'https://kitco.com/charts/gold/'),
(36, '2025-12-08 06:00:16', 4197.30, 4260.20, 4191.40, 'https://kitco.com/charts/gold/'),
(37, '2025-12-08 12:00:24', 4209.50, 4214.10, 4195.50, 'https://kitco.com/charts/gold/'),
(38, '2025-12-08 18:00:24', 4208.50, 4220.00, 4195.50, 'https://kitco.com/charts/gold/'),
(39, '2025-12-09 00:00:18', 4182.40, 4220.00, 4175.40, 'https://kitco.com/charts/gold/'),
(40, '2025-12-09 06:00:18', 4189.70, 4220.00, 4175.40, 'https://kitco.com/charts/gold/'),
(41, '2025-12-09 12:00:14', 4194.20, 4199.90, 4185.30, 'https://kitco.com/charts/gold/'),
(42, '2025-12-09 18:00:23', 4201.40, 4213.70, 4169.30, 'https://kitco.com/charts/gold/'),
(43, '2025-12-09 23:44:32', 4203.70, 4213.70, 4169.30, 'https://kitco.com/charts/gold/');

-- --------------------------------------------------------

--
-- Table structure for table `silver_price`
--

CREATE TABLE `silver_price` (
  `id` int(11) NOT NULL,
  `scrape_time` datetime NOT NULL,
  `price_usd` decimal(12,2) NOT NULL,
  `high_24` decimal(12,2) DEFAULT NULL,
  `low_24` decimal(12,2) DEFAULT NULL,
  `notes` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `silver_price`
--

INSERT INTO `silver_price` (`id`, `scrape_time`, `price_usd`, `high_24`, `low_24`, `notes`) VALUES
(1, '2025-12-01 00:07:22', 56.33, 56.57, 53.23, 'https://www.kitco.com/charts/silver/'),
(2, '2025-12-01 10:17:38', 57.61, 57.90, 56.14, 'https://www.kitco.com/charts/silver/'),
(3, '2025-12-01 12:00:17', 57.11, 57.90, 56.14, 'https://www.kitco.com/charts/silver/'),
(4, '2025-12-01 12:09:49', 56.98, 57.90, 56.14, 'https://www.kitco.com/charts/silver/'),
(5, '2025-12-01 12:56:24', 57.22, 57.90, 56.14, 'https://www.kitco.com/charts/silver/'),
(6, '2025-12-01 12:58:37', 57.18, 57.90, 56.14, 'https://www.kitco.com/charts/silver/'),
(7, '2025-12-01 18:00:19', 57.30, 57.90, 56.14, 'https://www.kitco.com/charts/silver/'),
(8, '2025-12-02 00:00:11', 57.56, 57.90, 56.14, 'https://www.kitco.com/charts/silver/'),
(9, '2025-12-02 06:00:19', 57.93, 58.87, 56.14, 'https://www.kitco.com/charts/silver/'),
(10, '2025-12-02 10:18:46', 56.94, 58.05, 56.52, 'https://www.kitco.com/charts/silver/'),
(11, '2025-12-02 12:00:12', 57.16, 58.05, 56.52, 'https://www.kitco.com/charts/silver/'),
(12, '2025-12-02 18:10:11', 56.91, 58.05, 56.52, 'https://www.kitco.com/charts/silver/'),
(13, '2025-12-03 00:00:19', 57.05, 58.42, 56.52, 'https://www.kitco.com/charts/silver/'),
(14, '2025-12-03 06:00:17', 58.39, 58.69, 56.52, 'https://www.kitco.com/charts/silver/'),
(15, '2025-12-03 12:00:29', 58.79, 59.00, 58.09, 'https://www.kitco.com/charts/silver/'),
(16, '2025-12-03 22:13:47', 58.21, 59.02, 57.53, 'https://www.kitco.com/charts/silver/'),
(17, '2025-12-03 22:15:01', 58.17, 59.02, 57.53, 'https://www.kitco.com/charts/silver/'),
(18, '2025-12-03 22:19:59', 58.19, 59.02, 57.53, 'https://www.kitco.com/charts/silver/'),
(19, '2025-12-04 00:00:18', 58.48, 59.02, 57.53, 'https://www.kitco.com/charts/silver/'),
(20, '2025-12-04 06:00:19', 58.44, 59.02, 57.53, 'https://www.kitco.com/charts/silver/'),
(21, '2025-12-04 12:00:14', 58.07, 58.79, 57.96, 'https://www.kitco.com/charts/silver/'),
(22, '2025-12-04 18:00:21', 57.33, 58.79, 56.58, 'https://www.kitco.com/charts/silver/'),
(23, '2025-12-05 00:51:36', 57.04, 58.79, 56.44, 'https://www.kitco.com/charts/silver/'),
(24, '2025-12-05 06:00:19', 57.06, 58.79, 56.44, 'https://www.kitco.com/charts/silver/'),
(25, '2025-12-05 12:00:17', 57.37, 57.72, 56.81, 'https://www.kitco.com/charts/silver/'),
(26, '2025-12-05 18:00:17', 58.08, 58.55, 56.81, 'https://www.kitco.com/charts/silver/'),
(27, '2025-12-06 00:00:32', 58.84, 59.37, 56.81, 'https://www.kitco.com/charts/silver/'),
(28, '2025-12-06 06:00:20', 58.28, 59.37, 56.81, 'https://www.kitco.com/charts/silver/'),
(29, '2025-12-06 12:00:09', 58.27, 59.37, 56.81, 'https://www.kitco.com/charts/silver/'),
(30, '2025-12-06 18:00:19', 58.27, 59.37, 56.81, 'https://www.kitco.com/charts/silver/'),
(31, '2025-12-07 00:00:12', 58.27, 59.37, 56.81, 'https://www.kitco.com/charts/silver/'),
(32, '2025-12-07 06:00:22', 58.27, 59.37, 56.81, 'https://www.kitco.com/charts/silver/'),
(33, '2025-12-07 12:34:18', 58.27, 59.37, 56.81, 'https://www.kitco.com/charts/silver/'),
(34, '2025-12-07 18:00:11', 58.27, 59.37, 56.81, 'https://www.kitco.com/charts/silver/'),
(35, '2025-12-08 00:00:12', 58.27, 59.37, 56.81, 'https://www.kitco.com/charts/silver/'),
(36, '2025-12-08 06:00:18', 58.27, 59.37, 56.81, 'https://www.kitco.com/charts/silver/'),
(37, '2025-12-08 12:00:26', 57.90, 58.90, 57.56, 'https://www.kitco.com/charts/silver/'),
(38, '2025-12-08 18:00:25', 58.29, 58.90, 57.56, 'https://www.kitco.com/charts/silver/'),
(39, '2025-12-09 00:00:20', 57.84, 58.90, 57.56, 'https://www.kitco.com/charts/silver/'),
(40, '2025-12-09 06:00:20', 58.08, 58.90, 57.56, 'https://www.kitco.com/charts/silver/'),
(41, '2025-12-09 12:00:16', 58.24, 58.47, 57.82, 'https://www.kitco.com/charts/silver/'),
(42, '2025-12-09 18:00:24', 58.39, 58.98, 57.54, 'https://www.kitco.com/charts/silver/'),
(43, '2025-12-09 23:44:33', 59.90, 60.00, 57.54, 'https://www.kitco.com/charts/silver/');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bitcoin_price`
--
ALTER TABLE `bitcoin_price`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ethereum_price`
--
ALTER TABLE `ethereum_price`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `gold_price`
--
ALTER TABLE `gold_price`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `silver_price`
--
ALTER TABLE `silver_price`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bitcoin_price`
--
ALTER TABLE `bitcoin_price`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT for table `ethereum_price`
--
ALTER TABLE `ethereum_price`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT for table `gold_price`
--
ALTER TABLE `gold_price`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT for table `silver_price`
--
ALTER TABLE `silver_price`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
