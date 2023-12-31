/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered=true AND escape_attempts<3;
SELECT date_of_birth FROM animals WHERE name='Agumon' OR name='Pikachu';
SELECT name, escape_attempts FROM animals WHERE weight_kg>10.5;
SELECT * FROM animals WHERE neutered=true;
SELECT * FROM animals WHERE name <> 'Gabumon';
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;


-- changing species to unspecified
 BEGIN;
 UPDATE animals SET species='unspecified';
 ROLLBACK;

--  Updating the animal species
 BEGIN;
 UPDATE animals SET species='digimon' WHERE name LIKE '%mon';
 UPDATE animals SET species='pokemon' WHERE species IS NULL;
 SELECT * FROM animals;
COMMIT;
 SELECT * FROM animals;

-- Delete Records
BEGIN;
DELETE FROM animals;
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;
BEGIN
DELETE FROM animals WHERE date_of_birth>'2022-01-01';
SAVEPOINT SP1;
UPDATE animals SET weight_kg=weight_kg*-1;
ROLLBACK;
UPDATE animals SET weight_kg=weight_kg*-1 WHERE weight_kg<0;
COMMIT;

-- Analitical questions answers
SELECT COUNT(*) AS total_animals FROM animals;
SELECT COUNT(*) AS never_escape FROM animals WHERE escape_attempts=0;
SELECT avg(weight_kg) FROM animals;
SELECT neutered, SUM(escape_attempts) AS count_escape FROM animals GROUP BY neutered ORDER BY count_escape DESC;
SELECT species, MIN(weight_kg) AS min_weight, MAX(weight_kg) AS max_weight FROM animals GROUP BY species;

/* Queries in multiple tables */

SELECT a.name 
FROM animals a
JOIN owners o ON a.owner_id = o.id
WHERE o.full_name = 'Melody Pond';

SELECT a.name 
FROM animals a
JOIN species s ON a.species_id = s.id
WHERE s.name = 'Pokemon';

SELECT o.full_name, a.name
FROM owners o
LEFT JOIN animals a ON o.id = a.owner_id
GROUP BY o.full_name, a.name;


SELECT s.name, COUNT(a.id) AS animal_count
FROM animals a
JOIN species s ON a.species_id = s.id
GROUP BY s.name;


SELECT a.name 
FROM animals a
JOIN owners o ON a.owner_id = o.id
JOIN species s ON a.species_id = s.id
WHERE o.full_name = 'Jennifer Orwell' AND s.name = 'Digimon';

SELECT a.name 
FROM animals a
JOIN owners o ON a.owner_id = o.id
WHERE o.full_name = 'Dean Winchester' AND a.escape_attempts=0;

SELECT o.full_name, COUNT(a.id) AS animal_count
FROM owners o
JOIN animals a ON o.id = a.owner_id
GROUP BY o.full_name
ORDER BY COUNT(a.id) DESC
LIMIT 1;

-- Join table queries
-- Who was the last animal seen by William Tatcher?
SELECT a.name FROM visits v JOIN animals a ON a.id = v.animals_id
JOIN vets vt ON vt.id = v.vets_id
WHERE vt.name = 'William Tatcher'
ORDER BY v.date_of_visit DESC
LIMIT 1;

--How many different animals did Stephanie Mendez see?
SELECT COUNT(DISTINCT a.id)
FROM visits v
JOIN animals a ON a.id = v.animals_id
JOIN vets vt ON vt.id = v.vets_id
WHERE vt.name = 'Stephanie Mendez';

--List all vets and their specialties, including vets with no specialties.
SELECT vt.name, sp.name AS specialty
FROM vets vt
LEFT JOIN specializations s ON s.vet_id = vt.id
LEFT JOIN species sp ON sp.id = s.species_id
ORDER BY vt.name;

--List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT a.name
FROM visits v
JOIN animals a ON a.id = v.animals_id
JOIN vets vt ON vt.id = v.vets_id
WHERE vt.name = 'Stephanie Mendez'
  AND v.date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';
  
--What animal has the most visits to vets?
SELECT a.name, COUNT(*) AS num_visits
FROM visits v
JOIN animals a ON a.id = v.animals_id
GROUP BY a.name
ORDER BY num_visits DESC
LIMIT 1;

--Who was Maisy Smith's first visit?
SELECT a.name, v.date_of_visit
FROM visits v
JOIN animals a ON a.id = v.animals_id
JOIN vets vt ON vt.id = v.vets_id
WHERE vt.name = 'Maisy Smith'
ORDER BY v.date_of_visit ASC
LIMIT 1;

--Details for most recent visit: animal information, vet information, and date of visit.
SELECT a.name AS animal_name, vt.name AS vet_name, v.date_of_visit
FROM visits v
JOIN animals a ON a.id = v.animals_id
JOIN vets vt ON vt.id = v.vets_id
ORDER BY v.date_of_visit DESC
LIMIT 1;

--How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(*)
FROM visits v
JOIN animals a ON a.id = v.animals_id
JOIN vets vt ON vt.id = v.vets_id
LEFT JOIN specializations s ON s.vet_id = vt.id AND s.species_id = a.species_id
WHERE s.vet_id IS NULL;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT species.name AS specialty
FROM species
JOIN animals ON species.id = animals.species_id
JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Maisy Smith'
GROUP BY species.name
ORDER BY COUNT(animals.id) DESC
LIMIT 1;

/* PERFORMANCE AUDIT */

SELECT COUNT(*) FROM visits where animal_id = 4;
SELECT * FROM visits where vet_id = 2;
SELECT * FROM owners where email = 'owner_18327@mail.com';