params ["_self", "_ship"];
isNil {[_self, _ship] call compile preprocessFileLineNumbers 'Scripts\explosionPointRegister.sqf';};