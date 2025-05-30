package states.modded;

import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.util.FlxAxes;
import backend.Song;
import substates.GameplayChangersSubstate;

class DaveMain extends MusicBeatState
{
	var buttonSelector:FlxSprite;

	var buttonList:Array<String> = ["Musics", "Credits", "Options"];
	var buttonGroup:FlxTypedGroup<FlxSprite>;

	var songList:Array<String> = ["Another Sleepless Night", "In the Evening"];
	var songGroup:FlxTypedGroup<FlxSprite>;

	override function create()
	{
		persistentUpdate = true;
		PlayState.isStoryMode = false;

		var bg:FlxSprite = new FlxSprite(0, 0).makeGraphic(FlxG.width, FlxG.height, 0xFF46465A);
		bg.screenCenter();
		bg.scrollFactor.set();
		add(bg);

		var topBar:FlxSprite = FlxSpriteUtil.drawRoundRect(new FlxSprite(0, FlxG.height / 2 - 350).makeGraphic(1200, 80, FlxColor.TRANSPARENT), 0, 0, 1200,
			80, 40, 40, 0xFF3C3C50);
		topBar.screenCenter(FlxAxes.X);
		topBar.scrollFactor.set();
		add(topBar);

		buttonSelector = FlxSpriteUtil.drawRoundRect(new FlxSprite(FlxG.width / 2 - 325,
			topBar.y + 10).makeGraphic(150, Std.int(topBar.height - 20), FlxColor.TRANSPARENT), 0, 0, 150,
			topBar.height
			- 20, 40, 40, 0xFF323246);
		buttonSelector.scrollFactor.set();
		add(buttonSelector);

		buttonGroup = new FlxTypedGroup();
		add(buttonGroup);

		for (i => button in buttonList)
		{
			var buttonBg:FlxSprite = new FlxSprite((FlxG.width / 2 - 325) + (i * 250),
				topBar.y + 10).makeGraphic(150, Std.int(topBar.height - 20), FlxColor.TRANSPARENT);
			buttonBg.scrollFactor.set();
			buttonBg.ID = i;
			buttonBg.visible = false;

			var buttonText:FlxText = new FlxText(buttonBg.x, buttonBg.y, buttonBg.width, button);
			buttonText.scrollFactor.set();
			buttonText.setFormat(Paths.font("Fredoka.ttf"), 40, FlxColor.CYAN, FlxTextAlign.CENTER);
			buttonText.ID = i;
			if (button == "Musics")
				buttonText.setFormat(Paths.font("Fredoka.ttf"), 40, FlxColor.WHITE, FlxTextAlign.CENTER);

			buttonGroup.add(buttonBg);
			buttonGroup.add(buttonText);
		}

		var songSelectorBG:FlxSprite = FlxSpriteUtil.drawRoundRect(new FlxSprite(0, FlxG.height / 2).makeGraphic(1100, 300, FlxColor.TRANSPARENT), 0, 0, 1100,
			300, 40, 40, 0xFF3C3C50);
		songSelectorBG.screenCenter(FlxAxes.X);
		songSelectorBG.scrollFactor.set();
		add(songSelectorBG);

		songGroup = new FlxTypedGroup();
		add(songGroup);

		for (i => song in songList)
		{
			var songImage:FlxSprite = new FlxSprite((FlxG.width / 2 - 250) + (i * 250), (songSelectorBG.y * 2 - 350)).loadGraphic(Paths.image("de/" + song));
			songImage.scrollFactor.set();
			songImage.ID = i;

			var songText:FlxText = new FlxText(songImage.x, songImage.y + songImage.height, 200, song);
			songText.scrollFactor.set();
			songText.setFormat(Paths.font("Fredoka.ttf"), 16, FlxColor.CYAN, FlxTextAlign.CENTER);

			songGroup.add(songImage);
			songGroup.add(songText);
		}

		var titleBg:FlxSprite = FlxSpriteUtil.drawRoundRect(new FlxSprite(0, FlxG.height / 2 - 250).makeGraphic(800, 200, FlxColor.TRANSPARENT), 0, 0, 800,
			200, 40, 40, 0xFF3C3C50);
		titleBg.screenCenter(FlxAxes.X);
		titleBg.scrollFactor.set();
		add(titleBg);

		var logo:FlxSprite = new FlxSprite(0, titleBg.y + 10).loadGraphic(Paths.image("de/logo"));
		logo.screenCenter(FlxAxes.X);
		logo.scrollFactor.set();
		add(logo);

		FlxG.mouse.visible = true;

		super.create();
	}

	override function update(elapsed:Float)
	{
		for (i in buttonGroup)
		{
			if (FlxG.mouse.overlaps(i))
			{
				buttonSelector.x = i.x;
				if (FlxG.mouse.justPressed)
				{
					var curSelected = buttonList[i.ID];
					switch (curSelected)
					{
						case "Musics":
							FlxG.switchState(new DaveMain());
						case "Options":
							FlxG.switchState(new options.OptionsState());
						case "Credits":
							FlxG.switchState(new states.credits.CreditsState());
					}
				}
			}
		}

		for (i in songGroup)
		{
			if (FlxG.mouse.overlaps(i))
			{
				i.alpha = 0.5;
				if (FlxG.mouse.justPressed)
				{
					persistentUpdate = false;
					var curSelected = songList[i.ID];
					switch (curSelected)
					{
						case "Another Sleepless Night":
							var songLowercase:String = Paths.formatToSongPath("another-sleepless-night");
							PlayState.SONG = Song.loadFromJson("another-sleepless-night", songLowercase);
							PlayState.isStoryMode = false;
						case "In the Evening":
							var songLowercase:String = Paths.formatToSongPath("in-the-evening");
							PlayState.SONG = Song.loadFromJson("in-the-evening", songLowercase);
							PlayState.isStoryMode = false;
					}
					LoadingState.loadAndSwitchState(new PlayState());
				}
			}
			else
			{
				i.alpha = 1;
			}
		}

		if(FlxG.keys.justPressed.CONTROL)
		{
			persistentUpdate = false;
			openSubState(new GameplayChangersSubstate());
		}

		if (controls.BACK)
			MusicBeatState.switchState(new states.TitleState());
		super.update(elapsed);
	}
}
