DROP DATABASE IF EXISTS trash_talks;

CREATE DATABASE trash_talks;

USE trash_talks;

CREATE TABLE user(
  user_id INTEGER(11) AUTO_INCREMENT NOT NULL,
  user_name VARCHAR(100) NOT NULL,
  user_first_name VARCHAR(100) NOT NULL,
  user_last_name VARCHAR(100) NOT NULL,
  user_birthday DATE NOT NULL,
  password VARCHAR(50) NOT NULL,
  date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (user_id)
);

CREATE TABLE waste(
  waste_id INTEGER(11) AUTO_INCREMENT NOT NULL,
  upc_code INTEGER(11) default 0,
  product_name VARCHAR(500) NOT NULL,
  producing_company VARCHAR(200) NOT NULL DEFAULT "N/A",
  wholly_recyclable TINYINT(1) NOT NULL, #States weather a item is recycleable for instance preanut butter jar would be false
  submitted_by INT(11) NOT NULL,
  date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (waste_id),
  FOREIGN KEY (submitted_by)
    REFERENCES user(user_id)
);

CREATE TABLE material(
  material_id INT(11) AUTO_INCREMENT NOT NULL,
  name_material VARCHAR(500) NOT NULL,
  chem_material VARCHAR(500) NOT NULL,
  technically_recyclable TINYINT(1) NOT NULL,
  recycle_rating INT(1) NOT NULL, #This rates the material as truely recyclable for instance styromfoam is technically recyclable but would get a 1 because it is unreasonable to find a recycling place
  contained_in INT(11) NOT NULL,
  date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (material_id),
  FOREIGN KEY (contained_in)
    REFERENCES waste(waste_id)
);

CREATE TABLE bin(
  bin_id INT(11) AUTO_INCREMENT NOT NULL,
  material_stream VARCHAR(50) NOT NULL,
  bin_details VARCHAR(100) NOT NULL, #Has the size, color, type, other details
  bin_owner VARCHAR(100) NOT NULL DEFAULT "N/A",
  bin_lat DECIMAL(15,8) NOT NULL,
  bin_long DECIMAL(15,8) NOT NULL,
  building_name VARCHAR(200) NOT NULL DEFAULT "N/A",
  floor VARCHAR(50) NOT NULL,
  location_details VARCHAR(200) NOT NULL,
  date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (bin_id)
);

CREATE TABLE bin_accepts(
  acceptable_material INT(11) NOT NULL,
  bin_fk INT(11) NOT NULL,
  FOREIGN KEY (acceptable_material)
    REFERENCES waste(waste_id),
  FOREIGN KEY (bin_fk)
    REFERENCES bin(bin_id)
);

INSERT INTO user (user_name, user_first_name, user_last_name, user_birthday, password)
VALUES ("lukechambers91", "Luke", "Chambers", '1991-03-16', "pasword1"), ("jackieo.alexander", "Jackie", "Alexander", '1992-01-08', "pasword2"), ("arturosroro", "Arturo", "Salmeron", '1991-11-28', "pasword3");

INSERT INTO waste (upc_code, product_name, producing_company, wholly_recyclable, submitted_by)
VALUES (123, "Aluminum Can", "Coca-Cola", 1, 1), (456, "Plastic Bottle", "Dasani (Coca-Cola)", 1, 1); 

INSERT INTO waste (product_name, wholly_recyclable, submitted_by)
VALUES ("Cardboard Box", 1, 3);

INSERT INTO waste (product_name, producing_company, wholly_recyclable, submitted_by)
VALUES ("Batteries", "Energizer", 0, 2);

INSERT INTO material (name_material, chem_material, technically_recyclable, recycle_rating, contained_in)
VALUES ("Aluminum Can", "Aluminum", 1, 9, 1), ("Plastic Bottle", "Plastic #1", 1, 8, 2), ("Plastic Bottle Lid", "Plastic #2", 1, 5, 2), ("Plastic Bottle Label", "Plastic Film #3", 1, 3, 2), ("Corregated Cardboard", "Corregated Cardboard", 1, 5, 3), ("Tape", "Plastic Film #3", 0, 0, 3);

INSERT INTO bin (material_stream, bin_details, bin_owner, bin_lat, bin_long, building_name, floor, location_details)
VALUES ("Single Stream", "96 Gallon Toter (Yellow)", "Georgia Tech", 33.779048, -84.397025, "EBB", "1st Floor", "Just inside main lobby, near front door");

INSERT INTO bin_accepts (acceptable_material, bin_fk)
VALUES (1, 1), (2, 1);