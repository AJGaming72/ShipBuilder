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
params [
	["_logic", objNull, [objNull]],		// Argument 0 is module logic
	["_units", [], [[]]],				// Argument 1 is a list of affected units (SYNC'D OBJECTS GO IN HERE!)
	["_activated", true, [true]]		// True when the module was activated, false when it is deactivated (i.e., synced triggers are no longer active)
];

if (!isServer) exitWith {};
private _ship = "B_Quadbike_01_F" createVehicle [0,0,0];
private _shipTriggers = {}; // The trigger (or triggers) that define the user as being inside the ship
private _hangarTriggers = {}; // The triggers that are used to put the player in or out of the ship
private _turrets = {}; // The modules for turrets
private _controllers = {}; // The module to link the ship controllers
private _hitPoints = {}; // The parts used to define hitpoints
private _actorClass = 0; // The ship's actor.


{
	// Current result is saved in variable _x
	switch (typeOf _x) do {
		// Here, we are putting each of the modules into their respective arrays so we can handle them accordingly.
		case "SB_Module_trigger": {_shipTriggers pushBack _x}; 
		case "SB_Module_hangarTrigger": {_hangarTriggers pushBack _x};
		case "SB_Module_turret": {_turrets pushBack _x;};
		case "SB_Module_shipController": {_controllers pushBack _x;};
		// Hitpoints!
		case "SB_hitPoint_01": {_hitPoints pushBack _x;};
		case "SB_hitPoint_02": {_hitPoints pushBack _x;};
		case "SB_hitPoint_03": {_hitPoints pushBack _x;};
		case "SB_hitPoint_04": {_hitPoints pushBack _x;};
		case "SB_hitPoint_05": {_hitPoints pushBack _x;};
		default {_actorClass = typeOf _x;_ship setPosASL (getPosASL _x);deleteVehicle _x;}; // The only vehicle that should be default is the ship's actor from 3den editor.
	};
} forEach _units;


private _shipActor = _actorClass createVehicle (getPos _ship);
_shipActor attachTo [_ship, [0,0,0]];
_ship setVariable ["SB_shipActor", _shipActor, false]; // We create the vehicle locally because really there's no reason to have it not be local, should be slightly better performance wise. Might be unnecessary.
_ship setVariable ["SB_alive", true, true];
_ship allowDamage false;


[_ship, 120] call SB_fnc_shipThrustHandlerPFH;
[_ship, 3] spawn SB_fnc_shipRotationHandler;

// This should handle the hitpoints 
_ship setVariable ["SB_numEngines", 0, true];
{
	private _engines = _ship getVariable ["SB_numEngines", 0];
	private _type = _x getVariable ["SB_hitpointType", ""];
	private _health = _x getVariable ["SB_hitpointHealth", 10000];
	SB_hitpointHealth
	if (_type == "engine") then {
		_ship setVariable ["SB_numEngines", (_engines + 1), true];

	};
	[_x, _ship, _type, _health] call SB_fnc_hitPointRegister;
} forEach (_hitpoints);

// Marker setup
[_ship] spawn SB_fnc_markerSetup;


{
	// Current result is saved in variable _x
	[_ship, _x] remoteExecCall ["SB_fnc_shipControllerSetup", 0, true]; // Controller setup for the ship
} forEach _controllers;

