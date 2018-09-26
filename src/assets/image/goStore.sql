-- phpMyAdmin SQL Dump
-- version 4.5.4.1deb2ubuntu2.1
-- http://www.phpmyadmin.net
--
-- Máy chủ: localhost
-- Thời gian đã tạo: Th9 25, 2018 lúc 06:59 PM
-- Phiên bản máy phục vụ: 5.7.23-0ubuntu0.16.04.1
-- Phiên bản PHP: 7.2.9-1+ubuntu16.04.1+deb.sury.org+1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `hrm_api`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `branches`
--

CREATE TABLE `branches` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `website` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `facebook` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `instagram` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `zalo` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `about` text COLLATE utf8mb4_unicode_ci,
  `tax_number` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `bank` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city_id` int(10) UNSIGNED DEFAULT NULL,
  `district_id` int(10) UNSIGNED DEFAULT NULL,
  `type` tinyint(1) NOT NULL DEFAULT '0',
  `status` tinyint(3) UNSIGNED DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `branches`
--

INSERT INTO `branches` (`id`, `name`, `address`, `phone`, `website`, `email`, `facebook`, `instagram`, `zalo`, `description`, `about`, `tax_number`, `bank`, `city_id`, `district_id`, `type`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Chi nhánh Cát Linh', 'address_1', 'phone_1', 'website_1', 'email_1', 'facebook_1', 'instagram_1', 'zalo_1', 'description_1', 'about_1', 'tax_number_1', 'bank_1', 2, 4, 1, 1, NULL, NULL),
(2, 'Chi nhánh Láng Hạ', 'address_2', 'phone_2', 'website_2', 'email_2', 'facebook_2', 'instagram_2', 'zalo_2', 'description_2', 'about_2', 'tax_number_2', 'bank_2', 2, 4, 0, 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `candidates`
--

CREATE TABLE `candidates` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `source` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_apply` date DEFAULT NULL,
  `time_interview` datetime DEFAULT NULL,
  `plan_id` int(10) UNSIGNED NOT NULL,
  `position_id` int(10) UNSIGNED NOT NULL,
  `status` tinyint(3) UNSIGNED DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `candidates`
--

