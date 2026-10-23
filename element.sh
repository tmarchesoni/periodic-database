#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ -z "$1" ]]
then
  echo "Please provide an element as an argument."
else
  if [[ "$1" =~ ^[0-9]+$ ]]
  then
    ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number=$1")
  else
    ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE name='$1' OR symbol='$1'")
  fi

  if [[ -z "$ATOMIC_NUMBER" ]]
  then
    echo "I could not find that element in the database."
  else
    SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number=$ATOMIC_NUMBER" | xargs)
    NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number=$ATOMIC_NUMBER" | xargs)
    TYPE=$($PSQL "SELECT type FROM types t JOIN properties p USING(type_id) WHERE p.atomic_number=$ATOMIC_NUMBER" | xargs)
    ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$ATOMIC_NUMBER" | xargs)
    MELTING_POINT_CELSIUS=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER" | xargs)
    BOILING_POINT_CELSIUS=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER" | xargs)

    echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT_CELSIUS celsius and a boiling point of $BOILING_POINT_CELSIUS celsius."
  fi
fi