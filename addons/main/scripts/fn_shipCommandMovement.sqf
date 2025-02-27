/*
	shipCommandMovement
	
	Handles input of a command to move the ship
	
	Arguments:
	_ship: The ship object
	_thrust: A thrust input (Integer)
	_rotation: Command input (Array format: [0, 0, 0])
	
	TODO: 
	Add speeds as setting 
	Add speed coefficients as setting on ship

	Run on Player
*/
if !(hasInterface) exitWith {};
params ["_ship", "_thrust", "_rotation"];

if (_ship getVariable ["SB_isDying",false]) exitWith {systemChat "Ship cannot be controlled: Dying";};// If we are dying, remove ability to control

// if we are going to thrust 
if (_thrust isNotEqualTo 0) then {
	private _currentStep = _ship getVariable ["SB_thrustStep", 2]; // 2 is the stop command
	private _stepNames = ["Full Reverse", "Reverse", "Halt", "Minimum Speed", "Cruise", "Combat", "Full Ahead"]; // Defining the names for each step
	private _speedCoefficients = [-25, -10, 0, 10, 40, 80, 100]; // 
	    _currentStep = _currentStep + _thrust; // Calculate our new step

	if !((_currentStep < 0) || (_currentStep > ((count _speedCoefficients) - 1))) then {
		// Make sure our step is within bounds
		_ship setVariable ["SB_thrustStep", _currentStep, true];
		_ship setVariable ["SB_thrustCommand", (_speedCoefficients select _currentStep), true];
		systemChat(format["Speed: %1", (_stepNames select _currentStep)]);
	};
};

// if we are rotating
if (_rotation isNotEqualTo [0, 0, 0]) then {
	private _rotationInput = _ship getVariable ["SB_rotationInput", [0, 0, 0]];
	_rotationInput = _rotationInput vectorAdd _rotation;
	{
		if (_x > 1) then {
			_rotationInput set [_forEachIndex, 1];
		} else {
			if (_x < -1) then {
				_rotationInput set [_forEachIndex, -1];
			};
		};
	} forEach _rotationInput; // Sanitize our input
	_ship setVariable ["SB_rotationInput", _rotationInput, true];
};