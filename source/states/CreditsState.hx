package;

#if desktop
import Discord.DiscordClient;
#end
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.math.FlxRect;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.utils.Assets;

using StringTools;

class CreditsState extends MusicBeatState
{
	var estatica:FlxSprite;
	var title:FlxText;
	var devrole:FlxText;
	var para1:FlxText;
	var bg:FlxSprite;
	var specialThanksY:Float;

	var camFollow:FlxObject;
	var camFollowPos:FlxObject;
	var newPos:Float;

	var lyricsTimingArray:Array<Float> = [
		12.3, //INTRO
		31.06,//O, How sweet
		33.7, //A bitter defeat
		36.16,//at hands of all of us
		40.05,//and all of me
		42.9, //And after its over
		44.9, //And after the final Curtain has closed.
		48.4, //So when the script is made true
		51.7, //Complete removal of you,
		54.7, //Is the outcome
		59.5, //Is this really the outcome?
		65.5, //...
		72.1, //But will it be the same...
		76.6, //With you gone?
		80.1, //It's a mad, mad world
		86.4, //It's a mad world
		92.6, //It's a mad, mad world
		98.8, //Without you...
		101.5, //...
		104.4, //The stage is set
		111,   //Our great production
		117,   //You've met your maker
		120.2, //Ive said my peace
		125.02,//So why won't this feeling cease?
		128.9, //...
		131.15,//And so it clutches around my soul,
		135.15,//...
		137.4, //I feel the bitter, everlasting cold.
		141.27,//...
		144,   //Is this what I wanted?
		147.15,//Am I satisfied?
		149.15,//And now I'm standing tall
		151.98,//Yet all I want to do
		154.92,//is hide inside
		157.97,//this empty shell
		161.15,//this husk
		162.68,//this world
		164.26,//this empty hell
		167.46,//I wander through
		170.42,//My song reigns true
		173.63,//The world is mad
		176.22,//And I am too
		180.17 //Without you...
	];

	public static var autoscroll:Bool = false;

	var bgEasterEggArray:Array<FlxSprite> = [];

	override public function create()
	{
		camFollow = new FlxObject(0, 0, 1, 1);
		camFollowPos = new FlxObject(0, 0, 1, 1);
		add(camFollow);
		add(camFollowPos);

		camFollowPos.setPosition(640, 200);
		FlxG.camera.follow(camFollowPos, null, 1);
		FlxG.mouse.visible = true;

		bg = new FlxSprite(0, 0).loadGraphic(Paths.image('modstuff/freeplay/HUD_Freeplay_2'));
		bg.antialiasing = ClientPrefs.globalAntialiasing;
		bg.updateHitbox();
		bg.screenCenter(XY);
		bg.color = FlxColor.RED;
		bg.scrollFactor.set(0, 0);
		add(bg);

		estatica = new FlxSprite();
		estatica.frames = Paths.getSparrowAtlas('modstuff/estatica_uwu');
		estatica.animation.addByPrefix('idle', "Estatica papu", 15);
		estatica.animation.play('idle');
		estatica.antialiasing = false;
		estatica.color = FlxColor.RED;
		estatica.alpha = 0.3;
		estatica.scrollFactor.set(0, 0);
		estatica.updateHitbox();
		add(estatica);

		var bg2:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image('credits/credits1'));
		bg2.antialiasing = ClientPrefs.globalAntialiasing;
		bg2.updateHitbox();
		bg2.screenCenter(XY);
		bg2.scrollFactor.set(0, 0);
		add(bg2);

