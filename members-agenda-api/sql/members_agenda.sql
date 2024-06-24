-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Hôte : mysql:3306
-- Généré le : lun. 24 juin 2024 à 15:35
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
-- Structure de la table `events`
--

CREATE TABLE `events` (
  `id` int UNSIGNED NOT NULL COMMENT 'system identifier',
  `title` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'title of the event',
  `start` datetime NOT NULL,
  `end` datetime NOT NULL,
  `venue_id` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `events`
--

INSERT INTO `events` (`id`, `title`, `start`, `end`, `venue_id`) VALUES
(1, '▣ QR Codes : suivez les points sans vous perdre ! ▣', '2024-06-26 10:00:00', '2024-06-26 12:00:00', 4),
(2, 'Parcours initiatique sur l\'authentification avec Keycloak', '2024-06-26 13:30:00', '2024-06-26 15:30:00', 4),
(3, 'Migration de projets Terraform vers Terragrunt.', '2024-06-26 16:00:00', '2024-06-26 18:00:00', 4),
(4, 'Angular change de logo mais pas que.', '2024-06-26 10:00:00', '2024-06-26 12:00:00', 5),
(5, 'Let\'s React : 8 ans plus tard !', '2024-06-26 13:30:00', '2024-06-26 15:30:00', 5),
(6, 'Automatiser les Tests d\'API avec Bruno', '2024-06-26 16:00:00', '2024-06-26 18:00:00', 5),
(7, 'Voyage au coeur d\'Appwrite : le backend open-source qui challenge Firebase 🧳', '2024-06-26 10:00:00', '2024-06-26 12:00:00', 6),
(8, 'Fresque de la Data', '2024-06-26 13:30:00', '2024-06-26 15:30:00', 6),
(9, 'Atelier : 10 tests simples pour améliorer l\'accessibilité de votre site', '2024-06-26 16:00:00', '2024-06-26 18:00:00', 6),
(10, 'Génération XZ', '2024-06-26 10:00:00', '2024-06-26 10:55:00', 7),
(11, 'Les apps écologiques, c\'est pas automatique ?', '2024-06-26 11:00:00', '2024-06-26 11:55:00', 7),
(12, 'Les normes de messagerie pour une meilleure expérience e-mail', '2024-06-26 13:30:00', '2024-06-26 14:25:00', 7),
(13, 'Cinq critères pour muscler vos échanges HTTP', '2024-06-26 14:30:00', '2024-06-26 15:25:00', 7),
(14, 'Du code source à l\'exécutable : plongée dans les entrailles de la compilation en Rust', '2024-06-26 16:00:00', '2024-06-26 16:55:00', 7),
(15, 'Flink vs Kafka Streams : le duel des titans du streaming', '2024-06-26 17:00:00', '2024-06-26 17:55:00', 7),
(16, 'Burn Your Idols - Comment devenir un bon rôle modèle ?', '2024-06-26 10:00:00', '2024-06-26 10:55:00', 8),
(17, 'Défier l\'entropie : réécrire ses applications ou reprendre le contrôle ?', '2024-06-26 11:00:00', '2024-06-26 11:55:00', 8),
(18, 'HTMX - Un retour aux templates ou le futur du front-end ?', '2024-06-26 13:30:00', '2024-06-26 14:25:00', 8),
(19, 'Un code à l\'épreuve du temps avec le Supple Design', '2024-06-26 14:30:00', '2024-06-26 15:25:00', 8),
(20, 'Et si on ouvre grand les bras aux SIG ?', '2024-06-26 16:00:00', '2024-06-26 16:55:00', 8),
(21, 'RetEx : Optimisation du temps de démarrage d\'une application Java Spring.', '2024-06-26 17:00:00', '2024-06-26 17:55:00', 8),
(22, 'Testcontainers : tu ne douteras plus de tes fonctionnalités, jeune Pydawan·e', '2024-06-27 10:30:00', '2024-06-27 11:25:00', 4),
(23, 'Il faut sauver le dernier giga de RAM', '2024-06-27 11:35:00', '2024-06-27 12:30:00', 4),
(24, 'MongoDB en scale-up : comment sortir d’un enfer monolithique', '2024-06-27 13:30:00', '2024-06-27 14:25:00', 4),
(25, '🆘 Mon Elasticsearch a perdu la boule 😵‍💫', '2024-06-27 16:00:00', '2024-06-27 16:55:00', 4),
(26, 'La force du temp réel : développement d\'un jeu mobile de palet breton/vendéen multijoueur', '2024-06-27 14:35:00', '2024-06-27 15:30:00', 4),
(27, 'Des batches à moindre coût environnemental !', '2024-06-27 17:05:00', '2024-06-27 17:30:00', 4),
(28, 'Déverrouiller sa porte en une commande slack 🤖 #iot #diy #cloud', '2024-06-27 17:35:00', '2024-06-27 18:00:00', 4),
(29, 'D’observateur à responsable : enrayer l’impact des biais racistes dans l\'expérience utilisateur.', '2024-06-27 10:30:00', '2024-06-27 11:25:00', 5),
(30, 'Une seconde pour traiter un milliard de lignes en java ?', '2024-06-27 11:35:00', '2024-06-27 12:30:00', 5),
(31, 'Tests JavaScript : reconstituer le puzzle', '2024-06-27 13:30:00', '2024-06-27 14:25:00', 5),
(32, 'La recherche à l\'ère de l\'IA', '2024-06-27 14:35:00', '2024-06-27 15:30:00', 5),
(33, 'La Clean Archi ca marche aussi dans le Front !', '2024-06-27 16:00:00', '2024-06-27 16:55:00', 5),
(34, 'Présentez avec style grâce à OBS !', '2024-06-27 17:05:00', '2024-06-27 17:30:00', 5),
(35, 'OpenFeature : Vers La normalisation du feature flags', '2024-06-27 17:35:00', '2024-06-27 18:00:00', 5),
(36, 'Model Mitosis : ne plus se tromper entre les microservices et le monolithe', '2024-06-27 10:30:00', '2024-06-27 11:25:00', 6),
(37, 'JSol\'Ex : traitement d\'images solaires en Java', '2024-06-27 11:35:00', '2024-06-27 12:30:00', 6),
(38, 'Playwright : tester vos applications devient un jeu d\'enfant', '2024-06-27 12:45:00', '2024-06-27 13:00:00', 6),
(39, 'Quelle est la structure d’un virus informatique et quels sont les outils de détection de virus', '2024-06-27 13:05:00', '2024-06-27 13:20:00', 6),
(40, 'Redis, le plus sous-estimé des plus utilisés !', '2024-06-27 13:30:00', '2024-06-27 14:25:00', 6),
(41, 'La bienveillance, (je trouve que) c\'est de la 💩', '2024-06-27 14:35:00', '2024-06-27 15:30:00', 6),
(42, 'Les feature flags : le couteau suisse de votre flow de développement', '2024-06-27 16:00:00', '2024-06-27 16:55:00', 6),
(43, 'C4 model, la solution pour standardiser mes schémas d\'architecture ?', '2024-06-27 17:05:00', '2024-06-27 17:30:00', 6),
(44, 'SQL Test Kit, ou comment tester unitairement vos requêtes SQL', '2024-06-27 17:35:00', '2024-06-27 18:00:00', 6),
(45, 'Manifeste pour un artisanat logiciel responsable', '2024-06-27 10:30:00', '2024-06-27 11:25:00', 7),
(46, 'Le langage Mojo 🔥: Un nouvel espoir pour l\'IA ?', '2024-06-27 11:35:00', '2024-06-27 12:30:00', 7),
(47, 'SOPS, Passez un savon à vos secrets en clair !', '2024-06-27 12:45:00', '2024-06-27 13:00:00', 7),
(48, 'Introduction aux Threads Virtuels en SpringBoot 3 à travers une démonstration', '2024-06-27 13:05:00', '2024-06-27 13:20:00', 7),
(49, 'Discuter avec ses articles de journaux : le RAG, kesako ?', '2024-06-27 13:30:00', '2024-06-27 14:25:00', 7),
(50, 'De HTTP 1 à 3, pourquoi et comment ?', '2024-06-27 14:35:00', '2024-06-27 15:30:00', 7),
(51, 'L\'architecture Micro-frontends, un nouvel espoir ?', '2024-06-27 16:00:00', '2024-06-27 16:55:00', 7),
(52, 'asdf, un outil pour toutes vos versions', '2024-06-27 17:05:00', '2024-06-27 17:30:00', 7),
(53, '/e/OS, mon smartphone Android sans Google', '2024-06-27 17:35:00', '2024-06-27 18:00:00', 7),
(54, 'Keycloak & Authorization : A New Hope', '2024-06-27 10:30:00', '2024-06-27 11:25:00', 8),
(55, 'Bug Bounty : Révolutionner la détection des vulnérabilités dans votre SI et passer à l\'échelle', '2024-06-27 11:35:00', '2024-06-27 12:30:00', 8),
(56, 'La Diva 👑, la Rockstar 🎸 et le consultant 💁', '2024-06-27 12:45:00', '2024-06-27 13:00:00', 8),
(57, 'Comment faire une bonne campagne de Green Washing Solutioniste ?', '2024-06-27 13:05:00', '2024-06-27 13:20:00', 8),
(58, 'Loi de Conway : Lorsque votre conception produit se fâche avec votre organisation', '2024-06-27 13:30:00', '2024-06-27 14:25:00', 8),
(59, '5 ans avec Flutter', '2024-06-27 14:35:00', '2024-06-27 15:30:00', 8),
(60, 'Est-il (encore) possible d\'héberger son propre serveur de messagerie ?', '2024-06-27 16:00:00', '2024-06-27 16:55:00', 8),
(61, 'Exegol : Le Hacking à base de conteneurs', '2024-06-27 17:05:00', '2024-06-27 17:30:00', 8),
(62, 'Compose to Kube, Episode IV: Un nouvel espoir', '2024-06-27 17:35:00', '2024-06-27 18:00:00', 8),
(63, 'Racine carrée, bit-shifting et paracétamol', '2024-06-28 10:30:00', '2024-06-28 11:25:00', 4),
(64, 'BackToBasics: texte et numÃ©rique', '2024-06-28 11:35:00', '2024-06-28 12:30:00', 4),
(65, 'Optimisation de performance bénéfice ou sacrifice ?', '2024-06-28 13:30:00', '2024-06-28 14:25:00', 4),
(66, 'L’open-source n’est pas (déjà) mort', '2024-06-28 14:35:00', '2024-06-28 15:30:00', 4),
(67, 'Apache Software Foundation, comment ça marche ?', '2024-06-28 16:00:00', '2024-06-28 16:55:00', 4),
(68, 'De l\'IA dans mon API Gateway ??? Mais pour quoi faire ?', '2024-06-28 09:35:00', '2024-06-28 10:00:00', 4),
(69, 'Alerte, tout brûle ! Comment gérer des incidents techniques', '2024-06-28 10:30:00', '2024-06-28 11:25:00', 5),
(70, 'Cracking the Quantum Code: Découvrons la révolution quantique !', '2024-06-28 11:35:00', '2024-06-28 12:30:00', 5),
(71, 'Comment intégrer au mieux une personne autiste en entreprise', '2024-06-28 11:35:00', '2024-06-28 12:30:00', 8),
(72, 'Stockage web : le guide galactique', '2024-06-28 14:35:00', '2024-06-28 15:30:00', 5),
(73, 'Unleashing the Force of Spring Boot 3', '2024-06-28 16:00:00', '2024-06-28 16:55:00', 5),
(74, 'Gleam, un langage né sous une bonne étoile', '2024-06-28 09:35:00', '2024-06-28 10:00:00', 5),
(75, 'Linguist : Détecter les langages de 400+ millions de dépôts Git', '2024-06-28 10:30:00', '2024-06-28 11:25:00', 6),
(76, 'Comment s’assurer de perdre des données avec Apache Kafka !', '2024-06-28 11:35:00', '2024-06-28 12:30:00', 6),
(77, 'Le côté obscur des pull requests et comment lutter', '2024-06-28 12:45:00', '2024-06-28 13:00:00', 6),
(78, 'Dédramatisons l\'accessibilité', '2024-06-28 13:05:00', '2024-06-28 13:20:00', 6),
(79, 'Des IA industrialisées à La Poste', '2024-06-28 13:30:00', '2024-06-28 14:25:00', 6),
(80, 'Green AI : comment éviter que la potion magique de l\'IA ne se transforme en poison ?', '2024-06-28 14:35:00', '2024-06-28 15:30:00', 6),
(81, 'La quête de la réactivité : L\'odyssée des Signals', '2024-06-28 16:00:00', '2024-06-28 16:55:00', 6),
(82, 'Gérer une partie de votre dette technique avec Renovate', '2024-06-28 09:35:00', '2024-06-28 10:00:00', 6),
(83, 'JPA ne serait-il pas finalement quantique ?', '2024-06-28 10:30:00', '2024-06-28 11:25:00', 7),
(84, 'Cartographier l\'Univers de Star Wars avec Neo4j', '2024-06-28 11:35:00', '2024-06-28 12:30:00', 7),
(85, 'Le developement embarqué, c\'est pour vous aussi !!!', '2024-06-28 12:45:00', '2024-06-28 13:00:00', 7),
(86, 'Pourquoi devriez vous toujours utiliser une pagination par curseur ?', '2024-06-28 13:05:00', '2024-06-28 13:20:00', 7),
(87, 'APIs ❤️ HTML', '2024-06-28 13:30:00', '2024-06-28 14:25:00', 7),
(88, 'Rendre le cloud \"carbon-aware\"', '2024-06-28 14:35:00', '2024-06-28 15:30:00', 7),
(89, '🗄️Et si vous mettiez à disposition vos jobs de CI/CD sur une étagère ?', '2024-06-28 16:00:00', '2024-06-28 16:55:00', 7),
(90, 'Android ♥ Kotlin, une folle histoire d\'amour', '2024-06-28 09:35:00', '2024-06-28 10:00:00', 7),
(91, 'Ce que j\'aurais aimé savoir avant que ma JVM n\'explose en prod', '2024-06-28 10:30:00', '2024-06-28 11:25:00', 8),
(92, 'Construire son framework d’entreprise au dessus de Spring boot', '2024-06-28 13:30:00', '2024-06-28 14:25:00', 5),
(93, 'Comment j\'ai trouvé le sens de la vie grâce à WebAssembly', '2024-06-28 12:45:00', '2024-06-28 13:00:00', 8),
(94, 'Les brouteurs d\'IA', '2024-06-28 13:05:00', '2024-06-28 13:20:00', 8),
(95, 'Elasticsearch Query Language: ES|QL', '2024-06-28 13:30:00', '2024-06-28 14:25:00', 8),
(96, 'Je malmène ta prod en direct avec 15 failles de sécu', '2024-06-28 14:35:00', '2024-06-28 15:30:00', 8),
(97, 'Orchestrez vos workflows métier avec Temporal.io', '2024-06-28 16:00:00', '2024-06-28 16:55:00', 8),
(98, 'Quel Vector d’attaque pour votre pipeline d’ingestion de logs ?', '2024-06-28 09:35:00', '2024-06-28 10:00:00', 8);

-- --------------------------------------------------------

--
-- Structure de la table `events_speakers`
--

CREATE TABLE `events_speakers` (
  `event_id` int UNSIGNED NOT NULL,
  `person_id` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `events_speakers`
--

INSERT INTO `events_speakers` (`event_id`, `person_id`) VALUES
(76, 1),
(2, 2),
(40, 2),
(6, 3),
(92, 4),
(66, 5),
(17, 6),
(83, 7),
(24, 8),
(69, 8),
(50, 9),
(28, 10),
(71, 11),
(72, 13),
(56, 14),
(12, 15),
(61, 16),
(63, 17),
(38, 18),
(42, 18),
(87, 19),
(1, 20),
(53, 20),
(59, 22),
(24, 23),
(90, 24),
(45, 25),
(37, 26),
(49, 27),
(78, 28),
(80, 29),
(13, 30),
(78, 30),
(85, 32),
(23, 33),
(21, 34),
(82, 35),
(79, 36),
(32, 37),
(95, 37),
(33, 39),
(14, 40),
(27, 40),
(65, 41),
(48, 42),
(55, 44),
(4, 45),
(55, 46),
(8, 47),
(98, 48),
(9, 49),
(96, 51),
(51, 52),
(64, 53),
(73, 54),
(97, 55),
(77, 56),
(18, 57),
(9, 58),
(91, 60),
(60, 61),
(4, 62),
(23, 63),
(67, 64),
(31, 65),
(46, 66),
(89, 67),
(43, 68),
(2, 69),
(3, 69),
(11, 70),
(36, 71),
(89, 72),
(36, 75),
(58, 75),
(70, 76),
(22, 79),
(41, 79),
(7, 80),
(76, 81),
(16, 82),
(41, 83),
(29, 85),
(34, 86),
(5, 87),
(68, 87),
(10, 88),
(57, 89),
(25, 90),
(92, 90),
(30, 91),
(7, 92),
(40, 93),
(84, 93),
(35, 94),
(39, 95),
(62, 97),
(13, 98),
(94, 99),
(79, 100),
(88, 102),
(74, 103),
(75, 104),
(80, 106),
(8, 107),
(54, 108),
(1, 109),
(86, 109),
(15, 110),
(5, 111),
(81, 112),
(19, 113),
(47, 114),
(52, 114),
(20, 116),
(93, 117),
(84, 118),
(49, 119),
(44, 120),
(26, 121),
(59, 123),
(62, 124);

-- --------------------------------------------------------

--
-- Structure de la table `people`
--

CREATE TABLE `people` (
  `id` int UNSIGNED NOT NULL COMMENT 'system identifier',
  `fullname` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'full name of the person',
  `is_member` bit(1) NOT NULL COMMENT '0 false, 1 true'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `people`
--

INSERT INTO `people` (`id`, `fullname`, `is_member`) VALUES
(1, 'Adam Souquieres', b'0'),
(2, 'Adrien Wattez', b'0'),
(3, 'Alan Duchene', b'0'),
(4, 'Alexandre Baron', b'0'),
(5, 'Alexandre Brianceau', b'0'),
(6, 'Alexandre Jeambrun', b'0'),
(7, 'Alexandre Thomazo', b'1'),
(8, 'Alexis \"Horgix\" Chotard', b'0'),
(9, 'Alexis Delhelle', b'0'),
(10, 'Alexis Morelle', b'0'),
(11, 'Angi Guyard', b'0'),
(12, 'Annelore Bidaux', b'1'),
(13, 'Anthony Le Goas', b'0'),
(14, 'Antoine Cailly', b'0'),
(15, 'Antoine G', b'0'),
(16, 'Antoine Mayer', b'0'),
(17, 'Audren Burlot', b'0'),
(18, 'Benjamin Cavy', b'0'),
(19, 'Benoit Averty', b'0'),
(20, 'Benoît Masson', b'0'),
(21, 'Benoit Miedan-Gros', b'1'),
(22, 'Can Yalin', b'0'),
(23, 'Caroline Becker', b'0'),
(24, 'Caroline Mouden', b'1'),
(25, 'Cécilia Bossard', b'0'),
(26, 'Cédric Champeau', b'0'),
(27, 'Cédric Jézéquel', b'0'),
(28, 'Céline Merand', b'0'),
(29, 'Charles Vivoix', b'0'),
(30, 'Charline Humeau', b'0'),
(31, 'Christopher Louët', b'1'),
(32, 'Damien Hackett', b'0'),
(33, 'Damien Lucas', b'0'),
(34, 'Daria Hervieux', b'0'),
(35, 'David De Carvalho', b'0'),
(36, 'David Mazin', b'0'),
(37, 'David Pilato', b'0'),
(38, 'Didier Certain', b'1'),
(39, 'Dorian Lamandé', b'0'),
(40, 'Édouard Siha', b'0'),
(41, 'Emmanuel-Lin Toulemonde', b'0'),
(42, 'Emmanuelle Rouillé', b'0'),
(43, 'Étienne Besson', b'1'),
(44, 'Florent Le Borgne', b'0'),
(45, 'Florian Allainmat', b'0'),
(46, 'Florian Girard', b'0'),
(47, 'Franck Cussac', b'0'),
(48, 'François Dubrez', b'0'),
(49, 'François-Xavier Lair', b'0'),
(50, 'Gaël Salaün', b'1'),
(51, 'Gaëtan Eleouet', b'0'),
(52, 'Gregory Houllier', b'0'),
(53, 'Guillaume Collic', b'1'),
(54, 'Guillaume Yan', b'0'),
(55, 'Gwendal Leclerc', b'0'),
(56, 'Hadrien Mens-Pellen', b'0'),
(57, 'Harold Favereau', b'0'),
(58, 'Henri Gauffriau', b'0'),
(59, 'Hermann Nsounga', b'1'),
(60, 'Hugo Métivier', b'0'),
(61, 'Hugues Lepesant', b'0'),
(62, 'Imryck N/A', b'0'),
(63, 'Ivan Béthus', b'0'),
(64, 'JB Onofré', b'0'),
(65, 'Jean-François Greffier', b'0'),
(66, 'Jean-Luc Tromparent', b'0'),
(67, 'Jean-Philippe Baconnais', b'0'),
(68, 'Jérôme Gauthier', b'0'),
(69, 'Jérôme Marchand', b'0'),
(70, 'Johanna Duigou', b'1'),
(71, 'Josian Chevalier', b'0'),
(72, 'Jules Agostini', b'0'),
(73, 'Julien Coste', b'1'),
(74, 'Julien Stephan', b'1'),
(75, 'Julien Topçu', b'0'),
(76, 'Laurent Grangeau', b'0'),
(77, 'Laurent Huet', b'1'),
(78, 'Léna Ndiaye', b'1'),
(79, 'Luc Sorel-Giffo', b'1'),
(80, 'Lucas Audart', b'0'),
(81, 'Ludovic Boutros', b'0'),
(82, 'Magali Milbergue', b'0'),
(83, 'Malo Toanen', b'0'),
(84, 'Marc Audefroy', b'1'),
(85, 'Marcy Ericka Charollois', b'0'),
(86, 'Martin Bahier', b'0'),
(87, 'Mathieu Ancelin', b'0'),
(88, 'Mathieu Pousse', b'0'),
(89, 'Maxime Dupont', b'0'),
(90, 'Maxime Odye', b'1'),
(91, 'Maxime Reynier', b'0'),
(92, 'Mickael Alves', b'0'),
(93, 'Mickaël Barroux', b'0'),
(94, 'Morgan Blanloeil', b'0'),
(95, 'Nailya Bogrova', b'0'),
(96, 'Nicolas Bouron', b'1'),
(97, 'Nicolas De Loof', b'0'),
(98, 'Nicolas Giraud', b'0'),
(99, 'Nicolas Ledez', b'1'),
(100, 'Nicolas Payneau', b'0'),
(101, 'Nicolas Pennec', b'1'),
(102, 'Olivier Bierlaire', b'0'),
(103, 'Pascal Le Merrer', b'1'),
(104, 'Paul Chaignon', b'0'),
(105, 'Quentin Peltier', b'1'),
(106, 'Reynald Rivière', b'0'),
(107, 'Sandra Pietrowska', b'0'),
(108, 'Sébastien Brousse', b'1'),
(109, 'Sébastien Chédor', b'1'),
(110, 'Sébastien Coulle', b'0'),
(111, 'Sébastien Prunier', b'0'),
(112, 'Stéphane Spassevitch', b'0'),
(113, 'Sylvain Decout', b'0'),
(114, 'Sylvain Métayer', b'0'),
(115, 'Sylvain Révéreault', b'1'),
(116, 'Talab Ou Ali Halima', b'0'),
(117, 'Théo Gianella', b'0'),
(118, 'Thomas Martin', b'0'),
(119, 'Victor Klötzer', b'0'),
(120, 'Victor Landeau', b'0'),
(121, 'Vincent Ogloblinsky', b'0'),
(122, 'Yoann Dubreuil', b'1'),
(123, 'Youen Garel', b'0'),
(124, 'Guillaume Lours', b'0');

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
-- Structure de la table `slots_members`
--

CREATE TABLE `slots_members` (
  `slot_id` int UNSIGNED NOT NULL,
  `person_id` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `slots_members`
--

INSERT INTO `slots_members` (`slot_id`, `person_id`) VALUES
(44, 7),
(44, 21),
(44, 38),
(44, 73);

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
-- Index pour la table `events`
--
ALTER TABLE `events`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_events_venues_id` (`venue_id`);

--
-- Index pour la table `events_speakers`
--
ALTER TABLE `events_speakers`
  ADD UNIQUE KEY `u_events_speakers` (`event_id`,`person_id`),
  ADD KEY `fk_events_speakers_person_id` (`person_id`);

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
-- Index pour la table `slots_members`
--
ALTER TABLE `slots_members`
  ADD UNIQUE KEY `u_slots_members` (`slot_id`,`person_id`),
  ADD KEY `fk_slots_members_person_id` (`person_id`);

--
-- Index pour la table `venues`
--
ALTER TABLE `venues`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `events`
--
ALTER TABLE `events`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'system identifier', AUTO_INCREMENT=99;

--
-- AUTO_INCREMENT pour la table `people`
--
ALTER TABLE `people`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'system identifier', AUTO_INCREMENT=125;

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
-- Contraintes pour la table `events`
--
ALTER TABLE `events`
  ADD CONSTRAINT `fk_events_venues_id` FOREIGN KEY (`venue_id`) REFERENCES `venues` (`id`);

--
-- Contraintes pour la table `events_speakers`
--
ALTER TABLE `events_speakers`
  ADD CONSTRAINT `fk_events_speakers_event_id` FOREIGN KEY (`event_id`) REFERENCES `events` (`id`),
  ADD CONSTRAINT `fk_events_speakers_person_id` FOREIGN KEY (`person_id`) REFERENCES `people` (`id`);

--
-- Contraintes pour la table `slots`
--
ALTER TABLE `slots`
  ADD CONSTRAINT `fk_slots_venues_id` FOREIGN KEY (`venue_id`) REFERENCES `venues` (`id`);

--
-- Contraintes pour la table `slots_members`
--
ALTER TABLE `slots_members`
  ADD CONSTRAINT `fk_slots_members_person_id` FOREIGN KEY (`person_id`) REFERENCES `people` (`id`),
  ADD CONSTRAINT `fk_slots_members_slot_id` FOREIGN KEY (`slot_id`) REFERENCES `slots` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
