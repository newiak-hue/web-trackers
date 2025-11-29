-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 29, 2025 at 09:13 PM
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

-- --------------------------------------------------------

--
-- Table structure for table `bitcoin_price`
--

CREATE TABLE `bitcoin_price` (
  `id` bigint(20) NOT NULL,
  `scrape_time` datetime NOT NULL,
  `price_usd` decimal(20,2) NOT NULL,
  `high_24h_usd` decimal(20,2) DEFAULT NULL,
  `low_24h_usd` decimal(20,2) DEFAULT NULL,
  `notes` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
-- Indexes for dumped tables
--

--
-- Indexes for table `bitcoin_price`
--
ALTER TABLE `bitcoin_price`
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
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `gold_price`
--
ALTER TABLE `gold_price`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `silver_price`
--
ALTER TABLE `silver_price`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
