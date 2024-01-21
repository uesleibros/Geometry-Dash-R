package objects;

import flixel.FlxSprite;
import flixel.math.FlxRect;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.system.FlxAssets;

class PieceImage extends FlxSprite {
	private var image_path:String;
	private var xml_path:String;

	public function new(image_path:String, xml_path:String, key:String) {
		super(0, 0);
		this.image_path = image_path;
		this.xml_path = xml_path;
		update_piece(key);
	}

	public function update_piece(key:String):Void {
		this.antialiasing = true;
		this.frames = FlxAtlasFrames.fromSparrow(this.image_path, this.xml_path); 
		this.animation.addByPrefix("idle", key, 30);
		this.animation.play("idle");
	}
}