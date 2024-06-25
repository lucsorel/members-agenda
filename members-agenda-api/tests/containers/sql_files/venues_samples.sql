-- Deletes any existing table
DROP TABLE IF EXISTS `venues`;

-- Creates the table
CREATE TABLE `venues` (
  `id` int UNSIGNED NOT NULL,
  `name` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `rank` tinyint UNSIGNED NOT NULL,
  `bg_color_hex` varchar(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Adds sample records
INSERT INTO `venues` (`id`, `name`, `rank`, `bg_color_hex`) VALUES
    (1, 'Accueil BreizhCamp', 1, '005F73'),
    (2, 'Goodies', 2, '2D8289');

-- Add index
ALTER TABLE `venues` ADD PRIMARY KEY (`id`);

-- AUTO_INCREMENT
ALTER TABLE `venues`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

