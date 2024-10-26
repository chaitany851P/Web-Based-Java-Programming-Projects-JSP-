-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 20, 2024 at 08:47 AM
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
-- Database: `online_book_store`
--

-- --------------------------------------------------------

--
-- Table structure for table `books`
--

CREATE TABLE `books` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `author` varchar(255) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `discount` varchar(50) DEFAULT NULL,
  `image_url` longtext NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `books`
--

INSERT INTO `books` (`id`, `title`, `author`, `price`, `discount`, `image_url`, `created_at`) VALUES
(1, 'iron man', 'Stand lee', 100.00, '2.00', 'https://resource.scholastic.com.au/ProductImages/8578000_Z.jpg', '2024-10-20 06:35:53'),
(2, 'Spider man', 'Marvel comin', 50.00, '2.00', 'https://m.media-amazon.com/images/I/51HqN9np8dL._SY445_SX342_.jpg', '2024-10-20 06:38:33'),
(3, 'Thor ', 'Marvel comin', 200.00, '3.00', 'https://m.media-amazon.com/images/I/610lUEQ19VL._SY466_.jpg', '2024-10-20 06:39:50'),
(4, 'Hulk vs Thanos', 'Marvel comin', 250.00, '0', 'https://i0.wp.com/comicbookdispatch.com/wp-content/uploads/2024/07/INCREDHULKANNUAL2024001_Preview_page_1.jpeg?resize=1011%2C1536&ssl=1', '2024-10-20 06:42:24'),
(5, 'Deadpool', 'Marvel comin', 500.00, '50', 'https://m.media-amazon.com/images/I/41-UOwgff+L._SY445_SX342_.jpg', '2024-10-20 06:44:31'),
(6, 'Doctor Doom Vol. 1: Pottersville', 'Marvel comin', 1000.00, '20', 'https://m.media-amazon.com/images/I/81X1kyB6lcL._SY466_.jpg', '2024-10-20 06:46:19');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin','user') NOT NULL DEFAULT 'user',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `email`, `username`, `password`, `role`, `created_at`) VALUES
(1, 'c@gmail.com', 'c', '123456789', 'user', '2024-10-20 06:14:17'),
(2, 'admin123@gmail.com', 'admin', '147896325', 'admin', '2024-10-20 06:16:45');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `books`
--
ALTER TABLE `books`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `books`
--
ALTER TABLE `books`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
