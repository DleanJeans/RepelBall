package systems.powerups;

class PowerupSystems {
	public var spawner(default, null):PowerupSpawner;
	public var activations(default, null):PowerupActivations;
	public var deactivations(default, null):PowerupDeactivations;
	public var manager(default, null):PowerupManager;

	public function new() {
		spawner = new PowerupSpawner();
		activations = new PowerupActivations();
		deactivations = new PowerupDeactivations();
		manager = new PowerupManager();
	}
	
}