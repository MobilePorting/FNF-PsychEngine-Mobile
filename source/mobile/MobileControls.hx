package mobile;

import mobile.flixel.FlxHitbox;
import mobile.flixel.FlxVirtualPad;
import flixel.FlxG;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxPoint;
import flixel.util.FlxDestroyUtil;
import mobile.flixel.FlxMobileControlsID;

class MobileControls extends FlxSpriteGroup
{
	public static var instance:MobileControls;
	public var virtualPad:FlxVirtualPad;
	public var hitbox:FlxHitbox;

	public function new()
	{
		instance = this;
		super();
		switch (MobileControls.getMode())
		{
			case 0: // RIGHT_FULL
				initControler(0);
			case 1: // LEFT_FULL
				initControler(1);
			case 2: // CUSTOM
				initControler(2);
			case 3: // BOTH_FULL
				initControler(3);
			case 4: // HITBOX
				initControler(4);
			case 5: // KEYBOARD
		}
	}

	private function initControler(virtualPadMode:Int = 0):Void
	{
		switch (virtualPadMode)
		{
			case 0:
				virtualPad = new FlxVirtualPad(RIGHT_FULL, NONE);
				add(virtualPad);
			case 1:
				virtualPad = new FlxVirtualPad(LEFT_FULL, NONE);
				add(virtualPad);
			case 2:
				virtualPad = MobileControls.getCustomMode(new FlxVirtualPad(RIGHT_FULL, NONE));
				add(virtualPad);
			case 3:
				virtualPad = new FlxVirtualPad(BOTH_FULL, NONE);
				add(virtualPad);
			case 4:
			if (!ClientPrefs.data.hitbox1)
					hitbox = new FlxHitbox(DEFAULT);
			else 
					hitbox = new FlxHitbox(EXTRA);

				add(hitbox);
		}
	}

	override public function destroy():Void
	{
		super.destroy();

		if (virtualPad != null)
		{
			virtualPad = FlxDestroyUtil.destroy(virtualPad);
			virtualPad = null;
		}

		if (hitbox != null)
		{
			hitbox = FlxDestroyUtil.destroy(hitbox);
			hitbox = null;
		}
	}

	public static function setOpacity(opacity:Float = 0.6):Void
	{
		FlxG.save.data.mobileControlsOpacity = opacity;
		FlxG.save.flush();
	}

	public static function getOpacity():Float
	{
		if (FlxG.save.data.mobileControlsOpacity == null)
		{
			FlxG.save.data.mobileControlsOpacity = 0.6;
			FlxG.save.flush();
		}

		return FlxG.save.data.mobileControlsOpacity;
	}

	public static function setMode(mode:Int = 0):Void
	{
		FlxG.save.data.mobileControlsMode = mode;
		FlxG.save.flush();
	}

	public static function getMode():Int
	{
		if (FlxG.save.data.mobileControlsMode == null)
		{
			FlxG.save.data.mobileControlsMode = 0;
			FlxG.save.flush();
		}

		return FlxG.save.data.mobileControlsMode;
	}

	public static function setCustomMode(virtualPad:FlxVirtualPad):Void
	{
		if (FlxG.save.data.buttons == null)
		{
			FlxG.save.data.buttons = new Array();
			for (buttons in virtualPad)
				FlxG.save.data.buttons.push(FlxPoint.get(buttons.x, buttons.y));
		}
		else
		{
			var tempCount:Int = 0;
			for (buttons in virtualPad)
			{
				FlxG.save.data.buttons[tempCount] = FlxPoint.get(buttons.x, buttons.y);
				tempCount++;
			}
		}

		FlxG.save.flush();
	}

