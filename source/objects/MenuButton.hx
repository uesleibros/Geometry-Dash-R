package objects;

import flixel.FlxSprite;
import flixel.input.mouse.FlxMouseEvent;

class MenuButton extends FlxSprite {
	public function new(sprite:FlxSprite) {
		super(sprite.x, sprite.y, sprite.graphic);
		this.width = sprite.width;
		this.height = sprite.height;

		FlxMouseEvent.add(this, onDown, null, onOver, onOut);
	}

	private function onDown(_) {}

	private function onOver(_) {
		this.scale.x = this.scale.y = 1.2;
	}

	private function onOut(_) {
		this.scale.x = this.scale.y = 1.0;
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
	}
}