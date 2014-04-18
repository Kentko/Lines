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

import flixel.tweens.FlxTween;
//import flixel.tweens.FlxEase;

// A FlxState which can be used for the game's menu.
class MenuState extends FlxState
{
	// variables
	private var _topWall:FlxSprite;
	private var _rightWall:FlxSprite;
	private var _bottomWall:FlxSprite;
	private var _leftWall:FlxSprite;
	
	private var _wallThickness:Int;
	
	private var _walls:FlxGroup;
	
	private var _line1:Flix;
	
	private var dragging:Bool = false;
	
	
	override public function create():Void
	{
		super.create();
		
		FlxG.mouse.visible = true;
		
		createWalls(15);
		
		// We need the MouseEventManager plugin for sprite-mouse-interaction
		//  must add this before sprites mouse interacts with
		//FlxG.plugins.add(new MouseEventManager());
		
		_line1 = new Flix(FlxG.width / 2, FlxG.height / 2);
		add(_line1);
	
	}
	
	// Add four walls in a FlxGroup with equal thicknesses
	private function createWalls(thickness:Int)
	{
		_wallThickness = thickness;
		
		_bottomWall = new FlxSprite(_wallThickness, FlxG.height - _wallThickness);
		_bottomWall.makeGraphic(FlxG.width - (2 * _wallThickness), _wallThickness, FlxColor.SALMON);
			
		_topWall = new FlxSprite(_wallThickness, 0);
		_topWall.makeGraphic(FlxG.width - (2 * _wallThickness), _wallThickness, FlxColor.TAN);
			
		_rightWall = new FlxSprite(FlxG.width - _wallThickness, 0);
		_rightWall.makeGraphic(_wallThickness, FlxG.height, FlxColor.MEDIUM_BLUE);
			
		_leftWall = new FlxSprite(0, 0);
		_leftWall.makeGraphic(_wallThickness, FlxG.height, FlxColor.ROYAL_BLUE);
			
		_walls = new FlxGroup();
		_walls.add(_bottomWall);
		_walls.add(_rightWall);
		_walls.add(_topWall);
		_walls.add(_leftWall);
		
		add(_walls);
	}

	//Function that is called when this state is destroyed - you might want to 
	//consider setting all objects this state uses to null to help garbage collection.
	override public function destroy():Void
	{
		super.destroy();
	}

	//Function that is called once every frame.
	override public function update():Void
	{
		
		
		super.update();
		
		if (FlxG.mouse.justReleased)
		{
			dragging = false;
		}	
		
		if (FlxG.mouse.pressed)
		{
			if (dragging == true || _line1.overlapsPoint(FlxG.mouse, true))
			{
				dragging = true;
				_line1.set(FlxG.mouse.screenX, FlxG.mouse.screenY);
			}
		}
		
	}
}