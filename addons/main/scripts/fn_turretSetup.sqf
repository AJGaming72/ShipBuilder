/*
	turretSetup
	
	Handles setting up the turret for use in the ship
	
	Arguments:
	_controller: This is the seat or console used to access the turret
	_turret: This is the turret the player wants to get in to
	_ship: The ship object
	
	TODO: 


	Run on server
	Addaction needs to be run per player + JIP
*/
if (!isServer) exitWith {};
params ["_controller", "_turret", "_ship"];
_controller setVariable ["SB_turret", _turret, true];
_turret setVariable ["SB_turretAvailable",true,true];
_turret setVariable ["SB_ship", _ship, true];
[_controller, _turret] remoteExecCall ["SB_fnc_turretSetupLocal", 0, true];
[_turret, _ship] call BIS_fnc_attachToRelative;
_turret enableSimulationGlobal true;
