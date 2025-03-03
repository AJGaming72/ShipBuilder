/*
	turretRC_EH
	
	Handles running a check to see if the user has stopped remote controlling the unit.

	Arguments:
	_turret: This is the turret the player is controlling
	
	TODO: 

	Run on player
*/
params ["_turret"];
waitUntil {sleep 1;(remoteControlled player) isNotEqualTo ((crew _turret) select 0); };

private _handle = _turret getVariable "SB_turretRCHandler";
if !(isNil _handle) then {
	_turret removeEventHandler ["GetOut", _handle];
};
_turret setVariable ["SB_turretAvailable", true, true];