INSERT INTO `candidates` (`id`, `name`, `email`, `phone`, `source`, `date_apply`, `time_interview`, `plan_id`, `position_id`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Nguyễn Văn A', NULL, NULL, NULL, NULL, NULL, 1, 5, 0, NULL, NULL),
(2, 'Nguyễn Văn B', NULL, NULL, NULL, NULL, NULL, 1, 5, 1, NULL, NULL),
(3, 'Nguyễn Văn C', NULL, NULL, NULL, NULL, NULL, 2, 6, 2, NULL, NULL),
(4, 'Nguyễn Thị D', NULL, NULL, NULL, NULL, NULL, 2, 6, 3, NULL, NULL),
(5, 'Nguyễn Thị E', NULL, NULL, NULL, NULL, NULL, 3, 5, 0, NULL, NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `cities`
--

CREATE TABLE `cities` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(35) COLLATE utf8mb4_unicode_ci NOT NULL,
  `zipcode` mediumint(8) UNSIGNED NOT NULL,
  `order` tinyint(3) UNSIGNED NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `cities`
--

INSERT INTO `cities` (`id`, `name`, `slug`, `zipcode`, `order`, `status`) VALUES
(1, 'Hồ Chí Minh', 'Ho-Chi-Minh', 700000, 1, 1),
(2, 'Hà Nội', 'Ha-Noi', 100000, 2, 1),
(3, 'An Giang', 'An-Giang', 880000, 3, 1),
(4, 'Bà Rịa - Vũng Tàu', 'Ba-Ria-Vung-Tau', 790000, 4, 1),
(5, 'Bắc Cạn', 'Bac-Can', 960000, 5, 1),
(6, 'Bắc Giang', 'Bac-Giang', 230000, 6, 1),
(7, 'Bạc Liêu', 'Bac-Lieu', 260000, 7, 1),
(8, 'Bắc Ninh', 'Bac-Ninh', 220000, 8, 1),
(9, 'Bến Tre', 'Ben-Tre', 930000, 9, 1),
(10, 'Bình Định', 'Binh-Dinh', 590000, 10, 1),
(11, 'Bình Dương', 'Binh-Duong', 820000, 11, 1),
(12, 'Bình Phước', 'Binh-Phuoc', 830000, 12, 1),
(13, 'Bình Thuận', 'Binh-Thuan', 800000, 13, 1),
(14, 'Cà Mau', 'Ca-Mau', 970000, 14, 1),
(15, 'Cần Thơ', 'Can-Tho', 900000, 15, 1),
(16, 'Cao Bằng', 'Cao-Bang', 270000, 16, 1),
(17, 'Đà Nẵng', 'Da-Nang', 550000, 17, 1),
(18, 'Đắc Lắc', 'Dac-Lac', 630000, 18, 1),
(19, 'Đắk Nông', 'Dak-Nong', 640000, 19, 1),
(20, 'Điện Biên', 'Dien-Bien', 380000, 20, 1),
(21, 'Đồng Nai', 'Dong-Nai', 810000, 21, 1),
(22, 'Đồng Tháp', 'Dong-Thap', 870000, 22, 1),
(23, 'Gia Lai', 'Gia-Lai', 600000, 23, 1),
(24, 'Hà Giang', 'Ha-Giang', 310000, 24, 1),
(25, 'Hà Nam', 'Ha-Nam', 400000, 25, 1),
(26, 'Hà Tĩnh', 'Ha-Tinh', 480000, 26, 1),
(27, 'Hải Dương', 'Hai-Duong', 170000, 27, 1),
(28, 'Hải Phòng', 'Hai-Phong', 180000, 28, 1),
(29, 'Hậu Giang', 'Hau-Giang', 910000, 29, 1),
(30, 'Hòa Bình', 'Hoa-Binh', 350000, 30, 1),
(31, 'Hưng Yên', 'Hung-Yen', 160000, 31, 1),
(32, 'Khánh Hòa', 'Khanh-Hoa', 650000, 32, 1),
(33, 'Kiên Giang', 'Kien-Giang', 920000, 33, 1),
(34, 'Kon Tum', 'Kon-Tum', 580000, 34, 1),
(35, 'Lai Châu', 'Lai-Chau', 390000, 35, 1),
(36, 'Lâm Đồng', 'Lam-Dong', 670000, 36, 1),
(37, 'Lạng Sơn', 'Lang-Son', 240000, 37, 1),
(38, 'Lào Cai', 'Lao-Cai', 330000, 38, 1),
(39, 'Long An', 'Long-An', 850000, 39, 1),
(40, 'Nam Định', 'Nam-Dinh', 420000, 40, 1),
(41, 'Nghệ An', 'Nghe-An', 460000, 41, 1),
(42, 'Ninh Bình', 'Ninh-Binh', 430000, 42, 1),
(43, 'Ninh Thuận', 'Ninh-Thuan', 660000, 43, 1),
(44, 'Phú Thọ', 'Phu-Tho', 290000, 44, 1),
(45, 'Phú Yên', 'Phu-Yen', 620000, 45, 1),
(46, 'Quảng Bình', 'Quang-Binh', 510000, 46, 1),
(47, 'Quảng Nam', 'Quang-Nam', 560000, 47, 1),
(48, 'Quảng Ngãi', 'Quang-Ngai', 570000, 48, 1),
(49, 'Quảng Ninh', 'Quang-Ninh', 200000, 49, 1),
(50, 'Quảng Trị', 'Quang-Tri', 520000, 50, 1),
(51, 'Sóc Trăng', 'Soc-Trang', 950000, 51, 1),
(52, 'Sơn La', 'Son-La', 360000, 52, 1),
(53, 'Tây Ninh', 'Tay-Ninh', 840000, 53, 1),
(54, 'Thái Bình', 'Thai-Binh', 410000, 54, 1),
(55, 'Thái Nguyên', 'Thai-Nguyen', 250000, 55, 1),
(56, 'Thanh Hoá', 'Thanh-Hoa', 440000, 56, 1),
(57, 'Thừa Thiên - Huế', 'Thua-Thien-Hue', 530000, 57, 1),
(58, 'Tiền Giang', 'Tien-Giang', 860000, 58, 1),
(59, 'Trà Vinh', 'Tra-Vinh', 940000, 59, 1),
(60, 'Tuyên Quang', 'Tuyen-Quang', 300000, 60, 1),
(61, 'Vĩnh Long', 'Vinh-Long', 890000, 61, 1),
(62, 'Vĩnh Phúc', 'Vinh-Phuc', 280000, 62, 1),
(63, 'Yên Bái', 'Yen-Bai', 320000, 63, 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `contracts`
--

CREATE TABLE `contracts` (
  `id` int(10) UNSIGNED NOT NULL,
  `code` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` tinyint(3) UNSIGNED NOT NULL,
  `title` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint(3) UNSIGNED DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `contracts`
--

INSERT INTO `contracts` (`id`, `code`, `type`, `title`, `status`, `created_at`, `updated_at`) VALUES
(1, '', 0, 'Hợp đồng học việc', 1, NULL, NULL),
(2, '', 1, 'Hợp đồng thử việc', 1, NULL, NULL),
(3, '', 2, 'Hợp đồng cộng tác viên', 1, NULL, NULL),
(4, '', 3, 'Hợp đồng chính thức có thời hạn', 1, NULL, NULL),
(5, '', 4, 'Hợp đồng chính thức không thời hạn', 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `contract_user`
--

CREATE TABLE `contract_user` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `contract_id` int(10) UNSIGNED NOT NULL,
  `link` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_sign` date NOT NULL,
  `date_effective` date NOT NULL,
  `status` tinyint(3) UNSIGNED DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `contract_user`
--

INSERT INTO `contract_user` (`id`, `user_id`, `contract_id`, `link`, `date_sign`, `date_effective`, `status`, `created_at`, `updated_at`) VALUES
(1, 2, 1, NULL, '0000-00-00', '0000-00-00', 1, NULL, NULL),
(2, 2, 2, NULL, '0000-00-00', '0000-00-00', 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `departments`
--

CREATE TABLE `departments` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `branch_id` int(10) UNSIGNED NOT NULL,
  `status` tinyint(3) UNSIGNED NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `departments`
--

INSERT INTO `departments` (`id`, `name`, `branch_id`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Phòng Nhân Sự', 1, 1, NULL, NULL),
(2, 'Phòng IT', 1, 1, NULL, NULL),
(3, 'Phòng Kế toán', 1, 1, NULL, NULL),
(4, 'Phòng Nhân Sự', 2, 1, NULL, NULL),
(5, 'Phòng IT', 2, 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `department_user`
--

CREATE TABLE `department_user` (
  `user_id` int(10) UNSIGNED NOT NULL,
  `department_id` int(10) UNSIGNED NOT NULL,
  `position_id` int(10) UNSIGNED NOT NULL,
  `status` tinyint(3) UNSIGNED NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `department_user`
--

INSERT INTO `department_user` (`user_id`, `department_id`, `position_id`, `status`, `created_at`, `updated_at`) VALUES
(5, 5, 1, 1, NULL, NULL),
(8, 1, 1, 1, NULL, NULL),
(8, 4, 5, 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `districts`
--

CREATE TABLE `districts` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(35) COLLATE utf8mb4_unicode_ci NOT NULL,
  `zipcode` mediumint(8) UNSIGNED NOT NULL,
  `order` tinyint(3) UNSIGNED NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `city_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `districts`
--

INSERT INTO `districts` (`id`, `name`, `slug`, `zipcode`, `order`, `status`, `city_id`) VALUES
(1, 'Quận Ba Đình', 'Quan-Ba-Dinh', 0, 1, 1, 2),
(2, 'Quận Hoàn Kiếm', 'Quan-Hoan-Kiem', 0, 2, 1, 2),
(3, 'Quận Hai Bà Trưng', 'Quan-Hai-Ba-Trung', 0, 3, 1, 2),
(4, 'Quận Đống Đa', 'Quan-Dong-Da', 0, 4, 1, 2),
(5, 'Quận Tây Hồ', 'Quan-Tay-Ho', 0, 5, 1, 2),
(6, 'Quận Cầu Giấy', 'Quan-Cau-Giay', 0, 6, 1, 2),
(7, 'Quận Thanh Xuân', 'Quan-Thanh-Xuan', 0, 7, 1, 2),
(8, 'Quận Hoàng Mai', 'Quan-Hoang-Mai', 0, 8, 1, 2),
(9, 'Quận Long Biên', 'Quan-Long-Bien', 0, 9, 1, 2),
(10, 'Huyện Từ Liêm', 'Huyen-Tu-Liem', 0, 10, 1, 2),
(11, 'Huyện Thanh Trì', 'Huyen-Thanh-Tri', 0, 11, 1, 2),
(12, 'Huyện Gia Lâm', 'Huyen-Gia-Lam', 0, 12, 1, 2),
(13, 'Huyện Đông Anh', 'Huyen-Dong-Anh', 0, 13, 1, 2),
(14, 'Huyện Sóc Sơn', 'Huyen-Soc-Son', 0, 14, 1, 2),
(15, 'Thành phố Hà Đông', 'Thanh-pho-Ha-Dong', 0, 15, 1, 2),
(16, 'Thành phố Sơn Tây', 'Thanh-pho-Son-Tay', 0, 16, 1, 2),
(17, 'Huyện Ba Vì', 'Huyen-Ba-Vi', 0, 17, 1, 2),
(18, 'Huyện Phúc Thọ', 'Huyen-Phuc-Tho', 0, 18, 1, 2),
(19, 'Huyện Thạch Thất', 'Huyen-Thach-That', 0, 19, 1, 2),
(20, 'Huyện Quốc Oai', 'Huyen-Quoc-Oai', 0, 20, 1, 2),
(21, 'Huyện Chương Mỹ', 'Huyen-Chuong-My', 0, 21, 1, 2),
(22, 'Huyện Đan Phượng', 'Huyen-Dan-Phuong', 0, 22, 1, 2),
(23, 'Huyện Hoài Đức', 'Huyen-Hoai-Duc', 0, 23, 1, 2),
(24, 'Huyện Thanh Oai', 'Huyen-Thanh-Oai', 0, 24, 1, 2),
(25, 'Huyện Mỹ Đức', 'Huyen-My-Duc', 0, 25, 1, 2),
(26, 'Huyện Ứng Hòa', 'Huyen-Ung-Hoa', 0, 26, 1, 2),
(27, 'Huyện Thường Tín', 'Huyen-Thuong-Tin', 0, 27, 1, 2),
(28, 'Huyện Phú Xuyên', 'Huyen-Phu-Xuyen', 0, 28, 1, 2),
(29, 'Huyện Mê Linh', 'Huyen-Me-Linh', 0, 29, 1, 2),
(30, 'Quận Một', 'Quan-Mot', 0, 1, 1, 1),
(31, 'Quận Hai', 'Quan-Hai', 0, 2, 1, 1),
(32, 'Quận Ba', 'Quan-Ba', 0, 3, 1, 1),
(33, 'Quận Bốn', 'Quan-Bon', 0, 4, 1, 1),
(34, 'Quận Năm', 'Quan-Nam', 0, 5, 1, 1),
(35, 'Quận Sáu', 'Quan-Sau', 0, 6, 1, 1),
(36, 'Quận Bảy', 'Quan-Bay', 0, 7, 1, 1),
(37, 'Quận Tám', 'Quan-Tam', 0, 8, 1, 1),
(38, 'Quận Chín', 'Quan-Chin', 0, 9, 1, 1),
(39, 'Quận Mười', 'Quan-Muoi', 0, 10, 1, 1),
(40, 'Quận Mười một', 'Quan-Muoi-mot', 0, 11, 1, 1),
(41, 'Quận Mười hai', 'Quan-Muoi-hai', 0, 12, 1, 1),
(42, 'Quận Gò Vấp', 'Quan-Go-Vap', 0, 13, 1, 1),
(43, 'Quận Tân Bình', 'Quan-Tan-Binh', 0, 14, 1, 1),
(44, 'Quận Tân Phú', 'Quan-Tan-Phu', 0, 15, 1, 1),
(45, 'Quận Bình Thạnh', 'Quan-Binh-Thanh', 0, 16, 1, 1),
(46, 'Quận Phú Nhuận', 'Quan-Phu-Nhuan', 0, 17, 1, 1),
(47, 'Quận Thủ Đức', 'Quan-Thu-Duc', 0, 18, 1, 1),
(48, 'Quận Bình Tân', 'Quan-Binh-Tan', 0, 19, 1, 1),
(49, 'Huyện Bình Chánh', 'Huyen-Binh-Chanh', 0, 20, 1, 1),
(50, 'Huyện Củ Chi', 'Huyen-Cu-Chi', 0, 21, 1, 1),
(51, 'Huyện Hóc Môn', 'Huyen-Hoc-Mon', 0, 22, 1, 1),
(52, 'Huyện Nhà Bè', 'Huyen-Nha-Be', 0, 23, 1, 1),
(53, 'Huyện Cần Giờ', 'Huyen-Can-Gio', 0, 24, 1, 1),
(55, 'Quận Hồng Bàng', 'Quan-Hong-Bang', 0, 1, 1, 28),
(56, 'Quận Lê Chân', 'Quan-Le-Chan', 0, 2, 1, 28),
(57, 'Quận Ngô Quyền', 'Quan-Ngo-Quyen', 0, 3, 1, 28),
(58, 'Quận Kiến An', 'Quan-Kien-An', 0, 4, 1, 28),
(59, 'Quận Hải An', 'Quan-Hai-An', 0, 5, 1, 28),
(60, 'Quận Đồ Sơn', 'Quan-Do-Son', 0, 6, 1, 28),
(61, 'Huyện An Lão', 'Huyen-An-Lao', 0, 7, 1, 28),
(62, 'Huyện Kiến Thụy', 'Huyen-Kien-Thuy', 0, 8, 1, 28),
(63, 'Huyện Thủy Nguyên', 'Huyen-Thuy-Nguyen', 0, 9, 1, 28),
(64, 'Huyện An Dương', 'Huyen-An-Duong', 0, 10, 1, 28),
(65, 'Huyện Tiên Lãng', 'Huyen-Tien-Lang', 0, 11, 1, 28),
(66, 'Huyện Vĩnh Bảo', 'Huyen-Vinh-Bao', 0, 12, 1, 28),
(67, 'Huyện Cát Hải', 'Huyen-Cat-Hai', 0, 13, 1, 28),
(68, 'Huyện Bạch Long Vĩ', 'Huyen-Bach-Long-Vi', 0, 14, 1, 28),
(69, 'Quận Dương Kinh', 'Quan-Duong-Kinh', 0, 15, 1, 28),
(70, 'Quận Hải Châu', 'Quan-Hai-Chau', 0, 1, 1, 17),
(71, 'Quận Thanh Khê', 'Quan-Thanh-Khe', 0, 2, 1, 17),
(72, 'Quận Sơn Trà', 'Quan-Son-Tra', 0, 3, 1, 17),
(73, 'Quận Ngũ Hành Sơn', 'Quan-Ngu-Hanh-Son', 0, 4, 1, 17),
(74, 'Quận Liên Chiểu', 'Quan-Lien-Chieu', 0, 5, 1, 17),
(75, 'Huyện Hoà Vang', 'Huyen-Hoa-Vang', 0, 6, 1, 17),
(76, 'Quận Cẩm Lệ', 'Quan-Cam-Le', 0, 7, 1, 17),
(77, 'Thị xã Hà Giang', 'Thi-xa-Ha-Giang', 0, 1, 1, 24),
(78, 'Huyện Đồng Văn', 'Huyen-Dong-Van', 0, 2, 1, 24),
(79, 'Huyện Mèo Vạc', 'Huyen-Meo-Vac', 0, 3, 1, 24),
(80, 'Huyện Yên Minh', 'Huyen-Yen-Minh', 0, 4, 1, 24),
(81, 'Huyện Quản Bạ', 'Huyen-Quan-Ba', 0, 5, 1, 24),
(82, 'Huyện Vị Xuyên', 'Huyen-Vi-Xuyen', 0, 6, 1, 24),
(83, 'Huyện Bắc Mê', 'Huyen-Bac-Me', 0, 7, 1, 24),
(84, 'Huyện Hoàng Su Phì', 'Huyen-Hoang-Su-Phi', 0, 8, 1, 24),
(85, 'Huyện Xín Mần', 'Huyen-Xin-Man', 0, 9, 1, 24),
(86, 'Huyện Bắc Quang', 'Huyen-Bac-Quang', 0, 10, 1, 24),
(87, 'Huyện Quang Bình', 'Huyen-Quang-Binh', 0, 11, 1, 24),
(88, 'Thị xã Cao Bằng', 'Thi-xa-Cao-Bang', 0, 1, 1, 16),
(89, 'Huyện Bảo Lạc', 'Huyen-Bao-Lac', 0, 2, 1, 16),
(90, 'Huyện Thông Nông', 'Huyen-Thong-Nong', 0, 3, 1, 16),
(91, 'Huyện Hà Quảng', 'Huyen-Ha-Quang', 0, 4, 1, 16),
(92, 'Huyện Trà Lĩnh', 'Huyen-Tra-Linh', 0, 5, 1, 16),
(93, 'Huyện Trùng Khánh', 'Huyen-Trung-Khanh', 0, 6, 1, 16),
(94, 'Huyện Nguyên Bình', 'Huyen-Nguyen-Binh', 0, 7, 1, 16),
(95, 'Huyện Hoà An', 'Huyen-Hoa-An', 0, 8, 1, 16),
(96, 'Huyện Quảng Uyên', 'Huyen-Quang-Uyen', 0, 9, 1, 16),
(97, 'Huyện Thạch An', 'Huyện Thạch An', 0, 10, 1, 16),
(98, 'Huyện Hạ Lang', 'Huyện Hạ Lang', 0, 11, 1, 16),
(99, 'Huyện Bảo Lâm', 'Huyện Bảo Lâm', 0, 12, 1, 16),
(100, 'Huyện Phục Hoà', 'Huyện Phục Hoà', 0, 13, 1, 16),
(101, 'Thị xã Lai Châu', 'Thi-xa-Lai-Chau', 0, 1, 1, 35),
(102, 'Huyện Tam Đường', 'Huyen-Tam-Duong', 0, 2, 1, 35),
(103, 'Huyện Phong Thổ', 'Huyen-Phong-Tho', 0, 3, 1, 35),
(104, 'Huyện Sìn Hồ', 'Huyen-Sin-Ho', 0, 4, 1, 35),
(105, 'Huyện Mường Tè', 'Huyen-Muong-Te', 0, 5, 1, 35),
(106, 'Huyện Than Uyên', 'Huyen-Than-Uyen', 0, 6, 1, 35),
(107, 'Huyện Tân Uyên', 'Huyen-Tan-Uyen', 0, 7, 1, 35),
(108, 'Thành phố Lào Cai', 'Thanh-pho-Lao-Cai', 0, 1, 1, 38),
(109, 'Huyện Xi Ma Cai', 'Huyen-Xi-Ma-Cai', 0, 2, 1, 38),
(110, 'Huyện Bát Xát', 'Huyen-Bat-Xat', 0, 3, 1, 38),
(111, 'Huyện Bảo Thắng', 'Huyen-Bao-Thang', 0, 4, 1, 38),
(112, 'Huyện Sa Pa', 'Huyen-Sa-Pa', 0, 5, 1, 38),
(113, 'Huyện Văn Bàn', 'Huyen-Van-Ban', 0, 6, 1, 38),
(114, 'Huyện Bảo Yên', 'Huyen-Bao-Yen', 0, 7, 1, 38),
(115, 'Huyện Bắc Hà', 'Huyen-Bac-Ha', 0, 8, 1, 38),
(116, 'Huyện Mường Khương', 'Huyen-Muong-Khuong', 0, 9, 1, 38),
(117, 'Thị xã Tuyên Quang', 'Thi-xa-Tuyen-Quang', 0, 1, 1, 60),
(118, 'Huyện Na Hang', 'Huyen-Na-Hang', 0, 11, 1, 60),
(119, 'Huyện Chiêm Hoá', 'Huyen-Chiem-Hoa', 0, 12, 1, 60),
(120, 'Huyện Hàm Yên', 'Huyen-Ham-Yen', 0, 13, 1, 60),
(121, 'Huyện Yên Sơn', 'Huyen-Yen-Son', 0, 14, 1, 60),
(122, 'Huyện Sơn Dương', 'Huyen-Son-Duong', 0, 15, 1, 60),
(123, 'Thành phố Lạng Sơn', 'Thanh-pho-Lang-Son', 0, 1, 1, 37),
(124, 'Huyện Văn Lãng', 'Huyen-Van-Lang', 0, 2, 1, 37),
(125, 'Huyện Bắc Sơn', 'Huyen-Bac-Son', 0, 3, 1, 37),
(126, 'Huyện Lộc Bình', 'Huyen-Loc-Binh', 0, 4, 1, 37),
(127, 'Huyện Chi Lăng', 'Huyen-Chi-Lang', 0, 5, 1, 37),
(128, 'Huyện Tràng Định', 'Huyen-Trang-Dinh', 0, 6, 1, 37),
(129, 'Huyện Bình Gia', 'Huyen-Binh-Gia', 0, 7, 1, 37),
(130, 'Huyện Văn Quan', 'Huyen-Van-Quan', 0, 8, 1, 37),
(131, 'Huyện Cao Lộc', 'Huyen-Cao-Loc', 0, 9, 1, 37),
(132, 'Huyện Đình Lập', 'Huyen-Dinh-Lap', 0, 10, 1, 37),
(133, 'Huyện Hữu Lũng', 'Huyen-Huu-Lung', 0, 11, 1, 37),
(134, 'TP.Long Xuyên', 'TPLong-Xuyen', 0, 1, 1, 3),
(135, 'Thị xã Châu Đốc', 'Thi-xa-Chau-Doc', 0, 2, 1, 3),
(136, 'Huyện An Phú', 'Huyen-An-Phu', 0, 3, 1, 3),
(137, 'Huyện Tân Châu', 'Huyen-Tan-Chau', 0, 4, 1, 3),
(138, 'Huyện Phú Tân', 'Huyen-Phu-Tan', 0, 5, 1, 3),
(139, 'Huyện Tịnh Biên', 'Huyen-Tinh-Bien', 0, 6, 1, 3),
(140, 'Huyện Tri Tôn', 'Huyen-Tri-Ton', 0, 7, 1, 3),
(141, 'Huyện Châu Phú', 'Huyen-Chau-Phu', 0, 8, 1, 3),
(142, 'Huyện Chợ Mới', 'Huyen-Cho-Moi', 0, 9, 1, 3),
(143, 'Huyện Châu Thành', 'Huyen-Chau-Thanh', 0, 10, 1, 3),
(144, 'Huyện Thoại Sơn', 'Huyen-Thoai-Son', 0, 11, 1, 3),
(145, 'Thành phố Vũng Tàu', 'Thanh-pho-Vung-Tau', 0, 1, 1, 4),
(146, 'Thị xã Bà Rịa', 'Thi-xa-Ba-Ria', 0, 2, 1, 4),
(147, 'Huyện Xuyên Mộc', 'Huyen-Xuyen-Moc', 0, 3, 1, 4),
(148, 'Huyện Long Điền', 'Huyen-Long-Dien', 0, 4, 1, 4),
(149, 'Huyện Côn Đảo', 'Huyen-Con-Dao', 0, 5, 1, 4),
(150, 'Huyện Tân Thành', 'Huyen-Tan-Thanh', 0, 6, 1, 4),
(151, 'Huyện Châu Đức', 'Huyen-Chau-Duc', 0, 7, 1, 4),
(152, 'Huyện Đất Đỏ', 'Huyen-Dat-Do', 0, 8, 1, 4),
(153, 'Thành phố Mỹ Tho', 'Thanh-pho-My-Tho', 0, 1, 1, 58),
(154, 'Thị xã Gò Công', 'Thi-xa-Go-Cong', 0, 2, 1, 58),
(155, 'Huyện Cái Bè', 'Huyen-Cai-Be', 0, 3, 1, 58),
(156, 'Huyện Cai Lậy', 'Huyen-Cai-Lay', 0, 4, 1, 58),
(157, 'Huyện Châu Thành', 'Huyen-Chau-Thanh', 0, 5, 1, 58),
(158, 'Huyện Chợ Gạo', 'Huyen-Cho-Gao', 0, 6, 1, 58),
(159, 'Huyện Gò Công Tây', 'Huyen-Go-Cong-Tay', 0, 7, 1, 58),
(160, 'Huyện Gò Công Đông', 'Huyen-Go-Cong-Dong', 0, 8, 1, 58),
(161, 'Huyện Tân Phước', 'Huyen-Tan-Phuoc', 0, 9, 1, 58),
(162, 'Huyện Tân Phú Đông', 'Huyen-Tan-Phu-Dong', 0, 10, 1, 58),
(163, 'Thành phố Rạch Giá', 'Thanh-pho-Rach-Gia', 0, 1, 1, 33),
(164, 'Thị xã Hà Tiên', 'Thi-xa-Ha-Tien', 0, 2, 1, 33),
(165, 'Huyện Kiên Lương', 'Huyen-Kien-Luong', 0, 3, 1, 33),
(166, 'Huyện Hòn Đất', 'Huyen-Hon-Dat', 0, 4, 1, 33),
(167, 'Huyện Tân Hiệp', 'Huyen-Tan-Hiep', 0, 5, 1, 33),
(168, 'Huyện Châu Thành', 'Huyen-Chau-Thanh', 0, 6, 1, 33),
(169, 'Huyện Giồng Riềng', 'Huyen-Giong-Rieng', 0, 7, 1, 33),
(170, 'Huyện Gò Quao', 'Huyen-Go-Quao', 0, 8, 1, 33),
(171, 'Huyện An Biên', 'Huyen-An-Bien', 0, 9, 1, 33),
(172, 'Huyện An Minh', 'Huyen-An-Minh', 0, 10, 1, 33),
(173, 'Huyện Vĩnh Thuận', 'Huyen-Vinh-Thuan', 0, 11, 1, 33),
(174, 'Huyện Phú Quốc', 'Huyen-Phu-Quoc', 0, 12, 1, 33),
(175, 'Huyện Kiên Hải', 'Huyen-Kien-Hai', 0, 13, 1, 33),
(176, 'Huyện U minh Thượng', 'Huyen-U-minh-Thuong', 0, 14, 1, 33),
(177, 'Quận Ninh Kiều', 'Quan-Ninh-Kieu', 0, 1, 1, 15),
(178, 'Quận Bình Thuỷ', 'Quan-Binh-Thuy', 0, 2, 1, 15),
(179, 'Quận Cái Răng', 'Quan-Cai-Rang', 0, 3, 1, 15),
(180, 'Quận Ô Môn', 'Quan-O-Mon', 0, 4, 1, 15),
(181, 'Huyện Phong Điền', 'Huyen-Phong-Dien', 0, 5, 1, 15),
(182, 'Huyện Cờ Đỏ', 'Huyen-Co-Do', 0, 6, 1, 15),
(183, 'Huyện Vĩnh Thạnh', 'Huyen-Vinh-Thanh', 0, 7, 1, 15),
(184, 'Huỵện Thốt Nốt', 'Huyen-Thot-Not', 0, 8, 1, 15),
(185, 'Thị xã Bến Tre', 'Thi-xa-Ben-Tre', 0, 1, 1, 9),
(186, 'Huyện Châu Thành', 'Huyen-Chau-Thanh', 0, 2, 1, 9),
(187, 'Huyện Chợ Lách', 'Huyen-Cho-Lach', 0, 3, 1, 9),
(188, 'Huyện Mỏ Cày', 'Huyen-Mo-Cay', 0, 4, 1, 9),
(189, 'Huyện Giồng Trôm', 'Huyen-Giong-Trom', 0, 5, 1, 9),
(190, 'Huyện Bình Đại', 'Huyen-Binh-Dai', 0, 6, 1, 9),
(191, 'Huyện Ba Tri', 'Huyen-Ba-Tri', 0, 7, 1, 9),
(192, 'Huyện Thạnh Phú', 'Huyen-Thanh-Phu', 0, 8, 1, 9),
(193, 'Thị xã Vĩnh Long', 'Thi-xa-Vinh-Long', 0, 1, 1, 61),
(194, 'Huyện Long Hồ', 'Huyen-Long-Ho', 0, 2, 1, 61),
(195, 'Huyện Mang Thít', 'Huyen-Mang-Thit', 0, 3, 1, 61),
(196, 'Huyện Bình Minh', 'Huyen-Binh-Minh', 0, 4, 1, 61),
(197, 'Huyện Tam Bình', 'Huyen-Tam-Binh', 0, 5, 1, 61),
(198, 'Huyện Trà Ôn', 'Huyen-Tra-On', 0, 6, 1, 61),
(199, 'Huyện Vũng Liêm', 'Huyen-Vung-Liem', 0, 7, 1, 61),
(200, 'Huyện Bình Tân', 'Huyen-Binh-Tan', 0, 8, 1, 61),
(201, 'Thị xã Trà Vinh', 'Thi-xa-Tra-Vinh', 0, 1, 1, 59),
(202, 'Huyện Càng Long', 'Huyen-Cang-Long', 0, 2, 1, 59),
(203, 'Huyện Cầu Kè', 'Huyen-Cau-Ke', 0, 3, 1, 59),
(204, 'Huyện Tiểu Cần', 'Huyen-Tieu-Can', 0, 4, 1, 59),
(205, 'Huyện Châu Thành', 'Huyen-Chau-Thanh', 0, 5, 1, 59),
(206, 'Huyện Trà Cú', 'Huyen-Tra-Cu', 0, 6, 1, 59),
(207, 'Huyện Cầu Ngang', 'Huyen-Cau-Ngang', 0, 7, 1, 59),
(208, 'Huyện Duyên Hải', 'Huyen-Duyen-Hai', 0, 8, 1, 59),
(209, 'Thành phố Sóc Trăng', 'Thanh-pho-Soc-Trang', 0, 1, 1, 51),
(210, 'Huyện Kế Sách', 'Huyen-Ke-Sach', 0, 2, 1, 51),
(211, 'Huyện Mỹ Tú', 'Huyen-My-Tu', 0, 3, 1, 51),
(212, 'Huyện Mỹ Xuyên', 'Huyen-My-Xuyen', 0, 4, 1, 51),
(213, 'Huyện Thạnh Trị', 'Huyen-Thanh-Tri', 0, 5, 1, 51),
(214, 'Huyện Long Phú', 'Huyen-Long-Phu', 0, 6, 1, 51),
(215, 'Huyện Vĩnh Châu', 'Huyen-Vinh-Chau', 0, 7, 1, 51),
(216, 'Huyện Cù Lao Dung', 'Huyen-Cu-Lao-Dung', 0, 8, 1, 51),
(217, 'Huyện Ngã Năm', 'Huyen-Nga-Nam', 0, 9, 1, 51),
(218, 'Huyện Châu Thành', 'Huyen-Chau-Thanh', 0, 10, 1, 51),
(219, 'Thị xã Bạc Liêu', 'Thi-xa-Bac-Lieu', 0, 1, 1, 7),
(220, 'Huyện Vĩnh Lợi', 'Huyen-Vinh-Loi', 0, 2, 1, 7),
(221, 'Huyện Hồng Dân', 'Huyen-Hong-Dan', 0, 3, 1, 7),
(222, 'Huyện Giá Rai', 'Huyen-Gia-Rai', 0, 4, 1, 7),
(223, 'Huyện Phước Long', 'Huyen-Phuoc-Long', 0, 5, 1, 7),
(224, 'Huyện Đông Hải', 'Huyen-Dong-Hai', 0, 6, 1, 7),
(225, 'Huyện Hoà Bình', 'Huyen-Hoa-Binh', 0, 7, 1, 7),
(226, 'Thành phố Cà Mau', 'Thanh-pho-Ca-Mau', 0, 1, 1, 14),
(227, 'Huyện Thới Bình', 'Huyen-Thoi-Binh', 0, 2, 1, 14),
(228, 'Huyện U Minh', 'Huyen-U-Minh', 0, 3, 1, 14),
(229, 'Huyện Trần Văn Thời', 'Huyen-Tran-Van-Thoi', 0, 4, 1, 14),
(230, 'Huyện Cái Nước', 'Huyen-Cai-Nuoc', 0, 5, 1, 14),
(231, 'Huyện Đầm Dơi', 'Huyen-Dam-Doi', 0, 6, 1, 14),
(232, 'Huyện Ngọc Hiển', 'Huyen-Ngoc-Hien', 0, 7, 1, 14),
(233, 'Huyện Năm Căn', 'Huyen-Nam-Can', 0, 8, 1, 14),
(234, 'Huyện Phú Tân', 'Huyen-Phu-Tan', 0, 9, 1, 14),
(235, 'TP. Điện Biên Phủ', 'TP-Dien-Bien-Phu', 0, 1, 1, 20),
(236, 'Thị xã Mường Lay', 'Thi-xa-Muong-Lay', 0, 2, 1, 20),
(237, 'Huyện Điện Biên', 'Huyen-Dien-Bien', 0, 3, 1, 20),
(238, 'Huyện Tuần Giáo', 'Huyen-Tuan-Giao', 0, 4, 1, 20),
(239, 'Huyện Mường Chà', 'Huyen-Muong-Cha', 0, 5, 1, 20),
(240, 'Huyện Tủa Chùa', 'Huyen-Tua-Chua', 0, 6, 1, 20),
(241, 'Huyện Điện Biên Đông', 'Huyen-Dien-Bien-Dong', 0, 7, 1, 20),
(242, 'Huyện Mường Nhé', 'Huyen-Muong-Nhe', 0, 8, 1, 20),
(243, 'Huyện Mường Ảng', 'Huyen-Muong-Ang', 0, 9, 1, 20),
(244, 'Thị xã Gia Nghĩa', 'Thi-xa-Gia-Nghia', 0, 1, 1, 19),
(245, 'Huyện Dăk RLấp', 'Huyen-Dak-RLap', 0, 2, 1, 19),
(246, 'Huyện Dăk Mil', 'Huyen-Dak-Mil', 0, 3, 1, 19),
(247, 'Huyện Cư Jút', 'Huyen-Cu-Jut', 0, 4, 1, 19),
(248, 'Huyện Dăk Song', 'Huyen-Dak-Song', 0, 5, 1, 19),
(249, 'Huyện Krông Nô', 'Huyen-Krong-No', 0, 6, 1, 19),
(250, 'Huyện Dăk GLong', 'Huyen-Dak-GLong', 0, 7, 1, 19),
(251, 'Huyện Tuy Đức', 'Huyen-Tuy-Duc', 0, 8, 1, 19),
(252, 'Thị xã Vị Thanh', 'Thi-xa-Vi-Thanh', 0, 1, 1, 29),
(253, 'Huyện Vị Thuỷ', 'Huyen-Vi-Thuy', 0, 2, 1, 29),
(254, 'Huyện Long Mỹ', 'Huyen-Long-My', 0, 3, 1, 29),
(255, 'Huyện Phụng Hiệp', 'Huyen-Phung-Hiep', 0, 4, 1, 29),
(256, 'Huyện Châu Thành', 'Huyen-Chau-Thanh', 0, 5, 1, 29),
(257, 'Huyện Châu Thành A', 'Huyen-Chau-Thanh-A', 0, 6, 1, 29),
(258, 'Thị xã Ngã Bảy', 'Thi-xa-Nga-Bay', 0, 7, 1, 29),
(259, 'Thị xã Bắc Kạn', 'Thi-xa-Bac-Kan', 0, 1, 1, 5),
(260, 'Huyện Chợ Đồn', 'Huyen-Cho-Don', 0, 2, 1, 5),
(261, 'Huyện Bạch Thông', 'Huyen-Bach-Thong', 0, 3, 1, 5),
(262, 'Huyện Na Rì', 'Huyen-Na-Ri', 0, 4, 1, 5),
(263, 'Huyện Ngân Sơn', 'Huyen-Ngan-Son', 0, 5, 1, 5),
(264, 'Huyện Ba Bể', 'Huyen-Ba-Be', 0, 6, 1, 5),
(265, 'Huyện Chợ Mới', 'Huyen-Cho-Moi', 0, 7, 1, 5),
(266, 'Huyện Pác Nặm', 'Huyen-Pac-Nam', 0, 8, 1, 5),
(267, 'TP. Thái Nguyên', 'TP-Thai-Nguyen', 0, 1, 1, 55),
(268, 'Thị xã Sông Công', 'Thi-xa-Song-Cong', 0, 2, 1, 55),
(269, 'Huyện Định Hoá', 'Huyen-Dinh-Hoa', 0, 3, 1, 55),
(270, 'Huyện Phú Lương', 'Huyen-Phu-Luong', 0, 4, 1, 55),
(271, 'Huyện Võ Nhai&#039;', 'Huyen-Vo-Nhai', 0, 5, 1, 55),
(272, 'Huyện Đại Từ', 'Huyen-Dai-Tu', 0, 6, 1, 55),
(273, 'Huyện Đồng Hỷ', 'Huyen-Dong-Hy', 0, 7, 1, 55),
(274, 'Huyện Phú Bình', 'Huyen-Phu-Binh', 0, 8, 1, 55),
(275, 'Huyện Phổ Yên', 'Huyen-Pho-Yen', 0, 9, 1, 55),
(276, 'Thành phố Yên Bái', 'Thanh-pho-Yen-Bai', 0, 1, 1, 63),
(277, 'Thị xã Nghĩa Lộ', 'Thi-xa-Nghia-Lo', 0, 2, 1, 63),
(278, 'Huyện Văn Yên', 'Huyen-Van-Yen', 0, 3, 1, 63),
(279, 'Huyện Yên Bình', 'Huyen-Yen-Binh', 0, 4, 1, 63),
(280, 'Huyện Mù Cang Chải', 'Huyen-Mu-Cang-Chai', 0, 5, 1, 63),
(281, 'Huyện Văn Chấn', 'Huyen-Van-Chan', 0, 6, 1, 63),
(282, 'Huyện Trấn Yên', 'Huyen-Tran-Yen', 0, 7, 1, 63),
(283, 'Huyện Trạm Tấu', 'Huyen-Tram-Tau', 0, 8, 1, 63),
(284, 'Huyện Lục Yên', 'Huyen-Luc-Yen', 0, 9, 1, 63),
(285, 'Thị xã Sơn La', 'Thi-xa-Son-La', 0, 1, 1, 52),
(286, 'Huyện Quỳnh Nhai', 'Huyen-Quynh-Nhai', 0, 2, 1, 52),
(287, 'Huyện Mường La', 'Huyen-Muong-La', 0, 3, 1, 52),
(288, 'Huyện Thuận Châu', 'Huyen-Thuan-Chau', 0, 4, 1, 52),
(289, 'Huyện Bắc Yên', 'Huyen-Bac-Yen', 0, 5, 1, 52),
(290, 'Huyện Phù Yên', 'Huyen-Phu-Yen', 0, 6, 1, 52),
(291, 'Huyện Mai Sơn', 'Huyen-Mai-Son', 0, 7, 1, 52),
(292, 'Huyện Yên Châu', 'Huyen-Yen-Chau', 0, 8, 1, 52),
(293, 'Huyện Sông Mã', 'Huyen-Song-Ma', 0, 9, 1, 52),
(294, 'Huyện Mộc Châu', 'Huyen-Moc-Chau', 0, 10, 1, 52),
(295, 'Huyện Sốp Cộp', 'Huyen-Sop-Cop', 0, 11, 1, 52),
(296, 'TP. Việt Trì', 'TP-Viet-Tri', 0, 1, 1, 44),
(297, 'Thị xã Phú Thọ', 'Thi-xa-Phu-Tho', 0, 2, 1, 44),
(298, 'Huyện Đoan Hùng', 'Huyen-Doan-Hung', 0, 3, 1, 44),
(299, 'Huyện Thanh Ba', 'Huyen-Thanh-Ba', 0, 4, 1, 44),
(300, 'Huyện Hạ Hoà', 'Huyen-Ha-Hoa', 0, 5, 1, 44),
(301, 'Huyện Cẩm Khê', 'Huyen-Cam-Khe', 0, 6, 1, 44),
(302, 'Huyện Yên Lập', 'Huyen-Yen-Lap', 0, 7, 1, 44),
(303, 'Huyện Thanh Sơn', 'Huyen-Thanh-Son', 0, 8, 1, 44),
(304, 'Huyện Phù Ninh', 'Huyen-Phu-Ninh', 0, 9, 1, 44),
(305, 'Huyện Lâm Thao', 'Huyen-Lam-Thao', 0, 10, 1, 44),
(306, 'Huyện Tam Nông', 'Huyen-Tam-Nong', 0, 11, 1, 44),
(307, 'Huyện Thanh Thủy', 'Huyen-Thanh-Thuy', 0, 12, 1, 44),
(308, 'Huyện Tân Sơn', 'Huyen-Tan-Son', 0, 13, 1, 44),
(309, 'Thành phố Vĩnh Yên', 'Thanh-pho-Vinh-Yen', 0, 1, 1, 62),
(310, 'Huyện Tam Dương', 'Huyen-Tam-Duong', 0, 2, 1, 62),
(311, 'Huyện Lập Thạch', 'Huyen-Lap-Thach', 0, 3, 1, 62),
(312, 'Huyện Vĩnh Tường', 'Huyen-Vinh-Tuong', 0, 4, 1, 62),
(313, 'Huyện Yên Lạc', 'Huyen-Yen-Lac', 0, 5, 1, 62),
(314, 'Huyện Bình Xuyên', 'Huyen-Binh-Xuyen', 0, 6, 1, 62),
(315, 'Thị xã Phúc Yên', 'Thi-xa-Phuc-Yen', 0, 7, 1, 62),
(316, 'Huyện Tam Đảo', 'Huyen-Tam-Dao', 0, 8, 1, 62),
(317, 'TP. Hạ Long', 'TP-Ha-Long', 0, 1, 1, 49),
(318, 'Thị xã Cẩm Phả', 'Thi-xa-Cam-Pha', 0, 2, 1, 49),
(319, 'Thị xã Uông Bí', 'Thi-xa-Uong-Bi', 0, 3, 1, 49),
(320, 'Thị xã Móng Cái', 'Thi-xa-Mong-Cai', 0, 4, 1, 49),
(321, 'Huyện Bình Liêu', 'Huyen-Binh-Lieu', 0, 5, 1, 49),
(322, 'Huyện Đầm Hà', 'Huyen-Dam-Ha', 0, 6, 1, 49),
(323, 'Huyện Hải Hà', 'Huyen-Hai-Ha', 0, 7, 1, 49),
(324, 'Huyện Tiên Yên', 'Huyen-Tien-Yen', 0, 8, 1, 49),
(325, 'Huyện Ba Chẽ', 'Huyen-Ba-Che', 0, 9, 1, 49),
(326, 'Huyện Đông Triều', 'Huyen-Dong-Trieu', 0, 10, 1, 49),
(327, 'Huyện Yên Hưng', 'Huyen-Yen-Hung', 0, 11, 1, 49),
(328, 'Huyện Hoành Bồ', 'Huyen-Hoanh-Bo', 0, 12, 1, 49),
(329, 'Huyện Vân Đồn', 'Huyen-Van-Don', 0, 13, 1, 49),
(330, 'Huyện Cô Tô', 'Huyen-Co-To', 0, 14, 1, 49),
(331, 'Thành phố Bắc Giang', 'Thanh-pho-Bac-Giang', 0, 1, 1, 6),
(332, 'Huyện Yên Thế', 'Huyen-Yen-The', 0, 2, 1, 6),
(333, 'Huyện Lục Ngạn', 'Huyen-Luc-Ngan', 0, 3, 1, 6),
(334, 'Huyện Sơn Động', 'Huyen-Son-Dong', 0, 4, 1, 6),
(335, 'Huyện Lục Nam', 'Huyen-Luc-Nam', 0, 5, 1, 6),
(336, 'Huyện Tân Yên', 'Huyen-Tan-Yen', 0, 6, 1, 6),
(337, 'Huyện Hiệp Hoà', 'Huyen-Hiep-Hoa', 0, 7, 1, 6),
(338, 'Huyện Lạng Giang', 'Huyen-Lang-Giang', 0, 8, 1, 6),
(339, 'Huyện Việt Yên', 'Huyen-Viet-Yen', 0, 9, 1, 6),
(340, 'Huyện Yên Dũng', 'Huyen-Yen-Dung', 0, 10, 1, 6),
(341, 'Thành phố Bắc Ninh', 'Thanh-pho-Bac-Ninh', 0, 1, 1, 8),
(342, 'Huyện Yên Phong', 'Huyen-Yen-Phong', 0, 2, 1, 8),
(343, 'Huyện Quế Võ', 'Huyen-Que-Vo', 0, 3, 1, 8),
(344, 'Huyện Tiên Du', 'Huyen-Tien-Du', 0, 4, 1, 8),
(345, 'Huyện Từ Sơn', 'Huyen-Tu-Son', 0, 5, 1, 8),
(346, 'Huyện Thuận Thành', 'Huyen-Thuan-Thanh', 0, 6, 1, 8),
(347, 'Huyện Gia Bình', 'Huyen-Gia-Binh', 0, 7, 1, 8),
(348, 'Huyện Lương Tài', 'Huyen-Luong-Tai', 0, 8, 1, 8),
(349, 'Thành phố Hải Dương', 'Thanh-pho-Hai-Duong', 0, 1, 1, 27),
(350, 'Huyện Chí Linh', 'Huyen-Chi-Linh', 0, 2, 1, 27),
(351, 'Huyện Nam Sách', 'Huyen-Nam-Sach', 0, 3, 1, 27),
(352, 'Huyện Kinh Môn', 'Huyen-Kinh-Mon', 0, 4, 1, 27),
(353, 'Huyện Gia Lộc', 'Huyen-Gia-Loc', 0, 5, 1, 27),
(354, 'Huyện Tứ Kỳ', 'Huyen-Tu-Ky', 0, 6, 1, 27),
(355, 'Huyện Thanh Miện', 'Huyen-Thanh-Mien', 0, 7, 1, 27),
(356, 'Huyện Ninh Giang', 'Huyen-Ninh-Giang', 0, 8, 1, 27),
(357, 'Huyện Cẩm Giàng', 'Huyen-Cam-Giang', 0, 9, 1, 27),
(358, 'Huyện Thanh Hà', 'Huyen-Thanh-Ha', 0, 10, 1, 27),
(359, 'Huyện Kim Thành', 'Huyen-Kim-Thanh', 0, 11, 1, 27),
(360, 'Huyện Bình Giang', 'Huyen-Binh-Giang', 0, 12, 1, 27),
(361, 'Thị xã Hưng Yên', 'Thi-xa-Hung-Yen', 0, 1, 1, 31),
(362, 'Huyện Kim Động', 'Huyen-Kim-Dong', 0, 2, 1, 31),
(363, 'Huyện Ân Thi', 'Huyen-An-Thi', 0, 3, 1, 31),
(364, 'Huyện Khoái Châu', 'Huyen-Khoai-Chau', 0, 4, 1, 31),
(365, 'Huyện Yên Mỹ', 'Huyen-Yen-My', 0, 5, 1, 31),
(366, 'Huyện Tiên Lữ', 'Huyen-Tien-Lu', 0, 6, 1, 31),
(367, 'Huyện Phù Cừ', 'Huyen-Phu-Cu', 0, 7, 1, 31),
(368, 'Huyện Mỹ Hào', 'Huyen-My-Hao', 0, 8, 1, 31),
(369, 'Huyện Văn Lâm', 'Huyen-Van-Lam', 0, 9, 1, 31),
(370, 'Huyện Văn Giang', 'Huyen-Van-Giang', 0, 10, 1, 31),
(371, 'Thành phố Hoà Bình', 'Thanh-pho-Hoa-Binh', 0, 1, 1, 30),
(372, 'Huyện Đà Bắc', 'Huyen-Da-Bac', 0, 2, 1, 30),
(373, 'Huyện Mai Châu', 'Huyen-Mai-Chau', 0, 3, 1, 30),
(374, 'Huyện Tân Lạc', 'Huyen-Tan-Lac', 0, 4, 1, 30),
(375, 'Huyện Lạc Sơn', 'Huyen-Lac-Son', 0, 5, 1, 30),
(376, 'Huyện Kỳ Sơn', 'Huyen-Ky-Son', 0, 6, 1, 30),
(377, 'Huyện Lương Sơn', 'Huyen-Luong-Son', 0, 7, 1, 30),
(378, 'Huyện Kim Bôi', 'Huyen-Kim-Boi', 0, 8, 1, 30),
(379, 'Huyện Lạc Thuỷ', 'Huyen-Lac-Thuy', 0, 9, 1, 30),
(380, 'Huyện Yên Thuỷ', 'Huyen-Yen-Thuy', 0, 10, 1, 30),
(381, 'Huyện Cao Phong', 'Huyen-Cao-Phong', 0, 11, 1, 30),
(382, 'Thành phố Phủ Lý', 'Thanh-pho-Phu-Ly', 0, 1, 1, 25),
(383, 'Huyện Duy Tiên', 'Huyen-Duy-Tien', 0, 2, 1, 25),
(384, 'Huyện Kim Bảng', 'Huyen-Kim-Bang', 0, 3, 1, 25),
(385, 'Huyện Lý Nhân', 'Huyen-Ly-Nhan', 0, 4, 1, 25),
(386, 'Huỵện Thanh Liêm', 'Huyen-Thanh-Liem', 0, 5, 1, 25),
(387, 'Huyện Bình Lục', 'Huyen-Binh-Luc', 0, 6, 1, 25),
(388, 'TP. Nam Định', 'TP-Nam-Dinh', 0, 1, 1, 40),
(389, 'Huyện Mỹ Lộc', 'Huyen-My-Loc', 0, 2, 1, 40),
(390, 'Huyện Xuân Trường', 'Huyen-Xuan-Truong', 0, 3, 1, 40),
(391, 'Huyện Giao Thủy', 'Huyen-Giao-Thuy', 0, 4, 1, 40),
(392, 'Huyện ý Yên', 'Huyen-y-Yen', 0, 5, 1, 40),
(393, 'Huyện Vụ Bản', 'Huyen-Vu-Ban', 0, 6, 1, 40),
(394, 'Huyện Nam Trực', 'Huyen-Nam-Truc', 0, 7, 1, 40),
(395, 'Huyện Trực Ninh', 'Huyen-Truc-Ninh', 0, 8, 1, 40),
(396, 'Huyện Nghĩa Hưng', 'Huyen-Nghia-Hung', 0, 9, 1, 40),
(397, 'Huyện Hải Hậu', 'Huyen-Hai-Hau', 0, 10, 1, 40),
(398, 'Thành phố Thái Bình', 'Thanh-pho-Thai-Binh', 0, 1, 1, 54),
(399, 'Huyện Quỳnh Phụ', 'Huyen-Quynh-Phu', 0, 2, 1, 54),
(400, 'Huyện Hưng Hà', 'Huyen-Hung-Ha', 0, 3, 1, 54),
(401, 'Huyện Đông Hưng', 'Huyen-Dong-Hung', 0, 4, 1, 54),
(402, 'Huyện Vũ Thư', 'Huyen-Vu-Thu', 0, 5, 1, 54),
(403, 'Huyện Kiến Xương', 'Huyen-Kien-Xuong', 0, 6, 1, 54),
(404, 'Huyện Tiền Hải', 'Huyen-Tien-Hai', 0, 7, 1, 54),
(405, 'Huyện Thái Thuỵ', 'Huyen-Thai-Thuy', 0, 8, 1, 54),
(406, 'Thành phố Ninh Bình', 'Thanh-pho-Ninh-Binh', 0, 1, 1, 42),
(407, 'Thị xã Tam Điệp', 'Thi-xa-Tam-Diep', 0, 2, 1, 42),
(408, 'Huyện Nho Quan', 'Huyen-Nho-Quan', 0, 3, 1, 42),
(409, 'Huyện Gia Viễn', 'Huyen-Gia-Vien', 0, 4, 1, 42),
(410, 'Huyện Hoa Lư', 'Huyen-Hoa-Lu', 0, 5, 1, 42),
(411, 'Huyện Yên Mô', 'Huyen-Yen-Mo', 0, 6, 1, 42),
(412, 'Huyện Kim Sơn', 'Huyen-Kim-Son', 0, 7, 1, 42),
(413, 'Huyện Yên Khánh', 'Huyen-Yen-Khanh', 0, 8, 1, 42),
(414, 'TP.Thanh Hoá', 'TPThanh-Hoa', 0, 1, 1, 56),
(415, 'Thị xã Bỉm Sơn', 'Thi-xa-Bim-Son', 0, 2, 1, 56),
(416, 'Thị xã Sầm Sơn', 'Thi-xa-Sam-Son', 0, 3, 1, 56),
(417, 'Huyện Quan Hoá', 'Huyen-Quan-Hoa', 0, 4, 1, 56),
(418, 'Huyện Quan Sơn', 'Huyen-Quan-Son', 0, 5, 1, 56),
(419, 'Huyện Mường Lát', 'Huyen-Muong-Lat', 0, 6, 1, 56),
(420, 'Huyện Bá Thước', 'Huyen-Ba-Thuoc', 0, 7, 1, 56),
(421, 'Huyện Thường Xuân', 'Huyen-Thuong-Xuan', 0, 8, 1, 56),
(422, 'Huyện Như Xuân', 'Huyen-Nhu-Xuan', 0, 9, 1, 56),
(423, 'Huyện Như Thanh', 'Huyen-Nhu-Thanh', 0, 10, 1, 56),
(424, 'Huyện Lang Chánh', 'Huyen-Lang-Chanh', 0, 11, 1, 56),
(425, 'Huyện Ngọc Lặc', 'Huyen-Ngoc-Lac', 0, 12, 1, 56),
(426, 'Huyện Thạch Thành', 'Huyen-Thach-Thanh', 0, 13, 1, 56),
(427, 'Huyện Cẩm Thủy', 'Huyen-Cam-Thuy', 0, 14, 1, 56),
(428, 'Huyện Thọ Xuân', 'Huyen-Tho-Xuan', 0, 15, 1, 56),
(429, 'Huyện Vĩnh Lộc', 'Huyen-Vinh-Loc', 0, 16, 1, 56),
(430, 'Huyện Thiệu Hoá', 'Huyen-Thieu-Hoa', 0, 17, 1, 56),
(431, 'Huyện Triệu Sơn', 'Huyen-Trieu-Son', 0, 18, 1, 56),
(432, 'Huyện Nông Cống', 'Huyen-Nong-Cong', 0, 19, 1, 56),
(433, 'Huyện Đông Sơn', 'Huyen-Dong-Son', 0, 20, 1, 56),
(434, 'Huyện Hà Trung', 'Huyen-Ha-Trung', 0, 21, 1, 56),
(435, 'Huyện Hoằng Hoá', 'Huyen-Hoang-Hoa', 0, 22, 1, 56),
(436, 'Huyện Nga Sơn', 'Huyen-Nga-Son', 0, 23, 1, 56),
(437, 'Huyện Hậu Lộc', 'Huyen-Hau-Loc', 0, 24, 1, 56),
(438, 'Huyện Quảng Xương', 'Huyen-Quang-Xuong', 0, 25, 1, 56),
(439, 'Huyện Tĩnh Gia', 'Huyen-Tinh-Gia', 0, 26, 1, 56),
(440, 'Huyện Yên Định', 'Huyen-Yen-Dinh', 0, 27, 1, 56),
(441, 'Thành phố Vinh', 'Thanh-pho-Vinh', 0, 1, 1, 41),
(442, 'Thị xã Cửa Lò', 'Thi-xa-Cua-Lo', 0, 2, 1, 41),
(443, 'Huyện Quỳ Châu', 'Huyen-Quy-Chau', 0, 3, 1, 41),
(444, 'Huyện Quỳ Hợp', 'Huyen-Quy-Hop', 0, 4, 1, 41),
(445, 'Huyện Nghĩa Đàn', 'Huyen-Nghia-Dan', 0, 5, 1, 41),
(446, 'Huyện Quỳnh Lưu', 'Huyen-Quynh-Luu', 0, 6, 1, 41),
(447, 'Huyện Kỳ Sơn', 'Huyen-Ky-Son', 0, 7, 1, 41),
(448, 'Huyện Tương Dương', 'Huyen-Tuong-Duong', 0, 8, 1, 41),
(449, 'Huyện Con Cuông', 'Huyen-Con-Cuong', 0, 9, 1, 41),
(450, 'Huyện Tân Kỳ', 'Huyen-Tan-Ky', 0, 10, 1, 41),
(451, 'Huyện Yên Thành', 'Huyen-Yen-Thanh', 0, 11, 1, 41),
(452, 'Huyện Diễn Châu', 'Huyen-Dien-Chau', 0, 12, 1, 41),
(453, 'Huyện Anh Sơn', 'Huyen-Anh-Son', 0, 13, 1, 41),
(454, 'Huyện Đô Lương', 'Huyen-Do-Luong', 0, 14, 1, 41),
(455, 'Huyện Thanh Chương', 'Huyen-Thanh-Chuong', 0, 15, 1, 41),
(456, 'Huyện Nghi Lộc', 'Huyen-Nghi-Loc', 0, 16, 1, 41),
(457, 'Huyện Nam Đàn', 'Huyen-Nam-Dan', 0, 17, 1, 41),
(458, 'Huyện Hưng Nguyên', 'Huyen-Hung-Nguyen', 0, 18, 1, 41),
(459, 'Huyện Quế Phong', 'Huyen-Que-Phong', 0, 19, 1, 41),
(460, 'Thành phố Hà Tĩnh', 'Thanh-pho-Ha-Tinh', 0, 1, 1, 26),
(461, 'Thị xã Hồng Lĩnh', 'Thi-xa-Hong-Linh', 0, 2, 1, 26),
(462, 'Huyện Hương Sơn', 'Huyen-Huong-Son', 0, 3, 1, 26),
(463, 'Huyện Đức Thọ', 'Huyen-Duc-Tho', 0, 4, 1, 26),
(464, 'Huyện Nghi Xuân', 'Huyen-Nghi-Xuan', 0, 5, 1, 26),
(465, 'Huyện Can Lộc', 'Huyen-Can-Loc', 0, 6, 1, 26),
(466, 'Huyện Hương Khê', 'Huyen-Huong-Khe', 0, 7, 1, 26),
(467, 'Huyện Thạch Hà', 'Huyen-Thach-Ha', 0, 8, 1, 26),
(468, 'Huyện Cẩm Xuyên', 'Huyen-Cam-Xuyen', 0, 9, 1, 26),
(469, 'Huyện Kỳ Anh', 'Huyen-Ky-Anh', 0, 10, 1, 26),
(470, 'Huyện Vũ Quang', 'Huyen-Vu-Quang', 0, 11, 1, 26),
(471, 'Huyện Lộc Hà', 'Huyen-Loc-Ha', 0, 12, 1, 26),
(472, 'Thành phố Đồng Hới', 'Thanh-pho-Dong-Hoi', 0, 1, 1, 46),
(473, 'Huyện Tuyên Hoá', 'Huyen-Tuyen-Hoa', 0, 2, 1, 46),
(474, 'Huyện Minh Hoá', 'Huyen-Minh-Hoa', 0, 3, 1, 46),
(475, 'Huyện Quảng Trạch', 'Huyen-Quang-Trach', 0, 4, 1, 46),
(476, 'Huyện Bố Trạch', 'Huyen-Bo-Trach', 0, 5, 1, 46),
(477, 'Huyện Quảng Ninh', 'Huyen-Quang-Ninh', 0, 6, 1, 46),
(478, 'Huyện Lệ Thuỷ', 'Huyen-Le-Thuy', 0, 7, 1, 46),
(479, 'Thị xã Đông Hà', 'Thi-xa-Dong-Ha', 0, 1, 1, 50),
(480, 'Thị xã Quảng Trị', 'Thi-xa-Quang-Tri', 0, 2, 1, 50),
(481, 'Huyện Vĩnh Linh', 'Huyen-Vinh-Linh', 0, 3, 1, 50),
(482, 'Huyện Gio Linh', 'Huyen-Gio-Linh', 0, 4, 1, 50),
(483, 'Huyện Cam Lộ', 'Huyen-Cam-Lo', 0, 5, 1, 50),
(484, 'Huyện Triệu Phong', 'Huyen-Trieu-Phong', 0, 6, 1, 50),
(485, 'Huyện Hải Lăng', 'Huyen-Hai-Lang', 0, 7, 1, 50),
(486, 'Huyện Hướng Hoá', 'Huyen-Huong-Hoa', 0, 8, 1, 50),
(487, 'Huyện Đăk Rông', 'Huyen-Dak-Rong', 0, 9, 1, 50),
(488, 'Huyện đảo Cồn cỏ', 'Huyen-dao-Con-co', 0, 10, 1, 50),
(489, 'Thành phố Huế', 'Thanh-pho-Hue', 0, 1, 1, 57),
(490, 'Huyện Phong Điền', 'Huyen-Phong-Dien', 0, 2, 1, 57),
(491, 'Huyện Hương Trà', 'Huyen-Huong-Tra', 0, 3, 1, 57),
(492, 'Huyện Phú Vang', 'Huyen-Phu-Vang', 0, 4, 1, 57),
(493, 'Huyện Hương Thuỷ', 'Huyen-Huong-Thuy', 0, 5, 1, 57),
(494, 'Huyện Nam Đông', 'Huyen-Nam-Dong', 0, 6, 1, 57),
(495, 'Huyện A Lưới', 'Huyen-A-Luoi', 0, 7, 1, 57),
(496, 'Huyện Quảng Điền', 'Huyen-Quang-Dien', 0, 8, 1, 57),
(497, 'Huyện Phú Lộc', 'Huyen-Phu-Loc', 0, 9, 1, 57),
(498, 'Thành phố Tam Kỳ', 'Thanh-pho-Tam-Ky', 0, 1, 1, 47),
(499, 'Thị xã Hội An', 'Thi-xa-Hoi-An', 0, 2, 1, 47),
(500, 'Huyện Duy Xuyên', 'Huyen-Duy-Xuyen', 0, 3, 1, 47),
(501, 'Huyện Điện Bàn', 'Huyen-Dien-Ban', 0, 4, 1, 47),
(502, 'Huyện Đại Lộc', 'Huyen-Dai-Loc', 0, 5, 1, 47),
(503, 'Huyện Quế Sơn', 'Huyen-Que-Son', 0, 6, 1, 47),
(504, 'Huyện Hiệp Đức', 'Huyen-Hiep-Duc', 0, 7, 1, 47),
(505, 'Huyện Thăng Bình', 'Huyen-Thang-Binh', 0, 8, 1, 47),
(506, 'Huyện Núi Thành', 'Huyen-Nui-Thanh', 0, 9, 1, 47),
(507, 'Huyện Tiên Phước', 'Huyen-Tien-Phuoc', 0, 10, 1, 47),
(508, 'Huyện Bắc Trà My', 'Huyen-Bac-Tra-My', 0, 11, 1, 47),
(509, 'Huyện Đông Giang', 'Huyen-Dong-Giang', 0, 12, 1, 47),
(510, 'Huyện Nam Giang', 'Huyen-Nam-Giang', 0, 13, 1, 47),
(511, 'Huyện Phước Sơn', 'Huyen-Phuoc-Son', 0, 14, 1, 47),
(512, 'Huyện Nam Trà My', 'Huyen-Nam-Tra-My', 0, 15, 1, 47),
(513, 'Huyện Tây Giang', 'Huyen-Tay-Giang', 0, 16, 1, 47),
(514, 'Huyện Phú Ninh', 'Huyen-Phu-Ninh', 0, 17, 1, 47),
(515, 'Huyện Nông Sơn&#039;', 'Huyen-Nong-Son', 0, 18, 1, 47),
(516, 'TP.Quảng Ngãi', 'TPQuang-Ngai', 0, 1, 1, 48),
(517, 'Huyện Lý Sơn', 'Huyen-Ly-Son', 0, 2, 1, 48),
(518, 'Huyện Bình Sơn', 'Huyen-Binh-Son', 0, 3, 1, 48),
(519, 'Huyện Trà Bồng', 'Huyen-Tra-Bong', 0, 4, 1, 48),
(520, 'Huyện Sơn Tịnh', 'Huyen-Son-Tinh', 0, 5, 1, 48),
(521, 'Huyện Sơn Hà', 'Huyen-Son-Ha', 0, 6, 1, 48),
(522, 'Huyện Tư Nghĩa', 'Huyen-Tu-Nghia', 0, 7, 1, 48),
(523, 'Huyện Nghĩa Hành', 'Huyen-Nghia-Hanh', 0, 8, 1, 48),
(524, 'Huyện Minh Long', 'Huyen-Minh-Long', 0, 9, 1, 48),
(525, 'Huyện Mộ Đức', 'Huyen-Mo-Duc', 0, 10, 1, 48),
(526, 'Huyện Đức Phổ', 'Huyen-Duc-Pho', 0, 11, 1, 48),
(527, 'Huyện Ba Tơ', 'Huyen-Ba-To', 0, 12, 1, 48),
(528, 'Huyện Sơn Tây', 'Huyen-Son-Tay', 0, 13, 1, 48),
(529, 'Huyện Tây Trà', 'Huyen-Tay-Tra', 0, 14, 1, 48),
(530, 'Thị xã KonTum', 'Thi-xa-KonTum', 0, 1, 1, 34),
(531, 'Huyện Đăk Glei', 'Huyen-Dak-Glei', 0, 2, 1, 34),
(532, 'Huyện Ngọc Hồi', 'Huyen-Ngoc-Hoi', 0, 3, 1, 34),
(533, 'Huyện Đăk Tô', 'Huyen-Dak-To', 0, 4, 1, 34),
(534, 'Huyện Sa Thầy', 'Huyen-Sa-Thay', 0, 5, 1, 34),
(535, 'Huyện Kon Plong', 'Huyen-Kon-Plong', 0, 6, 1, 34),
(536, 'Huyện Đăk Hà', 'Huyen-Dak-Ha', 0, 7, 1, 34),
(537, 'Huyện Kon Rộy', 'Huyen-Kon-Roy', 0, 8, 1, 34),
(538, 'Huyện Tu Mơ Rông', 'Huyen-Tu-Mo-Rong', 0, 9, 1, 34),
(539, 'Thành phố Quy Nhơn', 'Thanh-pho-Quy-Nhon', 0, 1, 1, 10),
(540, 'Huyện An Lão', 'Huyen-An-Lao', 0, 2, 1, 10),
(541, 'Huyện Hoài Ân', 'Huyen-Hoai-An', 0, 3, 1, 10),
(542, 'Huyện Hoài Nhơn', 'Huyen-Hoai-Nhon', 0, 4, 1, 10),
(543, 'Huyện Phù Mỹ', 'Huyen-Phu-My', 0, 5, 1, 10),
(544, 'Huyện Phù Cát', 'Huyen-Phu-Cat', 0, 6, 1, 10),
(545, 'Huyện Vĩnh Thạnh', 'Huyen-Vinh-Thanh', 0, 7, 1, 10),
(546, 'Huyện Tây Sơn', 'Huyen-Tay-Son', 0, 8, 1, 10),
(547, 'Huyện Vân Canh', 'Huyen-Van-Canh', 0, 9, 1, 10),
(548, 'Huyện An Nhơn', 'Huyen-An-Nhon', 0, 10, 1, 10),
(549, 'Huyện Tuy Phước', 'Huyen-Tuy-Phuoc', 0, 11, 1, 10),
(550, 'Thị xã Tây Ninh', 'Thi-xa-Tay-Ninh', 0, 1, 1, 53),
(551, 'Huyện Tân Biên', 'Huyen-Tan-Bien', 0, 2, 1, 53),
(552, 'Huyện Tân Châu', 'Huyen-Tan-Chau', 0, 3, 1, 53),
(553, 'Huyện Dương Minh Châu', 'Huyen-Duong-Minh-Chau', 0, 4, 1, 53),
(554, 'Huyện Châu Thành', 'Huyen-Chau-Thanh', 0, 5, 1, 53),
(555, 'Huyện Hoà Thành', 'Huyen-Hoa-Thanh', 0, 6, 1, 53),
(556, 'Huyện Bến Cầu', 'Huyen-Ben-Cau', 0, 7, 1, 53),
(557, 'Huyện Gò Dầu', 'Huyen-Go-Dau', 0, 8, 1, 53),
(558, 'Huyện Trảng Bàng', 'Huyen-Trang-Bang', 0, 9, 1, 53),
(559, 'Thị xã Tuy Hoà', 'Thi-xa-Tuy-Hoa', 0, 1, 1, 45),
(560, 'Huyện Đồng Xuân', 'Huyen-Dong-Xuan', 0, 2, 1, 45),
(561, 'Huyện Sông Cầu', 'Huyen-Song-Cau', 0, 3, 1, 45),
(562, 'Huyện Tuy An', 'Huyen-Tuy-An', 0, 4, 1, 45),
(563, 'Huyện Sơn Hoà', 'Huyen-Son-Hoa', 0, 5, 1, 45),
(564, 'Huyện Sông Hinh', 'Huyen-Song-Hinh', 0, 6, 1, 45),
(565, 'Huyện Đông Hoà', 'Huyen-Dong-Hoa', 0, 7, 1, 45),
(566, 'Huyện Phú Hoà', 'Huyen-Phu-Hoa', 0, 8, 1, 45),
(567, 'Huyện Tây Hoà', 'Huyen-Tay-Hoa', 0, 9, 1, 45),
(568, 'Thành phố Phan Thiết', 'Thanh-pho-Phan-Thiet', 0, 1, 1, 13),
(569, 'Huyện Tuy Phong', 'Huyen-Tuy-Phong', 0, 2, 1, 13),
(570, 'Huyện Bắc Bình', 'Huyen-Bac-Binh', 0, 3, 1, 13),
(571, 'Huyện Hàm Thuận Bắc', 'Huyen-Ham-Thuan-Bac', 0, 4, 1, 13),
(572, 'Huyện Hàm Thuận Nam', 'Huyen-Ham-Thuan-Nam', 0, 5, 1, 13),
(573, 'Huyện Hàm Tân', 'Huyen-Ham-Tan', 0, 6, 1, 13),
(574, 'Huyện Đức Linh', 'Huyen-Duc-Linh', 0, 7, 1, 13),
(575, 'Huyện Tánh Linh', 'Huyen-Tanh-Linh', 0, 8, 1, 13),
(576, 'Huyện đảo Phú Quý', 'Huyen-dao-Phu-Quy', 0, 9, 1, 13),
(577, 'Thị xã LaGi', 'Thi-xa-LaGi', 0, 10, 1, 13),
(578, 'Thành phố Biên Hoà', 'Thanh-pho-Bien-Hoa', 0, 1, 1, 21),
(579, 'Huyện Vĩnh Cửu', 'Huyen-Vinh-Cuu', 0, 2, 1, 21),
(580, 'Huyện Tân Phú', 'Huyen-Tan-Phu', 0, 3, 1, 21),
(581, 'Huyện Định Quán', 'Huyen-Dinh-Quan', 0, 4, 1, 21),
(582, 'Huyện Thống Nhất', 'Huyen-Thong-Nhat', 0, 5, 1, 21),
(583, 'Thị xã Long Khánh', 'Thi-xa-Long-Khanh', 0, 6, 1, 21),
(584, 'Huyện Xuân Lộc', 'Huyen-Xuan-Loc', 0, 7, 1, 21),
(585, 'Huyện Long Thành', 'Huyen-Long-Thanh', 0, 8, 1, 21),
(586, 'Huyện Nhơn Trạch', 'Huyen-Nhon-Trach', 0, 9, 1, 21),
(587, 'Huyện Trảng Bom', 'Huyen-Trang-Bom', 0, 10, 1, 21),
(588, 'Huyện Cẩm Mỹ', 'Huyen-Cam-My', 0, 11, 1, 21),
(589, 'Thị xã Tân An', 'Thi-xa-Tan-An', 0, 1, 1, 39),
(590, 'Huyện Vĩnh Hưng', 'Huyen-Vinh-Hung', 0, 2, 1, 39),
(591, 'Huyện Mộc Hoá', 'Huyen-Moc-Hoa', 0, 3, 1, 39),
(592, 'Huyện Tân Thạnh', 'Huyen-Tan-Thanh', 0, 4, 1, 39),
(593, 'Huyện Thạnh Hoá', 'Huyen-Thanh-Hoa', 0, 5, 1, 39),
(594, 'Huyện Đức Huệ', 'Huyen-Duc-Hue', 0, 6, 1, 39),
(595, 'Huyện Đức Hoà&#039;', 'Huyen-Duc-Hoa', 0, 7, 1, 39),
(596, 'Huyện Bến Lức', 'Huyen-Ben-Luc', 0, 8, 1, 39),
(597, 'Huyện Thủ Thừa', 'Huyen-Thu-Thua', 0, 9, 1, 39),
(598, 'Huyện Châu Thành', 'Huyen-Chau-Thanh', 0, 10, 1, 39),
(599, 'Huyện Tân Trụ', 'Huyen-Tan-Tru', 0, 11, 1, 39),
(600, 'Huyện Cần Đước', 'Huyen-Can-Duoc', 0, 12, 1, 39),
(601, 'Huyện Cần Giuộc', 'Huyen-Can-Giuoc', 0, 13, 1, 39),
(602, 'Huyện Tân Hưng&#039;', 'Huyen-Tan-Hung', 0, 14, 1, 39),
(603, 'Thành phố Cao Lãnh', 'Thanh-pho-Cao-Lanh', 0, 1, 1, 22),
(604, 'Thị xã Sa Đéc', 'Thi-xa-Sa-Dec', 0, 2, 1, 22),
(605, 'Huyện Tân Hồng', 'Huyen-Tan-Hong', 0, 3, 1, 22),
(606, 'Huyện Hồng Ngự', 'Huyen-Hong-Ngu', 0, 4, 1, 22),
(607, 'Huyện Tam Nông', 'Huyen-Tam-Nong', 0, 5, 1, 22),
(608, 'Huyện Thanh Bình', 'Huyen-Thanh-Binh', 0, 6, 1, 22),
(609, 'Huyện Cao Lãnh', 'Huyen-Cao-Lanh', 0, 7, 1, 22),
(610, 'Huyện Lấp Vò', 'Huyen-Lap-Vo', 0, 8, 1, 22),
(611, 'Huyện Tháp Mười', 'Huyen-Thap-Muoi', 0, 9, 1, 22),
(612, 'Huyện Lai Vung', 'Huyen-Lai-Vung', 0, 10, 1, 22),
(613, 'Huyện Châu Thành', 'Huyen-Chau-Thanh', 0, 11, 1, 22),
(614, 'Thị xã Thủ Dầu Một', 'Thi-xa-Thu-Dau-Mot', 0, 1, 1, 11),
(615, 'Huyện Bến Cát', 'Huyen-Ben-Cat', 0, 2, 1, 11),
(616, 'Huyện Tân Uyên', 'Huyen-Tan-Uyen', 0, 3, 1, 11),
(617, 'Huyện Thuận An', 'Huyen-Thuan-An', 0, 4, 1, 11),
(618, 'Huyện Dĩ An', 'Huyen-Di-An', 0, 5, 1, 11),
(619, 'Huyện Phú Giáo', 'Huyen-Phu-Giao', 0, 6, 1, 11),
(620, 'Huyện Dầu Tiếng', 'Huyen-Dau-Tieng', 0, 7, 1, 11),
(621, 'Thị xã Đồng Xoài', 'Thi-xa-Dong-Xoai', 0, 1, 1, 12),
(622, 'Huyện Đồng Phú', 'Huyen-Dong-Phu', 0, 2, 1, 12),
(623, 'Huyện Chơn Thành', 'Huyen-Chon-Thanh', 0, 3, 1, 12),
(624, 'Huyện Bình Long', 'Huyen-Binh-Long', 0, 4, 1, 12),
(625, 'Huyện Lộc Ninh', 'Huyen-Loc-Ninh', 0, 5, 1, 12),
(626, 'Huyện Bù Đốp', 'Huyen-Bu-Dop', 0, 6, 1, 12),
(627, 'Huyện Phước Long', 'Huyen-Phuoc-Long', 0, 7, 1, 12),
(628, 'Huyện Bù Đăng', 'Huyen-Bu-Dang', 0, 8, 1, 12),
(630, 'TP.Phan Rang - Tháp Chàm', 'TPPhan-Rang-Thap-Cham', 0, 1, 1, 43),
(631, 'Huyện Ninh Sơn', 'Huyen-Ninh-Son', 0, 2, 1, 43),
(632, 'Huyện Ninh Hải', 'Huyen-Ninh-Hai', 0, 3, 1, 43),
(633, 'Huyện Ninh Phước', 'Huyen-Ninh-Phuoc', 0, 4, 1, 43),
(634, 'Huyện Bác ái', 'Huyen-Bac-ai', 0, 5, 1, 43),
(635, 'Huyện Thuận Bắc', 'Huyen-Thuan-Bac', 0, 6, 1, 43),
(636, 'Thành phố Pleiku', 'Thanh-pho-Pleiku', 0, 1, 1, 23),
(637, 'Huyện Chư Păh', 'Huyen-Chu-Pah', 0, 2, 1, 23),
(638, 'Huyện Mang Yang', 'Huyen-Mang-Yang', 0, 3, 1, 23),
(639, 'Huyện Kbang', 'Huyen-Kbang', 0, 4, 1, 23),
(640, 'Thị xã An Khê', 'Thi-xa-An-Khe', 0, 5, 1, 23),
(641, 'Huyện Kông Chro', 'Huyen-Kong-Chro', 0, 6, 1, 23),
(642, 'Huyện Đức Cơ', 'Huyen-Duc-Co', 0, 7, 1, 23),
(643, 'Huyện Chưprông', 'Huyen-Chuprong', 0, 8, 1, 23),
(644, 'Huyện Chư Sê', 'Huyen-Chu-Se', 0, 9, 1, 23),
(645, 'Huyện Ayunpa', 'Huyen-Ayunpa', 0, 10, 1, 23),
(646, 'Huyện Krông Pa', 'Huyen-Krong-Pa', 0, 11, 1, 23),
(647, 'Huyện Ia Grai', 'Huyen-Ia-Grai', 0, 12, 1, 23),
(648, 'Huyện Đăk Đoa', 'Huyen-Dak-Doa', 0, 13, 1, 23),
(649, 'Huyện Ia Pa', 'Huyen-Ia-Pa', 0, 14, 1, 23),
(650, 'Huyện Đăk Pơ', 'Huyen-Dak-Po', 0, 15, 1, 23),
(651, 'Huyện Phú Thiện', 'Huyen-Phu-Thien', 0, 16, 1, 23),
(652, 'Thành phố Nha Trang', 'Thanh-pho-Nha-Trang', 0, 1, 1, 32),
(653, 'Huyện Vạn Ninh', 'Huyen-Van-Ninh', 0, 2, 1, 32),
(654, 'Huyện Ninh Hoà', 'Huyen-Ninh-Hoa', 0, 3, 1, 32),
(655, 'Huyện Diên Khánh', 'Huyen-Dien-Khanh', 0, 4, 1, 32),
(656, 'Huyện Khánh Vĩnh', 'Huyen-Khanh-Vinh', 0, 5, 1, 32),
(657, 'Thị xã Cam Ranh', 'Thi-xa-Cam-Ranh', 0, 6, 1, 32),
(658, 'Huyện Khánh Sơn', 'Huyen-Khanh-Son', 0, 7, 1, 32),
(659, 'Huyện Trường Sa', 'Huyen-Truong-Sa', 0, 8, 1, 32),
(660, 'Huyện Cam Lâm', 'Huyen-Cam-Lam', 0, 9, 1, 32),
(661, 'Thành phố Đà Lạt', 'Thanh-pho-Da-Lat', 0, 1, 1, 36),
(662, 'Thị xã Bảo Lộc', 'Thi-xa-Bao-Loc', 0, 2, 1, 36),
(663, 'Huyện Đức Trọng', 'Huyen-Duc-Trong', 0, 3, 1, 36),
(664, 'Huyện Di Linh', 'Huyen-Di-Linh', 0, 4, 1, 36),
(665, 'Huyện Đơn Dương', 'Huyen-Don-Duong', 0, 5, 1, 36),
(666, 'Huyện Lạc Dương', 'Huyen-Lac-Duong', 0, 6, 1, 36),
(667, 'Huyện Đạ Huoai', 'Huyen-Da-Huoai', 0, 7, 1, 36),
(668, 'Huyện Đạ Tẻh', 'Huyen-Da-Teh', 0, 8, 1, 36),
(669, 'Huyện Cát Tiên', 'Huyen-Cat-Tien', 0, 9, 1, 36),
(670, 'Huyện Lâm Hà', 'Huyen-Lam-Ha', 0, 10, 1, 36),
(671, 'Huyện Bảo Lâm', 'Huyen-Bao-Lam', 0, 11, 1, 36),
(672, 'Huyện Đam Rông', 'Huyen-Dam-Rong', 0, 12, 1, 36),
(675, 'TP.Buôn Ma Thuột', 'TPBuon-Ma-Thuot', 0, 1, 1, 18),
(676, 'Huyện Ea H Leo', 'Huyen-Ea-H-Leo', 0, 2, 1, 18),
(677, 'Huyện Krông Buk', 'Huyen-Krong-Buk', 0, 3, 1, 18),
(678, 'Huyện Krông Năng', 'Huyen-Krong-Nang', 0, 4, 1, 18),
(679, 'Huyện Ea Súp', 'Huyen-Ea-Sup', 0, 5, 1, 18),
(680, 'Huyện Cư M gar', 'Huyen-Cu-M-gar', 0, 6, 1, 18),
(681, 'Huyện Krông Pắc', 'Huyen-Krong-Pac', 0, 7, 1, 18),
(682, 'Huyện Ea Kar', 'Huyen-Ea-Kar', 0, 8, 1, 18),
(683, 'Huyện M&#039;&#039;Đrăk', 'Huyen-M-Drak', 0, 9, 1, 18),
(684, 'Huyện Krông Ana', 'Huyen-Krong-Ana', 0, 10, 1, 18),
(685, 'Huyện Krông Bông', 'Huyen-Krong-Bong', 0, 11, 1, 18),
(686, 'Huyện Lăk', 'Huyen-Lak', 0, 12, 1, 18),
(687, 'Huyện Buôn Đôn', 'Huyen-Buon-Don', 0, 13, 1, 18),
(688, 'Huyện Cư Kuin', 'Huyen-Cu-Kuin', 0, 14, 1, 18);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `interview`
--

CREATE TABLE `interview` (
  `candidate_id` int(10) UNSIGNED NOT NULL,
  `interview_by` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `interview`
--

INSERT INTO `interview` (`candidate_id`, `interview_by`) VALUES
(1, 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(273, '2016_06_01_000001_create_oauth_auth_codes_table', 1),
(274, '2016_06_01_000002_create_oauth_access_tokens_table', 1),
(275, '2016_06_01_000003_create_oauth_refresh_tokens_table', 1),
(276, '2016_06_01_000004_create_oauth_clients_table', 1),
(277, '2016_06_01_000005_create_oauth_personal_access_clients_table', 1),
(278, '2018_07_17_153100_create_users_table', 1),
(279, '2018_07_17_163531_create_roles_table', 1),
(280, '2018_07_17_163723_create_role_users_table', 1),
(281, '2018_09_10_050155_create_cities_table', 1),
(282, '2018_09_10_050223_create_districts_table', 1),
(283, '2018_09_10_050330_create_wards_table', 1),
(284, '2018_09_10_050335_alter_users_table', 1),
(285, '2018_09_10_060739_create_settings_table', 1),
(286, '2018_09_10_060921_create_branches_table', 1),
(287, '2018_09_10_061240_create_departments_table', 1),
(288, '2018_09_10_061336_create_positions_table', 1),
(289, '2018_09_10_061416_create_department_user_table', 1),
(290, '2018_09_18_044430_create_contracts_table', 1),
(291, '2018_09_18_044442_create_contract_user_table', 1),
(292, '2018_09_18_044452_create_plans_table', 1),
(293, '2018_09_18_044502_create_plan_details_table', 1),
(294, '2018_09_18_044514_create_candidates_table', 1),
(295, '2018_09_18_044526_create_interview_table', 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `oauth_access_tokens`
--

CREATE TABLE `oauth_access_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `client_id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `oauth_access_tokens`
--

INSERT INTO `oauth_access_tokens` (`id`, `user_id`, `client_id`, `name`, `scopes`, `revoked`, `created_at`, `updated_at`, `expires_at`) VALUES
('40fadf3e67f7803499a7d3185dbcb78798c8f2b45e0cb64d743d56f1fb60ed499deb81558b8fb2a8', 1, 2, NULL, '[]', 0, '2018-09-23 13:27:47', '2018-09-23 13:27:47', '2019-09-23 13:27:47'),
('d795b8d075ed6500768db56fb6bcabf5b11ff38211eebac82b80ff54998c9ce7584760639c34d11b', 1, 2, NULL, '[]', 0, '2018-09-23 16:03:52', '2018-09-23 16:03:52', '2019-09-23 16:03:52');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `oauth_auth_codes`
--

CREATE TABLE `oauth_auth_codes` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `oauth_clients`
--

CREATE TABLE `oauth_clients` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `secret` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `redirect` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `personal_access_client` tinyint(1) NOT NULL,
  `password_client` tinyint(1) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `oauth_clients`
--

INSERT INTO `oauth_clients` (`id`, `user_id`, `name`, `secret`, `redirect`, `personal_access_client`, `password_client`, `revoked`, `created_at`, `updated_at`) VALUES
(1, NULL, ' Personal Access Client', 'MJT91AdwYTdYQSEFJuNIHxjNGcHUPKxSTeMoyTmx', 'http://localhost', 1, 0, 0, '2018-09-23 13:26:55', '2018-09-23 13:26:55'),
(2, NULL, ' Password Grant Client', 'DPeYlUJUcGLEl2QAgSEqGZztUgWNMbGxemwWjYBD', 'http://localhost', 0, 1, 0, '2018-09-23 13:26:55', '2018-09-23 13:26:55');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `oauth_personal_access_clients`
--

CREATE TABLE `oauth_personal_access_clients` (
  `id` int(10) UNSIGNED NOT NULL,
  `client_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `oauth_personal_access_clients`
--

INSERT INTO `oauth_personal_access_clients` (`id`, `client_id`, `created_at`, `updated_at`) VALUES
(1, 1, '2018-09-23 13:26:55', '2018-09-23 13:26:55');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `oauth_refresh_tokens`
--

CREATE TABLE `oauth_refresh_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `access_token_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `oauth_refresh_tokens`
--

INSERT INTO `oauth_refresh_tokens` (`id`, `access_token_id`, `revoked`, `expires_at`) VALUES
('7c804ba982786f8f0186efc9330eaac10ab83bfc55ece62e9de71d1c81b017b36efd4aa9f1048fb0', '40fadf3e67f7803499a7d3185dbcb78798c8f2b45e0cb64d743d56f1fb60ed499deb81558b8fb2a8', 0, '2019-09-23 13:27:47'),
('ce5e7905f3bd8e273ed0c0ea5a7b5e8dcb67284518ca2be5f592e0d4f629fc18dd828742d716973a', 'd795b8d075ed6500768db56fb6bcabf5b11ff38211eebac82b80ff54998c9ce7584760639c34d11b', 0, '2019-09-23 16:03:52');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `plans`
--

CREATE TABLE `plans` (
  `id` int(10) UNSIGNED NOT NULL,
  `title` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_start` date NOT NULL,
  `date_end` date NOT NULL,
  `content` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint(3) UNSIGNED DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `plans`
--

INSERT INTO `plans` (`id`, `title`, `date_start`, `date_end`, `content`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Tuyển lập trình viên dự án HRM ', '0000-00-00', '0000-00-00', '', 0, NULL, NULL),
(2, 'Tuyển lập trình viên dự án CRM ', '0000-00-00', '0000-00-00', '', 0, NULL, NULL),
(3, 'Tuyển nhân viên kế toán', '0000-00-00', '0000-00-00', '', 0, NULL, NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `plan_details`
--

CREATE TABLE `plan_details` (
  `id` int(10) UNSIGNED NOT NULL,
  `plan_id` int(10) UNSIGNED NOT NULL,
  `department_id` int(10) UNSIGNED NOT NULL,
  `position_id` int(10) UNSIGNED NOT NULL,
  `quantity` tinyint(3) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `plan_details`
--

INSERT INTO `plan_details` (`id`, `plan_id`, `department_id`, `position_id`, `quantity`) VALUES
(1, 1, 2, 5, 3),
(2, 1, 2, 6, 2),
(3, 2, 2, 5, 2),
(4, 2, 2, 6, 1),
(5, 3, 3, 5, 2);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `positions`
--

CREATE TABLE `positions` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint(3) UNSIGNED NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `positions`
--

INSERT INTO `positions` (`id`, `name`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Giám đốc', 1, NULL, NULL),
(2, 'Phó Giám đốc', 1, NULL, NULL),
(3, 'Giám đốc điều hành', 1, NULL, NULL),
(4, 'Trưởng phòng', 1, NULL, NULL),
(5, 'Nhân viên', 1, NULL, NULL),
(6, 'Thực tập sinh', 1, NULL, NULL),
(7, 'Cộng tác viên', 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `roles`
--

CREATE TABLE `roles` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `permissions` json NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `roles`
--

INSERT INTO `roles` (`id`, `name`, `slug`, `permissions`, `created_at`, `updated_at`) VALUES
(1, 'Super admin', 'superadmin', '{"admin.super-admin": true}', '2018-09-23 13:26:24', '2018-09-23 13:26:24'),
(2, 'edittor', 'edittor', '[]', '2018-09-24 06:05:35', '2018-09-24 06:05:35');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `role_users`
--

CREATE TABLE `role_users` (
  `user_id` int(10) UNSIGNED NOT NULL,
  `role_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `role_users`
--

INSERT INTO `role_users` (`user_id`, `role_id`) VALUES
(1, 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `settings`
--

CREATE TABLE `settings` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(35) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `settings`
--

INSERT INTO `settings` (`id`, `name`, `slug`, `value`, `status`, `created_at`, `updated_at`) VALUES
(1, 'name', 'name', 'Triplan', 1, NULL, NULL),
(2, 'description', 'description', 'description_Triplan', 1, NULL, NULL),
(3, 'about', 'about', 'about_Triplan', 1, NULL, NULL),
(4, 'phone', 'phone', 'phone_Triplan', 1, NULL, NULL),
(5, 'address', 'address', 'address_Triplan', 1, NULL, NULL),
(6, 'website', 'website', 'website_Triplan', 1, NULL, NULL),
(7, 'email', 'email', 'email_Triplan', 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `code` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `qualification` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gender` tinyint(4) NOT NULL DEFAULT '0',
  `date_of_birth` date DEFAULT NULL,
  `avatar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `city_id` int(10) UNSIGNED NOT NULL,
  `district_id` int(10) UNSIGNED NOT NULL,
  `status` tinyint(3) UNSIGNED NOT NULL DEFAULT '1',
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `users`
--

INSERT INTO `users` (`id`, `code`, `name`, `qualification`, `address`, `phone`, `gender`, `date_of_birth`, `avatar`, `email`, `password`, `city_id`, `district_id`, `status`, `remember_token`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 'DY1pal0B', 'SuperAdmin', NULL, NULL, NULL, 0, NULL, NULL, 'admin@nht.com', '$2y$10$2IVx8XUcGBr7fVOCtO927.cpqVB6V38URVmqCCTyMUtVjgS/Jjg1u', 0, 0, 1, '8L4pHyGXq0', NULL, '2018-09-23 13:26:24', '2018-09-23 13:26:24'),
(5, '0BxN6xpV', 'nhân viên mới', '12/12', 'hà nội', '01688162714', 0, '2016-02-03', NULL, 'trongdong71@gmail.com', '$2y$10$vFEHB/SBTyhoQBN9wkVU9.BwqChK7lTwYWH4tpMYkFxt5S/oxTkBu', 0, 0, 1, NULL, NULL, '2018-09-23 15:31:52', '2018-09-23 15:31:52'),
(8, 'yoxg91JO', 'vutrongdong', NULL, NULL, NULL, 1, NULL, NULL, 'trongdong717@gmail.com', '$2y$10$GpH7brREeCNwsIFjvDxpOOkaWKZ66qOxNSuoUb.Ej/Bf7cVKGlp0.', 0, 0, 1, NULL, NULL, '2018-09-24 04:03:23', '2018-09-24 04:03:23');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `wards`
--

CREATE TABLE `wards` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(35) COLLATE utf8mb4_unicode_ci NOT NULL,
  `zipcode` mediumint(8) UNSIGNED NOT NULL,
  `order` tinyint(3) UNSIGNED NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `district_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `wards`
--

INSERT INTO `wards` (`id`, `name`, `slug`, `zipcode`, `order`, `status`, `district_id`) VALUES
(1, 'Phưòng Bích Câu', 'Phuong-Bich-Cau', 0, 1, 1, 4),
(2, 'Phưòng Cát Linh', 'Phuong-Cat-Linh', 0, 2, 1, 4),
(3, 'Phưòng Hàng Bột', 'Phuong-Hang-Bot', 0, 3, 1, 4),
(4, 'Phưòng Khâm Thiên', 'Phuong-Kham-Thien', 0, 4, 1, 4),
(5, 'Phưòng Khương Thượng', 'Phuong-Khuong-Thuong', 0, 5, 1, 4),
(6, 'Phưòng Kim Liên', 'Phuong-Kim-Lien', 0, 6, 1, 4),
(7, 'Phưòng Láng Hạ', 'Phuong-Lang-Ha', 0, 7, 1, 4),
(8, 'Phưòng Láng Thượng', 'Phuong-Lang-Thuong', 0, 8, 1, 4),
(9, 'Phưòng Nam Đồng', 'Phuong-Nam-Đong', 0, 9, 1, 4),
(10, 'Phưòng Ngã Tư Sở', 'Phuong-Nga-Tu So', 0, 10, 1, 4),
(11, 'Phưòng Ô Chợ Dừa', 'Phuong-O-Cho-Dua', 0, 11, 1, 4),
(12, 'Phưòng Phương Liên', 'Phuong-Phuong-Lien', 0, 12, 1, 4),
(13, 'Phưòng Phương Mai', 'Phuong-Phuong-Mai', 0, 13, 1, 4),
(14, 'Phưòng Quang Trung', 'Phuong-Quang-Trung', 0, 14, 1, 4),
(15, 'Phưòng Quốc Tử Giám', 'Phuong-Quoc-Tu-Giam', 0, 15, 1, 4),
(16, 'Phưòng Thịnh Quang', 'Phuong-Thinh-Quang', 0, 16, 1, 4),
(17, 'Phưòng Thổ Quan', 'Phuong-Tho-Quan', 0, 17, 1, 4),
(18, 'Phưòng Trung Liệt', 'Phuong-Trung-Liet', 0, 18, 1, 4),
(19, 'Phưòng Trung Phụng', 'Phuong-Trung-Phung', 0, 19, 1, 4),
(20, 'Phưòng Trung Tự', 'Phuong-Trung-Tu', 0, 20, 1, 4),
(21, 'Phưòng Văn Chương', 'Phuong-Van-Chuong', 0, 21, 1, 4),
(22, 'Phưòng Văn Miếu', 'Phuong-Van-Mieu', 0, 22, 1, 4);

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `branches`
--
ALTER TABLE `branches`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `branches_email_unique` (`email`),
  ADD UNIQUE KEY `branches_tax_number_unique` (`tax_number`);

--
-- Chỉ mục cho bảng `candidates`
--
ALTER TABLE `candidates`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `cities`
--
ALTER TABLE `cities`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `contracts`
--
ALTER TABLE `contracts`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `contract_user`
--
ALTER TABLE `contract_user`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `departments`
--
ALTER TABLE `departments`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `department_user`
--
ALTER TABLE `department_user`
  ADD KEY `department_user_user_id_foreign` (`user_id`),
  ADD KEY `department_user_department_id_foreign` (`department_id`),
  ADD KEY `department_user_position_id_foreign` (`position_id`);

--
-- Chỉ mục cho bảng `districts`
--
ALTER TABLE `districts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `districts_city_id_foreign` (`city_id`);

--
-- Chỉ mục cho bảng `interview`
--
ALTER TABLE `interview`
  ADD KEY `interview_candidate_id_foreign` (`candidate_id`),
  ADD KEY `interview_interview_by_foreign` (`interview_by`);

--
-- Chỉ mục cho bảng `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `oauth_access_tokens`
--
ALTER TABLE `oauth_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_access_tokens_user_id_index` (`user_id`);

--
-- Chỉ mục cho bảng `oauth_auth_codes`
--
ALTER TABLE `oauth_auth_codes`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `oauth_clients`
--
ALTER TABLE `oauth_clients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_clients_user_id_index` (`user_id`);

--
-- Chỉ mục cho bảng `oauth_personal_access_clients`
--
ALTER TABLE `oauth_personal_access_clients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_personal_access_clients_client_id_index` (`client_id`);

--
-- Chỉ mục cho bảng `oauth_refresh_tokens`
--
ALTER TABLE `oauth_refresh_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_refresh_tokens_access_token_id_index` (`access_token_id`);

--
-- Chỉ mục cho bảng `plans`
--
ALTER TABLE `plans`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `plan_details`
--
ALTER TABLE `plan_details`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `positions`
--
ALTER TABLE `positions`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_slug_unique` (`slug`);

--
-- Chỉ mục cho bảng `role_users`
--
ALTER TABLE `role_users`
  ADD UNIQUE KEY `role_users_user_id_role_id_unique` (`user_id`,`role_id`),
  ADD KEY `role_users_role_id_foreign` (`role_id`);

--
-- Chỉ mục cho bảng `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `settings_name_unique` (`name`),
  ADD UNIQUE KEY `settings_slug_unique` (`slug`);

--
-- Chỉ mục cho bảng `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- Chỉ mục cho bảng `wards`
--
ALTER TABLE `wards`
  ADD PRIMARY KEY (`id`),
  ADD KEY `wards_district_id_foreign` (`district_id`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `branches`
--
ALTER TABLE `branches`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT cho bảng `candidates`
--
ALTER TABLE `candidates`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT cho bảng `cities`
--
ALTER TABLE `cities`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=64;
--
-- AUTO_INCREMENT cho bảng `contracts`
--
ALTER TABLE `contracts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT cho bảng `contract_user`
--
ALTER TABLE `contract_user`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT cho bảng `departments`
--
ALTER TABLE `departments`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT cho bảng `districts`
--
ALTER TABLE `districts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=689;
--
-- AUTO_INCREMENT cho bảng `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=296;
--
-- AUTO_INCREMENT cho bảng `oauth_clients`
--
ALTER TABLE `oauth_clients`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT cho bảng `oauth_personal_access_clients`
--
ALTER TABLE `oauth_personal_access_clients`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT cho bảng `plans`
--
ALTER TABLE `plans`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT cho bảng `plan_details`
--
ALTER TABLE `plan_details`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT cho bảng `positions`
--
ALTER TABLE `positions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT cho bảng `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT cho bảng `settings`
--
ALTER TABLE `settings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT cho bảng `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT cho bảng `wards`
--
ALTER TABLE `wards`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;
--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `department_user`
--
ALTER TABLE `department_user`
  ADD CONSTRAINT `department_user_department_id_foreign` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `department_user_position_id_foreign` FOREIGN KEY (`position_id`) REFERENCES `positions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `department_user_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `districts`
--
ALTER TABLE `districts`
  ADD CONSTRAINT `districts_city_id_foreign` FOREIGN KEY (`city_id`) REFERENCES `cities` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `interview`
--
ALTER TABLE `interview`
  ADD CONSTRAINT `interview_candidate_id_foreign` FOREIGN KEY (`candidate_id`) REFERENCES `candidates` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `interview_interview_by_foreign` FOREIGN KEY (`interview_by`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `role_users`
--
ALTER TABLE `role_users`
  ADD CONSTRAINT `role_users_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_users_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `wards`
--
ALTER TABLE `wards`
  ADD CONSTRAINT `wards_district_id_foreign` FOREIGN KEY (`district_id`) REFERENCES `districts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
