/*
	hitPointEHSetter
	
	This function handles the event handler being added on all players.
    We do this because it is good practice to keep addEventHandler code blocks as short as possible
    It is also more readable than remoteExecuting 'Call'


	Arguments:
	_self: The hitpoint

	
	TODO: 

	Run on server

*/
params ["_self"];
_self addEventHandler ["HitPart", {
    [(_this select 0)] call SB_fnc_hitPointRegister_EH;
}];