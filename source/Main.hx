package;

import flixel.FlxGame;
import openfl.display.Sprite;
import flixel.FlxG;

//crash handler
import openfl.Lib;
import haxe.io.Path;
import lime.app.Application;
import openfl.events.UncaughtErrorEvent;
import haxe.CallStack;
import haxe.io.Path;
import sys.io.File;
import sys.FileSystem;

using StringTools;

class Main extends Sprite
{
	public function new()
	{
		super();
		addChild(new FlxGame(0, 0, PlayState));

		FlxG.sound.muteKeys = null;
		FlxG.sound.volumeDownKeys = null;
		FlxG.sound.volumeUpKeys = null;

		FlxG.mouse.useSystemCursor = true;

		Lib.current.loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, onCrash);

		initHaxeUI();
	}

	function initHaxeUI() {
		// This has to come before Toolkit.init since locales get initialized there
		haxe.ui.locale.LocaleManager.instance.autoSetLocale = false;
		// Calling this before any HaxeUI components get used is important:
		// - It initializes the theme styles.
		// - It scans the class path and registers any HaxeUI components.
		haxe.ui.Toolkit.init();
		haxe.ui.Toolkit.theme = 'dark'; // don't be cringe
		// haxe.ui.Toolkit.theme = 'light'; // embrace cringe
		haxe.ui.Toolkit.autoScale = false;
		// Don't focus on UI elements when they first appear.
		haxe.ui.focus.FocusManager.instance.autoFocus = false;
		haxe.ui.tooltips.ToolTipManager.defaultDelay = 200;
		haxe.ui.backend.flixel.CursorHelper.useCustomCursors = false;
	}

	function onCrash(e:UncaughtErrorEvent):Void {
		var errMsg:String = "";
		var path:String;
		var callStack:Array<StackItem> = CallStack.exceptionStack(true);
		var dateNow:String = Date.now().toString();

		dateNow = dateNow.replace(" ", "_");
		dateNow = dateNow.replace(":", "'");

		path = "./crash/" + "App" + dateNow + ".txt";

		for (stackItem in callStack) {
			switch (stackItem) {
				case FilePos(s, file, line, column):
					errMsg += file + " (line " + line + ")\n";
				default:
					Sys.println(stackItem);
			}
		}

		errMsg += "\nUncaught Error: "
			+ e.error
			+ "\nCrash Handler written by: sqirra-rng";

		if (!FileSystem.exists("./crash/"))
			FileSystem.createDirectory("./crash/");

		File.saveContent(path, errMsg + "\n");

		Sys.println(errMsg);
		Sys.println("Crash dump saved in " + Path.normalize(path));

		Application.current.window.alert(errMsg, "Error!");
		Sys.exit(1);
	}
}
