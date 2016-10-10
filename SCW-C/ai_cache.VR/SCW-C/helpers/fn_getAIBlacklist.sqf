/*
	Author: tryteyker
	Description: This fetches AI blacklist from missionNamespace SCW_C_AI_BLACKLIST (if defined) otherwise defines empty blacklist.

	PARAMETERS:
	0: NOTHING - No parameters needed

	RETURNS:
	0: ARRAY - Array of blacklisted AI groups.
*/

#include "..\macros.hpp"

_aiBlacklist = missionNamespace getVariable ["SCW_C_AI_BLACKLIST", []];

if !(_aiBlacklist isEqualTo []) exitWith {_aiBlacklist}; // If the missionNamespace var is pre-defined (like in init.sqf) we return that to sender.

_aiBlacklist = [];

missionNamespace setVariable ["SCW_C_AI_BLACKLIST",_aiBlacklist]; // Otherwise we define our own blacklist (which is always empty)

_aiBlacklist // And return it to sender