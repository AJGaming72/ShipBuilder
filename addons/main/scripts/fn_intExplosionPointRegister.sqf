/*
	intExplosionPointRegister
	
	This function registers a hit point with the ship
	
	Arguments:
	_self: The explosion point
	_ship: The ship object
	

	TODO: 
	
	Run on server
*/
if (!isServer) exitWith {};
params ["_self", "_ship"];
private _arr = _ship getVariable ["SB_intExplosionPoints", []];
private _pos = getPosASL _self;
_arr pushBack _pos;
_ship setVariable ["SB_intExplosionPoints", _arr, true];
deleteVehicle _self;
