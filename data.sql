/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Agumon', '2020-02-03', 0, true, 10.23);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Gabumon', '2018-11-15', 2, true, 8.00);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Pikachu', '2021-01-07', 1, false, 15.04);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Devimon', '2017-05-12', 5, true, 11.00);

-- Insert data into animals table

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)VALUES('Charmander','2020-02-08',0,false,11.00);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)VALUES('Plantmon','2021-11-15',2,true,5.70);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)VALUES('Squirtle','1993-04-02',3,false,12.13);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)VALUES('Angemon','2005-06-12',1,true,45.00);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)VALUES('Boarmon','2005-06-07',7,true,20.40);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)VALUES('Blossom','1998-10-13',3,true,17.00);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)VALUES('Ditto','2022-05-14',4,true,22.00);

/* Insert data into owners table */

INSERT INTO owners (full_name, age) VALUES
    ('Sam Smith', 34),
    ('Jennifer Orwell', 19),
    ('Bob', 45),
    ('Melody Pond', 77),
    ('Dean Winchester', 14),
    ('Jodie Whittaker', 38);

INSERT INTO species (name) VALUES
('Pokemon'),
('Digimon');

UPDATE animals a
SET species_id = s.id
FROM species s
WHERE (a.name LIKE '%mon' AND s.name = 'Digimon')
   OR (a.name NOT LIKE '%mon' AND s.name = 'Pokemon');

UPDATE animals a
SET owner_id = o.id
FROM owners o
WHERE o.full_name IN ('Sam Smith', 'Jennifer Orwell', 'Bob', 'Melody Pond', 'Dean Winchester')
  AND (
    (a.name = 'Agumon' AND o.full_name = 'Sam Smith')
    OR (a.name IN ('Gabumon', 'Pikachu') AND o.full_name = 'Jennifer Orwell')
    OR (a.name IN ('Devimon', 'Plantmon') AND o.full_name = 'Bob')
    OR (a.name IN ('Charmander', 'Squirtle', 'Blossom') AND o.full_name = 'Melody Pond')
    OR (a.name IN ('Angemon', 'Boarmon') AND o.full_name = 'Dean Winchester')
  );