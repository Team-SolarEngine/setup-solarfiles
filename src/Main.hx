package ;

import haxe.ui.HaxeUIApp;
import ui.FullView;

class Main {
    public static function main() {
		haxe.ui.Toolkit.theme = "dark";
		haxe.ui.backend.flixel.CursorHelper.useCustomCursors = false;
        var app = new HaxeUIApp();
        app.ready(function() {
            app.addComponent(new FullView());

            app.start();
        });
    }
}
