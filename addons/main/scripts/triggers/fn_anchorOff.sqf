/*
	anchorOff
	
	Handles anchor off for the triggers
	
	Arguments:
	_ship: Ship object

	TODO: 

	Run on player
*/
params ["_ship"];
if !(hasInterface) exitWith {};
{
    private _posOffset = _x getVariable ["SB_posOffset",[0,0,0]];
    _x attachTo [_ship, _posOffset];
} forEach (_ship getVariable ["SB_exteriorHangarTriggers",[]]); // Reattach the triggers so they follow the ship
{
    [_x,_ship] call BIS_fnc_attachToRelative;
} forEach (_ship getVariable ["SB_fires",[]]); // Reattach the Fires so they follow the ship
