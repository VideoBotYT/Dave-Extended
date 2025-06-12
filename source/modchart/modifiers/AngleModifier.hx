package modchart.modifiers;

import flixel.FlxG;
@:keep
class AngleModifier extends Rotate {
	override public function getOrigin(curPos:Vector3D, params:RenderParams):Vector3D {
		return new Vector3D(FlxG.width * 0.5, HEIGHT * 0.5);
	}

	override public function getRotateName():String
		return 'angle';

	override public function shouldRun(params:RenderParams):Bool
		return true;

	override function visuals(data:Visuals, params:RenderParams) {
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
