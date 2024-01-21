package;

import flixel.FlxGame;
import openfl.display.FPS;
import openfl.display.Sprite;

class Main extends Sprite
{
	public static var fpsCounter:FPS;
	var screen_width:Int = 1280;
	var screen_height:Int = 680;

	public function new()
	{
		super();

		fpsCounter = new FPS(10, 3, 0xFFFFFF);
		addChild(new FlxGame(0, 0, states.TitleState, 60, 60, true, false));
		addChild(fpsCounter);
	}
}
