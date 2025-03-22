#include "defines.hpp"

class CfgPatches {
    class ADDON {
		name = ADDONNAME;
		author = AUTHOR;
		requiredVersion = REQUIREDVERSION;
		url = "https://github.com/AJGaming72/ShipBuilder";

		units[] = {
			// Units
			"SB_turretAI",
			// Points
			"SB_explosionPoint",
			"SB_hitPoint_01",
			"SB_hitPoint_02",
			"SB_hitPoint_03",
			"SB_hitPoint_04",
			"SB_hitPoint_05",
			// Modules
			"SB_Module_ship",
			"SB_Module_shipChair",
			"SB_Module_trigger",
			"SB_Module_hangarTrigger",
			"SB_Module_turret",
			"SB_Module_shipController",
			"SB_module_map",
			"SB_module_camera",
			"SB_module_escapePod"
		};
		weapons[] = {};
		requiredAddons[] = { "CBA_main" };
	};
};

class CfgVehicleIcons
{
	SB_icon_ship = "main\data\iconShip.paa";
	SB_icon_camera = "main\data\iconCamera.paa";
	SB_icon_chair = "main\data\iconChair.paa";
	SB_icon_controller = "main\data\iconController.paa";
	SB_icon_escapePod = "main\data\iconEscapePod.paa";
	SB_icon_turret = "main\data\iconTurret.paa";
};
class Extended_PreInit_EventHandlers {
    class SB_main_preInit {
        init = "call compile preprocessFileLineNumbers 'main\XEH_preInit.sqf'";
		clientInit = "call compile preprocessFileLineNumbers 'main\XEH_clientPreInit.sqf'";
	};
};

class CfgFactionClasses
{
	class NO_CATEGORY;
	class SB_Modules: NO_CATEGORY
	{
		displayName = "Shipbuilder";
	};
};
#include "CfgVehicles.hpp"
#include "CfgFunctions.hpp"

