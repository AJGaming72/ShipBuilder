/*
	turretSetupLocal
	Handles setting up the turret for use in the ship in the local environment
	
	Arguments:
	_controller: This is the seat or console used to access the turret
	_turret: This is the turret the player wants to get in to
	
	TODO: 
	Add toggle for the particular move


	Run Per player + JIP
*/
if !(hasInterface) exitWith {}; // Only allow players.
params ["_controller", "_turret"];
_controller addAction ["Get in turret",
{
	params ["_target", "_caller", "_actionId", "_arguments"];
	[_caller, (_arguments select 0)] call SB_fnc_turretGetIn;
	_caller switchMove "AmovPsitMstpSnonWnonDnon_ground";
}, [_turret]];