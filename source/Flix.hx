package;

import flixel.addons.effects.FlxTrail;
import flixel.plugin.MouseEventManager;

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
		
		makeGraphic(100, 1, FlxColor.WHITE);
		
		
		// Setup the mouse events
		MouseEventManager.addSprite(this, onDown, onUp, onOver, onOut);
	}
	
	public function set(X:Float, Y:Float):Void 
	{
		set_x(X);
		set_y(Y);
	}
	
	private function onDown(Sprite:FlxSprite)
	{
		//color = 0x00FF00;
		color = FlxColor.ROYAL_BLUE;
	}
	
	private function onUp(Sprite:FlxSprite) 
	{
		// move to mouse location
		set_x(FlxG.mouse.screenX);
		set_y(FlxG.mouse.screenY);		
	}
	
	private function onOver(Sprite:FlxSprite) 
	{
		//color = 0x00FF00;
		color = FlxColor.SILVER;
	}
	
	private function onOut(Sprite:FlxSprite)
	{
		color = FlxColor.WHITE;	
	}
}