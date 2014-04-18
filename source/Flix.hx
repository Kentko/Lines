package;

import flixel.addons.effects.FlxTrail;
import flixel.plugin.MouseEventManager;
import flixel.util.FlxPoint;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;

import flixel.group.FlxGroup;

import flash.display.Bitmap;
import flixel.system.scaleModes.FixedScaleMode;
import flixel.util.FlxColor;

// line drawing class 
class Flix extends FlxSprite
{
	
	public function new(X:Float, Y:Float):Void
	{
		super(X, Y);		
		makeGraphic(100, 8, FlxColor.WHITE);
	}
	
	public function set(X:Float, Y:Float):Void 
	{
		set_x(X);
		set_y(Y);
	}
}