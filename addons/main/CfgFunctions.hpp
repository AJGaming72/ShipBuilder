class CfgFunctions {
    class SB {
        class Main {
        file = "main\scripts";
        class cameraCreate {};
        class activeCam {};
        class destroyShip {};
        class escapePodLaunch {};
        class escapePodRegister {};
        class escapePodAction {};
        class explosionPointRegister {};
        class hitPointRegister {};
        class hitPointEHSetter {};
        class hitPointRegister_EH {};
        class intExplosionPointRegister {};
        class intShipDestructionEffects {};
        class mapCreate {};
        class mapDraw {};
        class markerSetup {};
        class shipCommandMovement {};
        class shipSetup {};
        class shipControllerSetup {};
        class shipThrustHandler {};
        class shipRotationHandler {};
        class toggleAnchor {};

        class turretGetIn {};
        class turretSetup {};
        class turretSetupLocal {};
        class turretRC_EH {};


        /*
        Functions that didn't make it in
        shipThrustHandlerScheduled
        temp_explosionInitRegister
        temp_intExplosionInitRegister
        postInit
        syncParts
        */
        };
        class Triggers {
            file = "main\scripts\triggers";
            class detectPlayerVehicle {};
            class interiorActivation {};
            class teleportFromExt {};
            class teleportFromInt {};
            class triggerUpdateRot {};
            class globalTrigger {};
            class anchorOn {};
            class anchorOff {};
        };
    };
};