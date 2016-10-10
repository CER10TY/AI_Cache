# Spawn, Cache, Waypointing: Caching Module

## Module description

The SCW-C module is responsible for caching groups during mission. Usually this module is run at mission start but may be run at any point in time.
This module is highly customisable with both a macros.hpp and other missionNamespace variables to allow the mission maker to customise it to the full extent. All functions can be used individually if need be.

### How To

fn_cacheAllGroups is the main function responsible for caching all units throughout the mission. As all the other functions, it is run on server only. 
Caching interval, player groups and AI Group Blacklists are all customisable but don't have to be touched if you don't want to.

There are a few missionNamespace variables that can be defined in init.sqf to be used by functions:
* "SCW_C_PLAYER_GROUPS" - Array of player groups that should affect the caching.
* "SCW_C_AI_BLACKLIST" - Array of blacklisted AI groups - these groups will be excluded from dynamic caching.
* "SCW_C_CACHE_GROUPS" - Boolean variable that decides whether dynamic caching is on or off. It can be set during mission and if set to false will immediately disable caching (and re-spawn all cached units).