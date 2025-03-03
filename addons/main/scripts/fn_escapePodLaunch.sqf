/*
	escapePodLaunch
	
	This script launches an escape pod
	
	Arguments:
	_offset: The escape pod point
	_escapePod: The escape pod object
    _ship: The ship object

	TODO: 
	
	Run on player
*/
if (!hasInterface) exitWith {};
params["_escapePod","_offset","_ship","_actionId"];
_escapePod setPosASL (AGLToASL (_ship modelToWorld (_offset select 0))); // Convert our offset from model space to world space
_escapePod setVectorDir (_ship vectorModelToWorld (_offset select 1)); // Convert our direction from model space to world space
_escapePod setVelocityModelSpace [0, 50, 0]; // Launch the pod with some speed

_escapePod setVariable ["SB_escapePodAvailable",false,true]; // This stops the user from being able to access the escape pod action.