package systems.powerups;

class PowerupSystems {
	public var spawner(default, null):PowerupSpawner;
	public var effects(default, null):PowerupEffects;
	public var manager(default, null):PowerupManager;

	public function new() {
		spawner = new PowerupSpawner();
		effects = new PowerupEffects();
		manager = new PowerupManager();
	}
	
}