package codename.backend.options.type;

import flixel.graphics.FlxGraphic;
import flixel.FlxSprite;
import codename.backend.shaders.CustomShader;

class PortraitOption extends TextOption {
	public var portrait:FlxSprite = null;

	public function new(name:String, desc:String, callback:Void->Void, ?graphic:FlxGraphic, size:Float = 96, usePortrait:Bool = true) {
		super(name, desc, callback);
		if (graphic != null) addPortrait(graphic, size, usePortrait);
	}

	public function addPortrait(graphic:FlxGraphic, size:Float = 96, usePortrait:Bool = true) {
		if (portrait == null) {
			portrait = new FlxSprite();
			portrait.antialiasing = true;
			if(usePortrait) portrait.shader = new CustomShader('engine/circleProfilePicture');
			add(portrait);
		}
		portrait.loadGraphic(graphic);
		portrait.scale.set(size, size);
		portrait.updateHitbox();
		portrait.setPosition(90 - portrait.width, 0);
	}
}