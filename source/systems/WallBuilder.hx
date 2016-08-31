package systems;

import flixel.FlxG;
import flixel.FlxObject;
import objects.Wall;

class WallBuilder {
	public var leftWall(default, null):Wall;
	public var rightWall(default, null):Wall;
	public var topWall(default, null):Wall;
	public var bottomWall(default, null):Wall;

	public function new() {
		buildWalls();
		addWallsToLevel();
	}
	
	public function buildWalls() {
		rightWall = Game.pools.getWall(FlxG.width - Game.unitLength(), 0, Game.unitLength(), FlxG.height, FlxObject.LEFT);
		leftWall = Game.pools.getWall(0, 0, Game.unitLength(), FlxG.height, FlxObject.RIGHT);
		topWall = Game.pools.getWall(0, 0, FlxG.width, Game.unitLength(), FlxObject.DOWN);
		bottomWall = Game.pools.getWall(0, FlxG.height - Game.unitLength(), FlxG.width, Game.unitLength(), FlxObject.UP);
	}
	
	public function addWallsToLevel() {
		Game.level.addWall(topWall);
		Game.level.addWall(bottomWall);
		Game.level.addWall(leftWall);
		Game.level.addWall(rightWall);
	}
	
}