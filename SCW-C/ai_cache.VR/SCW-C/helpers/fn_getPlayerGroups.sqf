/*
	Author: tryteyker
	Description: This fetches all player groups in mission and assigns them to missionNamespace var SCW_C_PLAYER_GROUPS in addition to returning them.

	PARAMETERS: 
	0: NOTHING - No parameters needed.

	RETURNS:
	0: ARRAY - Array of all player groups.
*/

#include "..\macros.hpp"

_allGroupsWithPlayers = missionNamespace getVariable ["SCW_C_PLAYER_GROUPS", []];

if !(_allGroupsWithPlayers isEqualTo []) exitWith {_allGroupsWithPlayers}; // If the missionNamespace var is already defined we can be sure player did this in init.sqf so we return that instead.

{_allGroupsWithPlayers pushBackUnique group _x} forEach allPlayers; // Otherwise we get all player groups.

missionNamespace setVariable ["SCW_C_PLAYER_GROUPS",_allGroupsWithPlayers]; // And assign that to missionNamespace var

_allGroupsWithPlayers // And finally return it to sender.