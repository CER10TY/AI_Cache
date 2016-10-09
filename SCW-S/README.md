# Spawn, Cache, Waypointing: Spawn Module

## Reponsible for maintaining this module:
* CER10TY

## Module description

The SCW-S spawn module is responsible for spawning AI as defined by the player. Usually, the module is executed on mission start up through init.sqf, but can be called any time during the mission. 
This module can spawn Infantry, Car, IFV and Tank groups. As a precaution it is recommended to set group size to 1 when spawning Cars, IFVs or Tanks.
For spawning, the module makes use of four marker brushes: Solid, Solid non-transparent, Solid Border and Horizontal. Each of these markers, and what type they spawn, can be customised in the macros.hpp found in the SCW-S folder.

### How To

As mentioned previously the module uses four marker brushes to determine what type of unit to spawn. These are the following:

* Solid (spawns type Infantry)
* Solid non-transparent (spawns type Car)
* Solid Border (spawns type IFV/APC)
* Horizontal (spawns type Tank)

The way the module determines how many units and on what side to spawn works the following way:

number of groups:number of units in group:side of units

So 5 groups of Infantry with 5 units each on side WEST would have the following setup:

* Solid marker (size, color and variable name irrelevant)
* 5:5:W as text, to note 5 groups, 5 units in each group, and side WEST

Here is 2 groups of Cars with 1 Car in each group, on side RESISTANCE (INDEPENDENT):

* Solid non-transparent (SolidFull) marker (size, color and variable name irrelevant)
* 2:1:R as text, to note 2 groups, 1 car in each group, on side RESISTANCE.

For safety reasons it is recommended to not use more than 1 Car/IFV/Tank in 1 group (as they may end up getting stuck in each other).

Example screenshot: http://images.akamai.steamusercontent.com/ugc/253716559972355797/7517FA9B19EAB9691D7EDA4A166138774F4866B3/