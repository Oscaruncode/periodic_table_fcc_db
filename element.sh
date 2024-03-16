#! /bin/bash
PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

MAIN_PROGRAM(){
if [[ -z $1 ]]
  then
    echo "Please provide an element as an argument."
  else
    SHOW_ELEMENT $1
  fi
}



MAIN_PROGRAM