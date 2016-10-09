/*
Arrays for units are defined the following way:
Soldiers
Cars
IFVs/APCs
Tanks
*/
#define UNITS_WEST \
[ \
	["B_soldier_F", "B_soldier_AR_F","B_soldier_AAR_F","B_Soldier_LAT_F"], \
	["B_MRAP_01_F"], \
	["B_APC_wheeled_01_cannon_F"], \
	["B_MBT_01_TUSK_F"] \
]
#define UNITS_EAST \
[ \
	["O_soldier_F"], \
	["O_MRAP_02_F"], \
	["O_APC_Tracked_02_cannon_F"], \
	["O_MBT_02_cannon_F"] \
]
#define UNITS_RESISTANCE \
[ \
	["I_soldier_F"], \
	["I_MRAP_03_F"], \
	["I_APC_wheeled_03_cannon_F"], \
	["I_MBT_03_cannon_F"] \
]
#define UNITS_CIVILIAN \
[ \
	["C_man_1_1_F"], \
	["C_SUV_01_F"], \
	["C_Heli_light_01_civll_f"] \
]
/*
Marker Whitelist defined the following way:
[Marker type, Unit type]
For possible marker types see Arma 3 3DEN Editor or CfgMarkers (this only supports ellipse/rectangular markers)
*/
#define MARKERS_WHITELIST \
[ \
	["Solid","inf"], \
	["SolidFull","car"], \
	["SolidBorder","apc"], \
	["Horizontal","tank"] \
]