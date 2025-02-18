/*
	explosionPointRegister
	
	This function registers a hit point with the ship
	
	Arguments:
	_self: The explosion point
	_ship: The ship object
	
	[_self, _ship] call SB_fnc_explosionPointRegister;

	TODO: 

	Run on server
	
*/
if (!isServer) exitWith {};
params ["_self", "_ship"];
private _arr = _ship getVariable ["SB_explosionPoints", []];
private _offset = _ship worldToModel ASLToAGL getPosASL _self;
_arr pushBack _offset;
_ship setVariable ["SB_explosionPoints", _arr, true];
deleteVehicle _self;