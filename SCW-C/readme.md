# Spawn, Cache, Waypointing: Caching Module

## Module description

The SCW-C module is responsible for caching groups during mission. Usually this module is run at mission start but may be run at any point in time.
This module is highly customisable with both a macros.hpp and other missionNamespace variables to allow the mission maker to customise it to the full extent. All functions can be used individually if need be.

### How To

fn_cacheAllGroups is the main function responsible for caching all units throughout the mission. As all the other functions, it is run on server only. 
Caching interval, player groups and AI Group Blacklists are all customisable but don't have to be touched if you don't want to.

There are a few missionNamespace variables that can be defined in init.sqf to be used by functions:
* "SCW_C_AI_BLACKLIST" - Array of blacklisted AI groups - these groups will be excluded from dynamic caching.
* "SCW_C_CACHE_GROUPS" - Boolean variable that decides whether dynamic caching is on or off. It can be set during mission and if set to false will immediately disable caching (and re-spawn all cached units).

Additionally other missionNamespace variables store caching info:
* "SCW_C_PLAYER_GROUPS" - Array of all player groups. Modifying this array is possible to exclude certain player groups from affecting dynamic caching.
* "SCW_C_AI_GROUPS" - Array of all AI Groups minus those defined in SCW_C_AI_BLACKLIST. Modifying this is not recommended, modify the blacklist instead.
* "SCW_C_CACHED_GROUPS" - Array storing all currently cached AI groups. 

In \scw-c\macros.hpp you will find three useful constants:
* "SCW_C_CACHE_DISTANCE" - The distance at which to cache units. If any player group is closer than this distance, the closest AI group gets uncached.
* "SCW_C_CACHING_INTERVAL" - The interval at which to check caching. Setting this to a higher value will put less strain on server but you will get worse results.
* "SCW_C_CACHE_GROUP_LEADER" - By default set to false, this constant decides whether or not to cache group leader along with all other units. Be aware that if you cache group leader you will not be able to assign waypoints to the cached group. 