		for(i in 0...7){
			var shit:FlxSprite = new FlxSprite().loadGraphic(Paths.image('credits/scroll/scroll${i + 1}'));
			shit.screenCenter();
			shit.alpha = 0;
			shit.scrollFactor.set();
			if(autoscroll){
				add(shit);
				bgEasterEggArray.push(shit);
			}
		}
		if(autoscroll){
			// I KNOW THIS FUCKING SUCKS ITS 2 HOURS AWAY FROM RELEASE I DONT CAAAAREEEEE MAKE FUN OF ME ALL YOU WANNTTTT
			FlxTween.tween(bgEasterEggArray[0], {alpha: 1}, 20, {onComplete: function(shit:FlxTween){
				FlxTween.tween(bgEasterEggArray[0], {alpha: 0}, 5, {onComplete: function(shit:FlxTween){
					FlxTween.tween(bgEasterEggArray[1], {alpha: 1}, 20, {onComplete: function(shit:FlxTween){
						FlxTween.tween(bgEasterEggArray[1], {alpha: 0}, 5, {onComplete: function(shit:FlxTween){
							FlxTween.tween(bgEasterEggArray[2], {alpha: 1}, 20, {onComplete: function(shit:FlxTween){
								FlxTween.tween(bgEasterEggArray[2], {alpha: 0}, 5, {onComplete: function(shit:FlxTween){
									FlxTween.tween(bgEasterEggArray[3], {alpha: 1}, 20, {onComplete: function(shit:FlxTween){
										FlxTween.tween(bgEasterEggArray[3], {alpha: 0}, 5, {onComplete: function(shit:FlxTween){
											FlxTween.tween(bgEasterEggArray[4], {alpha: 1}, 20, {onComplete: function(shit:FlxTween){
												FlxTween.tween(bgEasterEggArray[4], {alpha: 0}, 5, {onComplete: function(shit:FlxTween){
													FlxTween.tween(bgEasterEggArray[5], {alpha: 1}, 20, {onComplete: function(shit:FlxTween){
														FlxTween.tween(bgEasterEggArray[5], {alpha: 0}, 5, {onComplete: function(shit:FlxTween){
															FlxTween.tween(bgEasterEggArray[6], {alpha: 1}, 20);
														}});
													}});
												}});
											}});
										}});
									}});
								}});
							}});
						}});
					}});
				}});
			}});
		}
		for(i in 0...41){
			var creditX = 430;
			var creditY = i * 300 + 60;
			//if(i % 2 != 0)
				//creditX += 250;

			var infoArray:Array<String> = CoolUtil.coolTextFile(Paths.txt("creditsTexts/dev" + Std.string(i + 1)));

			var icon:FlxSprite = new FlxSprite(creditX - 480, creditY - 160).loadGraphic(Paths.image('credits/Char' + Std.string(i + 1)));
			icon.color = FlxColor.RED;
			icon.setGraphicSize(Std.int(icon.width * 0.85));
			add(icon);		

			var blackBox = new FlxSprite(icon.x + 450, icon.y + 151).makeGraphic(500, 275, FlxColor.BLACK);
			blackBox.alpha = 0.5;
			add(blackBox);

			if(i % 2 != 0)
				icon.x = creditX + 420;

			title = new FlxText(creditX, creditY - 10, 0, "", 32);
			title.text = infoArray[0];
			title.setFormat(Paths.font("Mario64.ttf"), 48, FlxColor.RED, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);			title.borderSize = 1.7;
			title.updateHitbox();
			add(title);

			devrole = new FlxText(creditX, title.y + 50, 0, "", 32);
			devrole.text = infoArray[1];
			devrole.setFormat(Paths.font("Mario64.ttf"), 26, FlxColor.RED, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);			devrole.borderSize = 1.7;
			devrole.updateHitbox();
			add(devrole);

			para1 = new FlxText(creditX, devrole.y + 32, 450, "", 32);
			para1.text = infoArray[2];
			para1.setFormat(Paths.font("Mario64.ttf"), 21, FlxColor.RED, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
			para1.borderSize = 1.7;
			para1.updateHitbox();
			add(para1);

			specialThanksY = creditY + 365;
		}

		var infoArray:Array<String> = CoolUtil.coolTextFile(Paths.txt("creditsTexts/specialThanks"));

		var specialThanksBox = new FlxSprite(0, specialThanksY).makeGraphic(700, infoArray.length * 35, FlxColor.BLACK);
		specialThanksBox.alpha = 0.5;
		add(specialThanksBox);
		specialThanksBox.screenCenter(X);

		var specialThanksTitle:FlxText = new FlxText(0, specialThanksBox.y + 20, 0, "Special Thanks", 32);
		specialThanksTitle.setFormat(Paths.font("Mario64.ttf"), 48, FlxColor.RED, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);			title.borderSize = 1.7;
		specialThanksTitle.updateHitbox();
		add(specialThanksTitle);
		specialThanksTitle.screenCenter(X);

		for(i in 0...infoArray.length){
			var specialThanksText:FlxText = new FlxText(0, specialThanksTitle.y + 70 + (30 * i), 0, "", 32);
			specialThanksText.text = infoArray[i];
			specialThanksText.setFormat(Paths.font("Mario64.ttf"), 21, FlxColor.RED, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);			title.borderSize = 1.7;
			specialThanksText.updateHitbox();
			add(specialThanksText);
			specialThanksText.screenCenter(X);
		}


		var theend:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image('credits/theend'));
		theend.antialiasing = ClientPrefs.globalAntialiasing;
		theend.updateHitbox();
		theend.screenCenter(XY);
		theend.scrollFactor.set(0, 0);
		theend.visible = false;
		add(theend);

