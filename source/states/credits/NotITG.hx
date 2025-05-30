package states.credits;

class NotITG extends OptionsScreen
{
    var credits:Array<Array<String>> = [
        ["VideoBot", "videobot", "Creator of NotITG Engine", "video-bot.netlify.app", "14FFFF", "0.75", "false"],
        ["TheoDev", "Theo", "Modcharting Tool", "", "483691", "0.25", "true"],
        ["Edwhak", "Edwhak", "NotITG noteskin port", "", "00FF00", "1", "false"],
        ["NotITG", "NotITG", "Original noteskin and Modifiers", "noti.tg", "d1d1d1", "0.5", "true"],
        ["Codename Engine", "cne", "Credits system", "codename-engine.com", "ae5cb8", "0.75", "true"]
    ];
    public override function new()
    {
        super("NotITG Engine", "People who made the engine");
        creditList();
    }

    function creditList()
	{
		for (credit in credits)
		{
			var opt:PortraitOption = new PortraitOption(credit[0], credit[2], function() CoolUtil.browserLoad(credit[3]),
				FlxG.bitmap.add(Paths.image("credits/NotITG/" + credit[1])), Std.parseFloat(credit[5]), credit[6] == "false" ? false : true);
			@:privateAccess opt.__text.color = if (credit[4] == null) FlxColor.WHITE else FlxColor.fromString("0x" + credit[4]);
			add(opt);
		}
	}
}