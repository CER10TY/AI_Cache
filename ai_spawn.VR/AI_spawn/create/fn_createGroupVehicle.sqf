/*
	Author: tryteyker
	Description: This function creates a group of vehicles based on params passed on. By default uses macros defined in \ai_spawn\macros.hpp.

	PARAMETERS:
		0: NUMBER - Actual group size (eg: 6 would create 6 vehicles with crew)
		1: SIDE - Side of group to spawn. Can be WEST, EAST, RESISTANCE, CIVILIAN.
		1: ARRAY - Position to create the group at.
		2: ARRAY - (Optional) The unit type(s) to spawn. Please note that using more than 1 will lead to randomisation.
	RETURNS:
		0: GROUP - Group created with this function.
*/

#include "..\macros.hpp"

params ["_groupSize", "_side", ["_groupPos", [0,0,0], [[]], 3], ["_unitTypes", [], [[]]]];

if (_unitTypes isEqualTo []) then {
	_unitTypes = ([_side] call SCW_S_fnc_grabUnitPool) select 1;
};
private _unitType = selectRandom _unitTypes; // This selects the unit class to use for this group. Only relevant when using more than 1 unit class in _unitTypes. Pending cleaner and more accessible solution.
private _group = createGroup _side; // Create empty group on side (since Arma 3 createCenter is done automatically by engine on start)

for "_i" from 1 to _groupSize do {
	private _veh = createVehicle [_unitType, _groupPos, [], 0, "NONE"]; // Creates unit at _groupPos, assigns it to _group.
	createVehicleCrew _veh;
	_group = (group driver _veh);
};

_group // Return _group.