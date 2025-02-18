/*
	mapDraw  
	
	Handles drawing on the map
	
	Arguments:
	_this: The screen object to display on
	
	TODO: 

    Run on player
*/
// No need to check if run on player, as it will be called from a function only running on players.
params ["_map"];
private _ship = _map getVariable "SB_ship";
private _zoom = _map getVariable ["SB_mapZoom", 0.3];
_map ctrlMapAnimAdd [0, _zoom, _ship];
ctrlMapAnimCommit _map;
