package modchart.modifiers;

import flixel.FlxG;
@:keep
class AngleModifier extends Rotate {
	override public function getOrigin(curPos:Vector3, params:ModifierParameters):Vector3 {
		return new Vector3(FlxG.width * 0.5, HEIGHT * 0.5);
	}

	override public function getRotateName():String
		return 'angle';

	override public function shouldRun(params:ModifierParameters):Bool
		return true;

	override function visuals(data:VisualParameters, params:ModifierParameters) {
		var rotateName = getRotateName();
		var player = params.player;

		var angleX = getPercent(rotateName + 'X', player);
		var angleY = getPercent(rotateName + 'Y', player);
		var angleZ = getPercent(rotateName + 'Z', player);

		data.angleX = angleX;
		data.angleY = angleY;
		data.angleZ = angleZ;

		return data;
	}
}
