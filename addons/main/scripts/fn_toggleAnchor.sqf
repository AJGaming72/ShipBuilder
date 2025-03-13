/*
	toggleAnchor
	
	Handles the anchoring of the ship
	
	Arguments:
	_ship: The ship object
	
	TODO: 

	Run on player
*/
params ["_ship"];
// Make sure user cant abuse this function.
if (_ship getVariable ["SB_isDying",false]) exitWith {systemChat "Ship cannot be controlled: Dying";};// If we are dying, remove ability to control
if ((_ship getVariable ["SB_thrustInput",0])isNotEqualTo 0) exitWith {systemChat "Ship must be stopped to anchor.";};
if ((_ship getVariable ["SB_rotationInput", [0,0,0]]) isNotEqualTo [0,0,0]) exitWith {systemChat "Ship must be stopped to anchor.";};

private _alive = _ship getVariable ["SB_alive", false];
private _active = _ship getVariable ["SB_active", false];
if (_alive && _active) then { // If the anchor is OFF
    {
        detach _x;
    } forEach (_ship getVariable ["SB_exteriorHangarTriggers",[]]); // Detach the triggers so they can still be active

    _ship enableSimulationGlobal false; // So our ship stops in place.
    _ship setVariable ["SB_active", false, true];
    [_ship getVariable "SB_thrustHandler"] call CBA_fnc_removePerFrameHandler; // We remove the PFH's from outside the loop to save performance
    [_ship getVariable "SB_rotationHandler"] call CBA_fnc_removePerFrameHandler; // We remove the PFH's from outside the loop to save performance
    private _turrets = _ship getVariable ["SB_turrets",[]];
    {
        // Remove the remote control from each of the turrets.
        {
            objNull remoteControl _x;
        }forEach crew _x;
    } forEach _turrets;
    systemChat "Anchored";
} else{ if (_alive && !_active) then { // If the anchor is ON
    // _ship, _speed
    _ship enableSimulationGlobal true; // Allow the attached objects to follow our ship
    {
        private _posOffset = _x getVariable ["SB_posOffset",[0,0,0]];
        _x attachTo [_ship, _posOffset];
    } forEach (_ship getVariable ["SB_exteriorHangarTriggers",[]]); // Reattach the triggers so they follow the ship

    _ship setVariable ["SB_active", true, true];
    [_ship, _ship getVariable ["SB_shipSpeed",120]] call SB_fnc_shipThrustHandler;
    [_ship, _ship getVariable ["SB_shipRotationSpeed",3]] call SB_fnc_shipRotationHandler;
    systemChat "Anchor Removed";
};};