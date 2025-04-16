-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 16, 2025 at 07:56 PM
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
-- Database: `ostad_blog_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `bookmarks`
--

CREATE TABLE `bookmarks` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `post_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `bookmarks`
--

INSERT INTO `bookmarks` (`id`, `user_id`, `post_id`, `created_at`, `updated_at`) VALUES
(1, 2, 8, '2025-04-14 11:42:48', '2025-04-14 11:42:48'),
(2, 12, 9, '2025-04-14 11:42:48', '2025-04-14 11:42:48'),
(3, 8, 9, '2025-04-14 11:42:48', '2025-04-14 11:42:48'),
(4, 4, 9, '2025-04-14 11:42:48', '2025-04-14 11:42:48'),
(5, 11, 7, '2025-04-14 11:42:48', '2025-04-14 11:42:48'),
(6, 7, 6, '2025-04-14 11:42:48', '2025-04-14 11:42:48'),
(7, 8, 9, '2025-04-14 11:42:48', '2025-04-14 11:42:48'),
(8, 7, 1, '2025-04-14 11:42:48', '2025-04-14 11:42:48'),
(9, 6, 8, '2025-04-14 11:42:48', '2025-04-14 11:42:48'),
(10, 7, 6, '2025-04-14 11:42:48', '2025-04-14 11:42:48');

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `post_id` bigint(20) UNSIGNED NOT NULL,
  `content` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `parent_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `comments`
--

INSERT INTO `comments` (`id`, `user_id`, `post_id`, `content`, `created_at`, `updated_at`, `parent_id`) VALUES
(1, 2, 2, 'Optio magni necessitatibus exercitationem similique. Qui minus et eos nihil. Et in voluptatem autem maxime quis quaerat.', '2025-04-14 11:42:48', '2025-04-14 11:42:48', NULL),
(2, 6, 4, 'Distinctio officiis distinctio cum. Fugiat eius aspernatur culpa perspiciatis quidem illo. Eos voluptatem ad magnam atque. Quidem sapiente ad eum debitis suscipit rerum. Commodi vitae totam atque hic.', '2025-04-14 11:42:48', '2025-04-14 11:42:48', NULL),
(3, 3, 1, 'Enim enim quisquam asperiores quaerat dicta dicta. Corporis rerum in eaque hic est quibusdam. Nihil aperiam et velit cum corrupti. Et sequi id at labore hic vero qui.', '2025-04-14 11:42:48', '2025-04-14 11:42:48', NULL),
(4, 4, 8, 'Assumenda ut in sunt minus voluptas velit odio. Est rerum illo voluptas id beatae recusandae dolorem. Illo voluptas veniam in vel culpa.', '2025-04-14 11:42:48', '2025-04-14 11:42:48', NULL),
(5, 2, 6, 'Accusantium rerum omnis quas consequatur minima suscipit. Qui delectus velit nobis dolore sit. Excepturi odit nemo perferendis hic non libero. Sint ipsa non rem aut aspernatur rem necessitatibus. Est sunt quis dolor iure architecto veniam sit.', '2025-04-14 11:42:48', '2025-04-14 11:42:48', NULL),
(6, 3, 1, 'Neque laborum similique minima perspiciatis. Perspiciatis ut et deleniti quod sequi corporis.', '2025-04-14 11:42:48', '2025-04-14 11:42:48', NULL),
(7, 12, 4, 'Laborum nemo quibusdam soluta aperiam neque ullam dicta. Minus voluptatem qui aperiam sint quis. Occaecati voluptatum est sed.', '2025-04-14 11:42:48', '2025-04-14 11:42:48', NULL),
(8, 3, 6, 'Atque modi consequatur tempore nam consequatur maiores. Ut praesentium natus neque aperiam aut eligendi. Consequuntur cum hic et.', '2025-04-14 11:42:48', '2025-04-14 11:42:48', NULL),
(9, 7, 1, 'Mollitia consectetur aperiam occaecati at iusto a illo. Accusamus quia et quasi. Nemo sint natus quisquam praesentium assumenda facilis a.', '2025-04-14 11:42:48', '2025-04-14 11:42:48', NULL),
(10, 9, 4, 'Officia id enim ullam est est fugit. Iusto quo qui natus id ea. Similique tempora in eum nisi aut laudantium expedita.', '2025-04-14 11:42:48', '2025-04-14 11:42:48', NULL),
(11, 2, 9, 'Ut animi officiis ad eligendi. Quos occaecati et non error odio. A magni quod aut eveniet porro. Harum quae quaerat eaque minima magni.', '2025-04-14 11:42:48', '2025-04-14 11:42:48', 4),
(12, 8, 7, 'Nobis facilis veniam aut. Et placeat dicta nulla aut voluptatibus. Et deleniti excepturi et voluptatem pariatur animi.', '2025-04-14 11:42:48', '2025-04-14 11:42:48', 10),
(13, 12, 2, 'Deleniti quos et tenetur quam. Nisi aperiam modi rerum accusamus cumque quis. Incidunt qui repellendus aliquam et.', '2025-04-14 11:42:48', '2025-04-14 11:42:48', 3),
(14, 10, 4, 'Distinctio in totam omnis nisi rerum temporibus. Doloremque rem voluptas ducimus placeat eos quisquam eaque. Exercitationem labore aut suscipit et. Quae nihil eaque nihil non aspernatur id.', '2025-04-14 11:42:48', '2025-04-14 11:42:48', 1),
(15, 3, 1, 'Quia velit quibusdam et aut libero cupiditate. Illum eaque est aut expedita nesciunt est facere. Consectetur maiores at velit consequuntur exercitationem sunt ut. Id iusto odio et quis.', '2025-04-14 11:42:48', '2025-04-14 11:42:48', 1),
(16, 11, 2, 'Aut ut dignissimos est aut. Maiores et debitis ut aperiam consequuntur ipsam veniam. Quaerat maiores officiis incidunt ratione delectus dolores.', '2025-04-14 11:42:48', '2025-04-14 11:42:48', 1),
(17, 9, 4, 'Dignissimos voluptatem et ducimus eligendi aut laborum quae commodi. Sed voluptates exercitationem vel voluptatem harum eos delectus. Reiciendis tempore vel dolorum id corrupti at.', '2025-04-14 11:42:48', '2025-04-14 11:42:48', 9),
(18, 11, 2, 'Dolorum laudantium sit dolore quisquam. Labore non esse quia et amet. Deleniti aliquam dolorum nihil maiores ad. Nihil ipsam nihil quo cupiditate qui.', '2025-04-14 11:42:48', '2025-04-14 11:42:48', 1),
(19, 9, 4, 'Ut dolores sunt fugit voluptate et blanditiis laboriosam. Eum possimus vel ipsa in quia et labore.', '2025-04-14 11:42:48', '2025-04-14 11:42:48', 1),
(20, 8, 7, 'Voluptatem provident molestias omnis dolor et consequuntur. In rem eaque vel est. Nostrum aut unde et id. Voluptatem dignissimos a tenetur atque odit.', '2025-04-14 11:42:48', '2025-04-14 11:42:48', 9);

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `likes`
--

CREATE TABLE `likes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `post_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `likes`
--

INSERT INTO `likes` (`id`, `user_id`, `post_id`, `created_at`, `updated_at`) VALUES
(1, 1, 5, '2025-04-14 11:42:48', '2025-04-14 11:42:48'),
(2, 1, 9, '2025-04-14 11:42:48', '2025-04-14 11:42:48'),
(3, 2, 7, '2025-04-14 11:42:48', '2025-04-14 11:42:48'),
(4, 11, 8, '2025-04-14 11:42:48', '2025-04-14 11:42:48'),
(5, 4, 5, '2025-04-14 11:42:48', '2025-04-14 11:42:48');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(642, '0001_01_01_000000_create_users_table', 1),
(643, '0001_01_01_000001_create_cache_table', 1),
(644, '0001_01_01_000002_create_jobs_table', 1),
(645, '2025_04_11_201052_create_posts_table', 1),
(646, '2025_04_12_071741_create_tags_table', 1),
(647, '2025_04_12_092758_create_post_tags_table', 1),
(648, '2025_04_12_102313_create_comments_table', 1),
(649, '2025_04_12_105115_create_likes_table', 1),
(650, '2025_04_12_105743_create_bookmarks_table', 1),
(651, '2025_04_12_112116_create_notifications_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `type` enum('like','comment','reply') NOT NULL,
  `message` text NOT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`id`, `user_id`, `type`, `message`, `read_at`, `created_at`, `updated_at`) VALUES
(1, 10, 'comment', 'Nulla nemo molestias at perferendis sit dolorum rerum in.', '2025-03-26 13:11:39', '2025-04-14 11:42:48', '2025-04-14 11:42:48'),
(2, 10, 'reply', 'Eligendi ut ratione placeat neque.', NULL, '2025-04-14 11:42:48', '2025-04-14 11:42:48'),
(3, 12, 'reply', 'Ea ut vitae assumenda ut distinctio ipsa.', NULL, '2025-04-14 11:42:48', '2025-04-14 11:42:48'),
(4, 1, 'comment', 'Eos consequatur dolores consequatur dolores ea quasi velit doloribus.', '2025-03-31 05:27:01', '2025-04-14 11:42:48', '2025-04-14 11:42:48'),
(5, 3, 'reply', 'Eveniet impedit omnis ullam ut illum vero accusamus nesciunt.', '2025-04-04 12:21:24', '2025-04-14 11:42:48', '2025-04-14 11:42:48'),
(6, 1, 'reply', 'Dolorem est quod quos tempora doloribus et maxime.', NULL, '2025-04-14 11:42:48', '2025-04-14 11:42:48'),
(7, 4, 'reply', 'Labore aut eveniet adipisci sed doloremque mollitia.', '2025-04-13 12:22:48', '2025-04-14 11:42:48', '2025-04-14 11:42:48'),
(8, 11, 'reply', 'Et fugit laborum rerum nihil voluptatem voluptas quisquam.', '2025-03-29 15:59:50', '2025-04-14 11:42:48', '2025-04-14 11:42:48'),
(9, 1, 'like', 'Ipsum aut enim totam quia officiis repellendus distinctio officiis.', NULL, '2025-04-14 11:42:48', '2025-04-14 11:42:48'),
(10, 11, 'reply', 'Perferendis doloremque tempore deleniti dolorum quae.', '2025-03-14 17:26:35', '2025-04-14 11:42:48', '2025-04-14 11:42:48'),
(11, 6, 'like', 'Atque sequi modi quidem sequi qui.', NULL, '2025-04-14 11:42:48', '2025-04-14 11:42:48'),
(12, 8, 'reply', 'Omnis architecto id ea consequatur ipsa.', '2025-03-17 14:37:43', '2025-04-14 11:42:48', '2025-04-14 11:42:48'),
(13, 3, 'like', 'Odio at et aperiam ipsum quisquam quibusdam eum.', '2025-04-12 18:39:43', '2025-04-14 11:42:48', '2025-04-14 11:42:48'),
(14, 10, 'like', 'Architecto omnis ab sint qui modi similique aut.', '2025-04-13 03:02:22', '2025-04-14 11:42:48', '2025-04-14 11:42:48'),
(15, 12, 'comment', 'Deleniti nihil aperiam a voluptas nesciunt voluptas ut.', '2025-03-22 13:32:15', '2025-04-14 11:42:48', '2025-04-14 11:42:48');

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `visibility` enum('public','private') NOT NULL DEFAULT 'public',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`id`, `user_id`, `title`, `content`, `image`, `visibility`, `created_at`, `updated_at`) VALUES
(1, 7, 'Et facere nam ipsum molestiae praesentium facere.', 'Provident magni error est at odio. Commodi quis optio possimus labore officia incidunt. Quis exercitationem enim ipsum dolorum laborum alias et. Exercitationem rem commodi esse eligendi.\n\nVoluptates eius eos iste voluptate. Et odit enim ab nam qui delectus fuga. Sed repellat tempore est saepe facilis.\n\nEum corrupti pariatur facere excepturi. Beatae magni in dolor est laudantium. Ab ea unde autem autem nostrum molestiae.', 'https://dummyimage.com/640x480/30e321/470d43&text=ut', 'private', '2025-04-14 11:42:47', '2025-04-14 11:42:47'),
(2, 7, 'Incidunt alias libero sunt laborum tempora.', 'Impedit aut in possimus molestiae qui culpa. Qui velit recusandae ut. Asperiores et aut veniam in itaque inventore autem.\n\nNemo minus sunt suscipit ut repellat. Dolores voluptatum dolore eum ipsam eius qui molestiae.\n\nBeatae aut esse in recusandae quidem commodi culpa. Mollitia qui veritatis incidunt sint. Aut dolores dolorem ut in cupiditate id. Sit minima sequi et velit.', 'https://dummyimage.com/640x480/ec80a7/229bee&text=dolor', 'private', '2025-04-14 11:42:47', '2025-04-14 11:42:47'),
(3, 12, 'Repudiandae est voluptatem excepturi odio voluptas dolore.', 'Optio excepturi dolores quaerat sit. Molestias labore ea quidem ut eligendi quisquam. Nulla ducimus veritatis sunt enim. Qui consequatur quidem officia autem.\n\nVoluptas facilis laboriosam animi in quae sed nobis. Magni cupiditate accusantium deleniti. Blanditiis reprehenderit at eum. Ea unde molestiae est quis ipsum id iusto enim. Maiores magnam rerum ab cupiditate ipsum et.\n\nAmet qui hic alias iste excepturi sed non. Quo rerum enim repellendus unde. Quisquam perferendis dolorem at dolore quis ut aperiam.', 'https://dummyimage.com/640x480/5f426a/ae190f&text=odio', 'private', '2025-04-14 11:42:47', '2025-04-14 11:42:47'),
(4, 2, 'Quia sint voluptas ut repellendus.', 'Fuga quod error aut alias qui enim quibusdam rerum. Iusto placeat dignissimos aut. Ut blanditiis harum omnis magnam ullam. Mollitia voluptates reiciendis non quo sunt illo quos rerum.\n\nMagni et ipsa accusantium hic sint voluptatem. Et voluptates nesciunt amet impedit debitis similique saepe. Voluptatem sed saepe occaecati ut ipsam accusamus nihil ut. Eaque voluptates quisquam ut est dolore.\n\nRepudiandae tempore delectus et voluptatem. Sit accusantium nemo inventore minima praesentium quo distinctio. Nihil quisquam sed delectus eos qui dolores voluptatem.', 'https://dummyimage.com/640x480/c700a9/045a06&text=optio', 'private', '2025-04-14 11:42:47', '2025-04-14 11:42:47'),
(5, 8, 'Ut in eligendi repellat ex.', 'Hic qui provident labore id. Debitis tenetur cumque earum assumenda facere. Veritatis voluptatum quo est velit voluptas et sed. Quo minima iure iusto sint.\n\nQuia itaque blanditiis sapiente quo. Ut dicta incidunt eius veritatis et a velit. Dolorum facere illo reiciendis.\n\nSunt adipisci est commodi explicabo et occaecati. Est sint dolorem et. Rerum officia eveniet quia dolore adipisci.', 'https://dummyimage.com/640x480/0db9dd/81446a&text=repudiandae', 'public', '2025-04-14 11:42:47', '2025-04-14 11:42:47'),
(6, 2, 'Amet reprehenderit vero accusamus recusandae ut doloremque aliquam.', 'Dolor dolor voluptatem cum aliquam laborum libero. Dolor eaque aliquam voluptate dicta optio consequuntur. Et nihil ea rerum velit harum quae odit. Qui doloribus amet quidem iste labore tempora nihil ipsam.\n\nMinima perferendis in excepturi ut hic. Sint ullam molestiae asperiores ut et. Nihil aut ut odio odit deleniti.\n\nNumquam mollitia dolor aliquam et quos ab perferendis. Est sed occaecati sed repellendus. Et praesentium non nisi unde.', 'https://dummyimage.com/640x480/d69b98/1ea423&text=sunt', 'private', '2025-04-14 11:42:47', '2025-04-14 11:42:47'),
(7, 11, 'Sunt veritatis sed perspiciatis et est necessitatibus.', 'Aperiam inventore cupiditate nisi officia veniam. Debitis magnam rerum tenetur rerum eos qui. Sit unde modi magni delectus magni exercitationem laboriosam dolorum.\n\nEt sed officiis occaecati qui hic. Excepturi nesciunt dolores et aliquid quod. Non nisi ut ipsum ducimus necessitatibus.\n\nAut quaerat totam facere laudantium omnis aliquid. Similique pariatur officia sit omnis. Voluptates laudantium itaque et nihil.', 'https://dummyimage.com/640x480/a0a992/c1531a&text=deserunt', 'public', '2025-04-14 11:42:47', '2025-04-14 11:42:47'),
(8, 3, 'Iure ut aspernatur nihil voluptatem similique nostrum.', 'Qui nulla quaerat culpa maiores sed. Excepturi vero eos veritatis corporis ut. Laborum voluptatem placeat placeat aut. Sint aut quasi omnis provident qui omnis. Praesentium numquam aspernatur ipsa aliquid quod numquam amet.\n\nTotam quis laudantium ea nam in vero. Possimus dolor tenetur commodi sit. Quia et dicta dolorem aut earum omnis quisquam.\n\nDolor ad et suscipit nisi. Dolorem dolorem consequuntur consequuntur sed ut perferendis iure quo.', 'https://dummyimage.com/640x480/8c282f/90474c&text=ducimus', 'public', '2025-04-14 11:42:47', '2025-04-14 11:42:47'),
(9, 7, 'Nam beatae consequuntur sint a dolores ullam provident.', 'Eaque tenetur voluptatem quia similique quidem omnis recusandae dignissimos. Vel omnis est occaecati aliquam aut natus vitae molestias. Saepe repudiandae ut enim in exercitationem mollitia.\n\nIllo sit neque veritatis aliquid molestiae optio veniam. Officiis vel iste voluptatibus dolorem veritatis. Ut explicabo ducimus cum et.\n\nPerferendis sunt nam dolores aut sint aut. Qui sed reprehenderit fugiat rem quaerat. Aut blanditiis fugiat modi excepturi cumque expedita.', 'https://dummyimage.com/640x480/6f2acf/696cd1&text=ut', 'private', '2025-04-14 11:42:47', '2025-04-14 11:42:47'),
(10, 13, 'test data', 'this is a test data', 'uploads/posts/1744652874.jpg', 'private', '2025-04-14 11:47:54', '2025-04-14 11:47:54'),
(11, 13, 'public post', 'post', 'uploads/posts/1744652957.jpg', 'public', '2025-04-14 11:49:17', '2025-04-14 11:49:17');

-- --------------------------------------------------------

--
-- Table structure for table `post_tags`
--

CREATE TABLE `post_tags` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `post_id` bigint(20) UNSIGNED NOT NULL,
  `tag_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `post_tags`
