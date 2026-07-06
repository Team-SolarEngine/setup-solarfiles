package ui;

import haxe.ui.containers.HBox;

@:build(haxe.ui.ComponentBuilder.build("assets/preview.xml"))
class PreviewUI extends HBox{
    public static var instance:PreviewUI;
    public function new(){
        super();
        instance = this;

        bannerLabel.hide();
        iconLabel.hide();
    }
}