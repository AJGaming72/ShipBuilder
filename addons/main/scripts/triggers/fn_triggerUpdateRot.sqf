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
if (_triggerDefRot < 0) then {
    _triggerDefRot = _triggerArea select 2;
    _trigger setVariable ["SB_triggerDefRot", _triggerDefRot, false]; // This keeps us from having floating point errors start to occur
}; 
private _newRot = (getDir _trigger) + _triggerDefRot;
_trigger setTriggerArea [_triggerArea select 0, _triggerArea select 1, _newRot, _triggerArea select 3, _triggerArea select 4];