		var lyricsArray:Array<String> = CoolUtil.coolTextFile(Paths.txt("creditsTexts/mad_mad_world_lyrics"));

		var lyricsBox:FlxSprite = new FlxSprite(0, 580).makeGraphic(100, 48, FlxColor.BLACK);
		lyricsBox.alpha = 0.8;
		lyricsBox.updateHitbox();
		lyricsBox.scrollFactor.set(0, 0);
		add(lyricsBox);

		var lyricsText:FlxText = new FlxText(0, lyricsBox.y + 20, 0, "blah", 32);
		lyricsText.setFormat(Paths.font("Mario64.ttf"), 40, FlxColor.RED, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);			title.borderSize = 1.7;
		lyricsText.updateHitbox();
		lyricsText.scrollFactor.set(0, 0);
		add(lyricsText);
		lyricsBox.visible = false;
		lyricsText.visible = false;
		lyricsBox.y += 24;

		if(autoscroll){
			FlxG.camera.fade(FlxColor.BLACK, 5, true);

			bg.visible = false;
			estatica.visible = false;
			MainMenuState.beat = true;

			camFollowPos.setPosition(640, -800);
			FlxG.sound.playMusic(Paths.music('creditsFinale'), 1);

			FlxTween.tween(camFollowPos, {y: 13800}, 188, {
				onComplete: function(twn:FlxTween)
				{
					FlxG.sound.music.volume = 0;
					FlxG.camera.fade(FlxColor.BLACK, 2, false, function()
					{
						camFollowPos.setPosition(640, 0);
						lyricsBox.visible = false;
						lyricsText.visible = false;
						theend.visible = true;
						FlxG.camera.fade(FlxColor.BLACK, 2, true, function()
						{							
							new FlxTimer().start(10, function(tmr:FlxTimer){
								FlxG.camera.fade(FlxColor.BLACK, 5, false, function()
								{
									FlxG.sound.playMusic(Paths.music('freakyMenu'), 1);
									MusicBeatState.switchState(new MainMenuState());
								});
							});
						});
					});
				}
			});

			for(i in 0...lyricsTimingArray.length){
				new FlxTimer().start(lyricsTimingArray[i], function(tmr:FlxTimer){
					lyricsText.text = lyricsArray[i];
					lyricsText.x = FlxG.width / 2 - lyricsText.width / 2;
					lyricsBox.makeGraphic(Std.int(lyricsText.width), 48, FlxColor.BLACK);
					lyricsBox.x = lyricsText.x;

					if(lyricsArray[i] == ''){
						lyricsBox.visible = false;
						lyricsText.visible = false;
					}
					else{
						lyricsBox.visible = true;
						lyricsText.visible = true;
					}
				});
			}
		}else{
			FlxG.sound.playMusic(Paths.music('creditsmenu'), 1);
		}

		super.create();
	}

	override function update(elapsed:Float)
	{
		if(!autoscroll){
			if (FlxG.sound.music.volume < 0.7)
			{
				FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
			}
			if (controls.BACK)
			{
				FlxG.sound.play(Paths.sound('cancelMenu'));
				FlxG.sound.music.fadeOut(0.5, 0);
				MusicBeatState.switchState(new MainMenuState());
			}

			if (FlxG.mouse.wheel < 0)
				newPos += 40;
			if (FlxG.mouse.wheel > 0)
				newPos -= 40;

			if(newPos < 200)
				newPos = 200;

			if(12920 < newPos)
				newPos = 12920;

			if(camFollowPos.y != newPos){
				var lerpVal:Float = CoolUtil.boundTo(elapsed * 5, 0, 1);
				camFollowPos.y = FlxMath.lerp(camFollowPos.y, newPos, lerpVal);
			}
		}

		#if debug
		if (FlxG.keys.justPressed.FOUR) {
			MainMenuState.beat = true;
			FlxG.sound.playMusic(Paths.music('freakyMenu'), 1);
			MusicBeatState.switchState(new MainMenuState());
		}
		#end

		super.update(elapsed);
	}
}
