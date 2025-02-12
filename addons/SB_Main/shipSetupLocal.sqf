/*
	shipSetupLocal
	
	Handles the Rotation of a ship
	
	Arguments:
	_ship: The ship object
	_actorClass: The class of the ship actor
	_controller: The object that control the ship
	
	TODO: 

	Run on player
	
*/
params ["_ship","_controller"];
private _shipActor = (_ship getVariable "SB_actorClass") createVehicleLocal (getPos _ship);
_shipActor attachTo [_ship, [0,0,0]];
_ship setVariable ["SB_shipActor", _shipActor, false]; // We create the vehicle locally because really there's no reason to have it not be local, should be slightly better performance wise. Might be unnecessary.
_controller setVariable ["SB_ship", _ship, true];
_controller addAction ["Forward", {
	params ["_target", "_caller", "_actionId", "_arguments"];
	[(_target getVariable "SB_ship"), 1, [0, 0, 0]] execVM "Scripts\shipCommandMovement.sqf";
}];
_controller addAction ["Backward", {
	params ["_target", "_caller", "_actionId", "_arguments"];
	[(_target getVariable "SB_ship"), -1, [0, 0, 0]] execVM "Scripts\shipCommandMovement.sqf";
}];
_controller addAction ["PitchUp", {
	params ["_target", "_caller", "_actionId", "_arguments"];
	[(_target getVariable "SB_ship"), 0, [0, 1, 0]] execVM "Scripts\shipCommandMovement.sqf";
}];
_controller addAction ["PitchDown", {
	params ["_target", "_caller", "_actionId", "_arguments"];
	[(_target getVariable "SB_ship"), 0, [0, -1, 0]] execVM "Scripts\shipCommandMovement.sqf";
}];
_controller addAction ["YawRight", {
	params ["_target", "_caller", "_actionId", "_arguments"];
	[(_target getVariable "SB_ship"), 0, [1, 0, 0]] execVM "Scripts\shipCommandMovement.sqf";
}];
_controller addAction ["YawLeft", {
	params ["_target", "_caller", "_actionId", "_arguments"];
	[(_target getVariable "SB_ship"), 0, [-1, 0, 0]] execVM "Scripts\shipCommandMovement.sqf";
}];