/*
	cameraCreate
	
	Handles connecting a screen and a camera
	
	Arguments:
	_screen: The screen object to display on
	_selectionID: The texture index used to display on the screen
	_camera: The object used to show the place and direction of a camera
	
	TODO: 

	Run on player
*/
if !(hasInterface) exitWith {};
params ["_screen", "_selectionID", "_ship"];
// Creates render surface for camera to render to. Render surface doesn't seem to be a real thing but rather you just create a variable and the game understands how that works. Forum helped me here lol

private _actor = _ship getVariable ["SB_shipActor", _ship];
while {_actor == _ship} do {
	_actor = _ship getVariable ["SB_shipActor", _ship];
	sleep 1;
}; // We are waiting until we actually get the ship object. It might take some time to instantiate.

// IMPORTANT!!!
// IF THE OBJECT TEXTURE STRING HAS ANY SPACES IN IT, THE TEXTURE WILL THROW AN ERROR
// Good: "#(argb,512,512,1)r2t(sbrtactivecam,1)"
// Bad: "#(argb, 512, 512, 1)r2t(sbrtactivecam, 1)"
// This took so much longer than I want to admit to figure out.
private _screenID = ((_screen call BIS_fnc_netId) regexReplace ["[:]","_"]) + "sbactivecam";
_screen setObjectTexture [_selectionID, "#(argb,512,512,1)r2t("+_screenID+",1)"]; 
// Create our camera
private _cam = "camera" camCreate [0, 0, 0];
private _camOffset = _screen getVariable "SB_camOffset";
_cam setPosASL (AGLToASL (_actor modelToWorld (_camOffset select 0)));
_cam setVectorDirAndUp [_actor vectorModelToWorldVisual ((_camOffset select 1) select 0),_actor vectorModelToWorldVisual ((_camOffset select 1) select 1)];
[_cam, _actor] call BIS_fnc_attachToRelative;

_cam cameraEffect ["Terminate", "Back", "sbrtactivecam"];
_cam cameraEffect ["Internal", "Back", "sbrtactivecam"];


private _trg = createTrigger ["EmptyDetector", getPos _screen];
_trg setTriggerArea [5, 5, 0, false];
_trg setTriggerInterval 1;
_trg setVariable ["SB_camera", _cam];
_trg setVariable ["SB_screenID",_screenID];
_trg setTriggerActivation ["ANYPLAYER", "PRESENT", true];
_trg setTriggerArea [5,5,0,false,5];
_trg setTriggerStatements ["this", "[thisTrigger] call SB_fnc_activeCam;", ""];

