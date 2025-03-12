/*
	turretGetIn
	
	Handles putting a user in a turret from a remote location. This is so we can make chairs and consoles be the point from which we get in a turret remotely.
	
	Arguments:
	_user: This is the player that wants to get in the turret
	_turret: This is the turret the player wants to get in to
	
	TODO: 
	Add an option to kill the player if the turret unit dies 
	Forcibly stop remote controlling unit when turret / unit dies as a backup for if user gets stuck in turret.

	Run on player
*/
if !(hasInterface) exitWith {};
params ["_user", "_turret"];
private _ship = _turret getVariable "SB_ship";
if !(_turret getVariable ["SB_turretAvailable",false]) exitWith {systemChat "Turret is not available";};
if !(_ship getVariable "SB_active") exitWith {systemChat "Turrets safe while anchored.";};
// Make the turret be on the correct team
private _grp = createGroup (side _user);
_grp deleteGroupWhenEmpty true;
[_turret] joinSilent _grp;
// if the turret does not have a crew, we need to add it
if (count (crew _turret) == 0) then {
	// Create a unit and put them in our group
	private _unit = _grp createUnit ["C_man_1", [0, 0, 0], [], 0, "NONE"];
	[_unit] joinSilent _grp;
	_unit moveInAny _turret;
	// if the user exits the turret, we can just kill their unit.
	private _handle = _turret addEventHandler ["GetOut", {
		params ["_vehicle", "_role", "_unit", "_turret", "_isEject"];
		_unit setDamage 1;
		deleteVehicle _unit;
	}];
	_turret setVariable ["SB_turretRCHandler", _handle];
	_unit setUnitLoadout getUnitLoadout _user; // Make the unit look like our user
};

// Actually remoteControl the turret
_turret setVariable ["SB_turretAvailable", false, true];
_turret switchCamera "INTERNAL";
_user remoteControl ((crew _turret) select 0);
// We add a function to check if the user stops remote controlling. unfortunately, there is NOT an event handler for this. :(
[_turret] spawn SB_fnc_turretRC_EH;