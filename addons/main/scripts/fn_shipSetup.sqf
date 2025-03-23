/*
	shipSetup
	
	Handles setting up the ship
	
	Arguments:

	TODO: 

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
private _shipTriggersLogic = []; // The trigger (or triggers) that define the user as being inside the ship
private _hangarTriggers = []; // The triggers that are used to put the player in or out of the ship
private _turrets = []; // The modules for turrets
private _controllers = []; // The module to link the ship controllers
private _hitPoints = []; // The parts used to define hitpoints
private _maps = []; // Defines the map objects
private _cameras = [];
private _escapePods = [];
private _explosionPoints = [];
private _chairs = [];
private _shipActor = 0;

{
	// Current result is saved in variable _x
	switch (typeOf _x) do {
		// Here, we are putting each of the modules into their respective arrays so we can handle them accordingly.
		case "SB_Module_trigger": {_shipTriggersLogic pushBack _x}; 
		case "SB_Module_hangarTrigger": {_hangarTriggers pushBack _x};
		case "SB_Module_turret": {_turrets pushBack _x;};
		case "SB_Module_shipController": {_controllers pushBack _x;};
		case "SB_module_map": {_maps pushBack _x;};
		case "SB_module_camera": {_cameras pushBack _x;};
		case "SB_module_escapePod": {_escapePods pushBack _x;};
		case "SB_Module_shipChair": {_chairs pushBack _x;};
		// Explosion Point
		case "SB_explosionPoint": {_explosionPoints pushBack _x;};
		// Hitpoints!
		case "SB_hitPoint_01": {_hitPoints pushBack _x;};
		case "SB_hitPoint_02": {_hitPoints pushBack _x;};
		case "SB_hitPoint_03": {_hitPoints pushBack _x;};
		case "SB_hitPoint_04": {_hitPoints pushBack _x;};
		case "SB_hitPoint_05": {_hitPoints pushBack _x;};
		default {_shipActor = _x;}; // The only vehicle that should be default is the ship's actor from 3den editor.
	};
} forEach _syncObjectsLogic;
if (_shipActor isEqualTo 0) exitWith {diag_log "[SB] No ship actor found.";};
_ship enableSimulationGlobal false;
_ship setPosASL getPosASL _shipActor;
private _shipDirOffset = _logic getVariable ["SB_module_shipDirOffset",0];
_ship setDir ((getDir _shipActor) + _shipDirOffset);
[_shipActor, _ship] call BIS_fnc_attachToRelative;
_ship setVariable ["SB_shipActor", _shipActor, true];
_shipActor setVariable ["SB_ship", _ship, true];
_ship setVariable ["SB_alive", true, true];
_ship setVariable ["SB_fires", [], true];
_ship allowDamage false;

private _shipName = _logic getVariable "SB_Module_shipName";
if (_shipName isEqualTo "") exitWith {diag_log "[SB] No ship name."};
missionNamespace setVariable [_shipName, _ship];
publicVariable _shipName;


private _shipTriggers = [];
{
	/*
	Here, we create our trigger
	Then, we use info from our objects the user placed in the 3den editor to find out how our trigger should be setup.
	*/
	// Current result is saved in variable _x
	private _interiorTrigger = createTrigger ["EmptyDetector", [0,0,0], false]; // Because this is used in other scripts, we actually need the trigger created on the server here.
	private _pos = getPosASL _x;
	_interiorTrigger setPosASL _pos; // We setPosASL after instead of setting pos here to avoid an unusual issue with height not being set properly.
	private _area = _x getVariable "objectArea";
	private _activation = ["ANYPLAYER", "PRESENT", true];
	private _statements = ["vehicle player in thisList;","player setVariable ['SB_ship', " + _shipName + ", true];", "player setVariable ['SB_ship', -1, true];SB_activeCam = -1;"];
	_interiorTrigger setTriggerActivation _activation;
	_interiorTrigger setTriggerStatements _statements;
	_interiorTrigger setTriggerArea _area;
	private _arrow = "Sign_Arrow_Direction_F" createVehicle [0,0,0]; 
	_arrow setPosASL _pos;
	_arrow setDir (_area select 2);
	_arrow setObjectTextureGlobal [0,""];
	[_x,_arrow, _pos, _activation, _statements, _area] remoteExecCall ["SB_fnc_globalTrigger",0,true];
	_shipTriggers pushBack _interiorTrigger;
} forEach _shipTriggersLogic;

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
		private _interiorName = "SB_" + ((_ship call BIS_fnc_netId) regexReplace ["[:]","_"]) + "_intHangar" + str _triggerID;
		private _exteriorName = "SB_" + ((_ship call BIS_fnc_netId) regexReplace ["[:]","_"]) + "_extHangar" + str _triggerID;
		if (_interiorName in _interiorTriggers) then {
			diag_log "Hangar Trigger overwritten, may cause unintended behavior. Check Hangar ID's: " + _interiorName;
		};
		private _pos = getPosASL _x;
		private _area = _x getVariable "objectArea";
		private _activation = ["ANYPLAYER", "PRESENT", true];
		private _statements = ["[thisList] call SB_fnc_detectPlayerVehicle;","","[thisTrigger,"+ _exteriorName +", " + _shipName + "] call SB_fnc_teleportFromInt;"];
		private _arrow = "Sign_Arrow_Direction_F" createVehicle [0,0,0]; 
		_arrow setPosASL _pos;
		_arrow setDir (_area select 2);
		_arrow setObjectTextureGlobal [0,""];
		[_x,_arrow, _pos, _activation, _statements, _area, _interiorName] remoteExecCall ["SB_fnc_globalTrigger",0,true];
		
	} else {
		private _exteriorTriggers = _ship getVariable ["SB_exteriorHangarTriggers", []]; 
		private _interiorName = "SB_" + ((_ship call BIS_fnc_netId) regexReplace ["[:]","_"]) + "_intHangar" + str _triggerID;
		private _exteriorName = "SB_" + ((_ship call BIS_fnc_netId) regexReplace ["[:]","_"]) + "_extHangar" + str _triggerID;

		if (_exteriorName in _exteriorTriggers) then {
			diag_log "[SB] Hangar Trigger overwritten, may cause unintended behavior. Check Hangar ID's: " + _exteriorName;
		};
		private _pos = (getPosASL _x);
		private _offset = [_ship worldToModel ASLToAGL getPosASL _x, getDir _x,_ship];
		private _area = _x getVariable "objectArea";
		private _activation = ["ANYPLAYER", "PRESENT", true];
		private _statements = ["[thisTrigger] call SB_fnc_triggerUpdateRot;[thisList] call SB_fnc_detectPlayerVehicle;","[thisTrigger,"+_interiorName+"] call SB_fnc_teleportFromExt;", ""];
		private _arrow = "Sign_Arrow_Direction_F" createVehicle [0,0,0]; 
		_arrow setPosASL _pos;
		_arrow setDir (_area select 2);
		_arrow setObjectTextureGlobal [0,""];
		[_x,_arrow, _pos, _activation, _statements, _area, _exteriorName, _offset,_ship] remoteExecCall ["SB_fnc_globalTrigger",0,true];

	};
	
} forEach _hangarTriggers;

