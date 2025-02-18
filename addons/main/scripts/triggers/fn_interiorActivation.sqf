/*
	interiorActivation
	
	Updates the player to show that they are inside the ship.
	
	Arguments:
	_ship: Ship object

	TODO: 

	Run on player
*/
if !(hasInterface) exitWith {};
params ["_ship"];
player setVariable ["SB_ship", _ship, true];
if (_ship getVariable ["SB_isDying", false]) then {
    [_ship] spawn SB_fnc_intShipDestructionEffects;
}; // Activate our death script if they are in the interior.