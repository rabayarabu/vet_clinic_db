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

/* Create table */
 CREATE TABLE vets( 
    id INT GENERATED ALWAYS AS IDENTITY, 
    name VARCHAR(255), 
    age INT, 
    date_of_graduation DATE, 
    PRIMARY KEY(id)
    );
/* create join table */
CREATE TABLE specializations ( 
    species_id INT, vet_id INT, 
    CONSTRAINT fk_species 
    FOREIGN KEY(species_id) 
    REFERENCES species(id), 
    CONSTRAINT fk_vets 
    FOREIGN KEY(vet_id) 
    REFERENCES vets(id)
    );
/* create join table */
CREATE TABLE visits( 
    animals_id INT, 
    vets_id INT, 
    date_of_visit DATE, 
    CONSTRAINT fk_animals 
    FOREIGN KEY(animals_id) 
    REFERENCES animals(id), 
    CONSTRAINT fk_vets 
    FOREIGN KEY(vets_id) 
    REFERENCES vets(id), 
    PRIMARY KEY(animals_id, vets_id, date_of_visit)
    );

    /* PERFORMANCE AUDIT schema */

ALTER TABLE visits DROP CONSTRAINT visits_pkey;
ALTER TABLE owners ADD COLUMN email VARCHAR(120);
CREATE INDEX visits_animal_id_asc ON visits(animal_id ASC);
CREATE INDEX visits_vet_id_asc ON visits(vet_id ASC);
CREATE INDEX visits_date_of_visit_asc ON visits(date_of_visit ASC);
CREATE INDEX owners_email_asc ON owners(email ASC);