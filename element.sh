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

SHOW_ELEMENT() {
  if [[ $1 =~ ^[0-9]+$ ]]
  then
        QUERY_ELEMENT=$($PSQL "SELECT p.atomic_number, el.name, el.symbol, p.type, p.atomic_mass, p.melting_point_celsius, p.boiling_point_celsius FROM properties AS p FULL JOIN elements AS el ON p.atomic_number = el.atomic_number WHERE p.atomic_number = $1")
  else
        QUERY_ELEMENT=$($PSQL "SELECT p.atomic_number, el.name, el.symbol, p.type, p.atomic_mass, p.melting_point_celsius, p.boiling_point_celsius FROM properties AS p FULL JOIN elements AS el ON p.atomic_number = el.atomic_number WHERE el.symbol='$1' OR el.name='$1'")
  fi
        # Vars
        IFS='|' read -r ATOMIC_NUMBER NAME SYMBOL TYPE ATOMIC_MASS MELTING_POINT_CELSIUS BOILING_POINT_CELSIUS <<< "$QUERY_ELEMENT"

        # Delete spaces
        ATOMIC_NUMBER=$(echo "$ATOMIC_NUMBER" | tr -d '[:space:]')
        NAME=$(echo "$NAME" | tr -d '[:space:]')
        SYMBOL=$(echo "$SYMBOL" | tr -d '[:space:]')
        TYPE=$(echo "$TYPE" | tr -d '[:space:]')
        ATOMIC_MASS=$(echo "$ATOMIC_MASS" | tr -d '[:space:]')
        MELTING_POINT_CELSIUS=$(echo "$MELTING_POINT_CELSIUS" | tr -d '[:space:]')
        BOILING_POINT_CELSIUS=$(echo "$BOILING_POINT_CELSIUS" | tr -d '[:space:]')

        # Echo Element info
        echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT_CELSIUS celsius and a boiling point of $BOILING_POINT_CELSIUS celsius."
}


MAIN_PROGRAM $1