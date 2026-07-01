package;

import haxe.ui.backend.flixel.UIState;
import flixel.addons.display.FlxBackdrop;
import flixel.addons.display.FlxGridOverlay;

import ui.FullView;

class PlayState extends UIState
{
	var ui:FullView;

	var bg:FlxBackdrop;

	override public function create()
	{
		bg = new FlxBackdrop(FlxGridOverlay.createGrid(80, 80, 160, 160, true, 0x337F7F7F, 0x0));
		bg.velocity.set(20, 20);
		add(bg);

		ui = new FullView();
		add(ui);
		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
