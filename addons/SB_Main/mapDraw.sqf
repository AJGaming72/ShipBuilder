private _map = _this select 0;
private _ship = _map getVariable "SB_ship";
private _zoom = _map getVariable ["SB_mapZoom", 0.3];
_map ctrlMapAnimAdd [0, _zoom, _ship];
ctrlMapAnimCommit _map;
