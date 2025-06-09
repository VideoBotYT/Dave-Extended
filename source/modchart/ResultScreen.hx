package modchart;

import flixel.addons.display.FlxBackdrop;
import flixel.addons.display.FlxGridOverlay;
import flixel.util.FlxAxes;
import flixel.FlxCamera;
import flixel.system.FlxAssets;


class ResultScreen extends MusicBeatSubstate
{
	var camRate:FlxCamera;

	var background:FlxSprite;
	var top:FlxSprite;
	var backdrop:FlxBackdrop;
	var scorebg:FlxSprite;
	var line:FlxSprite;

	var song:FlxText;

	var gameInstance:PlayState = PlayState.instance;
	var game:PlayState;

	var fantastictxt:FlxText;
	var excelenttxt:FlxText;
	var greattxt:FlxText;
	var wayofftxt:FlxText;
	var decenttxt:FlxText;
	var misstxt:FlxText;
	var scoretxt:FlxText;

	var acctxt:FlxText;
	var comtxt:FlxText;

	var rating:FlxText;

	var dascore:Int;
	var daacc:Float;
	var dacom:Int;
	var daBest:Int;

	var ratings:Array<String> = ["S+", "S", "A", "B", "C", "D", "E", "F", "F-"];

	var ended:Bool = false;

	public var end:Void->Void;

	public function new(score:Int, maxc:Int, acc:Float, fantastic:Int, excelent:Int, great:Int, decent:Int, wayoff:Int, miss:Int)
	{
		super();

		camRate = new FlxCamera();
		FlxG.cameras.add(camRate, false);
		FlxCamera.defaultCameras = [camRate];
		FlxG.cameras.setDefaultDrawTarget(camRate, false);

		dascore = score;
		daacc = acc;
		dacom = maxc;

		background = new FlxSprite(0, 0).makeGraphic(FlxG.width, FlxG.height, 0xFF000000);
		background.screenCenter();
		add(background);

		scorebg = new FlxSprite(0, FlxG.height / 2 - 100).makeGraphic(Std.int(FlxG.width), Std.int(FlxG.height / 2 + 100), 0xFF606A93);
		scorebg.screenCenter(FlxAxes.X);
		add(scorebg);

		backdrop = new FlxBackdrop(FlxGridOverlay.createGrid(80, 80, 160, 160, true, 0x33FFFFFF, 0x0));
		backdrop.velocity.set(40, 20);
		add(backdrop);

		top = new FlxSprite(0, FlxG.height / 2 - 450).makeGraphic(Std.int(FlxG.width), Std.int(FlxG.height / 2), 0xFF2F505D);
		top.screenCenter(FlxAxes.X);
		add(top);

		song = new FlxText(0, FlxG.height / 2 - 300, FlxG.width, "", 32);
		song.screenCenter(FlxAxes.X);
		song.setFormat(Paths.font("gaposiss.ttf"), 32, FlxColor.WHITE, FlxTextAlign.CENTER);
		add(song);

		line = new FlxSprite(0, song.y + 50).makeGraphic(Std.int(song.text.length * 40), 10, FlxColor.WHITE);
		line.screenCenter(FlxAxes.X);
		add(line);

		rating = new FlxText(0, song.y + 75, Std.int(FlxG.width * 0.6), "S+", 32);
		rating.screenCenter(FlxAxes.X);
		rating.setFormat(Paths.font('Vollkorn-BoldItalic.ttf'), 64, FlxColor.WHITE, FlxTextAlign.CENTER);
		add(rating);

		fantastictxt = new FlxText(FlxG.width / 2 - 450, scorebg.y + 40, 400, "Fantastics: " + fantastic, 32);
		add(fantastictxt);
		excelenttxt = new FlxText(fantastictxt.x, (fantastictxt.y + fantastictxt.height) + 20, 400, "Excelents: " + excelent, 32);
		add(excelenttxt);
		greattxt = new FlxText(excelenttxt.x, (excelenttxt.y + excelenttxt.height) + 20, 400, "Greats: " + great, 32);
		add(greattxt);

		wayofftxt = new FlxText(fantastictxt.x * 4, fantastictxt.y, 400, "Way Off: " + wayoff, 32);
		add(wayofftxt);
		decenttxt = new FlxText(wayofftxt.x, (wayofftxt.y + wayofftxt.height) + 20, 400, "Decents: " + decent, 32);
		add(decenttxt);
		misstxt = new FlxText(decenttxt.x, (decenttxt.y + decenttxt.height) + 20, 400, "Miss: " + miss, 32);
		add(misstxt);

		comtxt = new FlxText(fantastictxt.x * 2.5, (fantastictxt.y + fantastictxt.height) * 1.4, 400, "Combo: 0", 32);
		add(comtxt);
		acctxt = new FlxText(comtxt.x, (comtxt.y + comtxt.height) + 20, 400, "Accuraty: 0%", 32);
		add(acctxt);

		scoretxt = new FlxText(acctxt.x, (acctxt.y + acctxt.height), Std.int(FlxG.width * 0.6), "Score: 3000", 32);
		add(scoretxt);

		if (FlxG.sound.music != null)
			FlxG.sound.music.stop();
	}

	override function update(elapsed:Float)
	{
		PlayState.instance.camZooming = false;

		scoretxt.text = "Score: " + dascore;
		acctxt.text = "Accuraty: " + daacc + "%";
		comtxt.text = "Max Combo: " + dacom;

		song.text = PlayState.SONG.song;

		line.width = (song.text.length*40);

		if (daacc == 100)
			rating.text = ratings[0];
		else if (daacc >= 95)
			rating.text = ratings[1];
		else if (daacc >= 90)
			rating.text = ratings[2];
		else if (daacc >= 80)
			rating.text = ratings[3];
		else if (daacc >= 70)
			rating.text = ratings[4];
		else if (daacc >= 60)
			rating.text = ratings[5];
		else if (daacc >= 50)
			rating.text = ratings[6];
		else if (daacc <= 40)
			rating.text = ratings[7];
		else if (daacc <= 30)
			rating.text = ratings[8];

		if ((controls.ACCEPT || FlxG.mouse.justPressed) && !ended)
		{
			FlxG.sound.play(Paths.sound('confirmMenu'));
			camRate.fade(FlxColor.BLACK, 0.5, false, function()
			{
				ended = true;
				PlayState.deathCounter = 0;
				PlayState.seenCutscene = false;
				PlayState.changedDifficulty = false;
				PlayState.inResultScreen = false;

				if (PlayState.chartingMode)
				{
					persistentUpdate = false;
					PlayState.instance.paused = true;
					MusicBeatState.switchState(new ChartingState());
					PlayState.chartingMode = true;

					#if desktop
					DiscordClient.changePresence("Chart Editor", null, null, true);
					#end
					return;
				}
				MusicBeatState.switchState(new states.modded.DaveMain());
			});
		}

		super.update(elapsed);
	}
}
