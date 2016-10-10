/*
	Author: tryteyker
	Description: The flipside to fn_getPlayerGroups.sqf, this function retrieves all currently active AI groups in mission and subtracts blacklisted AI groups from the list.

	PARAMETERS: 
	0: NOTHING - No parameters needed.

	RETURNS:
	0: ARRAY - Array of all AI groups.
*/

#include "..\macros.hpp"

_AIBlacklist = call SCW_C_fnc_getAIBlacklist; // We fetch the AI Group blacklist - important for later!
_allAIGroups = [];

_playerGroups = call SCW_C_fnc_getPlayerGroups; // We grab all player groups.

_allAIGroups = allGroups - _playerGroups - _AIBlacklist;
missionNamespace setVariable ["SCW_C_AI_GROUPS",_allAIGroups];

_allAIGroups