private _turretObjs = [];
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
	_turretObjs pushBack (_syncObjects select _turret);
} forEach _turrets;
_ship setVariable ["SB_turrets", _turretObjs, true];

// This should handle the hitpoints 
_ship setVariable ["SB_numEngines", 0, true]; // We need to initialize our variable outside of the loop so we don't do it every time.
{
	/*
	First, we get all the information about our engines.
	Then, we update our SB_numEngines variable so that we make certain we remove the right amount of thrust when an engine is destroyed
	Finally, we register the hitpoint with our function
	This only accounts for the Engine hitpoint type right now.
	*/
	private _hitpoint = _x;
	private _engines = _ship getVariable ["SB_numEngines", 0];
	private _health = _hitpoint getVariable ["SB_Module_hitpointHealth", 10000];
	private _type = _hitpoint getVariable ["SB_module_hitpointType", 'ENGINE'];
	if (_type == "ENGINE") then {
		_ship setVariable ["SB_numEngines", (_engines + 1), true];
		private _engines = _ship getVariable ["SB_engines", []];
		_engines pushBackUnique _x;
		_ship setVariable ["SB_engines", _engines]; 
	};
	{
	if (_hitpoint inArea _x) exitWith {
		_hitpoint setVariable ["SB_inside", true, true];
	};
	} forEach _shipTriggers;
	[_hitpoint, _ship, _health] call SB_fnc_hitPointRegister;
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

{
	// screen ship selection dimensions
	// Current result is saved in variable _x
	private _syncObjects = synchronizedObjects _x;
	_syncObjects deleteAt (_syncObjects find _logic); // This should mean we only have one item in our array, the ship controller.
	if (count _syncObjects > 1) then {diag_log "[SB] Multiple map objects attached to one map module. Defaulting to first item in array.";};
	private _dimensions = [(_x getVariable "SB_module_mapX"),(_x getVariable "SB_module_mapY")];
	private _selectionID = _x getVariable "SB_module_selectionID";
	[(_syncObjects select 0), _ship, _selectionID, _dimensions] remoteExec ["SB_fnc_mapCreate", 0, true];
} forEach _maps;


{
	private _syncObjects = synchronizedObjects _x;
	_syncObjects deleteAt (_syncObjects find _logic); // This should mean we only have one item in our array, the ship controller.
	private _escapePod = 1;
	private _pointMarker = 0;
	{
		if ((_syncObjects select 0) inArea _x) exitWith{ 
			_escapePod = 0;
			_pointMarker = 1;
		}; // Using exitWith allows us to exit the forEach loop, which is slightly more efficient. Using then would just use slightly more time, no change to effect.
	} forEach _shipTriggers;
	// params ["_self", "_escapePod", "_ship"];
	[(_syncObjects select _pointMarker),(_syncObjects select _escapePod), _ship] call SB_fnc_escapePodRegister;
} forEach _escapePods;


{
	// Current result is saved in variable _x
	private _explosionPoint = _x;
	_explosionPoint setVariable ["SB_interior", false];
	{
		if (_explosionPoint inArea _x) exitWith { 
			_explosionPoint setVariable ["SB_interior", true];
		};
	} forEach _shipTriggers;
	// We seperate these so we don't get the case that it is not in one array, but in the other, and gets misrepresented as exterior.

	if (_explosionPoint getVariable "SB_interior") then {
		[_explosionPoint, _ship] call SB_fnc_intExplosionPointRegister;
	} else {
		[_explosionPoint, _ship] call SB_fnc_explosionPointRegister;
	};
} forEach _explosionPoints;


{
	// Current result is saved in variable _x
	private _syncObjects = synchronizedObjects _x;
	_syncObjects deleteAt (_syncObjects find _logic); // This should mean we only have one item in our array, the ship controller.
	if (count _syncObjects > 1) then {diag_log "[SB] Multiple Captain's Chair objects attached to one module. Defaulting to first item in array.";};
	(_syncObjects select 0) setVariable ["SB_ship", _ship, true];
	(_syncObjects select 0) setVariable ["SB_chair", true, true];
} forEach _chairs;



// This way nothing gets thrown off in the loading process.
_ship enableSimulationGlobal true;
private _shipSpeed = _logic getVariable ["SB_Module_shipSpeed", 120];
private _shipRotationSpeed = _logic getVariable ["SB_module_shipRotationSpeed", 3];
_ship setVariable ["SB_shipSpeed", _shipSpeed, true];
_ship setVariable ["SB_shipRotationSpeed", _shipRotationSpeed, true];
_ship setVariable ["SB_active", true, true];
[_ship, _shipSpeed] call SB_fnc_shipThrustHandler;
[_ship, _shipRotationSpeed] call SB_fnc_shipRotationHandler;
// Needs attachTo to go off first
{

	private _selectionID = _x getVariable "SB_module_selectionID";
	private _syncObjects = synchronizedObjects _x;
	_syncObjects deleteAt (_syncObjects find _logic);
	private _screen = 1;
	private _cam = 0;
	if ((count _syncObjects) isNotEqualTo 2) exitWith {diag_log "[SB] More than 2 objects synchronized to camera module. Abandoning Camera setup."};// Error handling
	{
		if ((_syncObjects select 0) inArea _x) exitWith{ 
			_screen = 0;
			_cam = 1;
		}; // Using exitWith allows us to exit the forEach loop, which is slightly more efficient. Using then would just use slightly more time, no change to effect.
	} forEach _shipTriggers;
	// screen, _selectionID, camera, ship;
	sleep 1; // The camera needs time for other stuff to initialize first.
	private _camOffset = [_ship worldToModel ASLToAGL getPosASL (_syncObjects select _cam), [(_syncObjects select _cam), _ship, true] call BIS_fnc_vectorDirAndUpRelative];
	deleteVehicle (_syncObjects select _cam);
	(_syncObjects select _screen) setVariable ["SB_camOffset",_camOffset,true];
	[(_syncObjects select _screen),_selectionID,_ship] remoteExec ["SB_fnc_cameraCreate", 0, true];


	
} forEach _cameras;