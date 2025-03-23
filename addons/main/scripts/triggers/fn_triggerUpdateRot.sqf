/*
	triggerUpdateRot
	
	Rotates the trigger while the ship rotates
	
	Arguments:
	
	TODO: 

	Run on trigger condition / Player
*/
if !(hasInterface) exitWith {};
params ["_trigger"];
private _triggerDefRot = _trigger getVariable ["SB_triggerDefRot", -1];
private _triggerArea = triggerArea _trigger;
private _arrow = _trigger getVariable "SB_arrow";
_trigger setTriggerArea [_triggerArea select 0, _triggerArea select 1, getDir _arrow, _triggerArea select 3, _triggerArea select 4];
