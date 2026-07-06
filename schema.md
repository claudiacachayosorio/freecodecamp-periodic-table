# FIXES TO DATABASE PERIODIC_TABLE


## Initial tables

### elements
- atomic_number INT PRIMARY KEY
- name VARCHAR(40)
- symbol VARCHAR(2)

### properties
- atomic_number INT PRIMARY KEY
- boiling_point NUMERIC
- melting_point NUMERIC
- type VARCHAR(30)
- weight NUMERIC(9,6) NOT NULL


## Updated tables

### elements
- atomic_number INT PRIMARY KEY
- name VARCHAR(40) UNIQUE NOT NULL
- symbol VARCHAR(2) UNIQUE NOT NULL

### types
- type_id INT PRIMARY KEY
- type VARCHAR(30) NOT NULL

### properties
- atomic_number INT PRIMARY KEY REFERENCES elements (atomic_number)
- atomic_mass DECIMAL NOT NULL
- boiling_point_celsius NUMERIC
- melting_point_celsius NUMERIC
- type_id INT NOT NULL REFERENCES types (type_id)
