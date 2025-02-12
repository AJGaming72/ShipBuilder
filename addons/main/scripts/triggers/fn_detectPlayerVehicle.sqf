/*
	detectPlayerVehicle
	
	Handles making certain only the driver does the teleporting.
	
	Arguments:
	_thisList: List of object inside the trigger

	TODO: 

	Run on player
*/
params ["_thisList"];
if (vehicle player in _thisList) then {
    driver vehicle player isEqualTo player;
};