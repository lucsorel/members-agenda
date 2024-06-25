-- permet de supprimer des tables sans être gêné par les contraintes d'intégrité

SET foreign_key_checks = 0;

DROP TABLE IF EXISTS `venues`;
DROP TABLE IF EXISTS `people`;

DROP TABLE IF EXISTS `events`;
DROP TABLE IF EXISTS `events_speakers`;

DROP TABLE IF EXISTS `slots`;
DROP TABLE IF EXISTS `slots_members`;

-- Structure de la table `venues`

CREATE TABLE `venues` (
  `id` int UNSIGNED NOT NULL COMMENT 'system identifier',
  `name` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `rank` tinyint UNSIGNED NOT NULL COMMENT 'order of the venue in the agenda',
  `bg_color_hex` varchar(6) NOT NULL COMMENT 'background color when displayed'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Déchargement des données de la table `venues`

INSERT INTO `venues` (`id`, `name`, `rank`, `bg_color_hex`) VALUES
(1, 'Accueil BreizhCamp', 1, '005F73'),
(4, 'Amphi A', 4, '8E3089'),
(6, 'Amphi C', 6, 'AB7C69'),
(7, 'Amphi D', 7, 'B9A158');

-- Structure de la table `people`

CREATE TABLE `people` (
  `id` int UNSIGNED NOT NULL COMMENT 'system identifier',
  `fullname` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'full name of the person',
  `is_member` bit(1) NOT NULL COMMENT '0 false, 1 true'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Déchargement des données de la table `people`

INSERT INTO `people` (`id`, `fullname`, `is_member`) VALUES
(25, 'Cécilia',   b'0'),
(95, 'Nailya',    b'0'),
(70, 'Johanna',   b'1'),
(7,  'Alexandre', b'1'),
(79, 'Luc',       b'1');

-- Structure de la table `events`

CREATE TABLE `events` (
  `id` int UNSIGNED NOT NULL COMMENT 'system identifier',
  `title` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'title of the event',
  `start` datetime NOT NULL,
  `end` datetime NOT NULL,
  `venue_id` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Déchargement des données de la table `events`

INSERT INTO `events` (`id`, `title`, `start`, `end`, `venue_id`) VALUES
(22, 'Testcontainers : tu ne douteras plus de tes fonctionnalités, jeune Pydawan·e', '2024-06-27 10:30:00', '2024-06-27 11:25:00', 4),
(45, 'Manifeste pour un artisanat logiciel responsable', '2024-06-27 10:30:00', '2024-06-27 11:25:00', 7),
(39, 'Quelle est la structure d’un virus informatique et quels sont les outils de détection de virus', '2024-06-27 13:05:00', '2024-06-27 13:20:00', 6);

-- Structure de la table `events_speakers`

CREATE TABLE `events_speakers` (
  `event_id` int UNSIGNED NOT NULL,
  `person_id` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Déchargement des données de la table `events_speakers`

INSERT INTO `events_speakers` (`event_id`, `person_id`) VALUES
(22, 79),
(45, 25),
(39, 95);

CREATE TABLE `slots` (
  `id` int UNSIGNED NOT NULL COMMENT 'system identifier',
  `title` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'action to perform during this slot',
  `start` datetime NOT NULL,
  `end` datetime NOT NULL,
  `venue_id` int UNSIGNED NOT NULL COMMENT 'the id of the venue where the slot takes place',
  `needed_members_nb` tinyint NOT NULL DEFAULT '0' COMMENT 'the minimum number of members who must attend the slot'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Déchargement des données de la table `slots`

INSERT INTO `slots` (`id`, `title`, `start`, `end`, `venue_id`, `needed_members_nb`) VALUES
(43, 'Accueil', '2024-06-27 10:15:00', '2024-06-27 12:30:00', 1, 3),
(44, 'Surveillance / aide', '2024-06-27 10:15:00', '2024-06-27 12:30:00', 4, 3),
(47, 'Surveillance / aide', '2024-06-27 10:15:00', '2024-06-27 12:30:00', 7, 3),
(51, 'Surveillance / aide', '2024-06-27 12:30:00', '2024-06-27 13:30:00', 6, 3);

-- Structure de la table `slots_members`

CREATE TABLE `slots_members` (
  `slot_id` int UNSIGNED NOT NULL,
  `person_id` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Déchargement des données de la table `slots_members`

INSERT INTO `slots_members` (`slot_id`, `person_id`) VALUES
-- Alex
(43, 7),
-- Johanna
(51, 70);

-- Réactivation des contraintes d'intégrité

SET foreign_key_checks = 1;
