/*
	activeCam
	
	Handles the activeCam system
    Activecam will allow one camera to be highly accurate with its position, per player. This means you could, theoretically, have windows on a ship. Poggers!
	
	Arguments:
	_trigger: The trigger object
	
	TODO: 
    CBA interval

	Run on player
*/
params ["_trigger"];
private _cam = _trigger getVariable "SB_camera";
if (SB_activeCam isEqualTo _cam) exitWith {}; // This stops us from creating multiple of the same PFH forever and ever.
SB_activeCam = _cam;
private _screenID = _trigger getVariable "SB_screenID";
_cam cameraEffect ['Internal', 'Back', _screenID];
private _offset = _trigger getVariable ["SB_camOffset",[[0,0,0],[0,0]]];
private _ship = _trigger getVariable "SB_ship";
private _actor = _ship getVariable "SB_shipActor";

[{
	params ["_args", "_handle"];
	_args params ["_cam", "_actor", "_camOffset"];
	_cam setPosASL (AGLToASL (_actor modelToWorld (_camOffset select 0)));
	_cam setVectorDirAndUp [_actor vectorModelToWorldVisual ((_camOffset select 1) select 0),_actor vectorModelToWorldVisual ((_camOffset select 1) select 1)];
	if (_cam isNotEqualTo SB_activeCam) then {
		[_handle] call CBA_fnc_removePerFrameHandler;
	};
},0,[_cam, _actor, _offset]] call CBA_fnc_addPerFrameHandler;