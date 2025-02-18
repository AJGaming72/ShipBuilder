/*
	hitPointRegister_EH
	
	This function handles the behavior when a ship's hitpoint is damaged.
	
	Arguments:
    _this select 0: https// community.bistudio.com/wiki/Arma_3:_Event_Handlers#HitPart
	
	TODO: 
	Add more special behaviors

	Run on player
*/
if (!hasInterface) exitWith {};
(_this select 0) params ["_target", "_shooter", "_projectile", "_position", "_velocity", "_selection", "_ammo", "_vector", "_radius", "_surfaceType", "_isDirect", "_instigator"];
if (isNull _target) exitWith {systemChat "hitPointRegister_EH late execution";}; 
private _ship = _target getVariable "SB_ship";
if (_ship getVariable ["SB_isDying",false]) exitWith {};// If we are dying, remove ability to damage

private _damage = (_ammo select !_isDirect); // THIS IS A WEIRD LINE OF CODE. isDirect returns 0 if it is direct, and 1 if not. 0 Is the ammo's hit damage, and 1 is the ammo's indirect hit damage.
private _health = _target getVariable ["SB_partHealth", 0];
_health = _health - _damage;
_target setVariable ["SB_partHealth", _health, true];
if (_health <= 0) then {
	private _type = _target getVariable ["SB_partType", ""];
	switch (_type) do {
		case "engine": {
			private _engineModifier = _ship getVariable ["SB_engineModifier", 1];
			private _numEngines = _ship getVariable ["SB_numEngines", 1];
			_ship setVariable ["SB_engineModifier", (_engineModifier - (1 / _numEngines)), true]; 
			diag_log (format["ShipBuilder: %1: Engine Destroyed", _ship]);
		};
		                // case "shield": {};
		                // case "cockpit": {};
	};
	deleteVehicle _target;
};