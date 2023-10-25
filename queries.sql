/*Queries that provide answers to the questions from all projects.*/

SELECT * from animals WHERE name = 'Luna';
SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered = TRUE AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = TRUE;
SELECT * FROM animals WHERE name <> 'Gabumon';
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;
 /*----------------------------------*/

BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals; 
ROLLBACK;

SELECT * FROM animals; --After ROLLBACK

BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
SELECT * FROM animals WHERE species = 'digimon' OR species = 'pokemon'; 
COMMIT;
SELECT * FROM animals WHERE species = 'digimon' OR species = 'pokemon';

BEGIN;
DELETE FROM animals;
SELECT * FROM animals; -- Verify that all records were deleted
ROLLBACK;
SELECT * FROM animals;--After ROLLBACK


BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT animals_born_after_Jan1st22;
SELECT * FROM animals;
UPDATE animals SET weight_kg = weight_kg * -1;
SELECT * FROM animals;
ROLLBACK TO animals_born_after_Jan1st22;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;
SELECT * FROM animals;
/*--Animals count*/
SELECT COUNT(*) FROM animals;

/*--How many animals have never tried to escape*/
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;?

/*-- the average weight of animals*/
SELECT AVG(weight_kg) FROM animals;

/*--Who escapes the most, neutered or not neutered animals?*/
SELECT neutered, MAX(escape_attempts) AS escape_attempts FROM animals
GROUP BY neutered ORDER BY escape_attempts DESC 
LIMIT 1;

/*--The minimum and maximum weight of each type of animal*/
SELECT species, MIN(weight_kg) AS min_weight, MAX(weight_kg) AS max_weight
FROM animals GROUP BY species; 

/*--The average number of escape attempts per animal type of those born between 1990 and 2000*/
SELECT species, AVG(escape_attempts) AS avg_attempts
FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY species;

/*------------------------------------------------------------*/
/*What animals belong to Melody Pond?*/
SELECT a.name FROM animals a JOIN owners o ON a.owner_id = o.id
WHERE o.full_name = 'Melody Pond';

/*List of all animals that are pokemon (their type is Pokemon).*/
SELECT a.name FROM animals a JOIN species s ON a.species_id = s.id
WHERE s.name = 'Pokemon';

/*List all owners and their animals, remember to include those that don't own any animal.*/
SELECT o.full_name AS animals_owner, COALESCE(array_agg(a.name)) AS animals
FROM owners o LEFT JOIN animals a ON o.id = a.owner_id GROUP BY o.id, o.full_name;

/*How many animals are there per species?*/
SELECT s.name, COUNT(a.id)FROM species s JOIN animals a ON s.id = a.species_id
GROUP BY s.id, s.name;

/*List all Digimon owned by Jennifer Orwell.*/
SELECT a.name FROM animals a JOIN owners o ON a.owner_id = o.id
JOIN species s ON a.species_id = s.id
WHERE o.full_name = 'Jennifer Orwell' AND s.name = 'Digimon';

/*List all animals owned by Dean Winchester that haven't tried to escape.*/
SELECT a.name FROM animals a
JOIN owners o ON a.owner_id = o.id
WHERE o.full_name = 'Dean Winchester' AND a.escape_attempts = 0;

/*Who owns the most animals?*/
SELECT o.full_name, COUNT(a.id)FROM owners o
JOIN animals a ON o.id = a.owner_id
GROUP BY o.id, o.full_name ORDER BY COUNT(a.id) DESC
LIMIT 1;