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
  `utilisateur_id` INT NOT NULL,
  `nom` VARCHAR(45) NOT NULL,
  `prenom` VARCHAR(45) NOT NULL,
  `adresse_email` VARCHAR(45) NOT NULL,
  `num_tel` VARCHAR(45) NOT NULL,
  `mot_pass` VARCHAR(45) NOT NULL,
  `compte_actif` TINYINT NOT NULL,
  `date_creation` DATE NOT NULL,
  PRIMARY KEY (`utilisateur_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oc_pizza_db`.`client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oc_pizza_db`.`client` (
  `utilisateur_id` INT NOT NULL,
  `num_client` INT NOT NULL,
  `raison_sociale` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`utilisateur_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oc_pizza_db`.`adresse`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oc_pizza_db`.`adresse` (
  `adresse_id` INT NOT NULL,
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
  `client_utilisateur_id` INT NOT NULL,
  `nom` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`adresse_adresse_id`, `client_utilisateur_id`),
  INDEX `fk_adresse_has_client_adresse1_idx` (`adresse_adresse_id` ASC),
  CONSTRAINT `fk_adresse_has_client_adresse1`
    FOREIGN KEY (`adresse_adresse_id`)
    REFERENCES `oc_pizza_db`.`adresse` (`adresse_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oc_pizza_db`.`commande`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oc_pizza_db`.`commande` (
  `commande_id` INT NOT NULL,
  `num_commande` INT NOT NULL,
  `date_commande` DATE NOT NULL,
  `heure_commande` DATETIME NOT NULL,
  `paiement_type` VARCHAR(45) NOT NULL,
  `statut_commande` VARCHAR(45) NOT NULL,
  `totalTTC` VARCHAR(45) NOT NULL,
  `adresse_livraison_adresse_adresse_id` INT NOT NULL,
  `adresse_livraison_client_utilisateur_id` INT NOT NULL,
  PRIMARY KEY (`commande_id`),
  INDEX `fk_commande_adresse_livraison1_idx` (`adresse_livraison_adresse_adresse_id` ASC, `adresse_livraison_client_utilisateur_id` ASC) ,
  CONSTRAINT `fk_commande_adresse_livraison1`
    FOREIGN KEY (`adresse_livraison_adresse_adresse_id` , `adresse_livraison_client_utilisateur_id`)
    REFERENCES `oc_pizza_db`.`adresse_livraison` (`adresse_adresse_id` , `client_utilisateur_id`)
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
  `recette` TEXT NOT NULL,
  PRIMARY KEY (`produit_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oc_pizza_db`.`pointDeVente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oc_pizza_db`.`pointDeVente` (
  `boutique_id` INT NOT NULL,
  `coord_gps` VARCHAR(255) NULL,
  PRIMARY KEY (`boutique_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oc_pizza_db`.`employe`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oc_pizza_db`.`employe` (
  `num_secu` VARCHAR(100) NOT NULL,
  `role` VARCHAR(45) NOT NULL,
  `adresse_adresse_id` INT NOT NULL,
  `utilisateur_utilisateur_id` INT NOT NULL,
  `pointDeVente_boutique_id` INT NOT NULL,
  PRIMARY KEY (`utilisateur_utilisateur_id`),
  INDEX `fk_employe_adresse1_idx` (`adresse_adresse_id` ASC),
  INDEX `fk_employe_utilisateur1_idx` (`utilisateur_utilisateur_id` ASC),
  INDEX `fk_employe_pointDeVente1_idx` (`pointDeVente_boutique_id` ASC),
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
  INDEX `fk_ingredient_fournisseur1_idx` (`fournisseur_fournisseur_id` ASC),
  CONSTRAINT `fk_ingredient_fournisseur1`
    FOREIGN KEY (`fournisseur_fournisseur_id`)
    REFERENCES `oc_pizza_db`.`fournisseur` (`fournisseur_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oc_pizza_db`.`client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oc_pizza_db`.`client` (
  `utilisateur_id` INT NOT NULL,
  `num_client` INT NOT NULL,
  `raison_sociale` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`utilisateur_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oc_pizza_db`.`LigneCommande`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oc_pizza_db`.`LigneCommande` (
  `recette` TEXT NOT NULL,
  `commande_commande_id` INT NOT NULL,
  `produit_produit_id` INT NOT NULL,
  PRIMARY KEY (`commande_commande_id`, `produit_produit_id`),
  INDEX `fk_LigneCommande_produit1_idx` (`produit_produit_id` ASC),
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
-- Table `oc_pizza_db`.`produit_has_ingredient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oc_pizza_db`.`produit_has_ingredient` (
  `produit_produit_id` INT NOT NULL,
  `ingredient_ingredient_id` INT NOT NULL,
  `quantite` DECIMAL(5,2) NOT NULL,
  PRIMARY KEY (`produit_produit_id`, `ingredient_ingredient_id`),
  INDEX `fk_produit_has_ingredient_ingredient1_idx` (`ingredient_ingredient_id` ASC),
  INDEX `fk_produit_has_ingredient_produit1_idx` (`produit_produit_id` ASC),
  CONSTRAINT `fk_produit_has_ingredient_produit1`
    FOREIGN KEY (`produit_produit_id`)
    REFERENCES `oc_pizza_db`.`produit` (`produit_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_produit_has_ingredient_ingredient1`
    FOREIGN KEY (`ingredient_ingredient_id`)
    REFERENCES `oc_pizza_db`.`ingredient` (`ingredient_id`)
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
  INDEX `fk_pointDeVente_has_produit_produit1_idx` (`produit_produit_id` ASC),
  INDEX `fk_pointDeVente_has_produit_pointDeVente1_idx` (`pointDeVente_boutique_id` ASC),
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
  PRIMARY KEY (`pointDeVente_boutique_id`, `ingredient_ingredient_id`),
  INDEX `fk_pointDeVente_has_ingredient_ingredient1_idx` (`ingredient_ingredient_id` ASC),
  INDEX `fk_pointDeVente_has_ingredient_pointDeVente1_idx` (`pointDeVente_boutique_id` ASC),
  CONSTRAINT `fk_pointDeVente_has_ingredient_pointDeVente1`
    FOREIGN KEY (`pointDeVente_boutique_id`)
    REFERENCES `oc_pizza_db`.`pointDeVente` (`boutique_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pointDeVente_has_ingredient_ingredient1`
    FOREIGN KEY (`ingredient_ingredient_id`)
    REFERENCES `oc_pizza_db`.`ingredient` (`ingredient_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oc_pizza_db`.`Unite_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oc_pizza_db`.`Unite_type` (
  `unite_id` INT NOT NULL,
  PRIMARY KEY (`unite_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oc_pizza_db`.`Prix_par_unite`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oc_pizza_db`.`Prix_par_unite` (
  `ingredient_ingredient_id` INT NOT NULL,
  `Unite_type_unite_id` INT NOT NULL,
  `prix_HT` DECIMAL(5,2) NOT NULL,
  PRIMARY KEY (`ingredient_ingredient_id`, `Unite_type_unite_id`),
  INDEX `fk_ingredient_has_Unite_type_Unite_type1_idx` (`Unite_type_unite_id` ASC),
  INDEX `fk_ingredient_has_Unite_type_ingredient1_idx` (`ingredient_ingredient_id` ASC),
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
  `commande_commande_id` INT NOT NULL,
  `employe_utilisateur_utilisateur_id` INT NOT NULL,
  PRIMARY KEY (`commande_commande_id`, `employe_utilisateur_utilisateur_id`),
  INDEX `fk_commande_has_employe_employe1_idx` (`employe_utilisateur_utilisateur_id` ASC),
  INDEX `fk_commande_has_employe_commande1_idx` (`commande_commande_id` ASC),
  CONSTRAINT `fk_commande_has_employe_commande1`
    FOREIGN KEY (`commande_commande_id`)
    REFERENCES `oc_pizza_db`.`commande` (`commande_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_commande_has_employe_employe1`
    FOREIGN KEY (`employe_utilisateur_utilisateur_id`)
    REFERENCES `oc_pizza_db`.`employe` (`utilisateur_utilisateur_id`)
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
  INDEX `FKtdjnluyacapwwqv1ri621xbln` (`library_fk` ASC),
  INDEX `FK23b2oa5wh62flpuxf7a9tm8kh` (`publication_fk` ASC))
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
  INDEX `FKksilg4jm8e2gbpu70rhw5754i` (`copy_fk` ASC),
  INDEX `FKlusyhxhdljg6nvb9eite87ayg` (`member_fk` ASC))
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
  INDEX `FK3ipkf9x8d2m2bqqua1e93wt02` (`author_fk` ASC),
  INDEX `FKd74lo2ev6pepcc3pf1t6lvgct` (`edithor_fk` ASC))
ENGINE = MyISAM
AUTO_INCREMENT = 12
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
