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
		var wallWidth = Settings.unitLength();
		
		var topWallY = 0;
		var bottomWallY = FlxG.height - wallWidth;
		
		// Raise top and bottom walls on mobile
		if (FlxG.onMobile) {
			var emptyHeight = FlxG.height * 0.1;
			#if !js
			topWallY += cast emptyHeight / 2;
			#end
			bottomWallY -= cast emptyHeight / 2;
		}
		
		rightWall = Game.pools.getWall(FlxG.width, 0, wallWidth, FlxG.height, FlxObject.LEFT);
		leftWall = Game.pools.getWall(-wallWidth, 0, wallWidth, FlxG.height, FlxObject.RIGHT);
		topWall = Game.pools.getWall(-wallWidth, topWallY, FlxG.width + wallWidth * 2, wallWidth, FlxObject.DOWN);
		bottomWall = Game.pools.getWall(-wallWidth, bottomWallY, FlxG.width + wallWidth * 2, wallWidth, FlxObject.UP);
		
		rightWall.visible = leftWall.visible = false;
	}
	
	public function addWallsToLevel() {
		Game.stage.addWall(topWall);
		Game.stage.addWall(bottomWall);
		Game.stage.addWall(leftWall);
		Game.stage.addWall(rightWall);
	}
	
}