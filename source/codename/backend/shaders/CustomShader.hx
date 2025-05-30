package codename.backend.shaders;

import haxe.Exception;
import openfl.Assets;
import codename.scripting.hscript.IHScriptCustomBehaviour;
import codename.backend.shaders.FunkinShader;

class CustomShader extends FunkinShader {
	public var path:String = "";

	/**
	 * Creates a new custom shader
	 * @param name Name of the frag and vert files.
	 * @param glslVersion GLSL version to use. Defaults to `120`.
	 */
	public function new(name:String, glslVersion:String = "120") {
		var fragShaderPath = Paths.shaderFragment(name);
		var vertShaderPath = Paths.shaderVertex(name);
		var fragCode = Assets.exists(fragShaderPath) ? Assets.getText(fragShaderPath) : null;
		var vertCode = Assets.exists(vertShaderPath) ? Assets.getText(vertShaderPath) : null;

		fragFileName = fragShaderPath;
		vertFileName = vertShaderPath;

		path = fragShaderPath+vertShaderPath;

		if (fragCode == null && vertCode == null)
			trace('Shader "$name" couldn\'t be found.');

		super(fragCode, vertCode, glslVersion);
	}
}