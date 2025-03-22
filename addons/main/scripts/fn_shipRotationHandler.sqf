/*
	shipRotationHandler
	
	Handles the Rotation of a ship
	
	Arguments:
	_ship: The ship object
	_speed: Rotation speed (Degrees per second)
	
// Yaw, pitch, Roll
	
	TODO: 
	
	Run on Server
*/
if (!isServer) exitWith {};
params ["_ship", "_speed"];
private _rotPerTick = (SB_interval*_speed);
_ship setVariable ["SB_rotationInput", [0, 0, 0], true];
private _handle = [{
	params ["_args", "_handle"];
	_args params ["_ship", "_rotPerTick"];
	// Calculate the new position
	private _cmd = _ship getVariable ["SB_rotationInput", [0, 0, 0]];
	private _rotation = _ship getVariable ["SB_rotation", [0, 0, 0]];
	_rotation = _rotation vectorAdd (_cmd vectorMultiply _rotPerTick);
	if ((_rotation select 0) > 360) then {
		_rotation set [0, ((_rotation select 0) - 360)];
	}; // Stops us from getting crazy numbers that could cause underflow/overflow
	if ((_rotation select 0) < 0) then {
		_rotation set [0, ((_rotation select 0) + 360)];
	}; // Stops us from getting crazy numbers that could cause underflow/overflow
	if ((_rotation select 1) > 45) then {
		_rotation set [1, 45];
	}; // Maximum pitch of 45 degrees
	if ((_rotation select 1) < -45) then {
		_rotation set [1, -45];
	}; // Maximum pitch of 45 degrees
	[_ship, _rotation] call BIS_fnc_setObjectRotation;
	_ship setVariable ["SB_rotation", _rotation, true];

},SB_interval,[_ship, _rotPerTick]] call CBA_fnc_addPerFrameHandler;
_ship setVariable ["SB_rotationHandler",_handle,true];

