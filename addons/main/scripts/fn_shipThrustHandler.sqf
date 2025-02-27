/*
	shipMovementHandlerPFH
	
	Handles the movement of a ship
	
	Arguments:
	_ship: The ship object
	_mps: Meters per second the ship should travel at
	
	TODO: 
	Interval should be a CBA setting
	Add "ANCHOR" mode so ship's script isn't constantly running.

	Run on server
	
*/
if (!isServer) exitWith {};
params ["_ship", "_mps"];
private _distPerTick = (SB_interval*_mps); // This calculates how far we would have to travel each tick to move the proper mps
private _pos = getPosWorld _ship;

_ship setVariable ["SB_mps", _mps, true];

_ship setVariable ["SB_thrustInput", 0, true]; // Actual speed of ship
_ship setVariable ["SB_thrustCommand", 0, true]; // Commanded speed of ship
_ship setVariable ["SB_thrustStep", 2, true]; // 2 is the stop command
_ship setVariable ["SB_engineModifier", 1, true]; // 2 is the stop command
[{
	params ["_args", "_handle"];
	_args params ["_ship", "_distPerTick", "_pos"];
	private _alive = _ship getVariable ["SB_alive", true];
	private _input = _ship getVariable ["SB_thrustInput", 0];
	private _cmd = _ship getVariable ["SB_thrustCommand", 0];
	private _engineModifier = _ship getVariable ["SB_engineModifier", 1];
	// If our ship isn't going the commanded speed, move it slightly closer to the correct speed
	if (_input isNotEqualTo _cmd) then {
		// Our acceleration change rate is 1.
		if (_input > _cmd) then {
			_input = (_input - 1); // Prevents floating point errors from occuring
		} else {
			_input = (_input + 1); // Prevents floating point errors from occuring
		};
		_ship setVariable ["SB_thrustInput", _input, true]; // Make sure we update our variable
	};
	// move our ship based on the input

	private _dir = vectorNormalized vectorDir _ship;  // Forward direction
	private _up = vectorNormalized vectorUp _ship;    // Up direction

	// Compute Right Vector
	private _right = vectorNormalized (_up vectorCrossProduct _dir);
	private _up = vectorNormalized (_dir vectorCrossProduct _right); // Ensure orthogonality

	// Local-space offset (e.g., 1m to the right, 0m up, 2m forward)
	private _offset = [0, 0, (_input/100*_distPerTick * _engineModifier)]; 
	// In order to prevent floating point errors, we work with the input at a factor of 10x what is is. We *could* fix this with a toFixed
	// However, toFixed outputs a string, which we then need to parse. A simple math equation should be faster.

	// Convert to world-space
	private _worldOffset = 
	[
	    (_offset select 0) * (_right select 0) + (_offset select 1) * (_up select 0) + (_offset select 2) * (_dir select 0),
	    (_offset select 0) * (_right select 1) + (_offset select 1) * (_up select 1) + (_offset select 2) * (_dir select 1),
	    (_offset select 0) * (_right select 2) + (_offset select 1) * (_up select 2) + (_offset select 2) * (_dir select 2)
	];

	// This is essentially what modelToWorld does but I do it wil a position. ChatGPT actually made good code for once???????????? (it definitely stole it from somewhere)
	_pos = _pos vectorAdd _worldOffset;
	_ship setPosWorld _pos;
	_args set [2, _pos]; // Update our position
	if !(_alive) then {
		[_handle] call CBA_fnc_removePerFrameHandler;
	};
},SB_interval,[_ship, _distPerTick, _pos]] call CBA_fnc_addPerFrameHandler;

