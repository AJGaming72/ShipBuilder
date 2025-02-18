/*
	turretSetup
	
	Handles setting up the turret for use in the ship
	
	Arguments:
	_controller: This is the seat or console used to access the turret
	_turret: This is the turret the player wants to get in to
	
	TODO: 
	Add toggle for the particular move
	Make script work in a mod setting
	Add check to only anchored usage


	Run on server
	Addaction needs to be run per player + JIP
*/
if (!isServer) exitWith {};
params ["_controller", "_turret", "_ship"];
[_controller, _turret] remoteExecCall ["SB_fnc_turretSetupLocal", 0, true];
[_turret, _ship] call BIS_fnc_attachToRelative;
