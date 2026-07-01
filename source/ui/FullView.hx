package ui;

import haxe.ui.containers.HBox;

import ui.*;

class FullView extends HBox{

    var mainUI:MainUI;
    var previewUI:PreviewUI;

    public function new(){
        super();
        
        mainUI = new MainUI();
        previewUI = new PreviewUI();

		addComponent(mainUI);
        addComponent(previewUI);
    }
}