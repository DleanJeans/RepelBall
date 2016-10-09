package systems;

class Save {
	public var maxBallsIndex:Int = 1;
	public var scoresIndex:Int = 0;
	
	public var color1Index:Int = -1;
	public var color2Index:Int = -1;

	public function new() {}
	
	public inline function colorsNotSet():Bool {
		return color1Index == -1 && color2Index == -1;
	}
	
	public function saveMatchSettings(maxBallsIndex:Int, scoresIndex:Int, color1Index:Int, color2Index:Int) {
		this.maxBallsIndex = maxBallsIndex;
		this.scoresIndex = scoresIndex;
		this.color1Index = color1Index;
		this.color2Index = color2Index;
	}
	
}