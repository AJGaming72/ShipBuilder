/*
	turretGetIn
	
	Handles putting a user in a turret from a remote location. This is so we can make chairs and consoles be the point from which we get in a turret remotely.
	
	Arguments:
	_user: This is the player that wants to get in the turret
	_turret: This is the turret the player wants to get in to
	
	TODO: 
	Add an option to kill the player if the turret unit dies 
	Forcibly stop remote controlling unit when turret / unit dies as a backup for if user gets stuck in turret.
	Player check doesn't seem to work.

	Run on player
*/
if !(hasInterface) exitWith {};
params ["_user", "_turret"];
// Make certain the turret is not currently controlled by a player
private _playerControlled = false;
{
	if (isPlayer (_x select 0)) then {
		_playerControlled = true;
	};
} forEach (fullCrew _turret);
if (_playerControlled) exitWith {
	systemChat "Player controlling turret already!"
};
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
	// Remove the AI controlling the turret when the user exits it
	private _handle = [_unit, _user] spawn {
		private _unit = _this select 0;
		private _user = _this select 1;
		waitUntil { sleep 1; (focusOn isNotEqualTo _user); };
		_unit setDamage 1;
		deleteVehicle _unit;
	};
	_turret addEventHandler ["GetOut", {
		params ["_vehicle", "_role", "_unit", "_turret", "_isEject"];
		_unit setDamage 1;
		deleteVehicle _unit;
		_vehicle removeEventHandler [_thisEvent, _thisEventHandler]; // Remove the event handler so a non-remote user doesn't delete a player. I don't even think I can do that?
	}];
	_unit setUnitLoadout getUnitLoadout _user; // Make the unit look like our user
};

// Actually remoteControl the turret
_turret switchCamera "INTERNAL";
_user remoteControl _turret;