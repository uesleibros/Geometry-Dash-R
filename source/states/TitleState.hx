package states;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.group.FlxGroup.FlxTypedGroup;
import sys.io.File;

import objects.PieceImage;
import backend.GDHScript;

class TitleState extends flixel.FlxState {
	public var ui_buttons_group:FlxTypedGroup<PieceImage>;
	public var gj_logo:PieceImage;
	public var bg:FlxSprite;
	public var gjLogoTween:FlxTween;
	public var script:GDHScript;

	override public function create():Void {
		script = new GDHScript(File.getContent("mods/TitleState.hx"), this);

		var robtop_logo:PieceImage;
		var play_button:PieceImage;
		var create_button:PieceImage;
		var more_games_button:PieceImage;

		ui_buttons_group = new FlxTypedGroup<PieceImage>();

		bg = new FlxSprite();
		bg.makeGraphic(FlxG.width, FlxG.height);
		bg.loadGraphic(AssetPaths.default_bg__png, false);
		bg.updateHitbox();
		bg.screenCenter();
		bg.color = 0xFFADD8E6;

		gj_logo = new PieceImage("assets/images/menu/GJ_LaunchSheet.png", "assets/data/menu/GJ_LaunchSheet.xml", "GJ_logo");
		gj_logo.scale.set(0.6, 0.6);
		gj_logo.updateHitbox();

		robtop_logo = new PieceImage("assets/images/menu/GJ_LaunchSheet.png", "assets/data/menu/GJ_LaunchSheet.xml", "RobTop_logo");
		robtop_logo.scale.set(0.3, 0.3);
		robtop_logo.updateHitbox();

		robtop_logo.x += 15;
		robtop_logo.y = (FlxG.height - robtop_logo.height) - 15;

		play_button = new PieceImage("assets/images/menu/GJ_MenuButtonsSheet.png", "assets/data/menu/GJ_MenuButtonsSheet.xml", "PlayButton");
		create_button = new PieceImage("assets/images/menu/GJ_MenuButtonsSheet.png", "assets/data/menu/GJ_MenuButtonsSheet.xml", "CreatorButton");
		more_games_button = new PieceImage("assets/images/menu/GJ_MenuButtonsSheet.png", "assets/data/menu/GJ_MenuButtonsSheet.xml", "MoreGamesButton");

		play_button.scale.set(0.6, 0.6);
		play_button.updateHitbox();

		play_button.screenCenter();
		play_button.y += 30;

		create_button.scale.set(0.6, 0.6);
		create_button.updateHitbox();

		create_button.screenCenter();
		create_button.y = play_button.y + 40;
		create_button.x += play_button.width;

		more_games_button.scale.set(0.5, 0.5);
		more_games_button.updateHitbox();

		more_games_button.x = (FlxG.width - more_games_button.width) - 15;
		more_games_button.y = (FlxG.height - more_games_button.height) - 15;

		ui_buttons_group.add(play_button);
		ui_buttons_group.add(create_button);
		ui_buttons_group.add(more_games_button);

		add(bg);
		add(ui_buttons_group);
		add(gj_logo);
		add(robtop_logo);

		script.run_function("create");

		FlxG.sound.playMusic(AssetPaths.menuLoop__ogg, 0.5, true);
		pulseGJLogoOnBeat();
		super.create();
	}

	private function onPulseTimer(timer:FlxTimer):Void {
		if (gjLogoTween != null)
			gjLogoTween.cancel();

		gj_logo.scale.x = 0.6;
		gj_logo.scale.y = 0.6;

		gjLogoTween = FlxTween.tween(gj_logo.scale, {x: 0.65, y: 0.65}, 0.05, {
			onComplete: function(twn:FlxTween) {
				gjLogoTween = null;
				gj_logo.scale.x = 0.6;
				gj_logo.scale.y = 0.6;
				timer.destroy();
			} 
		});
   }

   private function onMouseOver(_):Void {

   }

   private function pulseGJLogoOnBeat():Void {
   	new FlxTimer().start(0.5, (timer:FlxTimer)->{ 
   		onPulseTimer(timer);
   		pulseGJLogoOnBeat();
   	});
   }

	override public function update(elapsed:Float):Void {
		gj_logo.screenCenter();
		gj_logo.y -= 230;

		script.run_function("update", [elapsed]);
		super.update(elapsed);
	}
}
