/*
	shipRotationHandler
	
	Handles the Rotation of a ship
	
	Arguments:
	_ship: The ship object
	_speed: Rotation speed (Degrees per second)
	
// Yaw, pitch, Roll
	
	TODO: 
	Interval should be a CBA setting
	Input should be keybinds via CBA
	Add "ANCHOR" mode so ship's script isn't constantly running.
	Make this a PFH
	Run on Server
*/
if (!isServer) exitWith {};
params ["_ship", "_speed"];
private _interval = 0.1;
private _rotPerTick = (_interval*_speed);
_ship setVariable ["SB_rotationInput", [0, 0, 0], true];
_ship setVariable ["SB_rotation", [0, 0, 0], true];
private _alive = _ship getVariable ["SB_alive",true];

while { _alive } do {
	// Calculate the new position
	private _cmd = _ship getVariable ["SB_rotationInput", [0, 0, 0]];
	private _rotation = _ship getVariable ["SB_rotation", [0, 0, 0]];
	_alive = _ship getVariable ["SB_alive", false]; // If the ship gets deleted, we want the script to end
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
	sleep _interval;
};
