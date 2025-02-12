#include "script_component.hpp"

class CfgPatches{ 
    class ADDON {
		name = CSTRING(component);
		units[] = {};
		weapons[] = {};
		requiredVersion = REQUIRED_VERSION;
		requiredAddons[] = { "CBA_main" };
		author = "Alsomjon";
		url = "https://community.bistudio.com/wiki";
		VERSION_CONFIG;
	};
};