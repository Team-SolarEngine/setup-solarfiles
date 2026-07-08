package ui;

import haxe.ui.containers.dialogs.Dialog;

@:build(haxe.ui.ComponentBuilder.build("assets/predefined.xml"))
class PredefinedDialog extends Dialog{
	public var typeOptions:Array<String> = ["Mod", "Script", "Improvement", "Other"];
    public function new(){
        super();
        buttons = DialogButton.CANCEL | DialogButton.APPLY;
    }
}