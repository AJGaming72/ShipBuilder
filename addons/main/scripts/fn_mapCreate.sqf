/*
	mapCreate   
	
	Handles making a map 
	
	Arguments:
	_screen: The screen object to display on
	
	TODO: 
    Make this work when there are multiple screens. The _id is not going to be friendly to creating multiple (Make it work on just the active ship?)
	Run on player + JIP (I think?)
*/
params ["_screen", "_ship", ["_dimensions", [1,1]]];
private _id = "SB_shipMap" + ((_screen call BIS_fnc_netId) regexReplace ["[:]","_"]); // Should give us a unique ID for this screen
_screen setObjectTexture [0,"#(rgb,1024,1024,1)ui(RscDisplayEmpty," + _id + ")"];
waitUntil { !isNull (findDisplay _id);};
private _display = findDisplay _id;

private _map = _display ctrlCreate ["RscMapControl", 1];

_map ctrlSetPosition [0, 0, 1, 1];
_map ctrlCommit 0;
_map ctrlMapSetPosition [0, 0, _dimensions select 0, _dimensions select 1]; 

_map setVariable ["SB_mapZoom", 0.3]; // Default map zoom of 0.3
_map setVariable ["SB_ship", _ship];
_screen setVariable ["SB_map", _map]; // zero need to send this to other computers

_screen addAction ["Zoom in",{
    params ["_target", "_caller", "_actionId", "_arguments"];
    private _map = _target getVariable "SB_map";
    private _zoom = _map getVariable ["SB_mapZoom", 0.3];
    _zoom = parseNumber ((_zoom - 0.1) toFixed 1);
    if (_zoom < 0.1) then {
        _zoom = 0.1;
    };
    _map setVariable ["SB_mapZoom", _zoom];
}];
_screen addAction ["Zoom out",{
    params ["_target", "_caller", "_actionId", "_arguments"];
    private _map = _target getVariable "SB_map";
    private _zoom = _map getVariable ["SB_mapZoom", 0.3];
    _zoom = parseNumber ((_zoom + 0.1) toFixed 1);
        if (_zoom > 1) then {
        _zoom = 1;
    };
    _map setVariable ["SB_mapZoom", _zoom];

}];
private _alive = _ship getVariable ["SB_alive", false];

_map ctrlAddEventHandler ["Draw", {
    _this execVM "Scripts\mapDraw.sqf";
}];
while {_alive} do {
    displayUpdate _display;
    _alive = _ship getVariable ["SB_alive", false];
    sleep 1;    
};
