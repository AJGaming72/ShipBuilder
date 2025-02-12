// Run on server
if (!isServer) exitWith {};
params ["_ship"];
_ship setVariable ["SB_numEngines", 0, true];
{
	private _engines = _ship getVariable ["SB_numEngines", 0];
	private _type = _x getVariable ["SB_partType", ""];
	if (_type == "engine") then {
		_ship setVariable ["SB_numEngines", (_engines + 1), true];
	};
} forEach (attachedObjects _ship);