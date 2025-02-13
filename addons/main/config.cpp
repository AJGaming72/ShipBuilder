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
			class Anything;
		};
	};
	class SB_Module_ship : Module_F {
		scope = 2;
		displayName = "Ship";
		category = "SB_Modules";

		isGlobal = 0;
		isDisposable = 1;
		class Attributes : AttributesBase {
			class shipVariableName : Edit {
				displayName = "Ship Variable Name";
				tooltip = "This is the name of the Ship Variable. This must be unique if you plan to have multiple ships.";
				property = "SB_Module_shipName";
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
			class ID : Edit {
				property = "SB_Module_hangarTriggerID";
				displayName = "Trigger ID";
				tooltip = "Number value, which corresponds with the sister trigger.";
				typeName = "NUMBER";
				defaultValue = 1;
			};
			class Type : Combo {
					property = "SB_Module_triggerType";
					displayName = "Trigger Type";
					tooltip = "Where is this trigger placed in relation to the ship?";
					typeName = "STRING";
					defaultValue = """INTERIOR""";
					class Values {
						class INTERIOR {name = "Hangar Interior"; value = """INTERIOR""";};
						class EXTERIOR {name = "Hangar Exterior"; value = """EXTERIOR""";};
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
			description = "Testing the module description section";
			sync[] = {"Anything", "LocationArea_F"};
			class LocationArea_F
			{
				description[] = { // Multi-line descriptions are supported
					"First line",
					"Second line"
				};
				position = 1;	// Position is taken into effect
				direction = 1;	// Direction is taken into effect
				optional = 1;	// Synced entity is optional
				duplicate = 1;	// Multiple entities of this type can be synced
				synced[] = { "BluforUnit", "AnyBrain" };	// Pre-defined entities like "AnyBrain" can be used (see the table below)
			};
			class BluforUnit
			{
				description = "Short description";
				displayName = "Any BLUFOR unit";	// Custom name
				icon = "iconMan";					// Custom icon (can be file path or CfgVehicleIcons entry)
				side = 1;							// Custom side (determines icon color)
			};
		};

	};
};
#include "CfgFunctions.hpp"
#include "CfgNonAIVehicles.hpp"

