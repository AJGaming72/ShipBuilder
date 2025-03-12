/*
	turretRC_EH
	
	Handles running a check to see if the user has stopped remote controlling the unit.

	Arguments:
	_turret: This is the turret the player is controlling
	
	TODO: 

	Run on player
*/
params ["_turret"];
private _ship = _turret getVariable "SB_ship";
waitUntil {sleep 1;
private _t = ((remoteControlled player) isNotEqualTo ((crew _turret) select 0));
if (isNil "_t") exitWith {true}; // I hate everything about this line of code.
// isNotEqualTo returns nothing if one of the variable is nil. Because of this, we have to check above if it has been instantiated.
// I don't think its *bad* per se, but it doesn't read well if you don't understand the weird quirk of the comparison.
_t;
};

private _handle = _turret getVariable "SB_turretRCHandler";
if !(isNil "_handle") then {
	_turret removeEventHandler ["GetOut", _handle];
};
_turret setVariable ["SB_turretAvailable", true, true];
