/*
	anchorOn
	
	Handles anchor on for the triggers
	
	Arguments:
	_ship: Ship object

	TODO: 

	Run on player
*/
params ["_ship"];
if !(hasInterface) exitWith {};
{
    detach _x;
} forEach (_ship getVariable ["SB_exteriorHangarTriggers",[]]); // Detach the triggers so they can still be active