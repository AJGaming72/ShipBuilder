/*
	teleportFromExt
	
	Handles teleporting player / player vehicle from the Outside to the Inside of the ship
	
	Arguments:
	_self: Trigger
	_connectedTrigger: Trigger paired to this one

	TODO: 

	Run on player
*/
if !(hasInterface) exitWith {};
params ["_self", "_connectedTrigger"];
private _veh = vehicle player;
if (_veh getVariable ["SB_exitedInt", false]) exitWith {};
private _triggerArea = triggerArea _self;
private _length = _triggerArea select 0;
private _width = _triggerArea select 1;
private _height = _triggerArea select 4;
private _triggerAngle = triggerArea _self select 2;

private _ctAngle = ((triggerArea _connectedTrigger) select 2) + getDir _connectedTrigger;

_veh setDir (_ctAngle + getDir _veh - _triggerAngle);

private _offset = _self worldToModel ASLToAGL getPosASL _veh;
// Width, Length, Height
private _offsetPercentage = [
    ((_offset select 0) / _width),// These values become inverted during the teleport
    ((_offset select 1) / _length) * -1,// These values become inverted during the teleport
    (_offset select 2) / _height
    ];
_offsetPercentage = _offsetPercentage vectorMultiply 0.75; // Now, it is 3/4ths of the size. This means that there is less of a chance that we will clip into walls

private _conTriggerArea = triggerArea _connectedTrigger;
private _conLength = _conTriggerArea select 0;
private _conWidth = _conTriggerArea select 1;
private _conHeight = _conTriggerArea select 4;

private _newOffset = [
    (_offsetPercentage select 1) * _conLength,
    (_offsetPercentage select 0) * _conWidth,
    (_offsetPercentage select 2) * _conHeight
];

_veh setPosASL (AGLToASL (_connectedTrigger modelToWorld _newOffset));

// Find size of trigger
// Find difference in position from trigger to vehicle
// Express these points as a percentage, then bring it 25% closer to center so we don't clip into walls 
// Move the ship based on the offset 

