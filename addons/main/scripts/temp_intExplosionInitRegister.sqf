params ["_self", "_ship"];
if (!isServer) exitWith {};
isNil {[_self, _ship] call compile preprocessFileLineNumbers 'Scripts\intExplosionPointRegister.sqf';};