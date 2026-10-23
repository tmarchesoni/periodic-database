# Periodic Table

A command-line Bash program that looks up chemical elements in a PostgreSQL database. Search by atomic number, element name, or chemical symbol to display the element's classification, atomic mass, melting point, and boiling point.

## Requirements

- Bash
- PostgreSQL and the `psql` command-line client
- A PostgreSQL database named `periodic_table`
- A PostgreSQL role named `freecodecamp` with permission to connect to the database and read its tables

The script connects using the `freecodecamp` role and relies on your PostgreSQL authentication configuration to allow that connection.

## Database setup

The `periodic_table.sql` file is a PostgreSQL dump that creates and populates the database and its tables. On a local PostgreSQL installation, create the required role if it does not already exist, then restore the dump:

```sh
sudo -u postgres createuser --login freecodecamp
sudo -u postgres psql -f periodic_table.sql
```

The dump starts by dropping the `periodic_table` database. Do not restore it into an environment where you need to preserve that database's existing data.

## Usage

From the `periodic_table` directory, make the script executable and run it with an atomic number, element name, or symbol:

```sh
chmod +x element.sh
./element.sh 1
./element.sh hydrogen
./element.sh H
```

The name and symbol lookup is case-insensitive. If no argument is provided or the element is not in the database, the program prints a corresponding message.

Example output:

```text
The element with atomic number 1 is Hydrogen (H). It's a nonmetal, with a mass of 1.008 amu. Hydrogen has a melting point of -259.1 celsius and a boiling point of -252.9 celsius.
```

## Project files

- `element.sh` — queries PostgreSQL and prints details for a matching element.
- `periodic_table.sql` — database dump with the schema and element data.
- `atomic_mass.txt` — atomic number and mass reference data.
