/* Database schema to keep the structure of entire database. */

CREATE TABLE animals(
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(255) NOT NULL,
    date_of_birth DATE NOT NULL,
    escape_attempts INT NOT NULL,
    neutered BOOLEAN NOT NULL,
    weight_kg DECIMAL(10,2),
    PRIMARY KEY(id)
);

/* ALTER animal table */

ALTER TABLE animals ADD COLUMN species VARCHAR(255);

-- Create table owners 
CREATE TABLE owners(
    id INT GENERATED ALWAYS AS IDENTITY,
    full_name VARCHAR(255),
    age INT,
    PRIMARY KEY(id));

--  Create table species
CREATE TABLE species(
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(255),
    PRIMARY KEY(id));

--  Remove column species
ALTER TABLE animals DROP COLUMN species;

-- Add species_id
 ALTER TABLE animals ADD COLUMN species_id INT, ADD CONSTRAINT fk_species FOREIGN KEY(species_id) REFERENCES species(id);

--  Add owner_id
 ALTER TABLE animals ADD COLUMN owner_id INT, ADD CONSTRAINT fk_owner FOREIGN KEY(owner_id) REFERENCES owners(id);