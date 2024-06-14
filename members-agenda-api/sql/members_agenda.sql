-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Hôte : mysql:3306
-- Généré le : ven. 14 juin 2024 à 11:37
-- Version du serveur : 8.0.37
-- Version de PHP : 8.0.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `members_agenda`
--

-- --------------------------------------------------------

--
-- Structure de la table `people`
--

CREATE TABLE `people` (
  `id` int UNSIGNED NOT NULL COMMENT 'system identifier',
  `fullname` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'full name of the person',
  `is_member` bit(1) NOT NULL COMMENT '0 false, 1 true'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `slots`
--

CREATE TABLE `slots` (
  `id` int UNSIGNED NOT NULL COMMENT 'system identifier',
  `title` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'action to perform during this slot',
  `start` datetime NOT NULL,
  `end` datetime NOT NULL,
  `venue_id` int UNSIGNED NOT NULL COMMENT 'the id of the venue where the slot takes place',
  `needed_members_nb` tinyint NOT NULL DEFAULT '0' COMMENT 'the minimum number of members who must attend the slot'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `slots`
--

INSERT INTO `slots` (`id`, `title`, `start`, `end`, `venue_id`, `needed_members_nb`) VALUES
(1, 'FAC - Accueil CYIM', '2024-06-25 09:00:00', '2024-06-25 09:30:00', 1, 2),
(2, 'Rendez-vous général', '2024-06-25 09:00:00', '2024-06-25 10:00:00', 1, 10),
(3, 'Départ vers FranceCar', '2024-06-25 09:40:00', '2024-06-25 10:00:00', 10, 2),
(4, 'Accueil Eurolive', '2024-06-25 10:30:00', '2024-06-25 11:00:00', 1, 1),
(5, 'Charger camion', '2024-06-25 10:15:00', '2024-06-25 11:00:00', 10, 10),
(6, 'Décharger camion', '2024-06-25 11:00:00', '2024-06-25 12:00:00', 1, 10),
(7, 'Mise en place accueil', '2024-06-25 14:00:00', '2024-06-25 18:00:00', 1, 4),
(8, 'Mise en place amphi', '2024-06-25 14:00:00', '2024-06-25 18:00:00', 4, 2),
(9, 'Mise en place amphi', '2024-06-25 14:00:00', '2024-06-25 18:00:00', 5, 3),
(10, 'Mise en place amphi', '2024-06-25 14:00:00', '2024-06-25 18:00:00', 6, 5),
(11, 'Mise en place amphi', '2024-06-25 14:00:00', '2024-06-25 18:00:00', 7, 3),
(12, 'Mise en place amphi', '2024-06-25 14:00:00', '2024-06-25 18:00:00', 8, 3),
(13, 'Mise en place stands', '2024-06-25 14:00:00', '2024-06-25 18:00:00', 3, 2),
(14, 'Camion matériel Sonowest', '2024-06-25 14:00:00', '2024-06-25 16:00:00', 10, 3),
(15, 'Accueil traiteur Lemétayer', '2024-06-25 14:30:00', '2024-06-25 16:00:00', 9, 1),
(16, 'Accueil sponsor barrière', '2024-06-25 15:00:00', '2024-06-25 16:00:00', 11, 3),
(17, 'Accueil sponsors hall', '2024-06-25 15:00:00', '2024-06-25 18:00:00', 3, 2),
(18, 'Point sécurité université', '2024-06-25 16:15:00', '2024-06-25 17:00:00', 11, 3),
(19, 'Briefing bénévoles', '2024-06-25 18:00:00', '2024-06-25 19:00:00', 1, 2),
(20, 'Ouverture', '2024-06-26 07:00:00', '2024-06-26 08:30:00', 3, 2),
(21, 'Accueil', '2024-06-26 08:30:00', '2024-06-26 10:30:00', 1, 4),
(22, 'Goodies', '2024-06-26 08:30:00', '2024-06-26 10:30:00', 2, 2),
(23, 'Accueil', '2024-06-26 09:45:00', '2024-06-26 12:15:00', 1, 3),
(24, 'Goodies', '2024-06-26 09:45:00', '2024-06-26 12:15:00', 2, 3),
(25, 'Surveillance / aide', '2024-06-26 09:45:00', '2024-06-26 12:15:00', 4, 3),
(26, 'Surveillance / aide', '2024-06-26 09:45:00', '2024-06-26 12:15:00', 5, 3),
(27, 'Surveillance / aide', '2024-06-26 09:45:00', '2024-06-26 12:15:00', 6, 3),
(28, 'Surveillance / aide', '2024-06-26 09:45:00', '2024-06-26 12:15:00', 7, 3),
(29, 'Surveillance / aide', '2024-06-26 09:45:00', '2024-06-26 12:15:00', 8, 3),
(30, 'Accueil', '2024-06-26 11:50:00', '2024-06-26 13:40:00', 1, 2),
(31, 'Surveillance buffet', '2024-06-26 11:50:00', '2024-06-26 13:40:00', 9, 2),
(32, 'Surveillance / aide', '2024-06-26 13:15:00', '2024-06-26 15:45:00', 4, 3),
(33, 'Surveillance / aide', '2024-06-26 13:15:00', '2024-06-26 15:45:00', 5, 3),
(34, 'Surveillance / aide', '2024-06-26 13:15:00', '2024-06-26 15:45:00', 6, 3),
(35, 'Surveillance / aide', '2024-06-26 13:15:00', '2024-06-26 15:45:00', 7, 3),
(36, 'Surveillance / aide', '2024-06-26 13:15:00', '2024-06-26 15:45:00', 8, 3),
(37, 'Ouverture', '2024-06-27 08:00:00', '2024-06-27 08:30:00', 3, 2),
(38, 'Accueil', '2024-06-27 08:00:00', '2024-06-27 09:00:00', 1, 5),
(39, 'Accueil', '2024-06-27 09:00:00', '2024-06-27 10:30:00', 1, 3),
(40, 'Goodies', '2024-06-27 08:30:00', '2024-06-27 10:30:00', 2, 2),
(41, 'Keynote live', '2024-06-27 08:45:00', '2024-06-27 10:15:00', 6, 3),
(42, 'Keynote retransmission', '2024-06-27 08:45:00', '2024-06-27 10:15:00', 7, 3),
(43, 'Accueil', '2024-06-27 10:15:00', '2024-06-27 12:30:00', 1, 3),
(44, 'Surveillance / aide', '2024-06-27 10:15:00', '2024-06-27 12:30:00', 4, 3),
(45, 'Surveillance / aide', '2024-06-27 10:15:00', '2024-06-27 12:30:00', 5, 3),
(46, 'Surveillance / aide', '2024-06-27 10:15:00', '2024-06-27 12:30:00', 6, 3),
(47, 'Surveillance / aide', '2024-06-27 10:15:00', '2024-06-27 12:30:00', 7, 3),
(48, 'Surveillance / aide', '2024-06-27 10:15:00', '2024-06-27 12:30:00', 8, 3),
(49, 'Accueil', '2024-06-27 12:30:00', '2024-06-27 13:15:00', 1, 3),
(50, 'Surveillance buffet', '2024-06-27 12:30:00', '2024-06-27 13:15:00', 9, 2),
(51, 'Surveillance / aide', '2024-06-27 12:30:00', '2024-06-27 13:15:00', 6, 3),
(52, 'Surveillance / aide', '2024-06-27 12:30:00', '2024-06-27 13:15:00', 7, 3),
(53, 'Surveillance / aide', '2024-06-27 12:30:00', '2024-06-27 13:15:00', 8, 3),
(54, 'Accueil', '2024-06-27 13:15:00', '2024-06-27 15:45:00', 1, 3),
(55, 'Surveillance / aide', '2024-06-27 13:15:00', '2024-06-27 15:45:00', 4, 3),
(56, 'Surveillance / aide', '2024-06-27 13:15:00', '2024-06-27 15:45:00', 5, 3),
(57, 'Surveillance / aide', '2024-06-27 13:15:00', '2024-06-27 15:45:00', 6, 3),
(58, 'Surveillance / aide', '2024-06-27 13:15:00', '2024-06-27 15:45:00', 7, 3),
(59, 'Surveillance / aide', '2024-06-27 13:15:00', '2024-06-27 15:45:00', 8, 3),
(60, 'Goodies', '2024-06-27 15:00:00', '2024-06-27 16:00:00', 2, 2),
(61, 'Accueil', '2024-06-27 15:45:00', '2024-06-27 18:10:00', 1, 3),
(62, 'Surveillance / aide', '2024-06-27 15:45:00', '2024-06-27 18:10:00', 4, 3),
(63, 'Surveillance / aide', '2024-06-27 15:45:00', '2024-06-27 18:10:00', 5, 3),
(64, 'Surveillance / aide', '2024-06-27 15:45:00', '2024-06-27 18:10:00', 6, 3),
(65, 'Surveillance / aide', '2024-06-27 15:45:00', '2024-06-27 18:10:00', 7, 3),
(66, 'Surveillance / aide', '2024-06-27 15:45:00', '2024-06-27 18:10:00', 8, 3),
(67, 'Keynote live', '2024-06-27 17:45:00', '2024-06-27 18:45:00', 6, 3),
(68, 'Préparation meet & greet', '2024-06-27 18:15:00', '2024-06-27 18:50:00', 9, 4),
(69, 'Ouverture', '2024-06-28 08:00:00', '2024-06-28 08:30:00', 3, 1),
(70, 'Accueil', '2024-06-28 08:00:00', '2024-06-28 09:00:00', 1, 3),
(71, 'Accueil', '2024-06-28 09:00:00', '2024-06-28 10:30:00', 1, 3),
(72, 'Goodies', '2024-06-28 08:30:00', '2024-06-28 10:30:00', 2, 2),
(73, 'Keynote live', '2024-06-28 08:45:00', '2024-06-28 10:15:00', 6, 3),
(74, 'Keynote retransmission', '2024-06-28 08:45:00', '2024-06-28 10:15:00', 7, 3),
(75, 'Accueil', '2024-06-28 10:15:00', '2024-06-28 12:30:00', 1, 3),
(76, 'Surveillance / aide', '2024-06-28 10:15:00', '2024-06-28 12:30:00', 4, 3),
(77, 'Surveillance / aide', '2024-06-28 10:15:00', '2024-06-28 12:30:00', 5, 3),
(78, 'Surveillance / aide', '2024-06-28 10:15:00', '2024-06-28 12:30:00', 6, 3),
(79, 'Surveillance / aide', '2024-06-28 10:15:00', '2024-06-28 12:30:00', 7, 3),
(80, 'Surveillance / aide', '2024-06-28 10:15:00', '2024-06-28 12:30:00', 8, 3),
(81, 'Accueil', '2024-06-28 12:30:00', '2024-06-28 13:15:00', 1, 3),
(82, 'Surveillance buffet', '2024-06-28 12:30:00', '2024-06-28 13:15:00', 9, 2),
(83, 'Surveillance / aide', '2024-06-28 12:30:00', '2024-06-28 13:15:00', 6, 3),
(84, 'Surveillance / aide', '2024-06-28 12:30:00', '2024-06-28 13:15:00', 7, 3),
(85, 'Surveillance / aide', '2024-06-28 12:30:00', '2024-06-28 13:15:00', 8, 3),
(86, 'Accueil', '2024-06-28 13:15:00', '2024-06-28 15:45:00', 1, 3),
(87, 'Surveillance / aide', '2024-06-28 13:15:00', '2024-06-28 15:45:00', 4, 3),
(88, 'Surveillance / aide', '2024-06-28 13:15:00', '2024-06-28 15:45:00', 5, 3),
(89, 'Surveillance / aide', '2024-06-28 13:15:00', '2024-06-28 15:45:00', 6, 3),
(90, 'Surveillance / aide', '2024-06-28 13:15:00', '2024-06-28 15:45:00', 7, 3),
(91, 'Surveillance / aide', '2024-06-28 13:15:00', '2024-06-28 15:45:00', 8, 3),
(92, 'Préparation rangement', '2024-06-28 15:00:00', '2024-06-28 16:00:00', 11, 3),
(93, 'Barrière sponsors', '2024-06-28 16:00:00', '2024-06-28 17:30:00', 3, 3),
(94, 'Accueil', '2024-06-28 15:45:00', '2024-06-28 17:30:00', 1, 3),
(95, 'Surveillance / aide', '2024-06-28 15:45:00', '2024-06-28 17:30:00', 4, 3),
(96, 'Surveillance / aide', '2024-06-28 15:45:00', '2024-06-28 17:30:00', 5, 3),
(97, 'Surveillance / aide', '2024-06-28 15:45:00', '2024-06-28 17:30:00', 6, 3),
(98, 'Surveillance / aide', '2024-06-28 15:45:00', '2024-06-28 17:30:00', 7, 3),
(99, 'Surveillance / aide', '2024-06-28 15:45:00', '2024-06-28 17:30:00', 8, 3),
(100, 'Rangement', '2024-06-28 17:30:00', '2024-06-28 19:00:00', 3, 20);

-- --------------------------------------------------------

--
-- Structure de la table `venues`
--

CREATE TABLE `venues` (
  `id` int UNSIGNED NOT NULL COMMENT 'system identifier',
  `name` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `rank` tinyint UNSIGNED NOT NULL COMMENT 'order of the venue in the agenda',
  `bg_color_hex` varchar(6) NOT NULL COMMENT 'background color when displayed'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `venues`
--

INSERT INTO `venues` (`id`, `name`, `rank`, `bg_color_hex`) VALUES
(1, 'Accueil BreizhCamp', 1, '005F73'),
(2, 'Goodies', 2, '2D8289'),
(3, 'Hall et stands', 3, '59A49F'),
(4, 'Amphi A', 4, '8E3089'),
(5, 'Amphi B', 5, '9C5679'),
(6, 'Amphi C', 6, 'AB7C69'),
(7, 'Amphi D', 7, 'B9A158'),
(8, 'Amphi E', 8, 'C7C748'),
(9, 'Restauration', 9, '43AA8B'),
(10, 'Prestataires', 10, '023E8A'),
(11, 'Divers', 11, '015199');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `people`
--
ALTER TABLE `people`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `slots`
--
ALTER TABLE `slots`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_slots_venues_id` (`venue_id`);

--
-- Index pour la table `venues`
--
ALTER TABLE `venues`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `people`
--
ALTER TABLE `people`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'system identifier';

--
-- AUTO_INCREMENT pour la table `slots`
--
ALTER TABLE `slots`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'system identifier', AUTO_INCREMENT=101;

--
-- AUTO_INCREMENT pour la table `venues`
--
ALTER TABLE `venues`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'system identifier', AUTO_INCREMENT=12;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `slots`
--
ALTER TABLE `slots`
  ADD CONSTRAINT `fk_slots_venues_id` FOREIGN KEY (`venue_id`) REFERENCES `venues` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
