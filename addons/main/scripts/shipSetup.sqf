/*
	shipSetup
	
	Handles setting up the ship
	
	Arguments:
	_ship: The ship object
	_shipActor: The ship object's actor
	_controller: The object that control the ship
	
	TODO: 

	Run on server
	
*/
params ["_ship", "_shipActor", "_controller"];
// if (!isServer) exitWith {};
private _actorClass = typeOf _shipActor;
_ship setVariable ["SB_actorClass", _actorClass];
deleteVehicle _shipActor;
_ship allowDamage false;
_controller setVariable ["SB_ship", _ship];
// [_ship, 3] execVM "Scripts\shipHandler.sqf";
[_ship, 120] execVM "Scripts\shipThrustHandlerPFH.sqf";
[_ship, 3] execVM "Scripts\shipRotationHandler.sqf";


[_ship] execVM "Scripts\syncParts.sqf";
_ship setVariable ["SB_alive", true, true];

// Marker setup
[_ship] execVM "Scripts\markerSetup.sqf";


// ********************************************************************************
[_ship, _controller] execVM "Scripts\shipSetupLocal.sqf"; // To be removed when mod
