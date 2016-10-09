/*
	Author: tryteyker
	Description: This function is primarily responsible for the 'meat' of SCW-S. It checks marker type and text and spawns corresponding units inside that marker.

	PARAMETERS:
	0: STRING - Marker name.
	1: ARRAY (OPT) - Array of accepted marker types (solid, solid border etc) and the corresponding unit types to spawn in said marker. Default defined in \ai_spawn\macros.hpp

	RETURNS:
	0: BOOL - true or false depending on if script finishes or there was an error.
*/

#include "..\macros.hpp"

params ["_marker",["_markerTypeWhitelist",[], [[]]]];

_markerTypeWhitelist = MARKERS_WHITELIST; // Marker whitelist as defined in \ai_spawn\macros.hpp

_markerText = markerText _marker; // This text includes the group amount and size of each group.
_markerArray = []; // Empty array which will pick up the defined valid array type and corresponding unit.

{
	if ((markerBrush _marker) == ((_markerTypeWhitelist select _forEachIndex) select 0)) exitWith {_markerArray = _markerTypeWhitelist select _forEachIndex}; // This exits immediately if markerbrush is equql to the first existing thing it encouters.
} foreach _markerTypeWhitelist; // We iterate through the entire whitelist to find the matching brush.

if (_markerArray isEqualTo []) exitWith {false}; // If _markerArray is stll empty after the loop we exit.
if (_markerText isEqualTo "" || count(toArray _markerText) < 5 || count(toArray _markerText) > 7) exitWith {false}; // A long and dragged out exit statement to eliminate empty descriptions, those short than 5 (4:3:W is 5, so min length) or longer than 7 (10:10:W is 7 so max length).

_markerText = _markerText splitString ":"; // As standard string is defined along the lines of "number:number:side", we strip the : to get both numbers.
_groupAmount = parseNumber(_markerText select 0); // Here we take the first string (group amount) and parse it into a number.
_groupSize = parseNumber(_markerText select 1); // Second string (group size) is parsed into number.
_groupType = _markerArray select 1; // This is the type defined in macros.hpp, like "inf", "car", "apc", "tank".
_groupSide = switch (_markerText select 2) do { // Last note in marker text is :W, :E, :R or :C. We pick up the side here.
			  case "W":
			  { 
			 	 WEST
			  };
			  case "E":
			  {
			  	EAST
			  };
			  case "R":
			  {
			  	RESISTANCE
			  };
			  case "C":
			  {
			  	CIVILIAN
			  };
			 };

switch _groupType do {
	case "inf":
	{
		[_groupSide, 0, _groupAmount, _groupSize, _marker] call SCW_S_fnc_determineGroup;
	};	
	case "car":
	{
		[_groupSide, 1, _groupAmount, _groupSize, _marker] call SCW_S_fnc_determineGroup;
	};
	case "apc":
	{
		[_groupSide, 2, _groupAmount, _groupSize, _marker] call SCW_S_fnc_determineGroup;
	};
	case "tank":
	{
		[_groupSide, 3, _groupAmount, _groupSize, _marker] call SCW_S_fnc_determineGroup;
	};
};

true