package systems;

import flixel.FlxG;

class Messages {
	public var askForAnyInput(get, never):String;
	public var scoringTeam(get, never):String;
	public var teamRoundScore1(get, never):String;
	public var teamRoundScore2(get, never):String;
	public var winningTeam(get, never):String;
	
	public var newLine:String = "\n";
	public var roundTie:String = "Round Tie!";
	public var scored:String = "scored";
	public var won:String = "won";
	public var dashSeparator:String = " - ";
	public var _0_000:String = "0.000";
	
	public function new() {}
	
	private inline function get_askForAnyInput():String {
		return
		if (FlxG.onMobile)
			"Tap to continue"
		else "Press any key to continue";
	}
	
	private function get_scoringTeam():String {
		var scoringTeam = Game.match.lastScoringTeam;
		if (scoringTeam != null)
			return scoringTeam.name;
		else return "";
	}
	
	public inline function onOff(bool:Bool) {
		return bool ? "ON" : "OFF";
	}
	
	public inline function getSlowMoActivation():String {
		return "Slow Mo: " + onOff(Game.speed.slowMoEnabled);
	}
	
	inline function get_teamRoundScore1():String return Std.string(Game.match.team1.roundScore);
	inline function get_teamRoundScore2():String return Std.string(Game.match.team2.roundScore);
	inline function get_winningTeam():String return Std.string(Game.match.winningTeam.name);
}