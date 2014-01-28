package com.captain.theater;

import flash.display.Sprite;
import flash.errors.Error;
import flash.events.Event;
import flash.Lib;

/**
 * ...
 * @author Joshua Morgan
 */
class TheaterCore extends Sprite
{
	private var BaseGameWidth = 320;
	private var BaseGameHeight = 480;
	public static var gameWidth = -1;
	public static var gameHeight = -1;
	
	private static var instance:TheaterCore;
	public static function GetInstance()
	{
		if (instance == null)
		{
			instance = new TheaterCore();
		}
		return instance;
	}
	
	public function new() 
	{
		if (TheaterCore.instance != null)
		{
			var error = new Error("ONLY ONE INSTANCE OF GameCore SHOULD EXIST!", 666);
			throw(error);
		}
		
		super();
		placeAndSize();
		
		gameInit();
		
		Lib.current.stage.addEventListener(Event.RESIZE, screenResize);
		
		#if debug
		debugStageDraw();
		#end
	}
	
	private function gameInit()
	{
		
	}
	
	private function screenResize(?e:Event)
	{
		placeAndSize();
		
		#if debug
		debugStageDraw();
		#end
	}
	
	private function placeAndSize()
	{
		var sw = Lib.current.stage.stageWidth;
		var sh = Lib.current.stage.stageHeight;
		
		this.x = sw / 2;
		this.y = sh / 2;
		
		var ratio = sw / sh;
		var targetRatio = BaseGameWidth / BaseGameHeight;
		
		if (ratio > targetRatio) // height needs to scale, width needs to expand
		{
			this.scaleX = this.scaleY = (sh / BaseGameHeight);
			gameWidth = Math.round(sw / this.scaleX);
			gameHeight = BaseGameHeight;
		}
		else  // width needs to scale, height needs to expand
		{
			this.scaleX = this.scaleY = (sw / BaseGameWidth);
			gameWidth = BaseGameWidth;
			gameHeight = Math.round(sh / this.scaleY);
		}
	}
	
	private function debugStageDraw()
	{
		graphics.clear();
		
		graphics.beginFill(0x00ff00);
		graphics.drawRect( -gameWidth / 2, -gameHeight / 2, gameWidth, gameHeight);
		graphics.endFill();
		
		graphics.beginFill(0xff00ff);
		graphics.drawCircle(0, 0, 10);
		graphics.endFill();
		
	}
}