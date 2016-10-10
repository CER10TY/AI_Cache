/*
	Author: tryteyker
	Description: This function is responsible for caching all groups on map. This function does not validate caching (ie it does not check that all players are indeed outside the group range to justify caching).

	PARAMETERS:
	0: ARRAY - Array of groups whose units should be cached.
	1: STRING - Can be "cache" or "uncache" depending on what operation should be performed.
	2: BOOL (OPT) - True or false if leader of group should be disabled or not. Defaults to true. If leader is not disabled, waypoints etc can still be followed by the group.

	RETURNS:
	0: BOOL - true or false based on if cache was successful or not.
*/

#include "..\macros.hpp"

params [["_groups", [], [[]]],"_operator",["_disableLeader",true,[true]]];

if (_groups isEqualTo []) exitWith {false}; // If there's no units to cache we exit.
if (_operator isEqualTo "") exitWith {false}; // If no operation specified we exit.
if !(isServer) exitWith {false}; // As all xGlobal commands require Server, we have to exit if it isn't executed on server (as then it will have either no or adverse effects).

SCW_C_CACHED_GROUPS = missionNamespace getVariable ["SCW_C_CACHED_GROUPS", []];

{
	{
		switch _operator do {
			case "cache":
			{
				if (!_disableLeader && (leader group _x == _x)) then { // If _disableLeader is false we should keep leader of group 'alive'. This catches leader and just makes sure his simulation etc stays enabled.
					_x hideObjectGlobal false;
					_x enableSimulationGlobal true;
				} else {
					_x hideObjectGlobal true; // Hide object
					_x enableSimulationGlobal false; // Disable simulation
				};
			};
			case "uncache":
			{
				// Even if _disableLeader is false we don't need to specify a condition to catch that - simply running this command on an already enabled unit does nothing.
				_x hideObjectGlobal false;
				_x enableSimulationGlobal true;
			};
		};
	} count (units _x); // Since _groups is always a Group we can't use commands on it. We need to iterate through all units of the Group.
} forEach _groups;

switch _operator do {
	case "cache":
	{
		SCW_C_CACHED_GROUPS = SCW_C_CACHED_GROUPS + _groups; // Add cached units to global array.
		missionNameSpace setVariable ["SCW_C_CACHED_GROUPS",SCW_C_CACHED_GROUPS];
	};
	case "uncache":
	{
		SCW_C_CACHED_GROUPS = SCW_C_CACHED_GROUPS - _groups; // Remove cached units from global array.
		missionNameSpace setVariable ["SCW_C_CACHED_GROUPS",SCW_C_CACHED_GROUPS];
	};
};
publicVariable "SCW_C_CACHED_GROUPS"; // Thrown in for good measure - should prevent any issues although clients don't really need this info anyway.

true // Don't need to return global cache array as it can just be grabbed by server as necessary.