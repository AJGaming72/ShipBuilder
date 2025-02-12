/*
	destroyShip
	
	This function makes a cinematic ship destruction
	
	Arguments:
	_ship: The ship object
	
	TODO: 

    Run on server
*/
params ["_ship"];
if (!isServer) exitWith {};
_ship setVariable ["SB_thrustCommand", 0.05, true];
_ship setVariable ["SB_rotationInput", [0, -0.25, 0], true];
_ship setVariable ["SB_isDying", true, true];
_ship setVariable ["SB_engineModifier", 1, true]; 
private _explosionPoints = _ship getVariable ["SB_explosionPoints", []];
private _intExplosionPoints = _ship getVariable ["SB_intExplosionPoints", []];

[_ship] execVM "Scripts\intShipDestructionEffects.sqf"; // Should be called on ALL machines

_ship setVariable ["SB_Fires", [], true];

{
    private _delay = floor random 30;
    [{    
    private _pos = ASLToATL (AGLToASL ((_this select 1) modelToWorld (_this select 0)));
    private _bomb = createVehicle ["Bo_GBU12_LGB_MI10", _pos, [], 0, "CAN_COLLIDE"];
    triggerAmmo _bomb;
    private _fire = createVehicle ["test_EmptyObjectForFireBig", _pos, [], 0, "CAN_COLLIDE"];
    private _fires = (_this select 1) getVariable ["SB_Fires", []];
    _fires pushBack _fire;
    (_this select 1) setVariable ["SB_fires", _fires, true];
    [_fire, (_this select 1)] call BIS_fnc_attachToRelative;
    }, [_x, _ship], _delay] call CBA_fnc_waitAndExecute;
} forEach _explosionPoints; // This runs the script that handles the explosion points on the exterior of the ship

{
    private _delay = floor random 30;
    [{    
    private _pos = (_this select 0);
    private _bomb = createVehicle ["Rocket_04_HE_F", _pos, [], 0, "CAN_COLLIDE"];
    triggerAmmo _bomb;
    // private _fire =  "#particlesource" createVehicleLocal _pos;
    // _fire setParticleClass "SmallDestructionFire";
    // _fire setPos _pos;

    // private _fires = (_this select 1) getVariable ["SB_intFires", []];

    // _fires pushBack _fire;
    // (_this select 1) setVariable ["SB_intFires", _fires];
    }, [_x, _ship], _delay] call CBA_fnc_waitAndExecute;
} forEach _intExplosionPoints; // This runs the script that handles the explosion points on the interior of the ship


private _fires = _ship getVariable ["SB_Fires", []];
waitUntil {(( getPosATL _ship) select 2) < 0};
{
    if ((( getPosATL _x) select 2) < 0) then {
        deleteVehicle _x;
    };
    // Current result is saved in variable _x
    
} forEach _fires;
[4] spawn BIS_fnc_earthquake;
_ship setVariable ["SB_alive", false];

