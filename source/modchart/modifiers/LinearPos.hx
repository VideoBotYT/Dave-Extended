package modchart.modifiers;

class LinearPos extends Modifier
{
    override function render(curPos:Vector3D, params:RenderParams)
    {
        var player = params.player;
        curPos.z += Math.tan(getPercent("tanZ", player));

        return curPos;
    }
}