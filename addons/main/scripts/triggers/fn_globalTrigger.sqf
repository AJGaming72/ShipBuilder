/*
	globalTrigger
	
	Makes sure that our triggers get added to the JIP queue
	
	Arguments:
	_pos: Position of the ship
    _activation: Activation statement
    _statements: Statement Statement
    _area: Area of the trigger
    _name: Name of the trigger in the mission namespace
    _offset: [Position Offset, dir, Object to attach to]

	TODO: 

	Run on player
*/
if !(hasInterface) exitWith {};
params ["_module","_arrow", "_pos","_activation","_statements","_area", ["_name",-1], ["_offset", -1],["_ship",-1]];
private _trigger = createTrigger ["EmptyDetector", [0,0,0], false]; // Because this is used in other scripts, we actually need the trigger created on the server here.
// Because module areas are measured from the CENTER, and triggers are measured from the BOTTOM, we have to offset the trigger, and then we have to double the height.
private _heightOffset = _area select 4;
_pos = [_pos select 0, _pos select 1, (_pos select 2) - _heightOffset];
_area set [4, _heightOffset*2];
_trigger setVariable ["SB_arrow", _arrow, false];
_trigger setPosASL _pos;
_trigger setTriggerActivation _activation;
_trigger setTriggerStatements _statements;
_trigger setTriggerArea _area;
if (_name isNotEqualTo -1) then {
    missionNamespace setVariable [_name, _trigger,false];
};
if (_offset isNotEqualTo -1) then {
    private _posOffset = _offset select 0;
    _posOffset set [2, ((_posOffset select 2) - _heightOffset)];
    private _dir = _offset select 1;
    private _ship = _offset select 2;
    _trigger attachTo [_ship,_posOffset];
    _trigger setVariable ["SB_posOffset", _posOffset];
    _area set [2,_dir];
    _arrow setDir (_area select 2);
    [_arrow, _trigger] call BIS_fnc_attachToRelative;
    private _hangarTriggers = _ship getVariable ["SB_exteriorHangarTriggers",[]];
    _hangarTriggers pushBackUnique _trigger;
    _ship setVariable ["SB_exteriorHangarTriggers",_hangarTriggers];

    _trigger setTriggerArea _area;
};