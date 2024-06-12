-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Hôte : mysql:3306
-- Généré le : mer. 12 juin 2024 à 14:01
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
(9, 'Prestataires', 9, '023E8A'),
(10, 'Divers', 10, '015199');

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
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'system identifier';

--
-- AUTO_INCREMENT pour la table `venues`
--
ALTER TABLE `venues`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'system identifier', AUTO_INCREMENT=11;

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
