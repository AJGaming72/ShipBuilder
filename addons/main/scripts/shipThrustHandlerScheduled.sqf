/*
	shipMovementHandler
	
	Handles the movement of a ship
	
	Arguments:
	_ship: The ship object
	_mps: Meters per second the ship should travel at
	
	TODO: 
	Interval should be a CBA setting
	Add "ANCHOR" mode so ship's script isn't constantly running.

	Run on server

	###################### NOT MAINTAINED ##################################
*/
params ["_ship", "_mps"];
if (!isServer) exitWith {};
private _interval = 0.01; // This is how often the command should tick
private _distPerTick = (_interval*_mps); // This calculates how far we would have to travel each tick to move the proper mps

_ship setVariable ["SB_thrustInput", 0, true]; // Actual speed of ship
_ship setVariable ["SB_thrustCommand", 0, true]; // Commanded speed of ship
_ship setVariable ["SB_thrustStep", 2, true]; // 2 is the stop command
_ship setVariable ["SB_engineModifier", 1, true]; // 2 is the stop command
private _alive = _ship getVariable ["SB_alive", true];
// while thrusting is possible
while { _alive } do {
	// Get our vehicle variables into variables so we don't have to keep calling for them
	private _input = _ship getVariable ["SB_thrustInput", 0];
	private _cmd = _ship getVariable ["SB_thrustCommand", 0];
	private _engineModifier = _ship getVariable ["SB_engineModifier", 1];
	_alive = _ship getVariable ["SB_alive", false]; // If the ship gets deleted, we want the script to end
	    // If our ship isn't going the commanded speed, move it slightly closer to the correct speed
	if (_input isNotEqualTo _cmd) then {
		private _accel = 0.01;
		if (_input > _cmd) then {
			_input = parseNumber ((_input - _accel) toFixed 2); // Prevents floating point errors from occuring
		} else {
			_input = parseNumber ((_input + _accel) toFixed 2); // Prevents floating point errors from occuring
		};
		_ship setVariable ["SB_thrustInput", _input, true]; // Make sure we update our variable
	};
	// move our ship based on the input
	_ship setPosWorld (_ship modelToWorldVisualWorld [0, (_input*_distPerTick * _engineModifier), 0]); 
	sleep _interval;
};

// Code inside of the while loop runs VERY well, can manage about 80-100x per second on my machine. Probably try and hit an FPS of 24-30.