/*
	Author: tryteyker
	Description: This function provides the fluid part of SCW-C. It is run periodically ON SERVER to check the following: If player groups distance > cache distance (specified in init.sqf) cache units, if not uncache.
	The caching can be disabled out-of-script by declaring missionNamespace variable SCW_C_CACHE_GROUPS false.

	PARAMETERS:
	0: NUMBER - Time in seconds between every caching check. Default defined in \scw-c\macros.hpp. Having this lower means bigger strain on server.
	1: ARRAY (OPT) - Array of player groups to check. By default this is defined in missionNamespace variable SCW_C_PLAYER_GROUPS.
	2: ARRAY (OPT) - Array of blacklisted groups that should be excluded from dynamic caching. By default this is defined in missionNamespace variable SCW_C_AI_BLACKLIST.
	3: NUMBER (OPT) - Caching distance of groups. By default this is defined in \scw-c\macros.hpp

	RETURNS:
	0: NOTHING - Script is spawned so no return value.
*/

#include "..\macros.hpp"

if !(isServer) exitWith {}; // Exit if not run on server.

params [["_interval",0,[0]],["_playerGroups", [], [[]]], ["_aiBlacklist", [], [[]]], ["_cachingDistance",0,[0]]];

_interval = if (_interval == 0) then {SCW_C_CACHING_INTERVAL} else {_interval}; // If interval is undefined we use config otherwise custom interval.

_playerGroups = if (_playerGroups isEqualTo []) then {call SCW_C_fnc_getPlayerGroups} else {_playerGroups}; // If _playerGroups is empty (means nothing was passed on) we get all player groups in game, otherwise we act like nothing happened.
_aiBlacklist = if (_aiBlacklist isEqualTo []) then {call SCW_C_fnc_getAIBlacklist} else {_aiBlacklist}; // Same here: If nothing, we get missionNamespace AI_BLACKLIST to supply something, otherwise we act like nothing happened.

_cachingDistance = if (_cachingDistance == 0) then {SCW_C_CACHE_DISTANCE} else {_cachingDistance}; // Grab caching distance

_groupsInRange = []; // Empty array to store groups in range.
if (missionNamespace getVariable ["SCW_C_AI_GROUPS",0] isEqualTo 0) then {
	private _aiGrps = call SCW_C_fnc_getAIGroups;
	[_aiGrps, "cache"] call SCW_C_fnc_cacheGroups;
};
while {missionNamespace getVariable ["SCW_C_CACHE_GROUPS",true]} do { // While missionNamespace var is true we do this.
	_cachedGrps = missionNamespace getVariable ["SCW_C_CACHED_GROUPS",[]]; // Get all currently cached groups.
	{
		_unitsInGrp = (units _x); // Grab units from current group.
		for "_i" from 0 to (count _cachedGrps - 1) do { // We check against all currently cached groups.
			_aiGrp = _cachedGrps select _i; // Select ai group to check against
			{
				if ((_x distance (leader _aiGrp)) <= _cachingDistance) then { // We check every player unit to see if they're close to the leader of the unit.
					_groupsInRange pushBackUnique _aiGrp; // If yes, we pushback the group into _groupsInRange ONCE (hence Unique)
					if (count _groupsInRange > 0) then {
						[_groupsInRange,"uncache"] call SCW_C_fnc_cacheGroups; // We uncache groups in range.
					};
				} else {
					if ((_x distance (leader _aiGrp)) > _cachingDistance) then { // Flip side; if player unit is outside range we cache.
						if (_aiGrp in _groupsInRange) then {
							_groupsInRange = _groupsInRange - _aiGrp; // If _aiGrp was already in range once we ditch them from _groupsInRange.
						};
						[[_aiGrp],"cache"] call SCW_C_fnc_cacheGroups; // And cache the _aiGrp.
					};
				};
				false // Since count returns a number, we need to return bool to avoid error. Thanks Kingsley.
			} count _unitsInGrp; // For all the units of the current group.
		};
		false
	} count _playerGroups; // And for all the player groups.
	//hint str _groupsInRange;
	sleep _interval;
};

// Once SCW_C_CACHE_GROUPS is set to false, while loop exits. At this stage we make sure to un-cache all units.
if !(missionNamespace getVariable ["SCW_C_CACHE_GROUPS",true]) then {
	private _aiGrps = call SCW_C_fnc_getAIGroups; 
	[_aiGrps, "uncache"] call SCW_C_fnc_cacheGroups;
};
