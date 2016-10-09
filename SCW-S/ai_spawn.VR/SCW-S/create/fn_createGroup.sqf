/*
	Author: tryteyker
	Description: Since latest revision this is pretty much just an extension to BIS_fnc_spawnGroup kept in for ease of access. OPT denotes optional parameters.

	PARAMETERS:
		0: ARRAY - Position to create the group at.
		1: SIDE - Side of group to spawn. Can be WEST, EAST, RESISTANCE, CIVILIAN.
		2: ARRAY, NUMBER, CONFIG - Either: List of character types to spawn OR amount of characters to spawn OR CfgGroups entry.
		3: ARRAY (OPT) - List of relative positions (nested array needed for multiple positions).
		4: ARRAY (OPT) - List of ranks (eg: ["PRIVATE","SERGEANT"]). Will iterate through array (so first unit gets private, second sergeant etc).
		5: ARRAY (OPT) - Range of skill (eg: If array given is [0,0.5] it will take minSkill 0, calculate Difference = (maxSkill - minSkill), and then randomly add(+) a number (random Difference) to minSkill 0).
		6: ARRAY (OPT) - Ammo Range. Same calculation as above.
		7: ARRAY (OPT) - Randomisation controls. First value (select 0) is the amount of mandatory units the group should have. Second value (select 1) is the spawn chance for remaining units (if select 0 < [amount of units])
		8: NUMBER (OPT) - Azimuth of spawned units (where they face).
		9: BOOL (OPT) - Force precision placement true/false. If this is true, vehicles will have their position set with setPos once again after script finishes. Irrelevant for soldiers. Has no effect when spawning vehicle on top of a unit as engine will force spawn it besides the unit.

	RETURNS:
		0: GROUP - Group created with this function.
*/

#include "..\macros.hpp"

params ["_groupPos", "_groupSide",["_type",[], [[], 0, configNull]],["_relPos",  [],[[]]], ["_ranks",[],[[]]], ["_skills",[],[[]]],["_ammoCount",[],[[]]],["_randomization",[],[[]]],["_azimuth",0,[0]],["_forcePrecise",true,[true]],["_maxVehicles",10e10,[0]]];

_grp = [_groupPos, _groupSide, _type, _relPos,_ranks,_skills,_ammoCount,_randomization,_azimuth,_forcePrecise,_maxVehicles] call BIS_fnc_spawnGroup;

_grp