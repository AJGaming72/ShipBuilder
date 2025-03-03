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
*/
if (!isServer) exitWith {};
params ["_self", "_ship", "_health"];
_self setVariable ["SB_ship", _ship, true];
_self setVariable ["SB_partHealth", _health, true];
[_self, _ship] call BIS_fnc_attachToRelative;
_self setObjectTextureGlobal [0,""];
_self setObjectTextureGlobal [1,""];
_self setObjectMaterialGlobal [0,""];
_self setObjectMaterialGlobal [1,""];
[_self] remoteExecCall ["SB_fnc_hitPointEHSetter", 0, true];
// Here, we are making sure that all players have the event handler.
// "HitPart" EH runs only on the shooters computer. It also works on most static objects. Yay!