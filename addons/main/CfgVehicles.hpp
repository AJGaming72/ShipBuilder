class CfgVehicles {
	/*
		UNITS
	*/
	class B_RangeMaster_F;
	class SB_turretAI : B_RangeMaster_F {
		displayName = "Turret AI";
		scope = 1;
		scopeCurator = 1;
	};
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
    	scopeCurator = 0;

	};

	class SB_hitPoint_01 : Land_VR_Block_01_F {
		displayName = "ShipBuilder Hitpoint 1";
    	scopeCurator = 0;
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
        scopeCurator = 0;
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
        scopeCurator = 0;
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
        scopeCurator = 0;
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
        scopeCurator = 0;
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
        scopeCurator = 0;
		displayName = "Ship";
		category = "SB_Modules";
		function = "SB_fnc_shipSetup";
		icon="SB_icon_ship";

		isGlobal = 0;
		class Attributes : AttributesBase {
			class SB_Module_shipName : Edit {
				property = "SB_Module_shipName";
				displayName = "Ship name";
				tooltip = "Name for the ship to be able to call it in scripts. MUST BE UNIQUE TO THE SHIP.";
				defaultValue = """ship""";
			};
			class SB_Module_shipSpeed : Edit {
				property = "SB_Module_shipSpeed";
				displayName = "Ship's Speed (m/s)";
				tooltip = "What should the ship's speed be in Meters per Second?";
				typeName = "NUMBER";
				validate = "number";
				defaultValue = 120;
			};
			class SB_module_shipRotationSpeed : Edit {
				property = "SB_module_shipRotationSpeed";
				displayName = "Ship Rotation Speed (d/s)";
				tooltip = "How fast should the ship rotate in Degrees per Second?";
				typeName = "NUMBER";
				validate = "number";
				defaultValue = 3;
			};
		};
	};
	class SB_Module_shipChair : Module_F {
		scope = 2;
        scopeCurator = 0;
		displayName = "Ship Captain's Chair";
		category = "SB_Modules";
		icon = "SB_icon_chair";

		isGlobal = 0;
		isDisposable = 1;
	};
	class SB_Module_trigger : Module_F {
		scope = 2;
        scopeCurator = 0;
		displayName ="Ship Builder Trigger";
		category = "SB_modules"; 
		icon = "\A3\ui_f\data\map\markers\military\circle_CA.paa";
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
		icon = "\A3\ui_f\data\map\mapcontrol\Tourism_CA.paa";
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
        scopeCurator = 0;
		displayName = "Turret Module";
		category = "SB_Modules";
		icon = "SB_icon_turret";

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
        scopeCurator = 0;
		displayName = "Ship Controller";
		category = "SB_Modules";
		icon = "SB_icon_controller";

		isGlobal = 0;
		isDisposable = 1;
	};
	class SB_module_map : Module_F {
		scope = 2;
        scopeCurator = 0;
		displayName = "Ship Map";
		category = "SB_Modules";
		icon = "\A3\modules_f\data\iconStrategicMapInit_ca.paa";

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
        scopeCurator = 0;
		displayName = "Ship Camera";
		category = "SB_Modules";
		icon = "SB_icon_camera";

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
        scopeCurator = 0;
		displayName = "Escape Pod";
		category = "SB_Modules";
		icon = "SB_icon_escapePod";

		isGlobal = 0;
		isDisposable = 1;
	};
};