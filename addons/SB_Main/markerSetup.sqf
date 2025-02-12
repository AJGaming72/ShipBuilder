/*
	markerSetup   
	
	Handles making a marker and moving it
	
	Arguments:
	_ship: The ship object
	
	TODO: 
	Run on server
*/
params ["_ship"];
private _id = "SB_shipMarker" + ((_ship call BIS_fnc_netId) regexReplace ["[:]","_"]); // Should give us a unique ID for this marker
private _marker = createMarker [_id, position _ship]; 
_marker setMarkerShape "ICON";
_marker setMarkerType "mil_triangle";

private _alive = _ship getVariable ["SB_alive", false];
while {_alive} do {
    _id setMarkerPos _ship;
    _id setMarkerDir getDir _ship;
    _alive = _ship getVariable ["SB_alive", false];
    sleep 1;
};