package modchart.standalone.adapters.notitg;

import backend.ClientPrefs;
import backend.Conductor;
import objects.Note;
import objects.StrumNote as Strum;
import states.PlayState;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import modchart.Manager;
import modchart.standalone.IAdapter;
#if LUA_ALLOWED
import llua.Lua;
import llua.LuaL;
import llua.State;
import llua.Convert;
import psychlua.FunkinLua;
import psychlua.LuaUtils;
#end

class Notitg implements IAdapter
{
	private var __fCrochet:Float = 0;

	private var __receptorXs:Array<Array<Float>>;
	private var __receptorYs:Array<Array<Float>>;

	// public function new() {
	// 	try {
	// 		setupLuaFunctions();
	// 	} catch (e) {
	// 		trace('[FunkinModchart NotITG Adapter] Failed while adding lua functions: $e');
	// 	}
	// }

	public function onModchartingInitialization()
	{
		__fCrochet = Conductor.crochet;

		__receptorXs = [];
		__receptorYs = [];

		@:privateAccess
		PlayState.instance.strumLineNotes.forEachAlive(strumNote ->
		{
			if (__receptorXs[strumNote.player] == null)
				__receptorXs[strumNote.player] = [];
			if (__receptorYs[strumNote.player] == null)
				__receptorYs[strumNote.player] = [];

			__receptorXs[strumNote.player][strumNote.noteData] = strumNote.x;
			__receptorYs[strumNote.player][strumNote.noteData] = getDownscroll() ? FlxG.height - strumNote.y - Manager.ARROW_SIZE : strumNote.y;
		});
	}

	public static function setupLuaFunctions(manager:Manager)
	{
		#if LUA_ALLOWED
		for (lua in PlayState.instance.luaArray)
		{
			Lua_helper.add_callback(lua.lua, "registerModifier", function(name:String, mod:String, player:Int = -1)
			{
				var modClass = Type.resolveClass('modchart.modifiers.' + mod);
				var modifier = Type.createInstance(modClass, []);

				manager.registerModifier(name, modifier, player);
			});
			Lua_helper.add_callback(lua.lua, "initManager", function()
			{
				LuaUtils.getTargetInstance().add(manager);
			});
			Lua_helper.add_callback(lua.lua, "addModifier", function(name:String, field:Int = -1)
			{
				manager.addModifier(name, field);
			});
			Lua_helper.add_callback(lua.lua, "setPercent", function(name:String, value:Float, player:Int = -1, field:Int = -1)
			{
				manager.setPercent(name, value, player, field);
			});
			Lua_helper.add_callback(lua.lua, "getPercent", function(name:String, player:Int = 0, field:Int = 0)
			{
				manager.getPercent(name, player, field);
			});
			Lua_helper.add_callback(lua.lua, "set", function(name:String, beat:Float, value:Float, player:Int = -1, field:Int = -1)
			{
				manager.set(name, beat, value, player, field);
			});
			Lua_helper.add_callback(lua.lua, "ease",
				function(name:String, beat:Float, length:Float, value:Float, easeFunc:String, player:Int = -1, field:Int = -1)
				{
					manager.ease(name, beat, length, value, LuaUtils.getTweenEaseByString(easeFunc), player, field);
				});
			Lua_helper.add_callback(lua.lua, "addPlayfield", function()
			{
				manager.addPlayfield();
			});
		}
		#end
	}

	public function isTapNote(sprite:FlxSprite)
	{
		return sprite is Note;
	}

	// Song related
	public function getSongPosition():Float
	{
		return Conductor.songPosition;
	}

	public function getCurrentBeat():Float
	{
		@:privateAccess
		return PlayState.instance.curDecBeat;
	}

	public function getStaticCrochet():Float
	{
		return __fCrochet + 8;
	}

	public function getBeatFromStep(step:Float)
		return step * .25;

	public function arrowHit(arrow:FlxSprite)
	{
		if (arrow is Note)
			return cast(arrow, Note).wasGoodHit;
		return false;
	}

	public function isHoldEnd(arrow:FlxSprite)
	{
		if (arrow is Note)
		{
			final castedNote = cast(arrow, Note);

			if (castedNote.nextNote != null)
				return !castedNote.nextNote.isSustainNote;
		}
		return false;
	}

	public function getLaneFromArrow(arrow:FlxSprite)
	{
		if (arrow is Note)
			return cast(arrow, Note).noteData;
		else if (arrow is Strum) @:privateAccess
			return cast(arrow, Strum).noteData;

		return 0;
	}

	public function getPlayerFromArrow(arrow:FlxSprite)
	{
		if (arrow is Note)
			return cast(arrow, Note).mustPress ? 1 : 0;
		else if (arrow is Strum) @:privateAccess
			return cast(arrow, Strum).player;

		return 0;
	}

	public function getKeyCount(?player:Int = 0):Int
	{
		return 4;
	}

	public function getPlayerCount():Int
	{
		return 2;
	}

	public function getTimeFromArrow(arrow:FlxSprite)
	{
		if (arrow is Note)
			return cast(arrow, Note).strumTime;

		return 0;
	}

	public function getHoldSubdivisions():Int
	{
		return 4;
	}

	// psych adjust the strum pos at the begin of playstate
	public function getDownscroll():Bool
	{
		return ClientPrefs.data.downScroll;
	}

	public function getDefaultReceptorX(lane:Int, player:Int):Float
	{
		return __receptorXs[player][lane];
	}

	public function getDefaultReceptorY(lane:Int, player:Int):Float
	{
		return __receptorYs[player][lane];
	}

	public function getArrowCamera():Array<FlxCamera>
		return [PlayState.instance.camManager];

	public function getCurrentScrollSpeed():Float
	{
		return PlayState.instance.songSpeed;
	}

	// 0 receptors
	// 1 tap arrows
	// 2 hold arrows
	public function getArrowItems()
	{
		var pspr:Array<Array<Array<FlxSprite>>> = [[[], [], []], [[], [], []]];

		@:privateAccess
		PlayState.instance.strumLineNotes.forEachAlive(strumNote ->
		{
			if (pspr[strumNote.player] == null)
				pspr[strumNote.player] = [];

			pspr[strumNote.player][0].push(strumNote);
		});
		PlayState.instance.notes.forEachAlive(strumNote ->
		{
			final player = Adapter.instance.getPlayerFromArrow(strumNote);
			if (pspr[player] == null)
				pspr[player] = [];

			pspr[player][strumNote.isSustainNote ? 2 : 1].push(strumNote);
		});

		return pspr;
	}

	public function getHoldParentTime(arrow:FlxSprite)
	{
		final note:Note = cast arrow;
		return note.parent.strumTime;
	}
}
