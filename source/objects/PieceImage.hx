package objects;

import backend.animation.AnimationController;
import flixel.FlxSprite;
import flixel.math.FlxRect;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.system.FlxAssets;

class PieceImage extends FlxSprite {
	private var image_path:String;
	private var xml_path:String;

	public function new(image_path:String, xml_path:String, key:String) {
		super(0, 0);
		this.animation = new AnimationController(this);
		this.image_path = image_path;
		this.xml_path = xml_path;
		update_piece(key);
	}

	public function update_piece(key:String):Void {
		/*for (child in this.sheet_xml.elements()) {
			if (child.nodeName == "SubTexture" && child.exists("name") && child.get("name") == key) {
				var offsetX:Int = Std.parseInt(child.get("offsetX"));
				var offsetY:Int = Std.parseInt(child.get("offsetY"));
				var width:Int = Std.parseInt(child.get("width"));
				var height:Int = Std.parseInt(child.get("height"));
				var x:Int = Std.parseInt(child.get("x"));
				var y:Int = Std.parseInt(child.get("y"));
				var rotated:Bool = child.get("rotated") == "true";
				//this.clipRect = new FlxRect(x, y, width, height);

				//this.offset.set(offsetX, offsetY);
				return;
			}
		}*/ 
		this.antialiasing = true;
		this.frames = FlxAtlasFrames.fromSparrow(this.image_path, this.xml_path); 
		this.animation.addByPrefix("idle", key, 30);
		this.animation.play("idle");
	}
}