-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 25, 2025 at 09:19 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `lms_univer`
--

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `admin_id` int(10) UNSIGNED NOT NULL,
  `office` varchar(100) DEFAULT NULL,
  `position` varchar(100) DEFAULT NULL,
  `phone_ext` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`admin_id`, `office`, `position`, `phone_ext`) VALUES
(1, 'B-101', 'Lead System Administrator', '1001'),
(2, 'B-102', 'IT Support Manager', '1002');

-- --------------------------------------------------------

--
-- Table structure for table `assignments`
--

CREATE TABLE `assignments` (
  `assignment_id` int(10) UNSIGNED NOT NULL,
  `offering_id` int(10) UNSIGNED NOT NULL,
  `title` varchar(200) NOT NULL,
  `description` text DEFAULT NULL,
  `due_date` datetime NOT NULL,
  `max_score` decimal(5,2) NOT NULL,
  `type` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `assignments`
--

INSERT INTO `assignments` (`assignment_id`, `offering_id`, `title`, `description`, `due_date`, `max_score`, `type`) VALUES
(1, 1, 'CS101 HW1 - Variables', 'Basic exercises on variables and expressions', '2025-09-20 23:59:00', 100.00, 'homework'),
(2, 1, 'CS101 HW2 - Conditionals', 'Tasks using if/else and boolean logic', '2025-10-05 23:59:00', 100.00, 'homework'),
(3, 2, 'IS201 Case Study 1', 'Short report on an information system in a real company', '2025-09-30 23:59:00', 50.00, 'project'),
(4, 3, 'MATH101 HW1 - Limits', 'Compute limits using algebraic techniques', '2025-09-22 23:59:00', 100.00, 'homework');

-- --------------------------------------------------------

--
-- Table structure for table `courses`
--

CREATE TABLE `courses` (
  `course_id` int(10) UNSIGNED NOT NULL,
  `code` varchar(20) NOT NULL,
  `title` varchar(200) NOT NULL,
  `description` text DEFAULT NULL,
  `category` varchar(50) DEFAULT NULL,
  `level` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `courses`
--

INSERT INTO `courses` (`course_id`, `code`, `title`, `description`, `category`, `level`) VALUES
(1, 'CS101', 'Intro to Programming', 'Basics of programming in Python', 'Computer Science', 'Undergrad'),
(2, 'IS201', 'Information Systems I', 'Intro to information systems in organizations', 'Information Systems', 'Undergrad'),
(3, 'MATH101', 'Calculus I', 'Limits and derivatives', 'Mathematics', 'Undergrad');

-- --------------------------------------------------------

--
-- Table structure for table `course_offerings`
--

CREATE TABLE `course_offerings` (
  `offering_id` int(10) UNSIGNED NOT NULL,
  `course_id` int(10) UNSIGNED NOT NULL,
  `term` varchar(20) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `course_offerings`
--

INSERT INTO `course_offerings` (`offering_id`, `course_id`, `term`, `start_date`, `end_date`) VALUES
(1, 1, 'Fall 2025', '2025-09-01', '2025-12-15'),
(2, 2, 'Fall 2025', '2025-09-01', '2025-12-15'),
(3, 3, 'Fall 2025', '2025-09-01', '2025-12-15');

-- --------------------------------------------------------

--
-- Table structure for table `enrollments`
--

CREATE TABLE `enrollments` (
  `enrollment_id` int(10) UNSIGNED NOT NULL,
  `student_id` int(10) UNSIGNED NOT NULL,
  `offering_id` int(10) UNSIGNED NOT NULL,
  `status` enum('enrolled','dropped','completed') NOT NULL,
  `enrollment_date` date NOT NULL,
  `final_grade` decimal(5,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `enrollments`
--

INSERT INTO `enrollments` (`enrollment_id`, `student_id`, `offering_id`, `status`, `enrollment_date`, `final_grade`) VALUES
(1, 5, 1, 'enrolled', '2025-09-05', NULL),
(2, 6, 1, 'enrolled', '2025-09-05', NULL),
(3, 7, 1, 'enrolled', '2025-09-05', NULL),
(4, 8, 1, 'enrolled', '2025-09-05', NULL),
(5, 9, 1, 'enrolled', '2025-09-05', NULL),
(6, 5, 2, 'enrolled', '2025-09-06', NULL),
(7, 6, 2, 'enrolled', '2025-09-06', NULL),
(8, 8, 2, 'enrolled', '2025-09-06', NULL),
(9, 7, 3, 'enrolled', '2025-09-07', NULL),
(10, 9, 3, 'enrolled', '2025-09-07', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `grades`
--

CREATE TABLE `grades` (
  `grade_id` int(10) UNSIGNED NOT NULL,
  `submission_id` int(10) UNSIGNED NOT NULL,
  `score` decimal(5,2) NOT NULL,
  `graded_at` datetime NOT NULL,
  `feedback` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `instructors`
--

CREATE TABLE `instructors` (
  `instructor_id` int(10) UNSIGNED NOT NULL,
  `department` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `instructors`
--

INSERT INTO `instructors` (`instructor_id`, `department`) VALUES
(3, 'Computer Science'),
(4, 'Information Systems');

-- --------------------------------------------------------

--
-- Table structure for table `instructor_offering`
--

CREATE TABLE `instructor_offering` (
  `offering_id` int(10) UNSIGNED NOT NULL,
  `instructor_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `instructor_offering`
--

INSERT INTO `instructor_offering` (`offering_id`, `instructor_id`) VALUES
(1, 3),
(2, 4),
(3, 4);

-- --------------------------------------------------------

--
-- Table structure for table `materials`
--

CREATE TABLE `materials` (
  `material_id` int(10) UNSIGNED NOT NULL,
  `offering_id` int(10) UNSIGNED NOT NULL,
  `title` varchar(200) NOT NULL,
  `type` varchar(30) NOT NULL,
  `upload_date` date NOT NULL,
  `week_number` tinyint(3) UNSIGNED DEFAULT NULL,
  `url` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `materials`
--

INSERT INTO `materials` (`material_id`, `offering_id`, `title`, `type`, `upload_date`, `week_number`, `url`) VALUES
(1, 1, 'CS101 Syllabus', 'pdf', '2025-09-01', 1, 'https://lms.univer.uz/materials/cs101_syllabus.pdf'),
(2, 1, 'Lecture 1 - Intro to Python', 'slides', '2025-09-02', 1, 'https://lms.univer.uz/materials/cs101_lec1_intro.pptx'),
(3, 2, 'IS201 Syllabus', 'pdf', '2025-09-01', 1, 'https://lms.univer.uz/materials/is201_syllabus.pdf'),
(4, 2, 'Lecture 1 - IS in Organizations', 'slides', '2025-09-03', 1, 'https://lms.univer.uz/materials/is201_lec1_is_orgs.pptx'),
(5, 3, 'MATH101 Syllabus', 'pdf', '2025-09-01', 1, 'https://lms.univer.uz/materials/math101_syllabus.pdf'),
(6, 3, 'Lecture 1 - Limits', 'pdf', '2025-09-02', 1, 'https://lms.univer.uz/materials/math101_lec1_limits.pdf');

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `student_id` int(10) UNSIGNED NOT NULL,
  `major` varchar(100) DEFAULT NULL,
  `study_year` tinyint(3) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`student_id`, `major`, `study_year`) VALUES
(5, 'Computer Science', 1),
(6, 'Computer Science', 1),
(7, 'Computer Science', 2),
(8, 'Information Systems', 2),
(9, 'Mathematics', 1);

-- --------------------------------------------------------

--
-- Table structure for table `submissions`
--

CREATE TABLE `submissions` (
  `submission_id` int(10) UNSIGNED NOT NULL,
  `assignment_id` int(10) UNSIGNED NOT NULL,
  `student_id` int(10) UNSIGNED NOT NULL,
  `submitted_at` datetime NOT NULL,
  `content_url` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `submissions`
--

INSERT INTO `submissions` (`submission_id`, `assignment_id`, `student_id`, `submitted_at`, `content_url`) VALUES
(1, 1, 5, '2025-09-18 20:00:00', 'https://lms.univer.uz/submissions/cs101_hw1_s5.zip'),
(2, 1, 6, '2025-09-18 20:15:00', 'https://lms.univer.uz/submissions/cs101_hw1_s6.zip'),
(3, 1, 7, '2025-09-19 19:50:00', 'https://lms.univer.uz/submissions/cs101_hw1_s7.zip'),
(4, 1, 8, '2025-09-19 21:10:00', 'https://lms.univer.uz/submissions/cs101_hw1_s8.zip'),
(5, 1, 9, '2025-09-20 22:05:00', 'https://lms.univer.uz/submissions/cs101_hw1_s9.zip'),
(6, 2, 5, '2025-10-03 19:30:00', 'https://lms.univer.uz/submissions/cs101_hw2_s5.zip'),
(7, 2, 6, '2025-10-04 21:00:00', 'https://lms.univer.uz/submissions/cs101_hw2_s6.zip'),
(8, 2, 7, '2025-10-05 20:45:00', 'https://lms.univer.uz/submissions/cs101_hw2_s7.zip'),
(9, 3, 5, '2025-09-28 18:00:00', 'https://lms.univer.uz/submissions/is201_case1_s5.pdf'),
(10, 3, 8, '2025-09-29 17:30:00', 'https://lms.univer.uz/submissions/is201_case1_s8.pdf'),
(11, 4, 7, '2025-09-21 16:00:00', 'https://lms.univer.uz/submissions/math101_hw1_s7.pdf'),
(12, 4, 9, '2025-09-21 16:20:00', 'https://lms.univer.uz/submissions/math101_hw1_s9.pdf');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(10) UNSIGNED NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `role` enum('student','instructor','admin') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `full_name`, `email`, `role`) VALUES
(1, 'Alice Admin', 'alice.admin@lms.uz', 'admin'),
(2, 'Bob Admin', 'bob.admin@lms.uz', 'admin'),
(3, 'Dr. John Smith', 'john.smith@lms.uz', 'instructor'),
(4, 'Dr. Emily Clark', 'emily.clark@lms.uz', 'instructor'),
(5, 'Adam Johnson', 'adam.johnson@lms.uz', 'student'),
(6, 'Bella Rossi', 'bella.rossi@lms.uz', 'student'),
(7, 'Carlos Martinez', 'carlos.martinez@lms.uz', 'student'),
(8, 'Diana Petrova', 'diana.petrova@lms.uz', 'student'),
(9, 'Ethan Zhang', 'ethan.zhang@lms.uz', 'student');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`admin_id`);

--
-- Indexes for table `assignments`
--
ALTER TABLE `assignments`
  ADD PRIMARY KEY (`assignment_id`),
  ADD KEY `fk_assignments_offering` (`offering_id`);

--
-- Indexes for table `courses`
--
ALTER TABLE `courses`
  ADD PRIMARY KEY (`course_id`),
  ADD UNIQUE KEY `code` (`code`);

--
-- Indexes for table `course_offerings`
--
ALTER TABLE `course_offerings`
  ADD PRIMARY KEY (`offering_id`),
  ADD KEY `fk_offerings_course` (`course_id`);

--
-- Indexes for table `enrollments`
--
ALTER TABLE `enrollments`
  ADD PRIMARY KEY (`enrollment_id`),
  ADD UNIQUE KEY `uc_enroll_student_offering` (`student_id`,`offering_id`),
  ADD KEY `fk_enroll_offering` (`offering_id`);

--
-- Indexes for table `grades`
--
ALTER TABLE `grades`
  ADD PRIMARY KEY (`grade_id`),
  ADD UNIQUE KEY `submission_id` (`submission_id`);

--
-- Indexes for table `instructors`
--
ALTER TABLE `instructors`
  ADD PRIMARY KEY (`instructor_id`);

--
-- Indexes for table `instructor_offering`
--
ALTER TABLE `instructor_offering`
  ADD PRIMARY KEY (`offering_id`,`instructor_id`),
  ADD KEY `fk_instr_offering_instr` (`instructor_id`);

--
-- Indexes for table `materials`
--
ALTER TABLE `materials`
  ADD PRIMARY KEY (`material_id`),
  ADD KEY `fk_materials_offering` (`offering_id`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`student_id`);

--
-- Indexes for table `submissions`
--
ALTER TABLE `submissions`
  ADD PRIMARY KEY (`submission_id`),
  ADD UNIQUE KEY `uc_submission_once` (`assignment_id`,`student_id`),
  ADD KEY `fk_submissions_student` (`student_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `assignments`
--
ALTER TABLE `assignments`
  MODIFY `assignment_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `courses`
--
ALTER TABLE `courses`
  MODIFY `course_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `course_offerings`
--
ALTER TABLE `course_offerings`
  MODIFY `offering_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `enrollments`
--
ALTER TABLE `enrollments`
  MODIFY `enrollment_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `grades`
--
ALTER TABLE `grades`
  MODIFY `grade_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `materials`
--
ALTER TABLE `materials`
  MODIFY `material_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `submissions`
--
ALTER TABLE `submissions`
  MODIFY `submission_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `admins`
--
ALTER TABLE `admins`
  ADD CONSTRAINT `fk_admins_user` FOREIGN KEY (`admin_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `assignments`
--
ALTER TABLE `assignments`
  ADD CONSTRAINT `fk_assignments_offering` FOREIGN KEY (`offering_id`) REFERENCES `course_offerings` (`offering_id`);

--
-- Constraints for table `course_offerings`
--
ALTER TABLE `course_offerings`
  ADD CONSTRAINT `fk_offerings_course` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`);

--
-- Constraints for table `enrollments`
--
ALTER TABLE `enrollments`
  ADD CONSTRAINT `fk_enroll_offering` FOREIGN KEY (`offering_id`) REFERENCES `course_offerings` (`offering_id`),
  ADD CONSTRAINT `fk_enroll_student` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`);

--
-- Constraints for table `grades`
--
ALTER TABLE `grades`
  ADD CONSTRAINT `fk_grades_submission` FOREIGN KEY (`submission_id`) REFERENCES `submissions` (`submission_id`);

--
-- Constraints for table `instructors`
--
ALTER TABLE `instructors`
  ADD CONSTRAINT `fk_instructors_user` FOREIGN KEY (`instructor_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `instructor_offering`
--
ALTER TABLE `instructor_offering`
  ADD CONSTRAINT `fk_instr_offering_instr` FOREIGN KEY (`instructor_id`) REFERENCES `instructors` (`instructor_id`),
  ADD CONSTRAINT `fk_instr_offering_off` FOREIGN KEY (`offering_id`) REFERENCES `course_offerings` (`offering_id`);

--
-- Constraints for table `materials`
--
ALTER TABLE `materials`
  ADD CONSTRAINT `fk_materials_offering` FOREIGN KEY (`offering_id`) REFERENCES `course_offerings` (`offering_id`);

--
-- Constraints for table `students`
--
ALTER TABLE `students`
  ADD CONSTRAINT `fk_students_user` FOREIGN KEY (`student_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `submissions`
--
ALTER TABLE `submissions`
  ADD CONSTRAINT `fk_submissions_assignment` FOREIGN KEY (`assignment_id`) REFERENCES `assignments` (`assignment_id`),
  ADD CONSTRAINT `fk_submissions_student` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
