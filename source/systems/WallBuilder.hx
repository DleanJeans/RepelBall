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
		var wallWidth = Game.unitLength();
		
		rightWall = Game.pools.getWall(FlxG.width, 0, wallWidth, FlxG.height, FlxObject.LEFT);
		leftWall = Game.pools.getWall(-wallWidth, 0, wallWidth, FlxG.height, FlxObject.RIGHT);
		topWall = Game.pools.getWall(0, 0, FlxG.width, wallWidth, FlxObject.DOWN);
		bottomWall = Game.pools.getWall(0, FlxG.height - wallWidth, FlxG.width, wallWidth, FlxObject.UP);
	}
	
	public function addWallsToLevel() {
		Game.level.addWall(topWall);
		Game.level.addWall(bottomWall);
		Game.level.addWall(leftWall);
		Game.level.addWall(rightWall);
	}
	
}