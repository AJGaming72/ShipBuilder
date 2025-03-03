/*
	escapePodAction
	
	Handles the addAction for the escape Pod.
	
	Arguments:
    _ship: The ship object
	_escapePod: The escape pod object
	_offset: The escape pod point

	TODO: 
	
	Run on player
*/
if !(hasInterface) exitWith {};
params ["_ship", "_escapePod", "_offset"];
_escapePod addAction ["Launch Escape Pod",{
	params ["_target", "_caller", "_actionId", "_arguments"];
	[_target, (_arguments select 0),(_arguments select 1)] call SB_fnc_escapePodLaunch;
}, [_offset, _ship],1.5,true,true,"","(_target getVariable ['SB_escapePodAvailable',false])"];