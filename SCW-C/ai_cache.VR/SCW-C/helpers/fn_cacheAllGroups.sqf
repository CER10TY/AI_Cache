/*
	Author: tryteyker
	Description: This function provides the fluid part of SCW-C. It is run periodically ON SERVER to check the following: If player groups distance > cache distance (specified in init.sqf) cache units, if not uncache.
	The caching can be disabled out-of-script by declaring missionNamespace variable SCW_C_CACHE_GROUPS false.

	PARAMETERS:
	0: NUMBER - Time in seconds between every caching check. Defaults to 60. Having this lower means bigger strain on server.
	1: ARRAY (OPT) - Array of player groups to check. By default this is defined in missionNamespace variable SCW_C_PLAYER_GROUPS.
	2: ARRAY (OPT) - Array of blacklisted groups that should be excluded from dynamic caching. By default this is defined in missionNamespace variable SCW_C_AI_BLACKLIST.
	3: NUMBER (OPT) - Caching distance of groups. By default this is defined in \scw-c\macros.hpp

	RETURNS:
	0: NOTHING - Script is spawned so no return value.
*/

#include "..\macros.hpp"

params [["_interval",60,[0]],["_playerGroups", [], [[]]], ["_aiBlacklist", [], [[]]]];

_playerGroups = if (_playerGroups isEqualTo []) then {call SCW_C_fnc_getPlayerGroups} else {_playerGroups}; // If _playerGroups is empty (means nothing was passed on) we get all player groups in game, otherwise we act like nothing happened.
_aiBlacklist = if (_aiBlacklist isEqualTo []) then {call SCW_C_fnc_getAIBlacklist} else {_aiBlacklist}; // Same here: If nothing, we get missionNamespace AI_BLACKLIST to supply something, otherwise we act like nothing happened.

_cachingDistance = SCW_C_CACHE_DISTANCE;

while {missionNamespace getVariable ["SCW_C_CACHE_GROUPS",true]} do {
	{
		{
		}
	} count _playerGroups;
};