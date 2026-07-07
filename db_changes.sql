/* ================================================================================================ */
/* CHANGES TO DATABASE PERIODIC_TABLE																*/
/* ================================================================================================ */
/* For reference only.																				*/
/* Do not run this file as it will delete data and change the structure of the tables.				*/
/* ================================================================================================ */




/* ================================================================================================ */
/* DELETE DATA																						*/
/* ================================================================================================ */

-- delete the non existent element, whose atomic_number is 1000, from the two tables

DELETE FROM elements WHERE atomic_number = 1000;
DELETE FROM properties WHERE atomic_number = 1000;




/* ================================================================================================ */
/* CHANGE TABLE: ELEMENTS																			*/
/* ================================================================================================ */

-- add the UNIQUE constraint to the symbol and name columns from the elements table

ALTER TABLE elements ADD UNIQUE(symbol);
ALTER TABLE elements ADD UNIQUE(name);

-- symbol and name columns should have the NOT NULL constraint

ALTER TABLE elements ALTER COLUMN symbol SET NOT NULL;
ALTER TABLE elements ALTER COLUMN name SET NOT NULL;

-- capitalize the first letter of all the symbol values in the elements table
-- only capitalize the letter and not change any others

UPDATE elements SET symbol = INITCAP(symbol);




/* ================================================================================================ */
/* NEW TABLE: TYPES																					*/
/* ================================================================================================ */

-- create a types table that will store the three types of elements
-- types table should have a type_id column that is an integer and the primary key
-- types table should have a type column that's a VARCHAR and cannot be null
-- it will store the different types from the type column in the properties table

CREATE TABLE types(
	type_id INT PRIMARY KEY,
	type VARCHAR(30) NOT NULL
);

-- add three rows to types table
-- values are the three different types from the properties table

INSERT INTO types (type_id, type)
VALUES (1, 'nonmetal'), (2, 'metal'), (3, 'metalloid');




/* ================================================================================================ */
/* CHANGE TABLE: PROPERTIES																			*/
/* ================================================================================================ */

-- set the atomic_number column from the properties table as a foreign key
-- references the column of the same name in the elements table

ALTER TABLE properties
ADD FOREIGN KEY (atomic_number) REFERENCES elements (atomic_number);

-- properties table should have a type_id foreign key column
-- references the type_id column from the types table

ALTER TABLE properties
ADD COLUMN type_id INT REFERENCES types (type_id);

-- each row in properties table should have a type_id value
-- references the correct type from the types table

UPDATE properties SET type_id = 1 WHERE type = 'nonmetal';
UPDATE properties SET type_id = 2 WHERE type = 'metal';
UPDATE properties SET type_id = 3 WHERE type = 'metalloid';

-- it should be an INT with the NOT NULL constraint

ALTER TABLE properties ALTER COLUMN type_id SET NOT NULL;

-- properties table should not have a type column

ALTER TABLE properties DROP COLUMN type;

-- rename the weight column to atomic_mass

ALTER TABLE properties
RENAME COLUMN weight TO atomic_mass;

-- remove all the trailing zeros after the decimals from each row of the atomic_mass column
-- may need to adjust a data type to DECIMAL for this
-- final values they should be as they are in the atomic_mass.txt file

ALTER TABLE properties
ALTER COLUMN atomic_mass TYPE DECIMAL;

UPDATE properties SET atomic_mass = 1.008 WHERE atomic_number = 1;
UPDATE properties SET atomic_mass = 4.0026 WHERE atomic_number = 2;
UPDATE properties SET atomic_mass = 6.94 WHERE atomic_number = 3;
UPDATE properties SET atomic_mass = 9.0122 WHERE atomic_number = 4;
UPDATE properties SET atomic_mass = 10.81 WHERE atomic_number = 5;
UPDATE properties SET atomic_mass = 12.011 WHERE atomic_number = 6;
UPDATE properties SET atomic_mass = 14.007 WHERE atomic_number = 7;
UPDATE properties SET atomic_mass = 15.999 WHERE atomic_number = 8;

-- rename the melting_point column to melting_point_celsius
-- rename the boiling_point column to boiling_point_celsius

ALTER TABLE properties RENAME COLUMN melting_point TO melting_point_celsius;
ALTER TABLE properties RENAME COLUMN boiling_point TO boiling_point_celsius;

-- melting_point_celsius and boiling_point_celsius columns should not accept null values

ALTER TABLE properties ALTER COLUMN melting_point_celsius SET NOT NULL;
ALTER TABLE properties ALTER COLUMN boiling_point_celsius SET NOT NULL;




/* ================================================================================================ */
/* INSERT DATA																						*/
/* ================================================================================================ */

-- add the element with atomic number 9 to database
-- name is Fluorine, symbol is F
-- mass is 18.998, melting point is -220, boiling point is -188.1
-- type is nonmetal

INSERT INTO elements (atomic_number, name, symbol)
VALUES (9, 'Fluorine', 'F');

INSERT INTO properties
(atomic_number, atomic_mass, melting_point_celsius, boiling_point_celsius, type_id)
VALUES (9, 18.998, -220, -188.1, 1);

-- add the element with atomic number 10 to database
-- name is Neon, symbol is Ne
-- mass is 20.18, melting point is -248.6, boiling point is -246.1
-- type is nonmetal

INSERT INTO elements (atomic_number, name, symbol)
VALUES (10, 'Neon', 'Ne');

INSERT INTO properties
(atomic_number, atomic_mass, melting_point_celsius, boiling_point_celsius, type_id)
VALUES (10, 20.18, -248.6, -246.1, 1);
