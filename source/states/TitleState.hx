package states;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.group.FlxGroup.FlxTypedGroup;

import objects.PieceImage;

class TitleState extends flixel.FlxState {
	private var ui_buttons:FlxTypedGroup<PieceImage>;
	private var gj_logo:PieceImage;
	private var bg:FlxSprite;
	private var gjLogoTween:FlxTween;

	override public function create():Void {
		var play_button:PieceImage;
		var create_button:PieceImage;

		ui_buttons = new FlxTypedGroup<PieceImage>();

		bg = new FlxSprite();
		bg.makeGraphic(FlxG.width, FlxG.height);
		bg.loadGraphic(AssetPaths.default_bg__png, false);
		bg.updateHitbox();
		bg.screenCenter();
		bg.color = 0xFFfd719b;

		gj_logo = new PieceImage("assets/images/menu/GJ_LaunchSheet.png", "assets/data/menu/GJ_LaunchSheet.xml", "GJ_logo");
		gj_logo.scale.set(0.6, 0.6);
		gj_logo.updateHitbox();

		play_button = new PieceImage("assets/images/menu/GJ_MenuButtonsSheet.png", "assets/data/menu/GJ_MenuButtonsSheet.xml", "PlayButton");
		create_button = new PieceImage("assets/images/menu/GJ_MenuButtonsSheet.png", "assets/data/menu/GJ_MenuButtonsSheet.xml", "CreatorButton");

		play_button.scale.set(0.6, 0.6);
		play_button.updateHitbox();

		play_button.screenCenter();
		play_button.y += 30;

		create_button.scale.set(0.6, 0.6);
		create_button.updateHitbox();

		create_button.screenCenter();
		create_button.y = play_button.y + 40;
		create_button.x += play_button.width;

		ui_buttons.add(play_button);
		ui_buttons.add(create_button);

		add(bg);
		add(ui_buttons);
		add(gj_logo);

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

		super.update(elapsed);
	}
}
