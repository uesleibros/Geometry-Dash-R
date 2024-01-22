package backend;

import flixel.FlxState;
import hscript.Parser;
import hscript.Expr;
import hscript.Interp;
import haxe.ds.StringMap;

class GDHScript {
	private var expr:Expr;
	private var parser:Parser = new Parser();
	private var interp:Interp = new Interp();

	/**
	 * Constructor of GDHScript.
	 * @param script The script for parser.
	 * @param state The current state.
	 */
	public function new(script:String, ?state:FlxState = null) {
		parser.allowJSON = true;
		parser.allowTypes = true;
		parser.allowMetadata = true;

		expr = parser.parseString(script);

		create_variables(state);
		interp.execute(expr);
	}

	private function create_variables(state:FlxState):Void {
		// Haxe
		set_variable("Math", Math);
		set_variable("LimeAssets", lime.utils.Assets);
		set_variable("Assets", openfl.utils.Assets);
		set_variable("Std", Std);
		set_variable("StringTools", StringTools);
		set_variable("trace", function(value:Dynamic) {
			trace(value);
		});

		// Flixel
		set_variable("FlxG", flixel.FlxG);
		set_variable("FlxSprite", flixel.FlxSprite);
		set_variable("FlxMath", flixel.math.FlxMath);
		set_variable("FlxText", flixel.text.FlxText);
		set_variable("FlxAtlasFrames", flixel.graphics.frames.FlxAtlasFrames);
		set_variable("FlxTypedGroup", flixel.group.FlxGroup.FlxTypedGroup);
		set_variable("FlxSpriteGroup", flixel.group.FlxSpriteGroup);
		set_variable("FlxTypedSpriteGroup", flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup);

		// Custom (Objects)
		set_variable("PieceImage", objects.PieceImage);

		// State
		if (state != null) {
			set_variable("state", state);
			set_variable("add", state.add);
		}
	}

	/**
	 * Set a new variable for GD HScript.
	 * @param name Name of variable.
	 * @param value Value of variable (can be an function).
	 */
	public function set_variable(name:String, value:Dynamic):Void {
		interp.variables.set(name, value);
	}

	/**
	 * Run a defined function from script.
	 * @param name Name of function.
	 * @param args Arguments to pass on function.
	 */
	public function run_function(name:String, ?args:Array<Any>):Void {
		var func:Dynamic = interp.variables.get(name);
		if (func != null && Reflect.isFunction(func)) {
			try {
				Reflect.callMethod(interp, func, args);
			} catch (e:Dynamic) {
				trace("Error while calling function " + name + ": " + e);
			}
		} else {
			trace("Function " + name + " is not defined or is not a function.");
		}
	}
}