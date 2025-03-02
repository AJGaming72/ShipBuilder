// #include "\a3\ui_f\hpp\definedikcodes.inc"
// Not sure whats going on with the include?
#define DIK_W 17
#define DIK_S 31
#define DIK_A 30
#define DIK_D 32
#define DIK_E 18
#define DIK_Q 16
#define DIK_F 33



["Shipbuilder","SB_shipForward", "Command Backward", {
    if ((vehicle player) getVariable ["SB_chair",false]) then {
        [((vehicle player) getVariable "SB_ship"), 1, [0, 0, 0]] call SB_fnc_shipCommandMovement;
    };        
},"",[DIK_E,[false,false,false]],false] call CBA_fnc_addKeybind;

["Shipbuilder","SB_shipBackward", "Command Backward", {
    if ((vehicle player) getVariable ["SB_chair",false]) then {
        [((vehicle player) getVariable "SB_ship"), -1, [0, 0, 0]] call SB_fnc_shipCommandMovement;
    };        
},"",[DIK_Q,[false,false,false]],false] call CBA_fnc_addKeybind;

["Shipbuilder","SB_shipUp", "Command Pitch Up", {
    if ((vehicle player) getVariable ["SB_chair",false]) then {
        [((vehicle player) getVariable "SB_ship"), 0, [0, 1, 0]] call SB_fnc_shipCommandMovement;
    };        
},{
   if ((vehicle player) getVariable ["SB_chair",false]) then {
        [((vehicle player) getVariable "SB_ship"), 0, [0, -1, 0]] call SB_fnc_shipCommandMovement;
    };     
},[DIK_S,[false,false,false]],false] call CBA_fnc_addKeybind;

["Shipbuilder","SB_shipDown", "Command Pitch Down", {
    if ((vehicle player) getVariable ["SB_chair",false]) then {
        [((vehicle player) getVariable "SB_ship"), 0, [0, -1, 0]] call SB_fnc_shipCommandMovement;
    };        
},{
   if ((vehicle player) getVariable ["SB_chair",false]) then {
        [((vehicle player) getVariable "SB_ship"), 0, [0, 1, 0]] call SB_fnc_shipCommandMovement;
    };     
},[DIK_W,[false,false,false]],false] call CBA_fnc_addKeybind;

["Shipbuilder","SB_shipLeft", "Command Yaw Left", {
    if ((vehicle player) getVariable ["SB_chair",false]) then {
        [((vehicle player) getVariable "SB_ship"), 0, [-1, 0, 0]] call SB_fnc_shipCommandMovement;
    };        
},{
   if ((vehicle player) getVariable ["SB_chair",false]) then {
        [((vehicle player) getVariable "SB_ship"), 0, [1, 0, 0]] call SB_fnc_shipCommandMovement;
    };     
},[DIK_A,[false,false,false]],false] call CBA_fnc_addKeybind;

["Shipbuilder","SB_shipRight", "Command Yaw Right", {
    if ((vehicle player) getVariable ["SB_chair",false]) then {
        [((vehicle player) getVariable "SB_ship"), 0, [1, 0, 0]] call SB_fnc_shipCommandMovement;
    };        
},{
   if ((vehicle player) getVariable ["SB_chair",false]) then {
        [((vehicle player) getVariable "SB_ship"), 0, [-1, 0, 0]] call SB_fnc_shipCommandMovement;
    };     
},[DIK_D,[false,false,false]],false] call CBA_fnc_addKeybind;

["Shipbuilder","SB_toggleAnchor", "Toggle Anchor", {
    if ((vehicle player) getVariable ["SB_chair",false]) then {
        [((vehicle player) getVariable "SB_ship")] call SB_fnc_toggleAnchor;
    };        
},"",[DIK_F,[false,false,false]],false] call CBA_fnc_addKeybind;

