#!/bin/bash

##############################
# INTERACTIVE PERIODIC TABLE #
##############################

# to run the script:
# ./element.sh <atomic_number|symbol|name>




# INITIAL VARIABLES

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

IN=$1




# FUNCTIONS

GET_ATOMIC_NUMBER() {
	# if input is atomic_number
	if [[ $IN =~ ^[0-9]+$ ]]
	then
		SELECT_NUMBER_CONDITION="atomic_number = $IN"

	# if input is symbol
	elif [[ $IN =~ ^[A-Z][a-z]?$ ]]
	then
		SELECT_NUMBER_CONDITION="symbol = '$IN'"

	# if input is name
	else
		SELECT_NUMBER_CONDITION="LOWER(name) = LOWER('$IN')"
	fi

	# get atomic_number
	ATOMIC_NUMBER=$(
		$PSQL "SELECT atomic_number FROM elements WHERE $SELECT_NUMBER_CONDITION;"
	)
}

GET_ELEMENT_DATA() {
	# get element_name
	ELEMENT_NAME=$(
		$PSQL "SELECT name FROM elements WHERE atomic_number = $ATOMIC_NUMBER;"
	)

	# get element_symbol
	ELEMENT_SYMBOL=$(
		$PSQL "SELECT symbol FROM elements WHERE atomic_number = $ATOMIC_NUMBER;"
	)

	# get atomic_mass
	ATOMIC_MASS=$(
		$PSQL "SELECT atomic_mass FROM properties WHERE atomic_number = $ATOMIC_NUMBER;"
	)

	# get melting_point
	MELTING_POINT=$(
		$PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number = $ATOMIC_NUMBER;"
	)

	# get boiling_point
	BOILING_POINT=$(
		$PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number = $ATOMIC_NUMBER;"
	)

	# get element_type
	ELEMENT_TYPE=$(
		$PSQL "SELECT type FROM types INNER JOIN properties USING (type_id) WHERE atomic_number = $ATOMIC_NUMBER;"
	)
}

ABOUT_ELEMENT() {
	# if no input
	if [[ -z $IN ]]
	then
		echo "Please provide an element as an argument."

	else
		GET_ATOMIC_NUMBER

		# if atomic_number not found
		if [[ -z $ATOMIC_NUMBER ]]
		then
			echo "I could not find that element in the database."

		else
			GET_ELEMENT_DATA
			echo "The element with atomic number $ATOMIC_NUMBER is $ELEMENT_NAME ($ELEMENT_SYMBOL). It's a $ELEMENT_TYPE, with a mass of $ATOMIC_MASS amu. $ELEMENT_NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
		fi
	fi
}




# POINT OF ENTRY

ABOUT_ELEMENT
