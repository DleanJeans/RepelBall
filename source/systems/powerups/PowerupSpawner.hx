package systems.powerups;

import flixel.FlxG;
import flixel.math.FlxPoint;
import flixel.util.FlxTimer;
import systems.Signals.Signal1;

class PowerupSpawner {
	public static inline var POWERUPS_COUNT = 2;
	public static inline var DOUBLE_BALLS = 0;
	public static inline var TRIPLE_BALLS = 1;
	public static inline var _60_SEC = 60;
	
	private var _timer:FlxTimer;
	private var _spawnDurations:Array<Float>;
	private var _timerSignal:Signal1<FlxTimer> = new Signal1<FlxTimer>();
	
	public function new() {
		_timer = new FlxTimer();
		
		_timerSignal.add(startTimer);
		_timerSignal.add(function (timer:FlxTimer) spawnRandom());
	}
	
	public function startSpawning() {
		spawnNPowerupsEveryMinute(10, 1);
	}
	
	public function stopSpawning() {
		_timer.cancel();
	}
	
	public function spawnNPowerupsEveryMinute(n:Int, minutes:Int) {
		_spawnDurations = generateRandomSpawnDuration(n, minutes);
		startTimer();
	}
	
	private function startTimer(?timer:FlxTimer) {
		var duration:Null<Float> = _spawnDurations[_timer.elapsedLoops];
		if (duration != null)
			_timer.start(duration, _timerSignal.dispatch);
	}
	
	private function generateRandomSpawnDuration(n:Int, minutes:Int):Array<Float> {
		var numbers:Array<Float> = [ for (i in 0...n) FlxG.random.float(25, 75) ];
		var sum:Float = 0;
		for (n in numbers)
			sum += n;
		
		return [ for (n in numbers) n / sum * _60_SEC * minutes ];
	}
	
	public inline function spawnRandom() {
		spawn(FlxG.random.weightedPick([75, 25]));
	}
	
	public function spawn(type:Int) {
		var randomPoint = getRandomPoint();
		var powerup = Game.pools.getPowerup(type, randomPoint);
		Game.level.addPowerup(powerup);
		powerup.popUp();
	}
	
	private inline function getRandomPoint():FlxPoint {
		return FlxPoint.weak(
		FlxG.random.float(Game.settings.POWERUP_MIN_X, Game.settings.POWERUP_MAX_X),
		FlxG.random.float(Game.settings.POWERUP_MIN_Y, Game.settings.POWERUP_MAX_Y)
		);
	}
	
}