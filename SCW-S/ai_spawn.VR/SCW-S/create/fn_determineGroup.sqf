/*
	Author: tryteyker
	Description: This function is there to actually determine group members, cars etc. This allows more effective managemnt of the switch statement over at fn_getMarkerSpec.sqf because I don't have to copy pasted it 4 times.

	PARAMETERS:
	0: SIDE - Side of unit.
	1: NUMBER - Number based on type of unit (0 for Infantry, 1 for Car, 2 for IFV/APC, 3 for Tank)
	2: NUMBER - Group amount (How many groups should spawn)
	3: NUMBER - Group size (how big individual groups are)
	4: STRING - Marker name (what marker to spawn them at)
*/

params ["_groupSide","_type","_groupAmount","_groupSize","_marker"];

private _pool = (_groupSide call SCW_S_fnc_grabUnitPool) select _type; // Grab infantry unit pool from side.
for "_i" from 1 to _groupAmount do { // We create as many groups as specified in _groupAmount.
	_members = []; // Empty array to hold units.
	_members resize _groupSize; // We resize array to fit group size (we need to note every individual soldier as BIS spawnGroup does not allow ['type',amount] kind of arrays)
	for "_i" from 0 to (count _members) - 1 do {
		_members set [_i, selectRandom _pool]; // We randomly select a unit type.
	};
	_pos = [[_marker]] call BIS_fnc_randomPos; // Find random position inside marker area.
	[_pos, _groupSide, _members, [], [], [], [], [], 0, false] call SCW_S_fnc_createGroup; // And finally we create group.
};