	public static function getCustomMode(virtualPad:FlxVirtualPad):FlxVirtualPad
	{
		var tempCount:Int = 0;

		if (FlxG.save.data.buttons == null)
			return virtualPad;

		for (buttons in virtualPad)
		{
			buttons.x = FlxG.save.data.buttons[tempCount].x;
			buttons.y = FlxG.save.data.buttons[tempCount].y;
			tempCount++;
		}

		return virtualPad;
	}
	public static function mobileControlsPressed(buttonID:FlxMobileControlsID){
		switch (getMode()) {
			case 0 | 1 | 2 | 3:
			switch (buttonID)
			{
				case FlxMobileControlsID.LEFT:
					return virtualpad.buttonLeft.pressed;
				case FlxMobileControlsID.UP:
					return virtualpad.buttonUp.pressed;
				case FlxMobileControlsID.RIGHT:
					return virtualpad.buttonRight.pressed;
				case FlxMobileControlsID.DOWN:
					return virtualpad.buttonDown.pressed;
				case FlxMobileControlsID.LEFT2:
					return virtualpad.buttonLeft2.pressed;
				case FlxMobileControlsID.UP2:
					return virtualpad.buttonUp2.pressed;
				case FlxMobileControlsID.RIGHT2:
					return virtualpad.buttonRight2.pressed;
				case FlxMobileControlsID.DOWN2:
					return virtualpad.buttonDown2.pressed;
				case FlxMobileControlsID.NONE:
					return false;
				default:
					return false;
			}
			case 4:
			switch (buttonID)
			{
				case FlxMobileControlsID.hitboxLEFT:
					return hitbox.buttonLeft.pressed;
				case FlxMobileControlsID.hitboxUP:
					return hitbox.buttonUp.pressed;
				case FlxMobileControlsID.hitboxRIGHT:
					return hitbox.buttonRight.pressed;
				case FlxMobileControlsID.hitboxDOWN:
					return htibox.buttonDown.pressed;
				case FlxMobileControlsID.NONE:
					return false;
				default:
					return false;
			}
			case 5: //none
		}
	}
	public static function mobileControlsJustPressed(buttonID:FlxMobileControlsID){
		switch (getMode()) {
			case 0 | 1 | 2 | 3:
			switch (buttonID)
			{
				case FlxMobileControlsID.LEFT:
					return virtualpad.buttonLeft.justPressed;
				case FlxMobileControlsID.UP:
					return virtualpad.buttonUp.justPressed;
				case FlxMobileControlsID.RIGHT:
					return virtualpad.buttonRight.justPressed;
				case FlxMobileControlsID.DOWN:
					return virtualpad.buttonDown.justPressed;
				case FlxMobileControlsID.LEFT2:
					return virtualpad.buttonLeft2.justPressed;
				case FlxMobileControlsID.UP2:
					return virtualpad.buttonUp2.justPressed;
				case FlxMobileControlsID.RIGHT2:
					return virtualpad.buttonRight2.justPressed;
				case FlxMobileControlsID.DOWN2:
					return virtualpad.buttonDown2.justPressed;
				case FlxMobileControlsID.NONE:
					return false;
				default:
					return false;
			}
			case 4:
			switch (buttonID)
			{
				case FlxMobileControlsID.hitboxLEFT:
					return hitbox.buttonLeft.justPressed;
				case FlxMobileControlsID.hitboxUP:
					return hitbox.buttonUp.justPressed;
				case FlxMobileControlsID.hitboxRIGHT:
					return hitbox.buttonRight.justPressed;
				case FlxMobileControlsID.hitboxDOWN:
					return hitbox.buttonDown.justPressed;
				case FlxMobileControlsID.NONE:
					return false;
				default:
					return false;
			}
			case 5: //none
		}
	}
	public static function mobileControlsJustReleased(buttonID:FlxMobileControlsID){
		switch (getMode()) {
			case 0 | 1 | 2 | 3:
			switch (buttonID)
			{
				case FlxMobileControlsID.LEFT:
					return virtualpad.buttonLeft.justReleased;
				case FlxMobileControlsID.UP:
					return virtualpad.buttonUp.justReleased;
				case FlxMobileControlsID.RIGHT:
					return virtualpad.buttonRight.justReleased;
				case FlxMobileControlsID.DOWN:
					return virtualpad.buttonDown.justReleased;
				case FlxMobileControlsID.LEFT2:
					return virtualpad.buttonLeft2.justReleased;
				case FlxMobileControlsID.UP2:
					return virtualpad.buttonUp2.justReleased;
				case FlxMobileControlsID.RIGHT2:
					return virtualpad.buttonRight2.justReleased;
				case FlxMobileControlsID.DOWN2:
					return virtualpad.buttonDown2.justReleased;
				case FlxMobileControlsID.NONE:
					return false;
				default:
					return false;
			}
			case 4:
			switch (buttonID)
			{
				case FlxMobileControlsID.hitboxLEFT:
					return hitbox.buttonLeft.justReleased;
				case FlxMobileControlsID.hitboxUP:
					return hitbox.buttonUp.justReleased;
				case FlxMobileControlsID.hitboxRIGHT:
					return hitbox.buttonRight.justReleased;
				case FlxMobileControlsID.hitboxDOWN:
					return hitbox.buttonDown.justReleased;
				case FlxMobileControlsID.NONE:
					return false;
				default:
					return false;
			}
			case 5: //none
		}
	}
		
}
