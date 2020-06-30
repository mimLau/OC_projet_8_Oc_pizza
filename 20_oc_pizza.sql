-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema oc_pizza_db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema oc_pizza_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `oc_pizza_db` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema db_library
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema db_library
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `db_library` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `oc_pizza_db` ;

-- -----------------------------------------------------
-- Table `oc_pizza_db`.`utilisateur`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oc_pizza_db`.`utilisateur` (
  `utilisateur_id` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `prenom` VARCHAR(45) NOT NULL,
  `adresse_email` VARCHAR(45) NOT NULL,
  `num_tel` VARCHAR(45) NOT NULL,
  `mot_de_passe` VARCHAR(45) NOT NULL,
  `compte_actif` TINYINT NOT NULL,
  `date_creation` DATE NOT NULL,
  PRIMARY KEY (`utilisateur_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oc_pizza_db`.`client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oc_pizza_db`.`client` (
  `num_client` INT NOT NULL,
  `raison_sociale` VARCHAR(45) NOT NULL,
  `utilisateur_utilisateur_id` INT NOT NULL,
  PRIMARY KEY (`utilisateur_utilisateur_id`),
  INDEX `fk_client_utilisateur1_idx` (`utilisateur_utilisateur_id` ASC) VISIBLE,
  CONSTRAINT `fk_client_utilisateur1`
    FOREIGN KEY (`utilisateur_utilisateur_id`)
    REFERENCES `oc_pizza_db`.`utilisateur` (`utilisateur_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oc_pizza_db`.`adresse`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oc_pizza_db`.`adresse` (
  `adresse_id` INT NOT NULL AUTO_INCREMENT,
  `num_voie` VARCHAR(100) NOT NULL,
  `voie` VARCHAR(255) NOT NULL,
  `code_postal` VARCHAR(45) NOT NULL,
  `ville` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`adresse_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oc_pizza_db`.`adresse_livraison`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oc_pizza_db`.`adresse_livraison` (
  `adresse_adresse_id` INT NOT NULL,
  `client_utilisateur_utilisateur_id` INT NOT NULL,
  `nom` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`adresse_adresse_id`, `client_utilisateur_utilisateur_id`),
  INDEX `fk_adresse_has_client_adresse1_idx` (`adresse_adresse_id` ASC) VISIBLE,
  INDEX `fk_adresse_livraison_client1_idx` (`client_utilisateur_utilisateur_id` ASC) VISIBLE,
  CONSTRAINT `fk_adresse_has_client_adresse1`
    FOREIGN KEY (`adresse_adresse_id`)
    REFERENCES `oc_pizza_db`.`adresse` (`adresse_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_adresse_livraison_client1`
    FOREIGN KEY (`client_utilisateur_utilisateur_id`)
    REFERENCES `oc_pizza_db`.`client` (`utilisateur_utilisateur_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oc_pizza_db`.`commande`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oc_pizza_db`.`commande` (
  `commande_id` INT NOT NULL,
  `num_commande` VARCHAR(45) NOT NULL,
  `date_commande` DATE NOT NULL,
  `heure_commande` DATETIME NOT NULL,
  `livraison_type` VARCHAR(45) NOT NULL,
  `paiement_mode` VARCHAR(45) NOT NULL,
  `paiement_type` VARCHAR(45) NOT NULL,
  `statut_commande` VARCHAR(45) NOT NULL,
  `totalTTC` VARCHAR(45) NOT NULL,
  `adresse_livraison_adresse_adresse_id` INT NULL,
  PRIMARY KEY (`commande_id`),
  INDEX `fk_commande_adresse_livraison1_idx` (`adresse_livraison_adresse_adresse_id` ASC) VISIBLE,
  CONSTRAINT `fk_commande_adresse_livraison1`
    FOREIGN KEY (`adresse_livraison_adresse_adresse_id`)
    REFERENCES `oc_pizza_db`.`adresse_livraison` (`adresse_adresse_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oc_pizza_db`.`produit`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oc_pizza_db`.`produit` (
  `produit_id` INT NOT NULL,
  `nom` VARCHAR(45) NOT NULL,
  `descriptif` VARCHAR(255) NOT NULL,
  `prix_unitaire_ht` DECIMAL(10,2) NOT NULL,
  `taux_tva100` DECIMAL(3,1) NOT NULL,
  `reference` VARCHAR(45) NOT NULL,
  `cat_produit` VARCHAR(45) NOT NULL,
  `recette` TEXT NULL,
  PRIMARY KEY (`produit_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oc_pizza_db`.`pointDeVente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oc_pizza_db`.`pointDeVente` (
  `boutique_id` INT NOT NULL AUTO_INCREMENT,
  `adresse_adresse_id` INT NOT NULL,
  `latitude` VARCHAR(255) NULL,
  `longitude` VARCHAR(45) NULL,
  `nom` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`boutique_id`),
  INDEX `fk_pointDeVente_adresse1_idx` (`adresse_adresse_id` ASC) VISIBLE,
  CONSTRAINT `fk_pointDeVente_adresse1`
    FOREIGN KEY (`adresse_adresse_id`)
    REFERENCES `oc_pizza_db`.`adresse` (`adresse_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oc_pizza_db`.`employe`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oc_pizza_db`.`employe` (
  `num_secu` VARCHAR(100) NOT NULL,
  `role` VARCHAR(45) NOT NULL,
  `adresse_adresse_id` INT NOT NULL,
  `utilisateur_utilisateur_id` INT NOT NULL,
  `pointDeVente_boutique_id` INT NULL,
  PRIMARY KEY (`utilisateur_utilisateur_id`),
  INDEX `fk_employe_adresse1_idx` (`adresse_adresse_id` ASC) VISIBLE,
  INDEX `fk_employe_utilisateur1_idx` (`utilisateur_utilisateur_id` ASC) VISIBLE,
  INDEX `fk_employe_pointDeVente1_idx` (`pointDeVente_boutique_id` ASC) VISIBLE,
  CONSTRAINT `fk_employe_adresse1`
    FOREIGN KEY (`adresse_adresse_id`)
    REFERENCES `oc_pizza_db`.`adresse` (`adresse_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_employe_utilisateur1`
    FOREIGN KEY (`utilisateur_utilisateur_id`)
    REFERENCES `oc_pizza_db`.`utilisateur` (`utilisateur_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_employe_pointDeVente1`
    FOREIGN KEY (`pointDeVente_boutique_id`)
    REFERENCES `oc_pizza_db`.`pointDeVente` (`boutique_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oc_pizza_db`.`fournisseur`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oc_pizza_db`.`fournisseur` (
  `fournisseur_id` INT NOT NULL,
  `nom` VARCHAR(45) NOT NULL,
  `adresse` VARCHAR(100) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `num_tel` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`fournisseur_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oc_pizza_db`.`ingredient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oc_pizza_db`.`ingredient` (
  `ingredient_id` INT NOT NULL,
  `nom` VARCHAR(45) NOT NULL,
  `reference` VARCHAR(45) NOT NULL,
  `stock_mini` DECIMAL(10,3) NOT NULL,
  `ingredient_cat` VARCHAR(45) NOT NULL,
  `fournisseur_fournisseur_id` INT NOT NULL,
  PRIMARY KEY (`ingredient_id`),
  INDEX `fk_ingredient_fournisseur1_idx` (`fournisseur_fournisseur_id` ASC) VISIBLE,
  CONSTRAINT `fk_ingredient_fournisseur1`
    FOREIGN KEY (`fournisseur_fournisseur_id`)
    REFERENCES `oc_pizza_db`.`fournisseur` (`fournisseur_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oc_pizza_db`.`LigneCommande`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oc_pizza_db`.`LigneCommande` (
  `commande_commande_id` INT NOT NULL,
  `produit_produit_id` INT NOT NULL,
  PRIMARY KEY (`commande_commande_id`, `produit_produit_id`),
  INDEX `fk_LigneCommande_produit1_idx` (`produit_produit_id` ASC) VISIBLE,
  CONSTRAINT `fk_LigneCommande_commande1`
    FOREIGN KEY (`commande_commande_id`)
    REFERENCES `oc_pizza_db`.`commande` (`commande_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_LigneCommande_produit1`
    FOREIGN KEY (`produit_produit_id`)
    REFERENCES `oc_pizza_db`.`produit` (`produit_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oc_pizza_db`.`Unite_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oc_pizza_db`.`Unite_type` (
  `unite_id` INT NOT NULL,
  `nom` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`unite_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oc_pizza_db`.`produit_has_ingredient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oc_pizza_db`.`produit_has_ingredient` (
  `produit_produit_id` INT NOT NULL,
  `ingredient_ingredient_id` INT NOT NULL,
  `quantite` DECIMAL(5,2) NOT NULL,
  `Unite_type_unite_id` INT NOT NULL,
  PRIMARY KEY (`produit_produit_id`, `ingredient_ingredient_id`),
  INDEX `fk_produit_has_ingredient_ingredient1_idx` (`ingredient_ingredient_id` ASC) VISIBLE,
  INDEX `fk_produit_has_ingredient_produit1_idx` (`produit_produit_id` ASC) VISIBLE,
  INDEX `fk_produit_has_ingredient_Unite_type1_idx` (`Unite_type_unite_id` ASC) VISIBLE,
  CONSTRAINT `fk_produit_has_ingredient_produit1`
    FOREIGN KEY (`produit_produit_id`)
    REFERENCES `oc_pizza_db`.`produit` (`produit_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_produit_has_ingredient_ingredient1`
    FOREIGN KEY (`ingredient_ingredient_id`)
    REFERENCES `oc_pizza_db`.`ingredient` (`ingredient_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_produit_has_ingredient_Unite_type1`
    FOREIGN KEY (`Unite_type_unite_id`)
    REFERENCES `oc_pizza_db`.`Unite_type` (`unite_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oc_pizza_db`.`pointDeVente_has_produit`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oc_pizza_db`.`pointDeVente_has_produit` (
  `pointDeVente_boutique_id` INT NOT NULL,
  `produit_produit_id` INT NOT NULL,
  `quantite` DECIMAL(5,2) NOT NULL,
  PRIMARY KEY (`pointDeVente_boutique_id`, `produit_produit_id`),
  INDEX `fk_pointDeVente_has_produit_produit1_idx` (`produit_produit_id` ASC) VISIBLE,
  INDEX `fk_pointDeVente_has_produit_pointDeVente1_idx` (`pointDeVente_boutique_id` ASC) VISIBLE,
  CONSTRAINT `fk_pointDeVente_has_produit_pointDeVente1`
    FOREIGN KEY (`pointDeVente_boutique_id`)
    REFERENCES `oc_pizza_db`.`pointDeVente` (`boutique_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pointDeVente_has_produit_produit1`
    FOREIGN KEY (`produit_produit_id`)
    REFERENCES `oc_pizza_db`.`produit` (`produit_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oc_pizza_db`.`pointDeVente_has_ingredient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oc_pizza_db`.`pointDeVente_has_ingredient` (
  `pointDeVente_boutique_id` INT NOT NULL,
  `ingredient_ingredient_id` INT NOT NULL,
  `quantite_stock` DECIMAL(5,2) NOT NULL,
  `Unite_type_unite_id` INT NOT NULL,
  PRIMARY KEY (`pointDeVente_boutique_id`, `ingredient_ingredient_id`),
  INDEX `fk_pointDeVente_has_ingredient_ingredient1_idx` (`ingredient_ingredient_id` ASC) VISIBLE,
  INDEX `fk_pointDeVente_has_ingredient_pointDeVente1_idx` (`pointDeVente_boutique_id` ASC) VISIBLE,
  INDEX `fk_pointDeVente_has_ingredient_Unite_type1_idx` (`Unite_type_unite_id` ASC) VISIBLE,
  CONSTRAINT `fk_pointDeVente_has_ingredient_pointDeVente1`
    FOREIGN KEY (`pointDeVente_boutique_id`)
    REFERENCES `oc_pizza_db`.`pointDeVente` (`boutique_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pointDeVente_has_ingredient_ingredient1`
    FOREIGN KEY (`ingredient_ingredient_id`)
    REFERENCES `oc_pizza_db`.`ingredient` (`ingredient_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pointDeVente_has_ingredient_Unite_type1`
    FOREIGN KEY (`Unite_type_unite_id`)
    REFERENCES `oc_pizza_db`.`Unite_type` (`unite_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oc_pizza_db`.`Prix_par_unite`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oc_pizza_db`.`Prix_par_unite` (
  `ingredient_ingredient_id` INT NOT NULL,
  `Unite_type_unite_id` INT NOT NULL,
  `prix_HT` DECIMAL(5,2) NOT NULL,
  PRIMARY KEY (`ingredient_ingredient_id`, `Unite_type_unite_id`),
  INDEX `fk_ingredient_has_Unite_type_Unite_type1_idx` (`Unite_type_unite_id` ASC) VISIBLE,
  INDEX `fk_ingredient_has_Unite_type_ingredient1_idx` (`ingredient_ingredient_id` ASC) VISIBLE,
  CONSTRAINT `fk_ingredient_has_Unite_type_ingredient1`
    FOREIGN KEY (`ingredient_ingredient_id`)
    REFERENCES `oc_pizza_db`.`ingredient` (`ingredient_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ingredient_has_Unite_type_Unite_type1`
    FOREIGN KEY (`Unite_type_unite_id`)
    REFERENCES `oc_pizza_db`.`Unite_type` (`unite_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oc_pizza_db`.`commande_has_employe`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oc_pizza_db`.`commande_has_employe` (
  `employe_utilisateur_utilisateur_id` INT NOT NULL,
  `commande_commande_id` INT NOT NULL,
  PRIMARY KEY (`employe_utilisateur_utilisateur_id`, `commande_commande_id`),
  INDEX `fk_commande_has_employe_employe1_idx` (`employe_utilisateur_utilisateur_id` ASC) VISIBLE,
  INDEX `fk_commande_has_employe_commande1_idx` (`commande_commande_id` ASC) VISIBLE,
  CONSTRAINT `fk_commande_has_employe_employe1`
    FOREIGN KEY (`employe_utilisateur_utilisateur_id`)
    REFERENCES `oc_pizza_db`.`employe` (`utilisateur_utilisateur_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_commande_has_employe_commande1`
    FOREIGN KEY (`commande_commande_id`)
    REFERENCES `oc_pizza_db`.`commande` (`commande_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `db_library` ;

-- -----------------------------------------------------
-- Table `db_library`.`accounts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_library`.`accounts` (
  `user_type` VARCHAR(31) NOT NULL,
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `account_owner_email` VARCHAR(255) NOT NULL,
  `account_owner_firstname` VARCHAR(255) NOT NULL,
  `account_owner_lastname` VARCHAR(255) NOT NULL,
  `account_owner_phone_nb` VARCHAR(255) NOT NULL,
  `active_account` BIT(1) NOT NULL,
  `registration_date` DATE NOT NULL,
  `role` VARCHAR(255) NOT NULL,
  `barcode` VARCHAR(255) NULL DEFAULT NULL,
  `nb_of_currents_loans` INT(11) NULL DEFAULT NULL,
  `account_owner_username` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = MyISAM
AUTO_INCREMENT = 10
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db_library`.`authors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_library`.`authors` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `alias` VARCHAR(255) NULL DEFAULT NULL,
  `firstname` VARCHAR(255) NOT NULL,
  `lastname` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = MyISAM
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db_library`.`copies`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_library`.`copies` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `available` BIT(1) NOT NULL,
  `barcode` VARCHAR(255) NOT NULL,
  `return_date` DATE NULL DEFAULT NULL,
  `library_fk` INT(11) NULL DEFAULT NULL,
  `publication_fk` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `FKtdjnluyacapwwqv1ri621xbln` (`library_fk` ASC) VISIBLE,
  INDEX `FK23b2oa5wh62flpuxf7a9tm8kh` (`publication_fk` ASC) VISIBLE)
ENGINE = MyISAM
AUTO_INCREMENT = 23
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db_library`.`editors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_library`.`editors` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = MyISAM
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db_library`.`libraries`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_library`.`libraries` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `address` VARCHAR(255) NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = MyISAM
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db_library`.`loans`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_library`.`loans` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `extented` INT(11) NOT NULL,
  `loan_date` DATE NOT NULL,
  `loan_status` VARCHAR(255) NOT NULL,
  `reminder_nb` INT(11) NOT NULL,
  `return_date` DATE NOT NULL,
  `copy_fk` INT(11) NULL DEFAULT NULL,
  `member_fk` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `FKksilg4jm8e2gbpu70rhw5754i` (`copy_fk` ASC) VISIBLE,
  INDEX `FKlusyhxhdljg6nvb9eite87ayg` (`member_fk` ASC) VISIBLE)
ENGINE = MyISAM
AUTO_INCREMENT = 19
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db_library`.`publications`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_library`.`publications` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `category` VARCHAR(255) NOT NULL,
  `identification_nb` VARCHAR(255) NOT NULL,
  `nb_of_available_copies` INT(11) NOT NULL,
  `nb_total_ofcopies` INT(11) NOT NULL,
  `publication_date` DATE NULL DEFAULT NULL,
  `sub_category` VARCHAR(255) NOT NULL,
  `title` VARCHAR(255) NOT NULL,
  `author_fk` INT(11) NULL DEFAULT NULL,
  `edithor_fk` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `FK3ipkf9x8d2m2bqqua1e93wt02` (`author_fk` ASC) VISIBLE,
  INDEX `FKd74lo2ev6pepcc3pf1t6lvgct` (`edithor_fk` ASC) VISIBLE)
ENGINE = MyISAM
AUTO_INCREMENT = 12
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `oc_pizza_db`.`utilisateur`
-- -----------------------------------------------------
START TRANSACTION;
USE `oc_pizza_db`;
INSERT INTO `oc_pizza_db`.`utilisateur` (`utilisateur_id`, `nom`, `prenom`, `adresse_email`, `num_tel`, `mot_de_passe`, `compte_actif`, `date_creation`) VALUES (1, 'Velsin', 'Fanny', 'v.fanny@gmail.com', '02 34 54 34 22', 'fanny', 1, '2020-03-23');
INSERT INTO `oc_pizza_db`.`utilisateur` (`utilisateur_id`, `nom`, `prenom`, `adresse_email`, `num_tel`, `mot_de_passe`, `compte_actif`, `date_creation`) VALUES (2, 'Joly', 'Thymothe', 'thym.joly@hotmail.fr', '07 54 63 89 32', 'thym', 1, '2020-03-23');
INSERT INTO `oc_pizza_db`.`utilisateur` (`utilisateur_id`, `nom`, `prenom`, `adresse_email`, `num_tel`, `mot_de_passe`, `compte_actif`, `date_creation`) VALUES (3, 'Allaoui', 'Fatima', 'fatima.alaoui@yahoo.com', '07 54 63 89 32', 'fatima', 1, '2020-03-23');
INSERT INTO `oc_pizza_db`.`utilisateur` (`utilisateur_id`, `nom`, `prenom`, `adresse_email`, `num_tel`, `mot_de_passe`, `compte_actif`, `date_creation`) VALUES (4, 'Aslan', 'Yazik', 'yazik.aslan-67@gmail.com', '07 54 63 89 32', 'yazik', 1, '2020-03-23');
INSERT INTO `oc_pizza_db`.`utilisateur` (`utilisateur_id`, `nom`, `prenom`, `adresse_email`, `num_tel`, `mot_de_passe`, `compte_actif`, `date_creation`) VALUES (5, 'Chapuis', 'Yoan', 'chap.yoan@hotmail.com', '07 54 63 89 32', 'yoan', 1, '2020-03-23');
INSERT INTO `oc_pizza_db`.`utilisateur` (`utilisateur_id`, `nom`, `prenom`, `adresse_email`, `num_tel`, `mot_de_passe`, `compte_actif`, `date_creation`) VALUES (6, 'Safnez', 'Safia', 'safia.safinez@gmail.com', '07 54 63 89 32', 'safia', 1, '2020-03-23');
INSERT INTO `oc_pizza_db`.`utilisateur` (`utilisateur_id`, `nom`, `prenom`, `adresse_email`, `num_tel`, `mot_de_passe`, `compte_actif`, `date_creation`) VALUES (7, 'Sellaoui', 'Nadia', 'sel.nad@hotmail.fr', '07 54 63 89 32', 'nadia', 1, '2020-03-23');
INSERT INTO `oc_pizza_db`.`utilisateur` (`utilisateur_id`, `nom`, `prenom`, `adresse_email`, `num_tel`, `mot_de_passe`, `compte_actif`, `date_creation`) VALUES (8, 'Schneider', 'Nicolas', 'nicolas@gmail.com', '07 54 63 89 32', 'nicolas', 1, '2020-03-23');
INSERT INTO `oc_pizza_db`.`utilisateur` (`utilisateur_id`, `nom`, `prenom`, `adresse_email`, `num_tel`, `mot_de_passe`, `compte_actif`, `date_creation`) VALUES (9, 'Kastel', 'Jérôme', 'jeromeK@yahoo.fr', '07 54 63 89 32', DEFAULT, 1, '2020-03-23');

COMMIT;


-- -----------------------------------------------------
-- Data for table `oc_pizza_db`.`client`
-- -----------------------------------------------------
START TRANSACTION;
USE `oc_pizza_db`;
INSERT INTO `oc_pizza_db`.`client` (`num_client`, `raison_sociale`, `utilisateur_utilisateur_id`) VALUES (1, 'madame', 1);
INSERT INTO `oc_pizza_db`.`client` (`num_client`, `raison_sociale`, `utilisateur_utilisateur_id`) VALUES (2, 'monsieur', 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `oc_pizza_db`.`adresse`
-- -----------------------------------------------------
START TRANSACTION;
USE `oc_pizza_db`;
INSERT INTO `oc_pizza_db`.`adresse` (`adresse_id`, `num_voie`, `voie`, `code_postal`, `ville`) VALUES (1, '2', 'rue des hirondelles', '54000', 'Nancy');
INSERT INTO `oc_pizza_db`.`adresse` (`adresse_id`, `num_voie`, `voie`, `code_postal`, `ville`) VALUES (2, '4', 'avenue de normandie', '54000', 'Nancy');
INSERT INTO `oc_pizza_db`.`adresse` (`adresse_id`, `num_voie`, `voie`, `code_postal`, `ville`) VALUES (3, '15', 'route du rhin', '54000', 'Nancy');
INSERT INTO `oc_pizza_db`.`adresse` (`adresse_id`, `num_voie`, `voie`, `code_postal`, `ville`) VALUES (4, '34b', 'allée des écrivains', '54000', 'Nancy');
INSERT INTO `oc_pizza_db`.`adresse` (`adresse_id`, `num_voie`, `voie`, `code_postal`, `ville`) VALUES (5, '12', 'square spindler', '54000', 'Nancy');
INSERT INTO `oc_pizza_db`.`adresse` (`adresse_id`, `num_voie`, `voie`, `code_postal`, `ville`) VALUES (6, '3', 'route de la corse', '54000', 'Nancy');
INSERT INTO `oc_pizza_db`.`adresse` (`adresse_id`, `num_voie`, `voie`, `code_postal`, `ville`) VALUES (8, '10', 'avenue des vosges', '54000', 'Nancy');
INSERT INTO `oc_pizza_db`.`adresse` (`adresse_id`, `num_voie`, `voie`, `code_postal`, `ville`) VALUES (9, '24', 'avenue général leclerc', '54000', 'Nancy');
INSERT INTO `oc_pizza_db`.`adresse` (`adresse_id`, `num_voie`, `voie`, `code_postal`, `ville`) VALUES (10, '1', 'rue de schulmeister', '54000', 'Nancy');
INSERT INTO `oc_pizza_db`.`adresse` (`adresse_id`, `num_voie`, `voie`, `code_postal`, `ville`) VALUES (11, '7', 'route augustin fresnel', '54000', 'Nancy');
INSERT INTO `oc_pizza_db`.`adresse` (`adresse_id`, `num_voie`, `voie`, `code_postal`, `ville`) VALUES (12, '55', 'avenue jean fishard', '54000', 'Nancy');
INSERT INTO `oc_pizza_db`.`adresse` (`adresse_id`, `num_voie`, `voie`, `code_postal`, `ville`) VALUES (13, '4', 'route de la baie', '54000', 'Nancy');
INSERT INTO `oc_pizza_db`.`adresse` (`adresse_id`, `num_voie`, `voie`, `code_postal`, `ville`) VALUES (14, '17', 'rue d\'orbey', '54000', 'Nancy');

COMMIT;


-- -----------------------------------------------------
-- Data for table `oc_pizza_db`.`adresse_livraison`
-- -----------------------------------------------------
START TRANSACTION;
USE `oc_pizza_db`;
INSERT INTO `oc_pizza_db`.`adresse_livraison` (`adresse_adresse_id`, `client_utilisateur_utilisateur_id`, `nom`) VALUES (1, 1, 'Maison');
INSERT INTO `oc_pizza_db`.`adresse_livraison` (`adresse_adresse_id`, `client_utilisateur_utilisateur_id`, `nom`) VALUES (2, 2, 'Bureau');
INSERT INTO `oc_pizza_db`.`adresse_livraison` (`adresse_adresse_id`, `client_utilisateur_utilisateur_id`, `nom`) VALUES (, DEFAULT, '');

COMMIT;


-- -----------------------------------------------------
-- Data for table `oc_pizza_db`.`commande`
-- -----------------------------------------------------
START TRANSACTION;
USE `oc_pizza_db`;
INSERT INTO `oc_pizza_db`.`commande` (`commande_id`, `num_commande`, `date_commande`, `heure_commande`, `livraison_type`, `paiement_mode`, `paiement_type`, `statut_commande`, `totalTTC`, `adresse_livraison_adresse_adresse_id`) VALUES (1, '1-1-10-05', '2020-05-10', DEFAULT, 'DOMICILE', 'CB', 'ENLIGNE', 'VALIDEE', '24', 1);
INSERT INTO `oc_pizza_db`.`commande` (`commande_id`, `num_commande`, `date_commande`, `heure_commande`, `livraison_type`, `paiement_mode`, `paiement_type`, `statut_commande`, `totalTTC`, `adresse_livraison_adresse_adresse_id`) VALUES (2, '2-2-10-05', '2020-05-10', DEFAULT, 'MAGASIN', 'CB', 'MAGASIN', 'ENCOURSDEPREPA', '43', NULL);
INSERT INTO `oc_pizza_db`.`commande` (`commande_id`, `num_commande`, `date_commande`, `heure_commande`, `livraison_type`, `paiement_mode`, `paiement_type`, `statut_commande`, `totalTTC`, `adresse_livraison_adresse_adresse_id`) VALUES (3, '3-1-10-05', '2020-05-10', DEFAULT, 'DOMICILE', 'ESPECE', 'LIVRAISON', 'LIVREE', '13', 2);
INSERT INTO `oc_pizza_db`.`commande` (`commande_id`, `num_commande`, `date_commande`, `heure_commande`, `livraison_type`, `paiement_mode`, `paiement_type`, `statut_commande`, `totalTTC`, `adresse_livraison_adresse_adresse_id`) VALUES (DEFAULT, '', '', DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `oc_pizza_db`.`produit`
-- -----------------------------------------------------
START TRANSACTION;
USE `oc_pizza_db`;
INSERT INTO `oc_pizza_db`.`produit` (`produit_id`, `nom`, `descriptif`, `prix_unitaire_ht`, `taux_tva100`, `reference`, `cat_produit`, `recette`) VALUES (1, 'Mexicaine', 'Sauce tomate, double fromages, poulet rôti, poivrons, olives noires.', 7.5, 10, 'P001', 'PIZZA', 'recette');
INSERT INTO `oc_pizza_db`.`produit` (`produit_id`, `nom`, `descriptif`, `prix_unitaire_ht`, `taux_tva100`, `reference`, `cat_produit`, `recette`) VALUES (3, 'Salade cesar', 'Laitue romaine, de parmesan, d\'œufs durs et de croûtons, arrosée de sa « sauce César', 3.5, 10, 'S001', 'SALADE', '');
INSERT INTO `oc_pizza_db`.`produit` (`produit_id`, `nom`, `descriptif`, `prix_unitaire_ht`, `taux_tva100`, `reference`, `cat_produit`, `recette`) VALUES (4, 'Tiramissu', DEFAULT, 2.5, 10, 'D001', 'DESSERT', '');
INSERT INTO `oc_pizza_db`.`produit` (`produit_id`, `nom`, `descriptif`, `prix_unitaire_ht`, `taux_tva100`, `reference`, `cat_produit`, `recette`) VALUES (5, 'Spicy', 'Sauce tomate, double fromages, merguez, boeuf haché, piment, poivrons, oignons.', 7.5, 10, 'P002', 'PIZZA', 'recette');
INSERT INTO `oc_pizza_db`.`produit` (`produit_id`, `nom`, `descriptif`, `prix_unitaire_ht`, `taux_tva100`, `reference`, `cat_produit`, `recette`) VALUES (6, 'Végétarienne', 'Sauce tomate, double fromages, poivrons, champignons frais, maïs, oignons.', 7.5, 10, 'P003', 'PIZZA', 'recette');
INSERT INTO `oc_pizza_db`.`produit` (`produit_id`, `nom`, `descriptif`, `prix_unitaire_ht`, `taux_tva100`, `reference`, `cat_produit`, `recette`) VALUES (7, 'Chicken crème', 'Crème fraîche, fromage, poulet, oignons, olives', 7.5, 10, 'P004', 'PIZZA', 'recette');
INSERT INTO `oc_pizza_db`.`produit` (`produit_id`, `nom`, `descriptif`, `prix_unitaire_ht`, `taux_tva100`, `reference`, `cat_produit`, `recette`) VALUES (8, 'Saumon', 'Crème fraîche, fromage, saumon, oignons, olives', 7.5, 10, 'P005', 'PIZZA', 'recette');
INSERT INTO `oc_pizza_db`.`produit` (`produit_id`, `nom`, `descriptif`, `prix_unitaire_ht`, `taux_tva100`, `reference`, `cat_produit`, `recette`) VALUES (9, 'Glace Hagend-Dazs', DEFAULT, 3, 10, 'D002', 'DESSERT', NULL);
INSERT INTO `oc_pizza_db`.`produit` (`produit_id`, `nom`, `descriptif`, `prix_unitaire_ht`, `taux_tva100`, `reference`, `cat_produit`, `recette`) VALUES (10, 'Muffing', DEFAULT, 2.5, 10, 'D003', 'DESSERT', NULL);
INSERT INTO `oc_pizza_db`.`produit` (`produit_id`, `nom`, `descriptif`, `prix_unitaire_ht`, `taux_tva100`, `reference`, `cat_produit`, `recette`) VALUES (11, 'Salade de fruit', DEFAULT, 4, 10, 'D004', 'DESSERT', NULL);
INSERT INTO `oc_pizza_db`.`produit` (`produit_id`, `nom`, `descriptif`, `prix_unitaire_ht`, `taux_tva100`, `reference`, `cat_produit`, `recette`) VALUES (12, 'Canette Pepsi', DEFAULT, 1, 10, 'B002', 'BOISSON', NULL);
INSERT INTO `oc_pizza_db`.`produit` (`produit_id`, `nom`, `descriptif`, `prix_unitaire_ht`, `taux_tva100`, `reference`, `cat_produit`, `recette`) VALUES (13, 'Canette Sprite', DEFAULT, 1, 10, 'B003', 'BOISSON', NULL);
INSERT INTO `oc_pizza_db`.`produit` (`produit_id`, `nom`, `descriptif`, `prix_unitaire_ht`, `taux_tva100`, `reference`, `cat_produit`, `recette`) VALUES (14, 'Bouteille Coca Cola', DEFAULT, 1.5, 10, 'B004', 'BOISSON', NULL);
INSERT INTO `oc_pizza_db`.`produit` (`produit_id`, `nom`, `descriptif`, `prix_unitaire_ht`, `taux_tva100`, `reference`, `cat_produit`, `recette`) VALUES (15, 'Bouteille Pepsi', DEFAULT, 1.5, 10, 'B005', 'BOISSON', NULL);
INSERT INTO `oc_pizza_db`.`produit` (`produit_id`, `nom`, `descriptif`, `prix_unitaire_ht`, `taux_tva100`, `reference`, `cat_produit`, `recette`) VALUES (16, 'Bouteille Sprite', DEFAULT, 1.5, 10, 'B006', 'BOISSON', NULL);
INSERT INTO `oc_pizza_db`.`produit` (`produit_id`, `nom`, `descriptif`, `prix_unitaire_ht`, `taux_tva100`, `reference`, `cat_produit`, `recette`) VALUES (17, 'Bouteille Oasis', DEFAULT, 1.5, 10, 'B007', 'BOISSON', NULL);
INSERT INTO `oc_pizza_db`.`produit` (`produit_id`, `nom`, `descriptif`, `prix_unitaire_ht`, `taux_tva100`, `reference`, `cat_produit`, `recette`) VALUES (18, 'Canette Oasis', DEFAULT, 1, 10, 'B008', 'BOISSON', NULL);
INSERT INTO `oc_pizza_db`.`produit` (`produit_id`, `nom`, `descriptif`, `prix_unitaire_ht`, `taux_tva100`, `reference`, `cat_produit`, `recette`) VALUES (19, 'Salade Grecque', 'Salade verte, tomates cerises, fêta, olives noires, fines herbes, sauce vinaigrette.', 3.5, 10, 'S002', 'SALADE', NULL);
INSERT INTO `oc_pizza_db`.`produit` (`produit_id`, `nom`, `descriptif`, `prix_unitaire_ht`, `taux_tva100`, `reference`, `cat_produit`, `recette`) VALUES (20, 'Salade classique', 'Salade verte, tomates cerises, oignons, sauce vinaigrette.', 3, 10, 'S003', 'SALADE', NULL);
INSERT INTO `oc_pizza_db`.`produit` (`produit_id`, `nom`, `descriptif`, `prix_unitaire_ht`, `taux_tva100`, `reference`, `cat_produit`, `recette`) VALUES (2, 'Canette Coca cola', DEFAULT, 1, 10, 'B001', 'BOISSON', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `oc_pizza_db`.`pointDeVente`
-- -----------------------------------------------------
START TRANSACTION;
USE `oc_pizza_db`;
INSERT INTO `oc_pizza_db`.`pointDeVente` (`boutique_id`, `adresse_adresse_id`, `latitude`, `longitude`, `nom`) VALUES (1, 4, '49.0851527 N', '6.3954883 E', 'Boutique_1');
INSERT INTO `oc_pizza_db`.`pointDeVente` (`boutique_id`, `adresse_adresse_id`, `latitude`, `longitude`, `nom`) VALUES (2, 5, '48.7726297  N', '6.3954883  E', 'Boutique_2');

COMMIT;


-- -----------------------------------------------------
-- Data for table `oc_pizza_db`.`employe`
-- -----------------------------------------------------
START TRANSACTION;
USE `oc_pizza_db`;
INSERT INTO `oc_pizza_db`.`employe` (`num_secu`, `role`, `adresse_adresse_id`, `utilisateur_utilisateur_id`, `pointDeVente_boutique_id`) VALUES ('223242343243423 63', 'GERANT', 6, 3, NULL);
INSERT INTO `oc_pizza_db`.`employe` (`num_secu`, `role`, `adresse_adresse_id`, `utilisateur_utilisateur_id`, `pointDeVente_boutique_id`) VALUES ('123242343243423 63', 'LIVREUR', 7, 4, 1);
INSERT INTO `oc_pizza_db`.`employe` (`num_secu`, `role`, `adresse_adresse_id`, `utilisateur_utilisateur_id`, `pointDeVente_boutique_id`) VALUES ('123242343243423 63', 'CAISSIER', 8, 5, 1);
INSERT INTO `oc_pizza_db`.`employe` (`num_secu`, `role`, `adresse_adresse_id`, `utilisateur_utilisateur_id`, `pointDeVente_boutique_id`) VALUES ('223242343243423 63', 'PIZZAIOLO', 9, 6, 1);
INSERT INTO `oc_pizza_db`.`employe` (`num_secu`, `role`, `adresse_adresse_id`, `utilisateur_utilisateur_id`, `pointDeVente_boutique_id`) VALUES ('223242343243423 63', 'LIVREUR', 10, 7, 2);
INSERT INTO `oc_pizza_db`.`employe` (`num_secu`, `role`, `adresse_adresse_id`, `utilisateur_utilisateur_id`, `pointDeVente_boutique_id`) VALUES ('123242343243423 63', 'CAISSIER', 11, 8, 2);
INSERT INTO `oc_pizza_db`.`employe` (`num_secu`, `role`, `adresse_adresse_id`, `utilisateur_utilisateur_id`, `pointDeVente_boutique_id`) VALUES ('123242343243423 63', 'PIZZAIOLO', 12, 9, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `oc_pizza_db`.`fournisseur`
-- -----------------------------------------------------
START TRANSACTION;
USE `oc_pizza_db`;
INSERT INTO `oc_pizza_db`.`fournisseur` (`fournisseur_id`, `nom`, `adresse`, `email`, `num_tel`) VALUES (1, 'Primeur Sapam', '2 Rue Robert Schuman, 68170 Rixheim', 'achats.mulhouse@sapam.fr', '03 89 60 67 17');
INSERT INTO `oc_pizza_db`.`fournisseur` (`fournisseur_id`, `nom`, `adresse`, `email`, `num_tel`) VALUES (2, 'Promocash', 'Parc de la Mer Rouge rue du Pâturage, 68000 Mulhouse', 'acahts.mul@promocash.fr', '03 89 60 73 50');
INSERT INTO `oc_pizza_db`.`fournisseur` (`fournisseur_id`, `nom`, `adresse`, `email`, `num_tel`) VALUES (3, 'Métro', 'Rue de la Griotte, 68260 Kingersheim', 'pcom.mul@metro.fr ', '03 89 57 05 28');

COMMIT;


-- -----------------------------------------------------
-- Data for table `oc_pizza_db`.`ingredient`
-- -----------------------------------------------------
START TRANSACTION;
USE `oc_pizza_db`;
INSERT INTO `oc_pizza_db`.`ingredient` (`ingredient_id`, `nom`, `reference`, `stock_mini`, `ingredient_cat`, `fournisseur_fournisseur_id`) VALUES (1, 'farine', 'a001', 30, 'BOULANGE', 1);
INSERT INTO `oc_pizza_db`.`ingredient` (`ingredient_id`, `nom`, `reference`, `stock_mini`, `ingredient_cat`, `fournisseur_fournisseur_id`) VALUES (2, 'oeufs', 'pf001', 30, 'PRODUITFRAIS', 1);
INSERT INTO `oc_pizza_db`.`ingredient` (`ingredient_id`, `nom`, `reference`, `stock_mini`, `ingredient_cat`, `fournisseur_fournisseur_id`) VALUES (3, 'crème fraiche', 'pf002', 5, 'PRODUITFRAIS', 1);
INSERT INTO `oc_pizza_db`.`ingredient` (`ingredient_id`, `nom`, `reference`, `stock_mini`, `ingredient_cat`, `fournisseur_fournisseur_id`) VALUES (4, 'sel', 'a002', 3, 'CONDIMENT', 2);
INSERT INTO `oc_pizza_db`.`ingredient` (`ingredient_id`, `nom`, `reference`, `stock_mini`, `ingredient_cat`, `fournisseur_fournisseur_id`) VALUES (5, 'levure', 'a003', 3, 'BOULANGE', 2);
INSERT INTO `oc_pizza_db`.`ingredient` (`ingredient_id`, `nom`, `reference`, `stock_mini`, `ingredient_cat`, `fournisseur_fournisseur_id`) VALUES (6, 'sauce tomate', 'a004', 4, 'EPICERIE', 2);
INSERT INTO `oc_pizza_db`.`ingredient` (`ingredient_id`, `nom`, `reference`, `stock_mini`, `ingredient_cat`, `fournisseur_fournisseur_id`) VALUES (7, 'tomate', 'l001', 4, 'LEGUME', 3);
INSERT INTO `oc_pizza_db`.`ingredient` (`ingredient_id`, `nom`, `reference`, `stock_mini`, `ingredient_cat`, `fournisseur_fournisseur_id`) VALUES (8, 'poivron', 'l002', 3, 'LEGUME', 3);
INSERT INTO `oc_pizza_db`.`ingredient` (`ingredient_id`, `nom`, `reference`, `stock_mini`, `ingredient_cat`, `fournisseur_fournisseur_id`) VALUES (9, 'olive noire', 'l003', 3, 'LEGUME', 3);
INSERT INTO `oc_pizza_db`.`ingredient` (`ingredient_id`, `nom`, `reference`, `stock_mini`, `ingredient_cat`, `fournisseur_fournisseur_id`) VALUES (10, 'oignon', 'l004', 5, 'LEGUME', 3);
INSERT INTO `oc_pizza_db`.`ingredient` (`ingredient_id`, `nom`, `reference`, `stock_mini`, `ingredient_cat`, `fournisseur_fournisseur_id`) VALUES (11, 'fromage rappé', 'f003', 6, 'PRODUITFRAIS', 1);
INSERT INTO `oc_pizza_db`.`ingredient` (`ingredient_id`, `nom`, `reference`, `stock_mini`, `ingredient_cat`, `fournisseur_fournisseur_id`) VALUES (12, 'mozarella', 'f004', 6, 'PRODUITFRAIS', 1);
INSERT INTO `oc_pizza_db`.`ingredient` (`ingredient_id`, `nom`, `reference`, `stock_mini`, `ingredient_cat`, `fournisseur_fournisseur_id`) VALUES (13, 'saumon', 'p001', 5, 'POISSON', 1);
INSERT INTO `oc_pizza_db`.`ingredient` (`ingredient_id`, `nom`, `reference`, `stock_mini`, `ingredient_cat`, `fournisseur_fournisseur_id`) VALUES (14, 'escalope de poulet', 'vo001', 6, 'VOLAILLE', 1);
INSERT INTO `oc_pizza_db`.`ingredient` (`ingredient_id`, `nom`, `reference`, `stock_mini`, `ingredient_cat`, `fournisseur_fournisseur_id`) VALUES (15, 'merguez', 'c001', 6, 'CHARCUTERIE', 1);
INSERT INTO `oc_pizza_db`.`ingredient` (`ingredient_id`, `nom`, `reference`, `stock_mini`, `ingredient_cat`, `fournisseur_fournisseur_id`) VALUES (16, 'poulet', 'v002', 6, 'VOLAILLE', 2);
INSERT INTO `oc_pizza_db`.`ingredient` (`ingredient_id`, `nom`, `reference`, `stock_mini`, `ingredient_cat`, `fournisseur_fournisseur_id`) VALUES (17, 'maïs', 'a005', 3, 'LEGUME', 2);
INSERT INTO `oc_pizza_db`.`ingredient` (`ingredient_id`, `nom`, `reference`, `stock_mini`, `ingredient_cat`, `fournisseur_fournisseur_id`) VALUES (18, 'boeuf haché', 'vi001', 5, 'VIANDE', DEFAULT);
INSERT INTO `oc_pizza_db`.`ingredient` (`ingredient_id`, `nom`, `reference`, `stock_mini`, `ingredient_cat`, `fournisseur_fournisseur_id`) VALUES (19, 'piment', 'l005', 3, 'LEGUME', DEFAULT);
INSERT INTO `oc_pizza_db`.`ingredient` (`ingredient_id`, `nom`, `reference`, `stock_mini`, `ingredient_cat`, `fournisseur_fournisseur_id`) VALUES (20, 'champignon', 'l006', 3, 'LEGUME', DEFAULT);
INSERT INTO `oc_pizza_db`.`ingredient` (`ingredient_id`, `nom`, `reference`, `stock_mini`, `ingredient_cat`, `fournisseur_fournisseur_id`) VALUES (21, 'huile', 'a006', 4, 'EPICERIE', DEFAULT);

COMMIT;


-- -----------------------------------------------------
-- Data for table `oc_pizza_db`.`LigneCommande`
-- -----------------------------------------------------
START TRANSACTION;
USE `oc_pizza_db`;
INSERT INTO `oc_pizza_db`.`LigneCommande` (`commande_commande_id`, `produit_produit_id`) VALUES (1, 1);
INSERT INTO `oc_pizza_db`.`LigneCommande` (`commande_commande_id`, `produit_produit_id`) VALUES (1, 3);
INSERT INTO `oc_pizza_db`.`LigneCommande` (`commande_commande_id`, `produit_produit_id`) VALUES (1, 12);
INSERT INTO `oc_pizza_db`.`LigneCommande` (`commande_commande_id`, `produit_produit_id`) VALUES (1, 10);
INSERT INTO `oc_pizza_db`.`LigneCommande` (`commande_commande_id`, `produit_produit_id`) VALUES (2, 8);
INSERT INTO `oc_pizza_db`.`LigneCommande` (`commande_commande_id`, `produit_produit_id`) VALUES (2, 4);
INSERT INTO `oc_pizza_db`.`LigneCommande` (`commande_commande_id`, `produit_produit_id`) VALUES (2, 15);
INSERT INTO `oc_pizza_db`.`LigneCommande` (`commande_commande_id`, `produit_produit_id`) VALUES (3, 1);
INSERT INTO `oc_pizza_db`.`LigneCommande` (`commande_commande_id`, `produit_produit_id`) VALUES (3, 3);
INSERT INTO `oc_pizza_db`.`LigneCommande` (`commande_commande_id`, `produit_produit_id`) VALUES (3, 10);

COMMIT;


-- -----------------------------------------------------
-- Data for table `oc_pizza_db`.`Unite_type`
-- -----------------------------------------------------
START TRANSACTION;
USE `oc_pizza_db`;
INSERT INTO `oc_pizza_db`.`Unite_type` (`unite_id`, `nom`) VALUES (1, 'kg');
INSERT INTO `oc_pizza_db`.`Unite_type` (`unite_id`, `nom`) VALUES (2, 'g');
INSERT INTO `oc_pizza_db`.`Unite_type` (`unite_id`, `nom`) VALUES (3, 'l');
INSERT INTO `oc_pizza_db`.`Unite_type` (`unite_id`, `nom`) VALUES (4, 'ml');
INSERT INTO `oc_pizza_db`.`Unite_type` (`unite_id`, `nom`) VALUES (5, 'unite');

COMMIT;


-- -----------------------------------------------------
-- Data for table `oc_pizza_db`.`produit_has_ingredient`
-- -----------------------------------------------------
START TRANSACTION;
USE `oc_pizza_db`;
INSERT INTO `oc_pizza_db`.`produit_has_ingredient` (`produit_produit_id`, `ingredient_ingredient_id`, `quantite`, `Unite_type_unite_id`) VALUES (1, 6, 250, 2);
INSERT INTO `oc_pizza_db`.`produit_has_ingredient` (`produit_produit_id`, `ingredient_ingredient_id`, `quantite`, `Unite_type_unite_id`) VALUES (1, 11, 50, 2);
INSERT INTO `oc_pizza_db`.`produit_has_ingredient` (`produit_produit_id`, `ingredient_ingredient_id`, `quantite`, `Unite_type_unite_id`) VALUES (1, 12, 50, 2);
INSERT INTO `oc_pizza_db`.`produit_has_ingredient` (`produit_produit_id`, `ingredient_ingredient_id`, `quantite`, `Unite_type_unite_id`) VALUES (1, 18, 100, 2);
INSERT INTO `oc_pizza_db`.`produit_has_ingredient` (`produit_produit_id`, `ingredient_ingredient_id`, `quantite`, `Unite_type_unite_id`) VALUES (1, 8, 20, 2);
INSERT INTO `oc_pizza_db`.`produit_has_ingredient` (`produit_produit_id`, `ingredient_ingredient_id`, `quantite`, `Unite_type_unite_id`) VALUES (1, 19, 1, 5);
INSERT INTO `oc_pizza_db`.`produit_has_ingredient` (`produit_produit_id`, `ingredient_ingredient_id`, `quantite`, `Unite_type_unite_id`) VALUES (1, 10, 3, 5);
INSERT INTO `oc_pizza_db`.`produit_has_ingredient` (`produit_produit_id`, `ingredient_ingredient_id`, `quantite`, `Unite_type_unite_id`) VALUES (8, 3, 125, 2);
INSERT INTO `oc_pizza_db`.`produit_has_ingredient` (`produit_produit_id`, `ingredient_ingredient_id`, `quantite`, `Unite_type_unite_id`) VALUES (8, 11, 100, 2);
INSERT INTO `oc_pizza_db`.`produit_has_ingredient` (`produit_produit_id`, `ingredient_ingredient_id`, `quantite`, `Unite_type_unite_id`) VALUES (8, 13, 100, 2);
INSERT INTO `oc_pizza_db`.`produit_has_ingredient` (`produit_produit_id`, `ingredient_ingredient_id`, `quantite`, `Unite_type_unite_id`) VALUES (8, 10, 3, 5);
INSERT INTO `oc_pizza_db`.`produit_has_ingredient` (`produit_produit_id`, `ingredient_ingredient_id`, `quantite`, `Unite_type_unite_id`) VALUES (8, 9, 20, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `oc_pizza_db`.`pointDeVente_has_ingredient`
-- -----------------------------------------------------
START TRANSACTION;
USE `oc_pizza_db`;
INSERT INTO `oc_pizza_db`.`pointDeVente_has_ingredient` (`pointDeVente_boutique_id`, `ingredient_ingredient_id`, `quantite_stock`, `Unite_type_unite_id`) VALUES (1, 6, 50, 1);
INSERT INTO `oc_pizza_db`.`pointDeVente_has_ingredient` (`pointDeVente_boutique_id`, `ingredient_ingredient_id`, `quantite_stock`, `Unite_type_unite_id`) VALUES (1, 11, 50, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `oc_pizza_db`.`Prix_par_unite`
-- -----------------------------------------------------
START TRANSACTION;
USE `oc_pizza_db`;
INSERT INTO `oc_pizza_db`.`Prix_par_unite` (`ingredient_ingredient_id`, `Unite_type_unite_id`, `prix_HT`) VALUES (6, 1, 5);
INSERT INTO `oc_pizza_db`.`Prix_par_unite` (`ingredient_ingredient_id`, `Unite_type_unite_id`, `prix_HT`) VALUES (11, 1, 20);

COMMIT;


-- -----------------------------------------------------
-- Data for table `oc_pizza_db`.`commande_has_employe`
-- -----------------------------------------------------
START TRANSACTION;
USE `oc_pizza_db`;
INSERT INTO `oc_pizza_db`.`commande_has_employe` (`employe_utilisateur_utilisateur_id`, `commande_commande_id`) VALUES (5, 1);
INSERT INTO `oc_pizza_db`.`commande_has_employe` (`employe_utilisateur_utilisateur_id`, `commande_commande_id`) VALUES (8, 2);
INSERT INTO `oc_pizza_db`.`commande_has_employe` (`employe_utilisateur_utilisateur_id`, `commande_commande_id`) VALUES (9, 2);
INSERT INTO `oc_pizza_db`.`commande_has_employe` (`employe_utilisateur_utilisateur_id`, `commande_commande_id`) VALUES (5, 3);
INSERT INTO `oc_pizza_db`.`commande_has_employe` (`employe_utilisateur_utilisateur_id`, `commande_commande_id`) VALUES (6, 3);
INSERT INTO `oc_pizza_db`.`commande_has_employe` (`employe_utilisateur_utilisateur_id`, `commande_commande_id`) VALUES (4, 3);
INSERT INTO `oc_pizza_db`.`commande_has_employe` (`employe_utilisateur_utilisateur_id`, `commande_commande_id`) VALUES (, DEFAULT);
INSERT INTO `oc_pizza_db`.`commande_has_employe` (`employe_utilisateur_utilisateur_id`, `commande_commande_id`) VALUES (, DEFAULT);
INSERT INTO `oc_pizza_db`.`commande_has_employe` (`employe_utilisateur_utilisateur_id`, `commande_commande_id`) VALUES (, DEFAULT);

COMMIT;

