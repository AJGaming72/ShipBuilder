/*
	intShipDestructionEffects
	
	This function makes the interior of the ship cinematic ship destruction
	
	Arguments:
	_ship: The ship object
	
	TODO: 

    Run on player
*/
if !(hasInterface) exitWith {};// Cringe not having an interface
params ["_ship"];
private _playerShip = player getVariable ["SB_ship", -1];
if (_playerShip isNotEqualTo _ship) exitWith {}; // Not in the ship

private _priority = 1500;
private _colorCorrectionHandle = -1;
private _inShip = 0; // Should be changed to a variable local to the player, doesn't need to be transmitted over network

while
{
	_colorCorrectionHandle = ppEffectCreate ["ColorCorrections", _priority];
	_colorCorrectionHandle < 0;
} do {
	_priority = _priority + 1;
};
_colorCorrectionHandle ppEffectEnable true;


private _lightsOnEffect = [1, 1, 0, [0, 0, 0, 0], [0.35, 0.1, 0.1, 0.2], [1, 1, 1, 0]];
private _lightsOffEffect = [0.6, 1, 0, [0, 0, 0, 0], [0.4, 0.1, 0.1, 0.6], [1, 1, 1, 0]];
private _defaultEffect = [1,1,0,[0, 0, 0, 0],[1, 1, 1, 1],[0.299, 0.587, 0.114, 0],[-1, -1, 0, 0, 0, 0, 0]];

while {_playerShip isEqualTo _ship} do {
    playSoundUI ["Alarm", 0.8, 1];

    private  _shake = floor random 4;
    if (_shake == 1) then {
        addCamShake [(floor random 20), 8, 25];
    };


    _colorCorrectionhandle ppEffectAdjust _lightsOnEffect;
    _colorCorrectionHandle ppEffectCommit 1;
    uiSleep 2;
    _colorCorrectionhandle ppEffectAdjust _lightsOffEffect;
    _colorCorrectionHandle ppEffectCommit 1;
    uiSleep 2;

    _playerShip = player getVariable "SB_ship";
};
_colorCorrectionhandle ppEffectAdjust _defaultEffect;
_colorCorrectionHandle ppEffectCommit 1;
uiSleep 1;
_colorCorrectionHandle ppEffectEnable false;
ppEffectDestroy _colorCorrectionHandle;