package codename.backend.options.type;

import flixel.group.FlxSpriteGroup;
import backend.Controls;

class OptionType extends FlxSpriteGroup {
	public var controls(get, null):Controls;
	public var selected:Bool = false;
	public var desc:String;

	public function new(desc:String) {
		super();
		this.desc = desc;
	}

	private function get_controls()
	{
		return Controls.instance;
	}

	public function onSelect() {}

	public function onChangeSelection(change:Float) {}

	public override function update(elapsed:Float) {
		super.update(elapsed);
		alpha = (selected ? 1 : 0.6);
	}
}