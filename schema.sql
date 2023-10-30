/* Database schema to keep the structure of entire database. */
CREATE DATABASE vet_clinic;
/*----------------Create Animals Table----------------*/
CREATE TABLE animals (
  id INT GENERATED BY DEFAULT AS IDENTITY,
  name VARCHAR(25),
  date_of_birth DATE,
  escape_attempts INTEGER,
  neutered BOOLEAN,
  weight_kg DECIMAL(5, 2)
);

ALTER TABLE animals ADD COLUMN species VARCHAR(25);

/*--------------------Create Owners Table-----------------------*/
CREATE TABLE owners (
  id SERIAL PRIMARY KEY,
  full_name VARCHAR(50),
  age INTEGER
);
/*--------------------Create Species Table-----------------------*/
CREATE TABLE species (
  id SERIAL PRIMARY KEY,
  name VARCHAR(50)
);

/*-------------------Alter Animals Table-------------------------*/
ALTER TABLE animals ADD PRIMARY KEY (Id);
ALTER TABLE animals DROP COLUMN species;
ALTER TABLE animals ADD COLUMN species_id INTEGER REFERENCES species(id);
ALTER TABLE animals ADD COLUMN owner_id INTEGER REFERENCES owners(id);

/*--------------------Create vets bable---------------------------*/
CREATE TABLE vets (
  id SERIAL PRIMARY KEY,
  name TEXT,
  age INTEGER,
  date_of_graduation DATE
);

/*There is a many-to-many relationship between the tables species and vets:
 a vet can specialize in multiple species,
 and a species can have multiple vets specialized in it. 
 Create a "join table" called specializations to handle this relationship.
 */
CREATE TABLE specializations (
  vet_id INT REFERENCES vets(id),
  species_id INT REFERENCES species(id),
  PRIMARY KEY (vet_id, species_id)
);


/* There is a many-to-many relationship between the tables animals and vets: 
an animal can visit multiple vets and one vet can be visited by multiple animals.
 Create a "join table" called visits to handle this relationship, it should also keep track of the date of the visit.
*/
CREATE TABLE visits (
  id SERIAL PRIMARY KEY,
  vet_id INT REFERENCES vets(id),
  animal_id INT REFERENCES animals(id),
  visit_date DATE
);