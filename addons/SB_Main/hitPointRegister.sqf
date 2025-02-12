/*
	hitPointRegister
	
	This function registers a hit point with the ship
	
	Arguments:
	_self: The hitpoint
	_ship: The ship object
	_type: type of hitpoint for special behavior 
	_health: Amount of health a hitpoint has
	
	TODO: 

	Run on server

	Add Event Handler to all players + JIP
	EH Needs to remoteExec inside so it only runs on the server
	
*/
params ["_self", "_ship", "_type", "_health"];
if (!isServer) exitWith {};
_self setVariable ["SB_ship", _ship, true];
_self setVariable ["SB_partHealth", _health, true];
_self setVariable ["SB_partType", _type, true];
[_self, _ship] call BIS_fnc_attachToRelative;

_self addEventHandler ["hitPart",
	{
		[(_this select 0)] execVM "Scripts\hitPointRegister_EH.sqf";
	} // No need for semicolon, part of an array.
];