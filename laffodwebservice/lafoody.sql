-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 08, 2021 at 01:49 AM
-- Server version: 10.4.13-MariaDB
-- PHP Version: 7.4.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `lafoody`
--

-- --------------------------------------------------------

--
-- Table structure for table `account`
--

CREATE TABLE `account` (
  `id_user` int(11) NOT NULL,
  `email` varchar(50) DEFAULT NULL,
  `password` varchar(200) DEFAULT NULL,
  `nama` varchar(50) DEFAULT NULL,
  `phone` varchar(13) DEFAULT NULL,
  `DOB` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `account`
--

INSERT INTO `account` (`id_user`, `email`, `password`, `nama`, `phone`, `DOB`) VALUES
(1, 'shak@mail.com', '7c4a8d09ca3762af61e59520943dc26494f8941b', 'dfggdg', '895320374803', '2021-01-09'),
(8, 's@mail.com', '7c4a8d09ca3762af61e59520943dc26494f8941b', 'shak', '896325', '2021-01-04'),
(9, 'se@mail.com', '7c4a8d09ca3762af61e59520943dc26494f8941b', 'se', '25882', '2021-01-04');

-- --------------------------------------------------------

--
-- Table structure for table `favorite`
--

CREATE TABLE `favorite` (
  `id_user` int(11) NOT NULL,
  `id_food` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `food`
--

CREATE TABLE `food` (
  `id_food` int(11) NOT NULL,
  `name` varchar(30) NOT NULL,
  `ingredients` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `variant` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `price` decimal(10,0) NOT NULL,
  `photo` varchar(40) NOT NULL,
  `id_user` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_food`
-- (See below for the actual view)
--
CREATE TABLE `view_food` (
`id_food` int(11)
,`name` varchar(30)
,`ingredients` mediumtext
,`variant` mediumtext
,`price` decimal(10,0)
,`photo` varchar(40)
,`phone` varchar(13)
,`id_user` int(11)
);

-- --------------------------------------------------------

--
-- Structure for view `view_food`
--
DROP TABLE IF EXISTS `view_food`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_food`  AS  select `f`.`id_food` AS `id_food`,`f`.`name` AS `name`,`f`.`ingredients` AS `ingredients`,`f`.`variant` AS `variant`,`f`.`price` AS `price`,`f`.`photo` AS `photo`,`c`.`phone` AS `phone`,`f`.`id_user` AS `id_user` from (`food` `f` join `account` `c` on(`f`.`id_user` = `c`.`id_user`)) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `account`
--
ALTER TABLE `account`
  ADD PRIMARY KEY (`id_user`);

--
-- Indexes for table `favorite`
--
ALTER TABLE `favorite`
  ADD KEY `id_user` (`id_user`),
  ADD KEY `id_food` (`id_food`);

--
-- Indexes for table `food`
--
ALTER TABLE `food`
  ADD PRIMARY KEY (`id_food`),
  ADD KEY `id_user` (`id_user`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `account`
--
ALTER TABLE `account`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `food`
--
ALTER TABLE `food`
  MODIFY `id_food` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `favorite`
--
ALTER TABLE `favorite`
  ADD CONSTRAINT `favorite_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `account` (`id_user`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `favorite_ibfk_2` FOREIGN KEY (`id_food`) REFERENCES `food` (`id_food`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `food`
--
ALTER TABLE `food`
  ADD CONSTRAINT `food_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `account` (`id_user`) ON DELETE CASCADE ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
