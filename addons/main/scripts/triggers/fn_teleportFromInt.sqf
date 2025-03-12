/*
	teleportFromInt
	
	Handles teleporting player / player vehicle from the inside to the outside of the ship
	
	Arguments:
	_self: Trigger
	
	TODO: 
    wiggleRoom should be a CBA setting
    Direction checking should be a setting (For vertical hangars)

	Run on player
*/
if !(hasInterface) exitWith {};
params ["_self", "_connectedTrigger", "_ship"];
private _triggerCone = _self getVariable ["SB_triggerCone", -1];
private _triggerArea = triggerArea _self;
private _triggerAngle = _triggerArea select 2;
private _length = _triggerArea select 0;
private _width = _triggerArea select 1;
private _height = _triggerArea select 4;


if (_triggerCone < 0) then { 
    // We are getting the angle from the centerpoint out to the corners of the trigger, like if you were to draw an X in the middle of the trigger
    // This lets will let us see if the user exited in a direction within this range, effectively letting us see which side they exited from.
    _triggerCone = acos ((_width^2 - _length^2)/(_width^2 + _length^2));
    _self setVariable ["SB_triggerCone", _triggerCone, true];
};

private _dir = (_self getRelDir (getPos player)) - _triggerAngle;
if (_dir < 0) then {
    _dir = _dir + 360;
};

private _wiggleRoom = 5;
private _minBound = (360 - (_triggerCone / 2)) - _wiggleRoom;
private _maxBound = (_triggerCone / 2) + _wiggleRoom;



// If the player has exited outside our bounds, we don't do any more here.
if (_dir < _minBound && _dir > _maxBound) exitWith {}; 

private _veh = vehicle player;
private _ctAngle = ((triggerArea _connectedTrigger) select 2) + getDir _connectedTrigger;
_veh setDir (_ctAngle + getDir _veh - _triggerAngle);

private _offset = _self worldToModel ASLToAGL getPosASL _veh;
// Width, Length, Height
private _offsetPercentage = [
    ((_offset select 0) / _width) * -1,// These values become inverted during the teleport
    ((_offset select 1) / _length) * -1,// These values become inverted during the teleport
    (_offset select 2) / _height
    ];

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

private _mps = _ship getVariable ["SB_mps", 0];
private _input = _ship getVariable ["SB_thrustInput", 0];
private _rot = _ship getVariable ["SB_rotation", [0, 0, 0]];
_mps = _mps * _input / 100;
private _pitch = rad (_rot select 1);
private _yaw = rad (_rot select 0);
_veh setVelocity [
    _mps * sin (_yaw),
    _mps * cos (_yaw),
    _mps * sin (_pitch)
];

_veh setVariable ["SB_exitedInt", true, true];
[{_this setVariable ["SB_exitedInt", false, true];}, _veh, 5] call CBA_fnc_waitAndExecute; // 5 Second leeway for them to leave the area