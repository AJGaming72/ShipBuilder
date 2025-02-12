class CfgNonAIVehicles {
    class EmptyDetector;
    class SB_hangarInteriorDetector : EmptyDetector {
        displayName = "Hangar Detector - Interior";

		class AttributeValues
		{
            condition = "[thisList] call SB_fnc_detectPlayerVehicle;";
            onActivation = "[thisTrigger, triggerHangerExterior, ship] call SB_fnc_teleportFromInt;";
            size2[]={5,5};
			size3[]={5,5,5};
			IsRectangle=1;
            repeatable = 1;
            ActivationBy = "ANYPLAYER";
        };
    };
    class SB_hangarExteriorDetector : SB_hangarInteriorDetector {
        displayName = "Hangar Detector - Exterior";
        class AttributeValues {
            condition = "[thisTrigger] call SB_fnc_triggerUpdateRot;[thisList] call SB_fnc_detectPlayerVehicle;";
            onActivation = "[thisTrigger, triggerHangerExterior] call SB_fnc_teleportFromExt;";
            size2[]={5,5};
			size3[]={5,5,5};
			IsRectangle=1;
            repeatable = 1;
            ActivationBy = "ANYPLAYER";
        };
    };

    class SB_shipInteriorDetector : SB_hangarInteriorDetector {
        displayName = "Ship Interior Detector";
        class AttributeValues {
            condition = "vehicle player in thisList;";
            onActivation = "[ship] call SB_fnc_interiorActivation";
            onDeactivation = "player setVariable ['SB_ship', -1, true];";
            size2[]={5,5};
			size3[]={5,5,5};
			IsRectangle=1;
            repeatable = 1;
            ActivationBy = "ANYPLAYER";
        };
    };
};

