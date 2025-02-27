#include "defines.hpp"

class CfgPatches {
    class ADDON {
		name = ADDONNAME;
		author = AUTHOR;
		requiredVersion = REQUIREDVERSION;
		url = "https://github.com/AJGaming72/ShipBuilder";

		units[] = {
			"SB_shipModule"
		};
		weapons[] = {};
		requiredAddons[] = { "CBA_main" };
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
class CfgVehicles {
	/*
		VEHICLES
	*/
	class Land_VR_Block_01_F;
	class Land_VR_Block_02_F;
	class Land_VR_Block_03_F;
	class Land_VR_Block_04_F;
	class Land_VR_Block_05_F;
	class Land_VR_Shape_01_cube_1m_F;

	class SB_explosionPoint : Land_VR_Shape_01_cube_1m_F {
		displayName = "Shipbuilder Explosion Point";
	};

	class SB_hitPoint_01 : Land_VR_Block_01_F {
		displayName = "ShipBuilder Hitpoint 1";
		class Attributes {
			class SB_Module_hitpointType {
				displayName = "Hitpoint Type";
				tooltip = "Placeholder for future plans!";
				property = "SB_Module_hitpointType";
				expression = "_this setVariable ['%s',_value];";
				control = "Combo";
				defaultValue = """ENGINE""";
				typeName = "STRING";
				class Values {
					class ENGINE {name = "Engine"; value = "ENGINE";};
					class CORE {name = "Core"; value = "CORE";};
				};
			};
			class SB_Module_hitpointHealth {
				displayName = "Hitpoint Health";
				tooltip = "The health of the hitpoint";
				property = "SB_Module_hitpointHealth";
				expression = "_this setVariable ['%s',_value];";
				control = "Edit";
				typeName = "NUMBER";
				validate = "number";
				defaultValue = "10000";
				
			};
		};	
	};
	class SB_hitPoint_02 : Land_VR_Block_02_F {
		displayName = "ShipBuilder Hitpoint 2";
		class Attributes {
			class SB_Module_hitpointType {
				displayName = "Hitpoint Type";
				tooltip = "Placeholder for future plans!";
				property = "SB_Module_hitpointType";
				expression = "_this setVariable ['%s',_value];";
				control = "Combo";
				defaultValue = """ENGINE""";
				typeName = "STRING";
				class Values {
					class ENGINE {name = "Engine"; value = "ENGINE";};
					class CORE {name = "Core"; value = "CORE";};
				};
			};
			class SB_Module_hitpointHealth {
				displayName = "Hitpoint Health";
				tooltip = "The health of the hitpoint";
				property = "SB_Module_hitpointHealth";
				expression = "_this setVariable ['%s',_value];";
				control = "Edit";
				typeName = "NUMBER";
				validate = "number";
				defaultValue = "10000";
			};
		};	
	};
	class SB_hitPoint_03 : Land_VR_Block_03_F {
		displayName = "ShipBuilder Hitpoint 3";
		class Attributes {
			class SB_Module_hitpointType {
				displayName = "Hitpoint Type";
				tooltip = "Placeholder for future plans!";
				property = "SB_Module_hitpointType";
				expression = "_this setVariable ['%s',_value];";
				control = "Combo";
				defaultValue = """ENGINE""";
				typeName = "STRING";
				class Values {
					class ENGINE {name = "Engine"; value = "ENGINE";};
					class CORE {name = "Core"; value = "CORE";};
				};
			};
			class SB_Module_hitpointHealth {
				displayName = "Hitpoint Health";
				tooltip = "The health of the hitpoint";
				property = "SB_Module_hitpointHealth";
				expression = "_this setVariable ['%s',_value];";
				control = "Edit";
				typeName = "NUMBER";
				validate = "number";
				defaultValue = "10000";
				
			};
		};	
	};
	class SB_hitPoint_04 : Land_VR_Block_04_F {
		displayName = "ShipBuilder Hitpoint 4";
		class Attributes {
			class SB_Module_hitpointType {
				displayName = "Hitpoint Type";
				tooltip = "Placeholder for future plans!";
				property = "SB_Module_hitpointType";
				expression = "_this setVariable ['%s',_value];";
				control = "Combo";
				defaultValue = """ENGINE""";
				typeName = "STRING";
				class Values {
					class ENGINE {name = "Engine"; value = "ENGINE";};
					class CORE {name = "Core"; value = "CORE";};

				};
			};
			class SB_Module_hitpointHealth {
				displayName = "Hitpoint Health";
				tooltip = "The health of the hitpoint";
				property = "SB_Module_hitpointHealth";
				expression = "_this setVariable ['%s',_value];";
				control = "Edit";
				typeName = "NUMBER";
				validate = "number";
				defaultValue = "10000";
				
			};
		};	
	};
	class SB_hitPoint_05 : Land_VR_Block_05_F {
		displayName = "ShipBuilder Hitpoint 5";
		class Attributes {
			class SB_Module_hitpointType {
				displayName = "Hitpoint Type";
				tooltip = "Placeholder for future plans!";
				property = "SB_Module_hitpointType";
				expression = "_this setVariable ['%s',_value];";
				control = "Combo";
				defaultValue = """ENGINE"""; // Default Value doesn't seem to take, this is remedied in SQF. Should investigate why this is.
				typeName = "STRING";
				class Values {
					class ENGINE {name = "Engine"; value = "ENGINE";};
					class CORE {name = "Core"; value = "CORE";};
				};
			};
			class SB_Module_hitpointHealth {
				displayName = "Hitpoint Health";
				tooltip = "The health of the hitpoint";
				property = "SB_Module_hitpointHealth";
				expression = "_this setVariable ['%s',_value];";
				control = "Edit";
				typeName = "NUMBER";
				validate = "number";
				defaultValue = "10000";
				
			};
		};	
	};


