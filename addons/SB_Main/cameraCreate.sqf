/*
	cameraCreate
	
	Handles connecting a screen and a camera
	
	Arguments:
	_screen: The screen object to display on
	_surfaceIndex: The texture index used to display on the screen
	_camera: The object used to show the place and direction of a camera
	
	TODO: 
	Add garbage cleanup
	Add an "Active Camera"
	Move the camera in a more clean way with the ship
	Interval from a CBA setting

	Run on player POST INIT
*/
params ["_screen", "_surfaceIndex", "_camera", "_ship"];
// Creates render surface for camera to render to. Render surface doesn't seem to be a real thing but rather you just create a variable and the game understands how that works. Forum helped me here lol
if !(hasInterface) exitWith {};

private _actor = _ship getVariable ["SB_shipActor", _ship];
while {_actor == _ship} do {
	_actor = _ship getVariable ["SB_shipActor", _ship];
}; // We are waiting until we actually get the ship object. It might take some time to instantiate.

// IMPORTANT!!!
// IF THE OBJECT TEXTURE STRING HAS ANY SPACES IN IT, THE TEXTURE WILL THROW AN ERROR
// Good: "#(argb,512,512,1)r2t(sbrtactivecam,1)"
// Bad: "#(argb, 512, 512, 1)r2t(sbrtactivecam, 1)"
// This took so much longer than I want to admit to figure out.
_screen setObjectTexture [_surfaceIndex, "#(argb,512,512,1)r2t(sbrtactivecam,1)"]; 

// Create our camera
private _cam = "camera" camCreate [0, 0, 0];
_cam setPosASL (getPosASL _camera);
_cam setVectorDirAndUp [(vectorDir _actor), (vectorUp _actor)];


_cam cameraEffect ["Terminate", "Back", "sbrtactivecam"];
_cam cameraEffect ["Internal", "Back", "sbrtactivecam"];

SB_activeCam = _cam;
private _camOffset = _actor worldToModel ASLToAGL getPosASL _camera;
_cam setVariable ["SB_camOffset", _camOffset];
_cam setVariable ["SB_ship", _ship];

deleteVehicle _camera; // No longer need the placeholder object

// INTERVAL NEEDS TO BE CHANGED
private _interval = 0.04;

// I plan for this to be a bit better in the future, this is a shoddy implementation of active camera
private _trg = createTrigger ["EmptyDetector", getPos _screen];
_trg setTriggerArea [5, 5, 0, false];
_trg setTriggerInterval 1;
_trg setVariable ["SB_camera", _cam];
_trg setTriggerActivation ["ANYPLAYER", "PRESENT", true];
_trg setTriggerStatements ["this", "thisTrigger getVariable ""SB_camera"" cameraEffect ['Internal', 'Back', 'sbrtactivecam'];", ""];


// While memory intensive, this method allows for a smoother camera connection to the ship. For this reason, I intend to add an active camera function.
[{
	params ["_args", "_handle"];
	_args params ["_cam", "_actor", "_camOffset"];
	_cam setPosASL (AGLToASL (_actor modelToWorld _camOffset));
	_cam setVectorDirAndUp [(vectorDir _actor), (vectorUp _actor)];
	if !(_cam == SB_activeCam) then {
		[_handle] call CBA_fnc_removePerFrameHandler;
	};
},0,[_cam, _actor, _camOffset]] call CBA_fnc_addPerFrameHandler;