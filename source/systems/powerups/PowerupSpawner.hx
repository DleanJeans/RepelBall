package systems.powerups;

import flixel.FlxG;
import flixel.math.FlxPoint;
import flixel.util.FlxTimer;
import flixel.util.helpers.FlxBounds;
import objects.Powerup;
import systems.Signals.Signal1;

class PowerupSpawner {
	public static inline var FIRST_WAVE = 1;
	public static inline var SECOND_WAVE = 0;
	
	public var spawnPerMinute(default, set):Int;
	
	private var  _maxSpawnPer2Wave:Int;
	private var _spawnPerWave:FlxBounds<Int>;
	
	private var _patternTimer:FlxTimer;
	private var _spawnTimer:FlxTimer;
	
	private var _firstWaveCount:Int;
	private var _secondWaveCount:Int = 0;
	
	public function new() {
		spawnPerMinute = Settings.powerup.spawnPerMinute;
		
		_patternTimer = new FlxTimer();
		_spawnTimer = new FlxTimer();
	}
	
	public function startSpawning() {
		_patternTimer.start(7.5, spawnIfTime, 0);
	}
	
	private function spawnIfTime(timer:FlxTimer) {
		var timeMark = timer.elapsedLoops % 2;
		switch (timeMark) {
			case FIRST_WAVE:
				_firstWaveCount = FlxG.random.int(_spawnPerWave.min, _spawnPerWave.max);
				_secondWaveCount =  _maxSpawnPer2Wave - _firstWaveCount;
				
				spawnFirstWave();
			case SECOND_WAVE:
				spawnSecondWave();
		}
	}
	
	private inline function spawnFirstWave() {
		spawnWave(_firstWaveCount);
	}
	
	private function spawnSecondWave() {
		if (_secondWaveCount > 0)
			spawnWave(_secondWaveCount);
	}
	
	private function spawnWave(count:Int) {
		_spawnTimer.start(getSpawnDelay(), function(_) {
			_spawnTimer.time = getSpawnDelay();
			spawnRandom();
		}, count);
	}
	
	private inline function getSpawnDelay():Float {
		return FlxG.random.float(0.75, 1);
	}
	
	public function stopSpawning() {
		_patternTimer.cancel();
		_spawnTimer.cancel();
		_secondWaveCount = 0;
	}
	
	public inline function spawnRandom() {
		spawn(FlxG.random.weightedPick([4, 2, 1]));
	}
	
	public function spawn(type:Int):Powerup {
		var powerup = Game.pools.getPowerup(type);
		
		powerup.solid = true;
		do {
			var randomPoint:FlxPoint = getRandomPoint();
			powerup.setCenter(randomPoint);
		} while (overlapAnything(powerup));
		
		Game.stage.addPowerup(powerup);
		powerup.popUp();
		return powerup;
	}
	
	private function overlapAnything(powerup:Powerup) {
		return FlxG.overlap(powerup, Game.stage.powerups) ||
		FlxG.overlap(powerup, Game.stage.balls);
	}
	
	private inline function getRandomPoint():FlxPoint {
		return FlxPoint.weak(
		FlxG.random.float(Settings.powerup.area.x, Settings.powerup.area.right),
		FlxG.random.float(Settings.powerup.area.y, Settings.powerup.area.bottom)
		);
	}
	
	function set_spawnPerMinute(newSpawn:Int):Int {
		_maxSpawnPer2Wave = cast newSpawn / 4;
		var half = cast _maxSpawnPer2Wave / 2;
		_spawnPerWave = new FlxBounds<Int>(
			half - 1 == 0 ? half : half - 1, 
			half + 2 == _maxSpawnPer2Wave ? half + 1 == _maxSpawnPer2Wave ? half : half + 1 : half + 2
		);
		return spawnPerMinute = newSpawn;
	}
	
}