	/*
		MODULES
	*/
	class Logic;
	class Module_F : Logic
	{
		class AttributesBase
		{
			class Default;
			class Edit;					// Default edit box (i.e. text input field)
			class Combo;				// Default combo box (i.e. drop-down menu)
			class Checkbox;				// Default checkbox (returned value is Boolean)
			class CheckboxNumber;		// Default checkbox (returned value is Number)
			class ModuleDescription;	// Module description
			class Units;				// Selection of units on which the module is applied
		};

		// Description base classes (for more information see below):
		class ModuleDescription
		{
			class AnyBrain;
			class Anything;
		};
	};
	class SB_Module_ship : Module_F {
		scope = 2;
		displayName = "Ship";
		category = "SB_Modules";
		function = "SB_fnc_shipSetup";

		isGlobal = 0;
		class Attributes : AttributesBase {
			class SB_Module_shipName : Edit {
				property = "SB_Module_shipName";
				displayName = "Ship name";
				tooltip = "Name for the ship to be able to call it in scripts. MUST BE UNIQUE TO THE SHIP.";
				defaultValue = """ship""";
			};
		};
	};
	class SB_Module_trigger : Module_F {
		scope = 2;
		displayName ="Ship Builder Trigger";
		category = "SB_modules"; 
		canSetArea = 1;
		canSetAreaShape = 0;
		canSetAreaHeight = 1;

		isGlobal = 0;
		isDisposable = 1;
		class AttributeValues
		{
			// This section allows you to set the default values for the attributes menu in 3DEN
			size3[] = { 10, 10, 10 };		// 3D size (x-axis radius, y-axis radius, z-axis radius)
			isRectangle = 1;				// Sets if the default shape should be a rectangle or ellipse
		};
	};
	class SB_Module_hangarTrigger : SB_Module_trigger{
		displayName = "Ship Builder Hangar Trigger";
		class Attributes : AttributesBase {
			class SB_Module_hangarTriggerID : Edit {
				property = "SB_Module_hangarTriggerID";
				displayName = "Trigger ID";
				tooltip = "Number value, which corresponds with the sister trigger.";
				typeName = "NUMBER";
				validate = "number";
				defaultValue = 1;
			};
			class SB_Module_triggerType : Combo {
					property = "SB_Module_triggerType";
					displayName = "Trigger Type";
					tooltip = "Where is this trigger placed in relation to the ship?";
					typeName = "STRING";
					defaultValue = """INTERIOR""";
					class Values {
						class INTERIOR {name = "Hangar Interior"; value = "INTERIOR";};
						class EXTERIOR {name = "Hangar Exterior"; value = "EXTERIOR";};
					};
			};
		};
	};
	class SB_Module_turret : Module_F {
		scope = 2;
		displayName = "Turret Module";
		category = "SB_Modules";

		isGlobal = 0;
		isDisposable = 1;
		class Attributes : AttributesBase {
			class ModuleDescription : ModuleDescription {};
		};
		class ModuleDescription : ModuleDescription {
			description = "
			This module is used to synchronize turrets, their controller, and the ship. <br/>
			Synchronize it with the Ship module, the Turret, and the Controller. <br/>
			If the Controller is not within the interior trigger area it will not work.
			";
		};
	};
	class SB_Module_shipController : Module_F {
		scope = 2;
		displayName = "Ship Controller";
		category = "SB_Modules";

		isGlobal = 0;
		isDisposable = 1;
	};
	class SB_module_map : Module_F {
		scope = 2;
		displayName = "Ship Map";
		category = "SB_Modules";

		isGlobal = 0;
		isDisposable = 1;
		class Attributes : AttributesBase {
			class SB_module_mapX : Edit {
				property = "SB_module_mapX";
				displayName = "Map Dimensions X";
				tooltip = "The X dimension of a map. Only use if your surface isn't 1:1";
				typeName = "NUMBER";
				validate = "number";
				defaultValue = 1;
			};
			class SB_module_mapY : Edit {
				property = "SB_module_mapY";
				displayName = "Map Dimensions Y";
				tooltip = "The Y dimension of a map. Only use if your surface isn't 1:1";
				typeName = "NUMBER";
				validate = "number";
				defaultValue = 1;
			};
			class SB_module_selectionID : Edit {
				property = "SB_module_selectionID";
				displayName = "Selection ID";
				tooltip = "Which hidden selection should the map be put on?";
				typeName = "NUMBER";
				validate = "number";
				defaultValue = 0;
			};
		};
	};
	class SB_module_camera : Module_F {
		scope = 2;
		displayName = "Ship Camera";
		category = "SB_Modules";

		isGlobal = 0;
		isDisposable = 1;
		class Attributes : AttributesBase {
			class SB_module_selectionID : Edit {
				property = "SB_module_selectionID";
				displayName = "Selection ID";
				tooltip = "Which hidden selection should the map be put on?";
				typeName = "NUMBER";
				validate = "number";
				defaultValue = 0;
			};
		};
	};
	class SB_module_escapePod : Module_F {
		scope = 2;
		displayName = "Escape Pod";
		category = "SB_Modules";

		isGlobal = 0;
		isDisposable = 1;
	};
};
#include "CfgFunctions.hpp"

