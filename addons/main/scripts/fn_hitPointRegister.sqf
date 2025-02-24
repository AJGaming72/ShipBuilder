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
if (!isServer) exitWith {};
params ["_self", "_ship", "_type", "_health"];
_self setVariable ["SB_ship", _ship, true];
_self setVariable ["SB_partHealth", _health, true];
_self setVariable ["SB_partType", _type, true];
[_self, _ship] call BIS_fnc_attachToRelative;
_self setObjectMaterialGlobal [0,""];
_self setObjectMaterialGlobal [1,""];
[{_self addEventHandler ["HitPart", {[(_this select 0)] call SB_fnc_hitPointRegister_EH;}]}] remoteExecCall ["call", 0, true];
// Here, we are making sure that all players have the event handler.
// "HitPart" EH runs only on the shooters computer. It also works on most static objects. Yay!