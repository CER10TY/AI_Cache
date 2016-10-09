/*
	Author: tryteyker
	Description: This function returns selected unit pool defined in \ai_spawn\macros.hpp and returns it.

	PARAMETERS:
		0: SIDE - Side to return unit pool from
	RETURNS:
		0: ARRAY - Unit pool defined in \ai_spawn\macros.hpp
*/

#include "..\macros.hpp";
params ["_side"];

_unitPool = [];

switch _side do {
	case WEST:
	{
		_unitPool = UNITS_WEST;
	};
	case EAST:
	{
		_unitPool = UNITS_EAST;
	};
	case RESISTANCE:
	{
		_unitPool = UNITS_RESISTANCE;
	};
	case CIVILIAN:
	{
		_unitPool = UNITS_CIVILIAN;
	};
};

_unitPool