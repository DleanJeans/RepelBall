package systems.ui;

import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;
using flixel.addons.util.position.FlxPosition;

class TeamSettings extends FlxSpriteGroup {
	public var teamName:FlxText;
	public var colorSwatch:ColorSwatchSelector;
	
	public function new(x:Float = 0, y:Float = 0) {
		super();
		
		setPosition(x, y);
		
		teamName = new FlxText();
		colorSwatch = Game.pools.getDefaultColorSwatch();
		
		teamName.size = 30;
		teamName.fieldWidth = colorSwatch.width * 1.75;
		teamName.text = "Team " + colorSwatch.getColorName();
		teamName.alignment = FlxTextAlign.CENTER;
		
		colorSwatch.setMidTop(teamName.getMidBottom());
		colorSwatch.colorChangedCallback = updateTeamName;
		colorSwatch.y += 20;
		
		add(teamName);
		add(colorSwatch);
		
		updateTeamName(colorSwatch);
		colorSwatch.fixSelector();
	}
	
	private function updateTeamName(colorSwatch:ColorSwatchSelector) {
		teamName.text = "Team " + colorSwatch.getColorName();
		teamName.color = colorSwatch.getColor();
	}
	
}