/*
	shipSetup
	
	Handles setting up the ship
	
	Arguments:

	TODO: 
	Ship speed and turn rate as attributes on ship module


	Run on server
	
*/
params [
	["_logic", objNull, [objNull]],		// Argument 0 is module logic
	["_units", [], [[]]],				// Argument 1 is a list of affected units (NOT SYNCH'D OBJECTS)
	["_activated", true, [true]]		// True when the module was activated, false when it is deactivated (i.e., synced triggers are no longer active)
];
if (!isServer) exitWith {};
private _syncObjectsLogic = synchronizedObjects _logic;
private _ship = "B_Quadbike_01_F" createVehicle [0,0,0];
private _shipTriggers = []; // The trigger (or triggers) that define the user as being inside the ship
private _hangarTriggers = []; // The triggers that are used to put the player in or out of the ship
private _turrets = []; // The modules for turrets
private _controllers = []; // The module to link the ship controllers
private _hitPoints = []; // The parts used to define hitpoints
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
} forEach _syncObjectsLogic;
if (_actorClass isEqualTo 0) exitWith {diag_log "[SB] No ship actor created.";};
private _shipActor = _actorClass createVehicle (getPos _ship);
_shipActor attachTo [_ship, [0,0,0]];
_ship setVariable ["SB_shipActor", _shipActor, false]; // We create the vehicle locally because really there's no reason to have it not be local, should be slightly better performance wise. Might be unnecessary.
_ship setVariable ["SB_alive", true, true];
_ship allowDamage false;


[_ship, 120] call SB_fnc_shipThrustHandlerPFH;
[_ship, 3] spawn SB_fnc_shipRotationHandler; // Change to PFH

{
	/*
	Here, we create our trigger
	Then, we use info from our objects the user placed in the 3den editor to find out how our trigger should be setup.
	*/
	// Current result is saved in variable _x
	private _interiorTrigger = createTrigger ["SB_shipInteriorDetector", _x];
	private _area = _x getVariable "objectArea";
	_interiorTrigger setTriggerArea _area;
} forEach _shipTriggers;

{
	/*
	This serves the purpose of making our hangar triggers work.
	First, we get the necessary info to understand where our trigger should be placed, and its ID so that we can connect it with its sister trigger.
	Then, we create the trigger, and register its name within the mission namespace.
	This is the same as if we put its variablename in the 3den editor, and allows us to call for it within the trigger's onActivation area.
	*/
	private _triggerID = _x getVariable "SB_Module_hangarTriggerID";
	private _type = _x getVariable "SB_Module_triggerType";
	if (_type isEqualTo "INTERIOR") then {
		private _interiorTriggers = _ship getVariable ["SB_interiorHangarTriggers", []]; 
		private _interiorName = "SB_" + ((_ship call BIS_fnc_netId) regexReplace ["[:]","_"]) + "_intHangar" + _triggerID;
		private _exteriorName = "SB_" + ((_ship call BIS_fnc_netId) regexReplace ["[:]","_"]) + "_extHangar" + _triggerID;

		if (_name in _interiorTriggers) then {
			diag_log "Hangar Trigger overwritten, may cause unintended behavior. Check Hangar ID's: " + _name;
		};
		private _trigger = createTrigger ["SB_hangarInteriorDetector", _x];
		private _area = _x getVariable "objectArea";
		_trigger setTriggerArea _area;
		_trigger setTriggerActivation ["[thisList] call SB_fnc_detectPlayerVehicle;","[thisTrigger,"+ _exteriorName +", ship] call SB_fnc_teleportFromInt;",""];
		missionNamespace setVariable [_name, _trigger];
		
	} else {
		private _exteriorTriggers = _ship getVariable ["SB_exteriorHangarTriggers", []]; 
		private _interiorName = "SB_" + ((_ship call BIS_fnc_netId) regexReplace ["[:]","_"]) + "_intHangar" + _triggerID;
		private _exteriorName = "SB_" + ((_ship call BIS_fnc_netId) regexReplace ["[:]","_"]) + "_extHangar" + _triggerID;

		if (_name in _interiorTriggers) then {
			diag_log "[SB] Hangar Trigger overwritten, may cause unintended behavior. Check Hangar ID's: " + _name;
		};
		private _trigger = createTrigger ["SB_hangarInteriorDetector", _x];
		private _area = _x getVariable "objectArea";
		_trigger setTriggerArea _area;
		_trigger setTriggerActivation ["[thisTrigger] call SB_fnc_triggerUpdateRot;[thisList] call SB_fnc_detectPlayerVehicle;","[thisTrigger,"+_interiorName+"] call SB_fnc_teleportFromExt;",""];
		missionNamespace setVariable [_name, _trigger];
	};
	
} forEach _hangarTriggers;

{
	// Current result is saved in variable _x
	private _syncObjects = synchronizedObjects _x;
	_syncObjects deleteAt (_syncObjects find _logic);
	private _controller = 1;
	private _turret = 0;
	if ((count _syncObjects) isNotEqualTo 2) exitWith {diag_log "[SB] More than 2 objects synchronized to turret module. Abandoning turret setup."};// Error handling
	{
		// _x is local to the forEach
		if ((_syncObjects select 0) inArea _x) exitWith{ 
			_controller = 0;
			_turret = 1;
		}; // Using exitWith allows us to exit the forEach loop, which is slightly more efficient. Using then would just use slightly more time, no change to effect.
	} forEach _shipTriggers; // Figure out which one is on the interior, allowing us to understand which object is the controller.
	[(_syncObjects select _controller), (_syncObjects select _turret), _ship] call SB_fnc_turretSetup;

} forEach _turrets;

// This should handle the hitpoints 
_ship setVariable ["SB_numEngines", 0, true]; // We need to initialize our variable outside of the loop so we don't do it every time.
{
	/*
	First, we get all the information about our engines.
	Then, we update our SB_numEngines variable so that we make certain we remove the right amount of thrust when an engine is destroyed
	Finally, we register the hitpoint with our function
	This only accounts for the Engine hitpoint type right now.
	*/
	private _engines = _ship getVariable ["SB_numEngines", 0];
	private _type = _x getVariable ["SB_hitpointType", ""];
	private _health = _x getVariable ["SB_hitpointHealth", 10000];
	if (_type == "engine") then {
		_ship setVariable ["SB_numEngines", (_engines + 1), true];

	};
	[_x, _ship, _type, _health] call SB_fnc_hitPointRegister;
} forEach (_hitpoints);

// Marker setup
[_ship] spawn SB_fnc_markerSetup;


{
	/*
	Run our setup function for each controller on all players, plus those that JIP (Join in Progress)
	*/
	// Current result is saved in variable _x
	private _syncObjects = synchronizedObjects _x;
	_syncObjects deleteAt (_syncObjects find _logic); // This should mean we only have one item in our array, the ship controller.
	// Error handling. I could just make it loop through, but that adds complexity where I don't want it.
	if (count _syncObjects > 1) then {diag_log "[SB] Multiple controller objects attached to one controller module. Defaulting to first item in array.";};
	[_ship, (_syncObjects select 0)] remoteExecCall ["SB_fnc_shipControllerSetup", 0, true]; // Controller setup for the ship
} forEach _controllers;