--

INSERT INTO `post_tags` (`id`, `post_id`, `tag_id`, `created_at`, `updated_at`) VALUES
(2, 1, 7, '2025-04-14 11:42:48', '2025-04-14 11:42:48'),
(3, 2, 13, '2025-04-14 11:42:48', '2025-04-14 11:42:48'),
(4, 3, 12, '2025-04-14 11:42:48', '2025-04-14 11:42:48'),
(5, 6, 8, '2025-04-14 11:42:48', '2025-04-14 11:42:48'),
(6, 2, 10, '2025-04-14 11:42:48', '2025-04-14 11:42:48'),
(7, 4, 2, '2025-04-14 11:42:48', '2025-04-14 11:42:48'),
(8, 7, 3, '2025-04-14 11:42:48', '2025-04-14 11:42:48'),
(9, 3, 7, '2025-04-14 11:42:48', '2025-04-14 11:42:48'),
(11, 6, 9, '2025-04-14 11:42:48', '2025-04-14 11:42:48'),
(12, 8, 6, '2025-04-14 11:42:48', '2025-04-14 11:42:48'),
(13, 6, 3, '2025-04-14 11:42:48', '2025-04-14 11:42:48'),
(14, 6, 10, '2025-04-14 11:42:48', '2025-04-14 11:42:48'),
(15, 5, 11, '2025-04-14 11:42:48', '2025-04-14 11:42:48');

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('bgOChx5159E6BmqmZlxi9rkysMKZdYxbHkw9v1So', 13, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'YTo2OntzOjY6Il90b2tlbiI7czo0MDoiSnFkTDFuOGhFOG1qRVMyZlpTYlNlR1Q0bktCSGRLRFVGN3U5QmFnMCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjEzO3M6OToiand0X3Rva2VuIjtzOjIxNjoiZXlKMGVYQWlPaUpLVjFRaUxDSmhiR2NpT2lKSVV6STFOaUo5LmV5SnBjM01pT2lKc1lYSmhkbVZzTFhSdmEyVnVJaXdpYVdGMElqb3hOelEwTmpVeU9ESTJMQ0psZUhBaU9qRTNORFEyT1RZd01qWXNJblZ6WlhKRmJXRnBiQ0k2SW1Ga2JXbHVRR1Y0WVcxd2JHVXVZMjl0SWl3aWRYTmxja2xrSWpveE0zMC5nMWNubnQ5OUdVUlExYUJ5SGNjcHU0SGIwdVpzeUp4ZWxZQkZpSHJaSkU4IjtzOjc6InVzZXJfaWQiO2k6MTM7fQ==', 1744652969),
('dyV2xE1Z8HUS9FXxbcTjZIIzPJjGHyaqFVHRxhMn', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36 OPR/117.0.0.0', 'YTo2OntzOjY6Il90b2tlbiI7czo0MDoiclRkeE9MUmdBNGNIN1JtWFh2Nzh0eWswM1gyNmRrZllsTzU4emY1NyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9wb3N0cy8xMSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjE7czo5OiJqd3RfdG9rZW4iO3M6MjEzOiJleUowZVhBaU9pSktWMVFpTENKaGJHY2lPaUpJVXpJMU5pSjkuZXlKcGMzTWlPaUpzWVhKaGRtVnNMWFJ2YTJWdUlpd2lhV0YwSWpveE56UTBOalV6TkRjNUxDSmxlSEFpT2pFM05EUTJPVFkyTnprc0luVnpaWEpGYldGcGJDSTZJblJsYzNSQVpYaGhiWEJzWlM1amIyMGlMQ0oxYzJWeVNXUWlPakY5Li1zMEpjbEZWd01xV2R3bF9JSThTMFRSTmtWalpuQzlVRGowaWhKWUExNGciO3M6NzoidXNlcl9pZCI7aToxO30=', 1744655047),
('mZfUszaFSIrVz5oScOFIA7tI7VthHO6ITGoFjq1k', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36 OPR/117.0.0.0', 'YTo2OntzOjY6Il90b2tlbiI7czo0MDoiUUF6OExRVENWSjJ3cVpYRGtnM2xjck0wOGllTHFWb0pIQ3JFMVgwUCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjE7czo5OiJqd3RfdG9rZW4iO3M6MjEzOiJleUowZVhBaU9pSktWMVFpTENKaGJHY2lPaUpJVXpJMU5pSjkuZXlKcGMzTWlPaUpzWVhKaGRtVnNMWFJ2YTJWdUlpd2lhV0YwSWpveE56UTBPREkxTlRjM0xDSmxlSEFpT2pFM05EUTROamczTnpjc0luVnpaWEpGYldGcGJDSTZJblJsYzNSQVpYaGhiWEJzWlM1amIyMGlMQ0oxYzJWeVNXUWlPakY5LkYtcnhZdXZldWJ1T0VkU25BV2tXMjd2OGtiZDBnLXI2aklKLXBmVGZhLU0iO3M6NzoidXNlcl9pZCI7aToxO30=', 1744825607);

-- --------------------------------------------------------

--
-- Table structure for table `tags`
--

CREATE TABLE `tags` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tags`
--

INSERT INTO `tags` (`id`, `name`, `created_at`, `updated_at`) VALUES
(2, 'rerum', '2025-04-14 11:42:47', '2025-04-14 11:42:47'),
(3, 'animi', '2025-04-14 11:42:47', '2025-04-14 11:42:47'),
(4, 'et', '2025-04-14 11:42:47', '2025-04-14 11:42:47'),
(5, 'vitae', '2025-04-14 11:42:47', '2025-04-14 11:42:47'),
(6, 'minima', '2025-04-14 11:42:47', '2025-04-14 11:42:47'),
(7, 'est', '2025-04-14 11:42:47', '2025-04-14 11:42:47'),
(8, 'magni', '2025-04-14 11:42:47', '2025-04-14 11:42:47'),
(9, 'sapiente', '2025-04-14 11:42:47', '2025-04-14 11:42:47'),
(10, 'laboriosam', '2025-04-14 11:42:47', '2025-04-14 11:42:47'),
(11, 'aut', '2025-04-14 11:42:47', '2025-04-14 11:42:47'),
(12, 'placeat', '2025-04-14 11:42:47', '2025-04-14 11:42:47'),
(13, 'voluptas', '2025-04-14 11:42:47', '2025-04-14 11:42:47');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `profile_pic` varchar(255) NOT NULL DEFAULT 'default/default-user-photo.png',
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `email_verified_at`, `password`, `profile_pic`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'testuser', 'test@example.com', '2025-04-14 11:42:46', '$2y$12$h2EN7ZYf1QCfY4.t2ANyK.QetqE7nLAEsHUvTeRBxFP2mvpb7jYQ2', 'default/default-user-photo.png', '8BCJnS6NF9', '2025-04-14 11:42:47', '2025-04-14 11:42:47'),
(2, 'testuser2', 'test2@example.com', '2025-04-14 11:42:47', '$2y$12$DbWKf/nsVtCadJXrUTlC1O3fs/ugfO4bXIE5qWoS7nGEgBigsgikW', 'default/default-user-photo.png', 'WMKTykdLJo', '2025-04-14 11:42:47', '2025-04-14 11:42:47'),
(3, 'blanca.grady', 'evan.ruecker@example.com', '2025-04-14 11:42:47', '$2y$12$Mr1U0uLQmQD3TltdrmXhsuI.tQShNaYDjj1YlO9qDeO7YtJ.TDLtm', 'https://dummyimage.com/640x480/1a50fb/c8d12f&text=veritatis', 'Yivhj2IvYa', '2025-04-14 11:42:47', '2025-04-14 11:42:47'),
(4, 'joconnell', 'rwilderman@example.org', '2025-04-14 11:42:47', '$2y$12$Mr1U0uLQmQD3TltdrmXhsuI.tQShNaYDjj1YlO9qDeO7YtJ.TDLtm', 'https://dummyimage.com/640x480/4ca4a3/aabbc0&text=fugit', 'A6JfG7MsHt', '2025-04-14 11:42:47', '2025-04-14 11:42:47'),
(5, 'ekassulke', 'kane.witting@example.net', '2025-04-14 11:42:47', '$2y$12$Mr1U0uLQmQD3TltdrmXhsuI.tQShNaYDjj1YlO9qDeO7YtJ.TDLtm', 'https://dummyimage.com/640x480/d74dab/46dd8a&text=doloribus', '1pfIUARKzr', '2025-04-14 11:42:47', '2025-04-14 11:42:47'),
(6, 'duane96', 'mohr.jessica@example.com', '2025-04-14 11:42:47', '$2y$12$Mr1U0uLQmQD3TltdrmXhsuI.tQShNaYDjj1YlO9qDeO7YtJ.TDLtm', 'https://dummyimage.com/640x480/b43bae/394624&text=sequi', 'Ci3Hm5fATM', '2025-04-14 11:42:47', '2025-04-14 11:42:47'),
(7, 'shane.treutel', 'quigley.savanah@example.com', '2025-04-14 11:42:47', '$2y$12$Mr1U0uLQmQD3TltdrmXhsuI.tQShNaYDjj1YlO9qDeO7YtJ.TDLtm', 'https://dummyimage.com/640x480/e85238/26a65b&text=maiores', 'LgOOfsEqog', '2025-04-14 11:42:47', '2025-04-14 11:42:47'),
(8, 'kylie41', 'cmclaughlin@example.com', '2025-04-14 11:42:47', '$2y$12$Mr1U0uLQmQD3TltdrmXhsuI.tQShNaYDjj1YlO9qDeO7YtJ.TDLtm', 'https://dummyimage.com/640x480/e2099e/c56fc0&text=possimus', 'oqP4GrEnYt', '2025-04-14 11:42:47', '2025-04-14 11:42:47'),
(9, 'skiles.leanna', 'kquigley@example.org', '2025-04-14 11:42:47', '$2y$12$Mr1U0uLQmQD3TltdrmXhsuI.tQShNaYDjj1YlO9qDeO7YtJ.TDLtm', 'https://dummyimage.com/640x480/ef4ff7/aa629e&text=delectus', 'AiwI9EAknq', '2025-04-14 11:42:47', '2025-04-14 11:42:47'),
(10, 'toni16', 'connelly.vivienne@example.net', '2025-04-14 11:42:47', '$2y$12$Mr1U0uLQmQD3TltdrmXhsuI.tQShNaYDjj1YlO9qDeO7YtJ.TDLtm', 'https://dummyimage.com/640x480/b9e1f4/febc19&text=iste', 'Kbf1tEDWU8', '2025-04-14 11:42:47', '2025-04-14 11:42:47'),
(11, 'xdaniel', 'muller.monserrate@example.org', '2025-04-14 11:42:47', '$2y$12$Mr1U0uLQmQD3TltdrmXhsuI.tQShNaYDjj1YlO9qDeO7YtJ.TDLtm', 'https://dummyimage.com/640x480/e64147/451738&text=aperiam', '54vi0bfXDJ', '2025-04-14 11:42:47', '2025-04-14 11:42:47'),
(12, 'keaton00', 'pstrosin@example.net', '2025-04-14 11:42:47', '$2y$12$Mr1U0uLQmQD3TltdrmXhsuI.tQShNaYDjj1YlO9qDeO7YtJ.TDLtm', 'https://dummyimage.com/640x480/00ecec/216501&text=tempora', 'Rgzflb5jvN', '2025-04-14 11:42:47', '2025-04-14 11:42:47'),
(13, 'testuser123', 'admin@example.com', NULL, '$2y$12$qb0p4IK8dA1ijEYSPI2QSeFsB3kbUqMhQeXCXN0ZjUXeApWkMnddW', 'uploads/1744652806.png', NULL, '2025-04-14 11:46:47', '2025-04-14 11:46:47');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bookmarks`
--
ALTER TABLE `bookmarks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `bookmarks_user_id_foreign` (`user_id`),
  ADD KEY `bookmarks_post_id_foreign` (`post_id`);

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `comments_user_id_foreign` (`user_id`),
  ADD KEY `comments_post_id_foreign` (`post_id`),
  ADD KEY `comments_parent_id_foreign` (`parent_id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `likes`
--
ALTER TABLE `likes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `likes_user_id_foreign` (`user_id`),
  ADD KEY `likes_post_id_foreign` (`post_id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `notifications_user_id_foreign` (`user_id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `posts_user_id_foreign` (`user_id`);

--
-- Indexes for table `post_tags`
--
ALTER TABLE `post_tags`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `post_tags_post_id_tag_id_unique` (`post_id`,`tag_id`),
  ADD KEY `post_tags_tag_id_foreign` (`tag_id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `tags`
--
ALTER TABLE `tags`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `tags_name_unique` (`name`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_username_unique` (`username`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bookmarks`
--
ALTER TABLE `bookmarks`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `likes`
--
ALTER TABLE `likes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=652;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `post_tags`
--
ALTER TABLE `post_tags`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `tags`
--
ALTER TABLE `tags`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bookmarks`
--
ALTER TABLE `bookmarks`
  ADD CONSTRAINT `bookmarks_post_id_foreign` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `bookmarks_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `comments_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `comments` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `comments_post_id_foreign` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `comments_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `likes`
--
ALTER TABLE `likes`
  ADD CONSTRAINT `likes_post_id_foreign` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `likes_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `notifications_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `posts`
--
ALTER TABLE `posts`
  ADD CONSTRAINT `posts_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `post_tags`
--
ALTER TABLE `post_tags`
  ADD CONSTRAINT `post_tags_post_id_foreign` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `post_tags_tag_id_foreign` FOREIGN KEY (`tag_id`) REFERENCES `tags` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
