package states.credits;

class FNFCredits extends OptionsScreen
{
	var credits:Array<Array<String>> = [
		["< Funkin' Crew >"],
		[
			"ninjamuffin99",
			"ninjamuffin99",
			"Programmer of Friday Night Funkin'",
			"https://x.com/ninja_muffin99",
			"CF2D2D"
		],
		[
			"PhantomArcade",
			"phantomarcade",
			"Animator of Friday Night Funkin'",
			"https://x.com/PhantomArcade3K",
			"FADC45"
		],
		[
			"evilsk8r",
			"evilsk8r",
			"Artist of Friday Night Funkin'",
			"https://x.com/evilsk8r",
			"5ABD4B"
		],
		[
			"kawaisprite",
			"kawaisprite",
			"Composer of Friday Night Funkin'",
			"https://x.com/kawaisprite",
			"378FC7"
		]
	];

	public override function new()
	{
		super("Friday Night Funkin'", "All credits to the people who made the base game");
		creditList();
	}

	function creditList()
	{
		for (credit in credits)
		{
			var opt:PortraitOption = new PortraitOption(credit[0], credit[2], function() CoolUtil.browserLoad(credit[3]),
				FlxG.bitmap.add(Paths.image("credits/" + credit[1])), 1, true);
			@:privateAccess opt.__text.color = if (credit[4] == null) FlxColor.WHITE else FlxColor.fromString("0x" + credit[4]);
			add(opt);
		}
	}
}
