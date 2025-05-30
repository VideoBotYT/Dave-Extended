package states.credits;

class PECredits extends OptionsScreen
{
	var credits:Array<Array<String>> = [
		['< Psych Engine Team >'],
		[
			'Shadow Mario',
			'shadowmario',
			'Main Programmer of Psych Engine',
			'https://twitter.com/Shadow_Mario_',
			'444444'
		],
		[
			'RiverOaken',
			'riveren',
			'Main Artist/Animator of Psych Engine',
			'https://twitter.com/RiverOaken',
			'B42F71'
		],
		[
			'shubs',
			'shubs',
			'Additional Programmer of Psych Engine',
			'https://twitter.com/yoshubs',
			'5E99DF'
		],
		['< Former Engine Members >'],
		[
			'bb-panzu',
			'bb',
			'Ex-Programmer of Psych Engine',
			'https://twitter.com/bbsub3',
			'3E813A'
		],
		['< Engine Contributors >'],
		[
			'iFlicky',
			'flicky',
			'Composer of Psync and Tea Time\nMade the Dialogue Sounds',
			'https://twitter.com/flicky_i',
			'9E29CF'
		],
		[
			'SqirraRNG',
			'sqirra',
			'Crash Handler and Base code for\nChart Editor\'s Waveform',
			'https://twitter.com/gedehari',
			'E1843A'
		],
		[
			'EliteMasterEric',
			'mastereric',
			'Runtime Shaders support',
			'https://twitter.com/EliteMasterEric',
			'FFBD40'
		],
		[
			'PolybiusProxy',
			'proxy',
			'.MP4 Video Loader Library (hxCodec)',
			'https://twitter.com/polybiusproxy',
			'DCD294'
		],
		[
			'KadeDev',
			'kade',
			'Fixed some cool stuff on Chart Editor\nand other PRs',
			'https://twitter.com/kade0912',
			'64A250'
		],
		[
			'Keoiki',
			'keoiki',
			'Note Splash Animations',
			'https://twitter.com/Keoiki_',
			'D2D2D2'
		],
		[
			"superpowers04",
			"superpowers04",
			"LUA JIT Fork",
			"https://x.com/superpowers04",
			"B957ED"
		],
		[
			'Smokey',
			'smokey',
			'Sprite Atlas Support',
			'https://twitter.com/Smokey_5_',
			'483D92'
		]
	];

	public override function new()
	{
		super("Psych Engine", "All credits to the people who made the base engine of Universe Engine");
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
