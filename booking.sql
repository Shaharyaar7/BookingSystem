-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 13, 2020 at 10:46 PM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.4.5

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `booking`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `BookingAddOrEdit` (IN `_booking_id` INT(100), IN `_user_id` INT(100), IN `_prop_id` INT(100), IN `_status` VARCHAR(100))  BEGIN
	IF _booking_id =0 THEN
		INSERT INTO `book`(`booking_id`,`user_id`,`prop_id`,`status_queue`)
        VALUES (_booking_id,_user_id,_prop_id,_status);
        
        SET _booking_id = LAST_INSERT_ID();
	ELSE
		UPDATE book
        SET
        booking_id = _booking_id,
        user_id = _user_id,
        prop_id = _prop_id,
        status_queue = _status
        where booking_id = _booking_id;
	END IF;
    
    SELECT _booking_id AS 'booking_id';
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `book`
--

CREATE TABLE `book` (
  `booking_id` int(100) NOT NULL,
  `user_id` int(100) NOT NULL,
  `prop_id` int(100) NOT NULL,
  `status_queue` varchar(100) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `book`
--

INSERT INTO `book` (`booking_id`, `user_id`, `prop_id`, `status_queue`, `created_at`) VALUES
(2, 1, 1, 'pending', '2020-06-13 18:40:56'),
(3, 1, 1, 'confirmed', '2020-06-13 20:44:48');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `book`
--
ALTER TABLE `book`
  ADD PRIMARY KEY (`booking_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `book`
--
ALTER TABLE `book`
  MODIFY `booking_id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
