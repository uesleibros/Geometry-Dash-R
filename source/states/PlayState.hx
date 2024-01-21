package states;

import flixel.FlxState;

class PlayState extends FlxState
{
	override public function create() {
		var text = new flixel.text.FlxText(0, 0, 0, "Teste", 64);
		text.screenCenter();
		add(text);
		super.create();
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
	}
}
