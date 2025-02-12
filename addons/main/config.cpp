#include "defines.hpp"

class CfgPatches {
    class ADDON {
		name = ADDONNAME;
		author = AUTHOR;
		requiredVersion = REQUIREDVERSION;
		url = "https://github.com/AJGaming72/ShipBuilder";

		units[] = {
			"SB_hangarInteriorDetector",
			"SB_hangarExteriorDetector",
			"SB_shipInteriorDetector",
			"SB_triggerModule",
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
		};
	};
	class SB_triggerModule : Module_F {
		scope = 2;
		displayName ="Ship Builder Trigger";
		category = "SB_modules"; 
		canSetArea = 1;
		canSetAreaShape = 0;
		canSetAreaHeight = 1;
		class Attributes : AttributesBase {
			class ID : Edit {
				property = "SB_hangarTriggerID";
				displayName = "Trigger ID";
				tooltip = "Number value, which corresponds with the sister trigger.";
				typeName = "NUMBER";
				defaultValue = 1;
			};
		};
		class AttributeValues
		{
			// This section allows you to set the default values for the attributes menu in 3DEN
			size3[] = { 10, 10, 10 };		// 3D size (x-axis radius, y-axis radius, z-axis radius)
			isRectangle = 1;				// Sets if the default shape should be a rectangle or ellipse
		};
	};
	class SB_hangarTriggerModule
	class SB_shipModule : Module_F {
		scope = 2;
		displayName = "Ship";
		category = "SB_Modules";

		isGlobal = 0;
		isDisposable = 1;
		class Attributes : AttributesBase {
			class shipVariableName : Edit {
				displayName = "Ship Variable Name";
				tooltip = "This is the name of the Ship Variable. You'll need to input this into other modules.";
				property = "SB_Module_shipName";
				defaultValue = """ship""";
			};
		};
	};
};
#include "CfgFunctions.hpp"
#include "CfgNonAIVehicles.hpp"

