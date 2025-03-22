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
private _side = side player;
// if the turret does not have a crew, we need to add it
private _unit = 0; // Instantiate this variable so we can use it outside of the scope of the if
private _grp = createGroup (side player);
if (count (crew _turret) == 0) then {
	_unit = _grp createUnit ["SB_turretAI", [0,0,0], [], 0, "NONE"];
	_unit moveInGunner _turret;
} else {
	_unit = ((crew _turret) select 0);
};// createVehicleCrew gave me some issues here. Didn't seem to like transferring the Unit along the network?
[_unit] joinSilent _grp;
private _handle = _turret addEventHandler ["GetOut", {
	params ["_vehicle", "_role", "_unit", "_turret", "_isEject"];
	player remoteControl objNull;
	switchCamera player;
	// Just remove the RC
}];
// If user opens zeus while we are remote controlling, it can break the RC. 
private _zHandle = findDisplay 46 displayAddEventHandler ["KeyDown", {
	if (inputAction "CuratorInterface" > 0) then
	{
			player remoteControl objNull;
			switchCamera player;
	};
	false
}];

_turret setVariable ["SB_turretRCHandler", _handle];
_turret setVariable ["SB_turretZHandler", _zHandle];
_turret setVariable ["SB_turretUnit", _unit, true];
_unit setUnitLoadout getUnitLoadout _user; // Make the unit look like our user

_turret setVariable ["SB_turretAvailable", false, true];
// Actually remoteControl the turret
_unit switchCamera "INTERNAL";
_user remoteControl _unit;
// We add a function to check if the user stops remote controlling. unfortunately, there is NOT an event handler for this. :(
[_turret] spawn SB_fnc_turretRC_EH;