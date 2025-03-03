/*
	escapePodRegister
	
	This script registers an escape pod
	
	Arguments:
	_self: The escape pod point
	_escapePod: The escape pod object
	_ship: The Ship Object

	TODO: 
	
	Run on server
*/
if !(isServer) exitWith {};
params ["_self", "_escapePod", "_ship"];
private _offset = [(_ship worldToModel ASLToAGL getPosASL _self), _ship vectorWorldToModel (vectorDir _self) ];
_escapePod setVariable ["SB_escapePodAvailable",true,true];
[_ship, _escapePod, _offset] remoteExecCall ["SB_fnc_escapePodAction", 0, true];
deleteVehicle _self;