/*
        class AttributeCategories
		{
			class Init
			{
				displayName="$STR_3DEN_Object_AttributeCategory_Init";
				class Attributes
				{
					class Name
					{
						data="name";
						value=0;
						unique=1;
						control="EditCode";
						validate="globalVariable";
						displayName="$STR_3DEN_Object_Attribute_Name_displayName";
						tooltip="$STR_3DEN_Object_Attribute_Name_tooltip";
						wikiType="[[String]]";
					};
					class Text
					{
						data="text";
						value=0;
						control="EditCode";
						displayName="$STR_3DEN_Trigger_Attribute_Text_displayName";
						tooltip="$STR_3DEN_Trigger_Attribute_Text_tooltip";
						wikiType="[[String]]";
					};
				};
			};
			class Transformation
			{
				displayName="$STR_3DEN_Object_AttributeCategory_Transformation";
				class Attributes
				{
					class Position
					{
						data="position";
						control="EditXYZ";
						validate="number";
						displayName="$STR_3DEN_Object_Attribute_Position_displayName";
						tooltip="$STR_3DEN_Object_Attribute_Position_tooltip";
						wikiType="[[Position3D]]";
					};
					class Rotation
					{
						data="rotation";
						control="EditZ";
						validate="number";
						displayName="$STR_3DEN_Object_Attribute_Rotation_displayName";
						tooltip="$STR_3DEN_Object_Attribute_Rotation_tooltip";
						wikiType="[[Number]]";
					};
					class Size
					{
						data="size2";
						control="EditAB";
						validate="number";
						displayName="$STR_3DEN_Trigger_Attribute_Size_displayName";
						tooltip="$STR_3DEN_Trigger_Attribute_Size_tooltip";
						wikiType="[[Array]]";
					};
					class Size3
					{
						data="size3";
						control="EditABC";
						validate="number";
						displayName="$STR_3DEN_Trigger_Attribute_Size_displayName";
						tooltip="$STR_3DEN_Trigger_Attribute_Size_tooltip";
						wikiType="[[Array]]";
					};
					class Shape
					{
						data="IsRectangle";
						control="ShapeTrigger";
						displayName="$STR_3DEN_Trigger_Attribute_Shape_displayName";
						tooltip="$STR_3DEN_Trigger_Attribute_Shape_tooltip";
						wikiType="[[Bool]]";
					};
				};
			};
			class Activation
			{
				displayName="$STR_3DEN_Trigger_AttributeCategory_Activation";
				class Attributes
				{
					class Type
					{
						data="TriggerType";
						control="TriggerType";
						displayName="$STR_3DEN_Trigger_Attribute_Type_displayName";
						tooltip="$STR_3DEN_Trigger_Attribute_Type_tooltip";
						wikiType="[[String]]";
					};
					class Activation
					{
						data="ActivationBy";
						control="TriggerActivation";
						displayName="$STR_3DEN_Trigger_Attribute_Activation_displayName";
						tooltip="$STR_3DEN_Trigger_Attribute_Activation_tooltip";
						wikiType="[[String]]";
					};
					class ActivationOwner
					{
						data="activationByOwner";
						control="TriggerActivationOwner";
						displayName="$STR_3DEN_Trigger_Attribute_Activation_displayName";
						tooltip="$STR_3DEN_Trigger_Attribute_ActivationOwner_tooltip";
						wikiType="[[String]]";
					};
					class ActivationType
					{
						data="activationType";
						control="ActivationType";
						displayName="$STR_3DEN_Trigger_Attribute_ActivationType_displayName";
						tooltip="$STR_3DEN_Trigger_Attribute_ActivationType_tooltip";
						wikiType="[[String]]";
					};
					class Repeat
					{
						data="repeatable";
						control="Checkbox";
						displayName="$STR_3DEN_Trigger_Attribute_Repeat_displayName";
						tooltip="$STR_3DEN_Trigger_Attribute_Repeat_tooltip";
						wikiType="[[Bool]]";
					};
					class IsServerOnly
					{
						data="isServerOnly";
						control="Checkbox";
						displayName="$STR_3DEN_Trigger_Attribute_IsServerOnly_displayName";
						tooltip="$STR_3DEN_Trigger_Attribute_IsServerOnly_tooltip";
						wikiType="[[Bool]]";
					};
				};
			};
			class Expression
			{
				displayName="$STR_3DEN_Trigger_AttributeCategory_Expression";
				class Attributes
				{
					class Condition
					{
						data="condition";
						value=0;
						control="EditCodeMulti3";
						validate="condition";
						displayName="$STR_3DEN_Trigger_Attribute_Condition_displayName";
						tooltip="$STR_3DEN_Trigger_Attribute_Condition_tooltip";
						wikiType="[[String]]";
					};
					class TriggerInterval
					{
						data="triggerInterval";
						control="Edit";
						validate="number";
						displayName="$STR_3DEN_Trigger_Attribute_TriggerInterval_displayName";
						tooltip="$STR_3DEN_Trigger_Attribute_TriggerInterval_tooltip";
						wikiType="[[Number]]";
					};
					class OnActivation
					{
						data="onActivation";
						value=0;
						control="EditCodeMulti5";
						validate="expression";
						displayName="$STR_3DEN_Trigger_Attribute_OnActivation_displayName";
						tooltip="$STR_3DEN_Trigger_Attribute_OnActivation_tooltip";
						wikiType="[[String]]";
					};
					class OnDeactivation
					{
						data="onDeactivation";
						value=0;
						control="EditCodeMulti3";
						validate="expression";
						displayName="$STR_3DEN_Trigger_Attribute_OnDeactivation_displayName";
						tooltip="$STR_3DEN_Trigger_Attribute_OnDeactivation_tooltip";
						wikiType="[[String]]";
					};
				};
			};
			class Timer
			{
				displayName="$STR_3DEN_Trigger_AttributeCategory_Timer";
				class Attributes
				{
					class TimeoutType
					{
						data="interuptable";
						value=0;
						control="TimeoutType";
						displayName="$STR_3DEN_Trigger_Attribute_TimeoutType_displayName";
						tooltip="$STR_3DEN_Trigger_Attribute_TimeoutType_tooltip";
						wikiType="[[Bool]]";
					};
					class Timeout
					{
						data="timeout";
						value=0;
						control="Timeout";
						displayName="$STR_3DEN_Trigger_Attribute_Timeout_displayName";
						tooltip="$STR_3DEN_Trigger_Attribute_Timeout_tooltip";
						wikiType="[[Array]] in format [min, mid, max]";
					};
				};
			};
			class Effects
			{
				displayName="$STR_3DEN_Trigger_AttributeCategory_Effects";
				collapsed=1;
				class Attributes
				{
					class Condition
					{
						data="effectCondition";
						control="Edit";
						validate="condition";
						displayName="$STR_3DEN_Trigger_Attribute_EffectCondition_displayName";
						tooltip="$STR_3DEN_Trigger_Attribute_EffectCondition_tooltip";
						wikiType="[[String]]";
					};
					class Sound
					{
						data="sound";
						control="Sound";
						displayName="$STR_3DEN_Trigger_Attribute_Sound_displayName";
						tooltip="$STR_3DEN_Trigger_Attribute_Sound_tooltip";
						wikiType="[[String]]";
					};
					class Voice
					{
						data="voice";
						control="SoundVoice";
						displayName="$STR_3DEN_Trigger_Attribute_Voice_displayName";
						tooltip="$STR_3DEN_Trigger_Attribute_Voice_tooltip";
						wikiType="[[String]]";
					};
					class SoundEnvironment
					{
						data="soundEnvironment";
						control="SoundEnvironment";
						displayName="$STR_3DEN_Trigger_Attribute_SoundEnvironment_displayName";
						tooltip="$STR_3DEN_Trigger_Attribute_SoundEnvironment_tooltip";
						wikiType="[[String]]";
					};
					class SoundTrigger
					{
						data="soundTrigger";
						control="SoundEffect";
						displayName="$STR_3DEN_Trigger_Attribute_SoundTrigger_displayName";
						tooltip="$STR_3DEN_Trigger_Attribute_SoundTrigger_tooltip";
						wikiType="[[String]]";
					};
					class Music
					{
						data="music";
						control="Music";
						displayName="$STR_3DEN_Trigger_Attribute_Music_displayName";
						tooltip="$STR_3DEN_Trigger_Attribute_Music_tooltip";
						wikiType="[[String]]";
					};
					class RscTitle
					{
						data="title";
						control="RscTitle";
						displayName="$STR_3DEN_Trigger_Attribute_RscTitle_displayName";
						tooltip="$STR_3DEN_Trigger_Attribute_RscTitle_tooltip";
						wikiType="[[String]]";
					};
				};
			};
		};
*/
