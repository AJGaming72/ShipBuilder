class CfgFunctions {
    class SB {
        class Main {
        file = "main\scripts";
        class cameraCreate {};
        class destroyShip {};
        class escapePodLaunch {};
        class escapePodRegister {};
        class explosionPointRegister {};
        class hitPointRegister {};
        class hitPointRegister_EH {};
        class intExplosionPointRegister {};
        class intShipDestructionEffects {};
        class mapCreate {};
        class mapDraw {};
        class markerSetup {};
        class shipCommandMovement {};
        class shipRotationHandler {};
        class shipSetup {};
        class shipSetupLocal {};
        class shipThrustHandlerPFH {};
        class syncParts {};

        class turretGetIn {};
        class turretSetup {};
        /*
        Functions that didn't make it in
        shipThrustHandlerScheduled
        temp_explosionInitRegister
        temp_intExplosionInitRegister
        postInit
        */
        };
        class Triggers {
            file = "main\scripts\triggers";
            class detectPlayerVehicle {};
            class interiorActivation {};
            class teleportFromExt {};
            class teleportFromInt {};
            class triggerUpdateRot {};
        };
    };
};