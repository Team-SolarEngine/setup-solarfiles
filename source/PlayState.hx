package;

import haxe.ui.backend.flixel.UIState;

import ui.MainUI;

class PlayState extends UIState
{
	var ui:MainUI;

	override public function create()
	{
		ui = new MainUI();
		add(ui);
		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
