/*
	turretSetup
	
	Handles setting up the turret for use in the ship
	
	Arguments:
	_seat: This is the seat or console used to access the turret
	_turret: This is the turret the player wants to get in to
	
	TODO: 
	Add toggle for the particular move
	Make script work in a mod setting
	Add check to only anchored usage


	Run on server
	Addaction needs to be run per player + JIP
*/

params ["_seat", "_turret", "_ship"];

_seat addAction ["Get in turret",
	{
		params ["_target", "_caller", "_actionId", "_arguments"];
		[_caller, (_arguments select 0)] execVM "Scripts\turretGetIn.sqf";
		_caller switchMove "AmovPsitMstpSnonWnonDnon_ground";
	}, [_turret]];
if (!isServer) exitWith {};
[_turret, _ship] call BIS_fnc_attachToRelative;
