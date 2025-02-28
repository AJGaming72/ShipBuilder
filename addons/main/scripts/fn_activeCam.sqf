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
systemChat format["_cam: %1",_cam];
if (SB_activeCam isNotEqualTo _cam) exitWith {}; // This stops us from creating multiple of the same PFH forever and ever.
SB_activeCam = _cam;
_cam cameraEffect ['Internal', 'Back', 'sbrtactivecam'];
private _offset = _cam getVariable ["SB_camOffset", [[0,0,0],[0,0]]];
private _ship = _cam getVariable "SB_ship";
private _actor = _ship getVariable "SB_shipActor";
systemChat format["_offset: %1",_offset];
systemChat format["_ship: %1",_ship];
systemChat format["_actor: %1",_actor];

[{
	params ["_args", "_handle"];
	_args params ["_cam", "_actor", "_camOffset"];
	_cam setPosASL (AGLToASL (_actor modelToWorld (_camOffset select 0)));
	_cam setVectorDirAndUp [_actor vectorModelToWorldVisual ((_camOffset select 1) select 0),_actor vectorModelToWorldVisual ((_camOffset select 1) select 1)];
	if (_cam isNotEqualTo SB_activeCam) then {
		[_handle] call CBA_fnc_removePerFrameHandler;
	};
},0,[_cam, _actor, _offset]] call CBA_fnc_addPerFrameHandler;