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
import flixel.tweens.FlxEase;
import flixel.util.FlxRandom;

class PlayState extends FlxState
{
	// variables
	private var _topWall:FlxSprite;
	private var _rightWall:FlxSprite;
	private var _bottomWall:FlxSprite;
	private var _leftWall:FlxSprite;
	
	private var _wallThickness:Int;
	
	private var _walls:FlxGroup;
	
	private var _line1:Flix;
	private var _lineTween:Flix;
	
	private var dragging:Bool = false;
	private var deltaX:Float;
	private var deltaY:Float;
	private var pointerLocation:FlxPoint;
	
	
	override public function create():Void
	{
		super.create();
		
		FlxG.mouse.visible = true;
		FlxG.debugger.visible = true;
		
		createWalls(15);
		
		_line1 = new Flix(FlxG.width / 2, FlxG.height / 2);
		add(_line1);
		
		FlxTween.color(_line1, 2.0, FlxColor.PINK, FlxColor.RED, 1, 1, { ease: FlxEase.sineInOut, type: FlxTween.PINGPONG });
		
		
		_lineTween = new Flix(FlxG.width / 3, FlxG.height / 3);
		add(_lineTween);
		
		//FlxTween.tween(_lineTween, { x:350, y:400 }, 4, { type:FlxTween.PINGPONG, ease:FlxEase.sineInOut, complete:changeColor, startDelay:.2, loopDelay:2 } );
		FlxTween.circularMotion(_lineTween, 250, 250, 50, 0, true, 2, true, { type:FlxTween.PINGPONG, ease:FlxEase.sineInOut, complete:changeColor, startDelay:.2, loopDelay:2 } );
		//FlxTween.cubicMotion(_lineTween, 0, 0, 500, 100, 400, 200, 100, 100, 2, { type:FlxTween.PINGPONG, ease:FlxEase.sineInOut, complete:changeColor, startDelay:.2, loopDelay:2 });
		
		pointerLocation = new FlxPoint();		
		
	}
	
	private function changeColor(tween:FlxTween):Void
	{
		_lineTween.color = FlxRandom.color();
	}
	
	// Add four walls in a FlxGroup with equal thicknesses
	private function createWalls(thickness:Int)
	{
		_wallThickness = thickness;
		
		_bottomWall = new FlxSprite(_wallThickness, FlxG.height - _wallThickness);
		_bottomWall.makeGraphic(FlxG.width - (2 * _wallThickness), _wallThickness, FlxRandom.colorExt(5, 50, 123, 255, 144, 255,-1,-1));
		_bottomWall.immovable = true;
			
		_topWall = new FlxSprite(_wallThickness, 0);
		_topWall.makeGraphic(FlxG.width - (2 * _wallThickness), _wallThickness, FlxRandom.color());
		_topWall.immovable = true;
			
		_rightWall = new FlxSprite(FlxG.width - _wallThickness, 0);
		_rightWall.makeGraphic(_wallThickness, FlxG.height, FlxRandom.color());
		_rightWall.immovable = true;
			
		_leftWall = new FlxSprite(0, 0);
		_leftWall.makeGraphic(_wallThickness, FlxG.height, FlxRandom.color());
		_leftWall.immovable = true;
			
		_walls = new FlxGroup();
		_walls.add(_bottomWall);
		_walls.add(_rightWall);
		_walls.add(_topWall);
		_walls.add(_leftWall);
		
		add(_walls);
		
		FlxTween.color(_topWall, 2.0, FlxRandom.color(), FlxRandom.color(), 1, 1, { ease: FlxEase.sineInOut, type: FlxTween.PINGPONG } );
		FlxTween.color(_bottomWall, 2.0, FlxRandom.color(), FlxRandom.color(), 1, 1, { ease: FlxEase.sineInOut, type: FlxTween.PINGPONG });
		FlxTween.color(_rightWall, 2.0, FlxRandom.color(), FlxRandom.color(), 1, 1, { ease: FlxEase.sineInOut, type: FlxTween.PINGPONG });
		FlxTween.color(_leftWall, 2.0, FlxRandom.color(), FlxRandom.color(), 1, 1, { ease: FlxEase.sineInOut, type: FlxTween.PINGPONG });
		
		
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
				
		#if debug
		FlxG.watch.add(_line1, "x" );
		FlxG.watch.add(_line1, "y" );
		FlxG.watch.add(FlxG.mouse, "screenX");
		FlxG.watch.add(FlxG.mouse, "screenY");
		#end
				
		pointerLocation.x = FlxG.mouse.screenX;
		pointerLocation.y = FlxG.mouse.screenY;
				
		if (FlxG.mouse.justReleased)
		{
			dragging = false;
		}
		
		if (FlxG.mouse.justPressed && _line1.overlapsPoint(FlxG.mouse, true))
		{
			dragging = true;
			
			// calculate x and y offsets to line's origin
			deltaX = pointerLocation.x - _line1.x;
			deltaY = pointerLocation.y - _line1.y;
		}
		
		if (FlxG.mouse.pressed && dragging == true)
		{
			_line1.set(pointerLocation.x - deltaX, pointerLocation.y - deltaY);
		}
		
		FlxG.collide(_line1, _walls);
		
	}
}