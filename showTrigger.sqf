MRH_fnc_drawTrigger =
{
	onEachFrame 
 {
_trigger = (getPos player) nearestObject "EmptyDetector";
if !(isNil _trigger) then {
    
_triggerPos = getPosATL _trigger;
_x = _triggerPos select 0;
_y = _triggerPos select 1;
_z = _triggerPos select 2;

_triggerSize = triggerArea _trigger;
_xsize = _triggerSize select 0;
_ysize = _triggerSize select 1;
_zsize = _triggerSize select 4;
_angle = _triggerSize select 2;

MRH_inside_fnc_rotatePoint = {
	
	params ["_pos","_angle","_center"];
	
	_x = _pos select 0;
	_y = _pos select 1;
	_a = _center select 0;
	_b = _center select 1;
	
	_xformat = _x - _a;
	_yformat = _y - _b;
	_newx = (_a + (_xformat * cos _angle)) + (_yformat* sin _angle);
	_newy = (_b - (_xformat * sin _angle)) + (_yformat* cos _angle);


	_newz = _pos select 2;
	[_newx,_newy,_newz]

	};


_isRectangle = _triggerSize select 3;

_color = [1,0,0,1];
if (triggerActivated _trigger) then {_color = [0,1,0,1]};

if (_isRectangle) then {
_posA = [(_x +_xsize),(_y - _ysize),_z];
_posB = [(_x +_xsize),(_y + _ysize),_z];
_posC = [(_x -_xsize),(_y + _ysize),_z];
_posD = [(_x -_xsize),(_y - _ysize),_z];


	
_posA = [_posA, _angle,_triggerPos] call MRH_inside_fnc_rotatePoint;
_posB = [_posB, _angle,_triggerPos] call MRH_inside_fnc_rotatePoint;
_posC = [_posC, _angle,_triggerPos] call MRH_inside_fnc_rotatePoint;
_posD = [_posD, _angle,_triggerPos] call MRH_inside_fnc_rotatePoint;

_posAd = [_posA select 0,_posA select 1,(_z+_zsize)];
_posBd = [_posB select 0,_posB select 1,(_z+_zsize)];
_posCd = [_posC select 0,_posC select 1,(_z+_zsize)];
_posDd = [_posD select 0,_posD select 1,(_z+_zsize)];

	 drawLine3D [_posA, _posB, _color];
	 drawLine3D [_posB, _posC, _color];
	 drawLine3D [_posC, _posD, _color];
	 drawLine3D [_posD, _posA, _color];

	 drawLine3D [_posAd, _posBd, _color];
	 drawLine3D [_posBd, _posCd, _color];
	 drawLine3D [_posCd, _posDd, _color];
	 drawLine3D [_posDd, _posAd, _color];

	 drawLine3D [_posAd, _posA, _color];
	 drawLine3D [_posBd, _posB, _color];
	 drawLine3D [_posCd, _posC, _color];
	 drawLine3D [_posDd, _posD, _color];
 }
 else
 {
	 if (_zsize <1) then {_zsize =100};
	 for "_i" from 1 to 360 do {
		 //_distance = _ysize;
	 _x = (_triggerPos select 0)+ _xsize*(cos _i);
	_y = (_triggerPos select 1) + _ysize*(sin _i);
	_moved = [[_x,_y,0],_angle, _triggerPos] call MRH_inside_fnc_rotatePoint;
	_return = [_moved select 0,_moved select 1,_z];
	_return2= [_moved select 0,_moved select 1,(_z + _zsize)];
	drawLine3D [_return, _return2, _color];

	 };
	
 };



_triggerType = triggerType _trigger;
_activation = triggerActivation _trigger;
_attachedVeh= triggerAttachedVehicle _trigger;
_statements = triggerStatements _trigger;

_text = format ["Trigger name:%1,Class:%2,Type:%3,Activation:%4, Attached vehicle:%5, Statements%6",str _trigger,str typeof _trigger, str _triggerType, str _activation, str _attachedVeh, str _statements];


drawIcon3D ["", _color,_triggerPos, 1, 1, 45, _text, 1, 0.05, "TahomaB"];
};

 };
};