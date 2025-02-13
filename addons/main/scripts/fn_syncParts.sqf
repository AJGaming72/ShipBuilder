// Run on server
params ["_ship", "_hitpoints"];
if (!isServer) exitWith {};
_ship setVariable ["SB_numEngines", 0, true];
{
	private _engines = _ship getVariable ["SB_numEngines", 0];
	private _type = _x getVariable ["SB_hitpointType", ""];
	if (_type == "engine") then {
		_ship setVariable ["SB_numEngines", (_engines + 1), true];
	};
} forEach (_hitpoints);