/*
	escapePodRegister
	
	This script registers an escape pod
	
	Arguments:
	_self: The escape pod point
	_escapePod: The escape pod object
	_ship: The Ship Object

	TODO: 
	
	Run on server

	Addaction needs to be Per Player + JIP
*/
if !(hasInterface) exitWith {};
params ["_self", "_escapePod", "_ship"];
private _offset = [(_ship worldToModel ASLToAGL getPosASL _self), _ship vectorWorldToModel (vectorDir _self) ];
_escapePod addAction ["Launch Escape Pod",
	{
		params ["_target", "_caller", "_actionId", "_arguments"];
		[_target, (_arguments select 0),(_arguments select 1),_actionId] execVM "Scripts\escapePodLaunch.sqf";
	}, [_offset, _ship]];
deleteVehicle _self;
