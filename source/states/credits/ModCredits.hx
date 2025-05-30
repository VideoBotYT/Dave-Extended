package states.credits;

class ModCredits extends OptionsScreen
{
    var credits:Array<Array<String>> = [
        ["VideoBot", "videobot", "Creator of the mod", "video-bot.netlify.app", "14FFFF", "0.75"],
        ["Daveberry", "dave", "Made music and main menu design, the mod is about him", "daveberry.netlify.app", "008BFF", "0.75"]
    ];
    public override function new()
	{
		super("Dave Extended", "All credits to the people who made the mod");
        credit();
    }

    function credit()
    {
        for (credit in credits)
		{
			var opt:PortraitOption = new PortraitOption(credit[0], credit[2], function() CoolUtil.browserLoad(credit[3]),
				FlxG.bitmap.add(Paths.image("credits/de/" + credit[1])), Std.parseFloat(credit[5]), false);
			@:privateAccess opt.__text.color = if (credit[4] == null) FlxColor.WHITE else FlxColor.fromString("0x" + credit[4]);
			add(opt);
		}
    }
}