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
params ["_ship", "_speed"];
if (!isServer) exitWith {};
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

/*
// Sim needs to be enabled for attaching the hitboxes
// v1 enableSimulation false;  
	v1 allowDamage false;
	v1 setPos ((getPos v1) vectorAdd [10, 0, 0]);
	[v1, 30] execVM "Scripts\shipRotationHandler.sqf";
	[v1, 10] execVM "Scripts\shipThrustHandler.sqf";
	c3 addAction ["Forward", {
		[v1, 1, [0, 0, 0]] execVM "Scripts\shipCommandMovement.sqf";
	}];
	c3 addAction ["Backward", {
		[v1, -1, [0, 0, 0]] execVM "Scripts\shipCommandMovement.sqf";
	}];
	c3 addAction ["PitchUp", {
		[v1, 0, [0, 1, 0]] execVM "Scripts\shipCommandMovement.sqf";
	}];
	c3 addAction ["PitchDown", {
		[v1, 0, [0, -1, 0]] execVM "Scripts\shipCommandMovement.sqf";
	}];
// c3 addAction ["Roll Right", {
		[v1, 0, [0, 0, -1]] execVM "Scripts\shipCommandMovement.sqf";
	}];
// c3 addAction ["Roll Left", {
		[v1, 0, [0, 0, 1]] execVM "Scripts\shipCommandMovement.sqf";
	}];
	c3 addAction ["YawRight", {
		[v1, 0, [-1, 0, 0]] execVM "Scripts\shipCommandMovement.sqf";
	}];
	c3 addAction ["YawLeft", {
		[v1, 0, [1, 0, 0]] execVM "Scripts\shipCommandMovement.sqf";
	}];
	[v1] execVM "Scripts\syncParts.sqf";
	
*/