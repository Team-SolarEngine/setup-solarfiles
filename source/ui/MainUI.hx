package ui;

import haxe.io.Bytes;
import haxe.ui.containers.VBox;
import haxe.ui.containers.dialogs.Dialogs;
import haxe.ui.containers.dialogs.MessageBox.MessageBoxType;
import sys.FileSystem;
import sys.io.File;
import haxe.Json;

using StringTools;

typedef Data = {
	var isOpenSource:String;
	var canMessWithComputer:String;
	var title:String;
	var description:String;
	var madeBy:String;
	var externalURL:String;
	var githubURL:String;
	var madeByURL:String;
	var downloadURL:String;
}

@:build(haxe.ui.ComponentBuilder.build("assets/ui/mainview.xml"))
class MainUI extends VBox{
    var bannerBytes:Bytes = null;
    var iconBytes:Bytes = null;

	var options:Array<String> = ["yes", "no"];

    public function new(){
        super();
		banner.onClick = function(event) {
			Dialogs.openBinaryFile("Open Banner", [{label: "Banner File (.png)", extension: "png"}], function(selectedFile) {
				if (selectedFile != null && selectedFile.bytes != null) {
					trace("Selected file: " + selectedFile.name);
                    bannerBytes = selectedFile.bytes;
					banner.text = "Banner Success!";
				}
			});
		}

		iconbtn.onClick = function(event) {
			Dialogs.openBinaryFile("Open Icon", [{label: "Icon File (.png)", extension: "png"}], function(selectedFile) {
				if (selectedFile != null && selectedFile.bytes != null) {
					trace("Selected file: " + selectedFile.name);
                    iconBytes = selectedFile.bytes;
					iconbtn.text = "Icon Success!";
				}
			});
		}

		finish.onClick = function(event){
			FileSystem.createDirectory(".solar-engine");

			if (bannerBytes == null){
				Dialogs.messageBox("Missing Banner file!", "ERROR", MessageBoxType.TYPE_ERROR);
				return;
			}
			if (iconBytes == null){
				Dialogs.messageBox("Missing Icon file!", "ERROR", MessageBoxType.TYPE_ERROR);
				return;
			}
			if (txtTitle.text == null || txtTitle.text == ""){
				Dialogs.messageBox("No Title!", "ERROR", MessageBoxType.TYPE_ERROR);
				return;
			}
			if (txtDescription.text == null || txtDescription.text == ""){
				Dialogs.messageBox("No Description!", "ERROR", MessageBoxType.TYPE_ERROR);
				return;
			}
			if (txtMadeBy.text == null || txtMadeBy.text == ""){
				Dialogs.messageBox("Missing Developer Info!", "ERROR", MessageBoxType.TYPE_ERROR);
				return;
			}
			if (downloadUrl.text == null || downloadUrl.text == ""){
				Dialogs.messageBox("Missing Download URL!", "ERROR", MessageBoxType.TYPE_ERROR);
				return;
			}

			var data:Dynamic = defaultData();
			data.isOpenSource = options[isOpenSourceSelect.listView.selectedIndex];
			data.canMessWithComputer = options[messesWithPC.listView.selectedIndex];
			data.title = txtTitle.text;
			data.description = txtDescription.text;
			data.madeBy = txtMadeBy.text;
			data.externalURL = externalUrl.text;
			data.githubURL = githubUrl.text;
			data.madeByURL = madeUrl.text;
			data.downloadURL = downloadUrl.text;
			
			File.saveContent("./.solar-engine/config.json", Json.stringify(data));
			File.saveContent("./.solar-engine/readme.md", "Has to be filled in.");

			File.saveBytes("./.solar-engine/banner.png", bannerBytes);
			File.saveBytes("./.solar-engine/icon.png", iconBytes);

			Dialogs.messageBox("Info Saved!", "SUCCESS", MessageBoxType.TYPE_INFO);
        }
    }

	function defaultData():Data{
		return {
			isOpenSource: "",
			canMessWithComputer: "",
			title: "",
			description: "",
			madeBy: "",
			externalURL: "",
			githubURL: "",
			madeByURL: "",
			downloadURL: ""
		};
	}
}