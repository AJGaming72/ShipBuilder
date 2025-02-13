/*
	shipControllerSetup
	
	Handles the setup of the ship's controller
	
	Arguments:
	_ship: The ship object
	_controller: The object that control the ship
	
	TODO: 

	Run on player
	
*/
params ["_ship","_controller"];
if !(hasInterface) exitWith {};
_controller setVariable ["SB_ship", _ship];
_controller addAction ["Forward", {
	params ["_target", "_caller", "_actionId", "_arguments"];
	[(_target getVariable "SB_ship"), 1, [0, 0, 0]] call SB_fnc_shipCommandMovement;
}];
_controller addAction ["Backward", {
	params ["_target", "_caller", "_actionId", "_arguments"];
	[(_target getVariable "SB_ship"), -1, [0, 0, 0]] call SB_fnc_shipCommandMovement;
}];
_controller addAction ["PitchUp", {
	params ["_target", "_caller", "_actionId", "_arguments"];
	[(_target getVariable "SB_ship"), 0, [0, 1, 0]] call SB_fnc_shipCommandMovement;
}];
_controller addAction ["PitchDown", {
	params ["_target", "_caller", "_actionId", "_arguments"];
	[(_target getVariable "SB_ship"), 0, [0, -1, 0]] call SB_fnc_shipCommandMovement;
}];
_controller addAction ["YawRight", {
	params ["_target", "_caller", "_actionId", "_arguments"];
	[(_target getVariable "SB_ship"), 0, [1, 0, 0]] call SB_fnc_shipCommandMovement;
}];
_controller addAction ["YawLeft", {
	params ["_target", "_caller", "_actionId", "_arguments"];
	[(_target getVariable "SB_ship"), 0, [-1, 0, 0]] call SB_fnc_shipCommandMovement;
}];