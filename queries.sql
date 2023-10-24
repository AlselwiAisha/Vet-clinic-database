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

SELECT COUNT(*) FROM animals;--Animals count
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;--How many animals have never tried to escape?
SELECT AVG(weight_kg) FROM animals;-- the average weight of animals

SELECT neutered, SUM(escape_attempts) AS total_attempts
FROM animals
GROUP BY neutered
ORDER BY total_attempts DESC
LIMIT 1;--Who escapes the most, neutered or not neutered animals?

SELECT species, MIN(weight_kg) AS min_weight, MAX(weight_kg) AS max_weight
FROM animals
GROUP BY species; --The minimum and maximum weight of each type of animal

SELECT species, AVG(escape_attempts) AS avg_attempts
FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY species;--The average number of escape attempts per animal type of those born between 1990 and 2000