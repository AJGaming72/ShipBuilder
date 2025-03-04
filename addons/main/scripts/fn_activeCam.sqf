/*
	activeCam
	
	
	Arguments:
	_trigger: The trigger object
	
	TODO: 

	Run on player
*/
params ["_trigger"];
private _cam = _trigger getVariable "SB_camera";
private _screenID = _trigger getVariable "SB_screenID";
_cam cameraEffect ['Internal', 'Back', _screenID];
