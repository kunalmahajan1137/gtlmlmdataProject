-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 02, 2025 at 09:30 PM
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
-- Database: `gtlmlmdata`
--

-- --------------------------------------------------------

--
-- Table structure for table `kyc_details`
--

CREATE TABLE `kyc_details` (
  `kyc_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `bank_info` varchar(255) DEFAULT NULL,
  `pan_card` varchar(255) DEFAULT NULL,
  `aadhar_front` varchar(255) DEFAULT NULL,
  `aadhar_back` varchar(255) DEFAULT NULL,
  `upload_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `kyc_details`
--

INSERT INTO `kyc_details` (`kyc_id`, `user_id`, `bank_info`, `pan_card`, `aadhar_front`, `aadhar_back`, `upload_date`) VALUES
(1, 9, '1743588030141_Screenshot 2025-04-02 003627.png', '1743588030146_Screenshot 2025-04-01 032016.png', '1743588030147_Screenshot 2025-04-02 003627.png', '1743588030150_Screenshot 2025-04-01 031449.png', '2025-04-02 10:00:30');

-- --------------------------------------------------------

--
-- Table structure for table `nominee_kyc_details`
--

CREATE TABLE `nominee_kyc_details` (
  `user_id` int(11) NOT NULL,
  `nominee_name` varchar(255) DEFAULT NULL,
  `relationship` varchar(255) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `percentage` decimal(5,2) DEFAULT NULL,
  `aadhar_number` varchar(12) DEFAULT NULL,
  `bank_info_file` varchar(255) DEFAULT NULL,
  `pan_card_file` varchar(255) DEFAULT NULL,
  `aadhar_front_file` varchar(255) DEFAULT NULL,
  `aadhar_back_file` varchar(255) DEFAULT NULL,
  `upload_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `nominee_kyc_details`
--

INSERT INTO `nominee_kyc_details` (`user_id`, `nominee_name`, `relationship`, `dob`, `percentage`, `aadhar_number`, `bank_info_file`, `pan_card_file`, `aadhar_front_file`, `aadhar_back_file`, `upload_date`) VALUES
(9, 'xya', 'abc', '4333-06-20', 45.00, '54467567', '1743612820227_Screenshot 2025-04-02 003627.png', '1743612820231_Screenshot 2025-04-01 032016.png', '1743612820235_Screenshot 2025-04-01 031523.png', '1743612820235_Screenshot 2025-04-01 031449.png', '2025-04-02 16:53:40');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `sponsor_id` varchar(50) NOT NULL,
  `sponsor_name` varchar(100) NOT NULL,
  `position` enum('Left','Right') NOT NULL,
  `name` varchar(100) NOT NULL,
  `mobile` varchar(15) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `confpassword` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `sponsor_id`, `sponsor_name`, `position`, `name`, `mobile`, `email`, `password`, `confpassword`, `created_at`) VALUES
(9, '1', 'user', 'Left', 'kunal', '09970396971', 'Test5@gmail.com', '123', '123', '2025-03-28 16:08:40'),
(10, '2', 'abc', 'Left', 'Kunal', '6568765533', 'test1@gmail.com', '123', '123', '2025-03-31 15:35:09');

-- --------------------------------------------------------

--
-- Table structure for table `users_details`
--

CREATE TABLE `users_details` (
  `user_id` int(11) NOT NULL,
  `dob` date DEFAULT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `fathername` varchar(100) DEFAULT NULL,
  `husbandname` varchar(100) DEFAULT NULL,
  `nationality` varchar(50) DEFAULT NULL,
  `address1` varchar(255) DEFAULT NULL,
  `address2` varchar(255) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `pincode` varchar(10) DEFAULT NULL,
  `bankname` varchar(100) DEFAULT NULL,
  `accholdername` varchar(100) DEFAULT NULL,
  `accounttype` varchar(50) DEFAULT NULL,
  `branchadd` varchar(255) DEFAULT NULL,
  `accountno` varchar(50) DEFAULT NULL,
  `IFSCcode` varchar(20) DEFAULT NULL,
  `PANno` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users_details`
--

INSERT INTO `users_details` (`user_id`, `dob`, `gender`, `fathername`, `husbandname`, `nationality`, `address1`, `address2`, `state`, `city`, `pincode`, `bankname`, `accholdername`, `accounttype`, `branchadd`, `accountno`, `IFSCcode`, `PANno`) VALUES
(9, '2001-06-20', 'male', 'Tukaram', 'null', 'null', 'lane no 9 nimbalkar nagar', 'lohegaon pune', 'Maharashtra', 'Pune', 'null', 'Bank of India', 'Kunal', 'saving', 'null', '876543276', 'null', 'GDFK525F'),
(10, '2025-03-25', 'male', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null', 'null');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `kyc_details`
--
ALTER TABLE `kyc_details`
  ADD PRIMARY KEY (`kyc_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `nominee_kyc_details`
--
ALTER TABLE `nominee_kyc_details`
  ADD PRIMARY KEY (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mobile` (`mobile`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `users_details`
--
ALTER TABLE `users_details`
  ADD KEY `user bind` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `kyc_details`
--
ALTER TABLE `kyc_details`
  MODIFY `kyc_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `kyc_details`
--
ALTER TABLE `kyc_details`
  ADD CONSTRAINT `kyc_details_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `nominee_kyc_details`
--
ALTER TABLE `nominee_kyc_details`
  ADD CONSTRAINT `nominee_kyc_details_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `users_details`
--
ALTER TABLE `users_details`
  ADD CONSTRAINT `user bind` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
