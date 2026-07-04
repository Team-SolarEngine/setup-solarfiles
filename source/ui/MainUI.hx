package ui;

import haxe.io.Bytes;
import haxe.ui.containers.VBox;
import haxe.ui.containers.dialogs.Dialogs;
import haxe.ui.containers.dialogs.MessageBox.MessageBoxType;
import sys.FileSystem;
import sys.io.File;
import haxe.Json;
import haxe.ui.ToolkitAssets;
import haxe.ui.containers.dialogs.Dialog.DialogButton;

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
	var type:String;
}

@:build(haxe.ui.ComponentBuilder.build("assets/ui/mainview.xml"))
class MainUI extends VBox {
	var bannerBytes:Bytes = null;
	var iconBytes:Bytes = null;

	var options:Array<String> = ["yes", "no"];
	var typeOptions:Array<String> = ["Mods", "Scripts"];

	public function new() {
		super();
		banner.onClick = function(event) {
			Dialogs.openBinaryFile("Open Banner", [{label: "Banner File (.png)", extension: "png"}], function(selectedFile) {
				if (selectedFile != null && selectedFile.bytes != null) {
					trace("Selected file: " + selectedFile.name);
					bannerBytes = selectedFile.bytes;
					banner.text = "Banner Success!";

					ToolkitAssets.instance.imageFromBytes(bannerBytes, function(imageInfo) {
						if (imageInfo != null) {
							try {
								PreviewUI.instance.bannerPreview.resource = imageInfo.data;
								PreviewUI.instance.bannerLabel.show();
							} catch (_) {}
						}
					});
				}
			});
		}

		iconbtn.onClick = function(event) {
			Dialogs.openBinaryFile("Open Icon", [{label: "Icon File (.png)", extension: "png"}], function(selectedFile) {
				if (selectedFile != null && selectedFile.bytes != null) {
					trace("Selected file: " + selectedFile.name);
					iconBytes = selectedFile.bytes;
					iconbtn.text = "Icon Success!";

					ToolkitAssets.instance.imageFromBytes(iconBytes, function(imageInfo) {
						if (imageInfo != null) {
							try {
								PreviewUI.instance.iconPreview.resource = imageInfo.data;
								PreviewUI.instance.iconLabel.show();
							} catch (_) {}
						}
					});
				}
			});
		}

		clearbtn.onClick = function(event){
			Dialogs.messageBox("Are you sure?", "QUESTION", MessageBoxType.TYPE_YESNO, function(callback){
				(callback == DialogButton.YES) ? clearInfo() : return;
			});
		}

		finish.onClick = function(event) {
			FileSystem.createDirectory(".solar-engine");

			if (iconBytes == null) {
				Dialogs.messageBox("Missing Icon file!", "ERROR", MessageBoxType.TYPE_ERROR);
				return;
			}
			if (bannerBytes == null) {
				Dialogs.messageBox("Missing Banner file!", "ERROR", MessageBoxType.TYPE_ERROR);
				return;
			}
			if (txtTitle.text == null || txtTitle.text == "") {
				Dialogs.messageBox("No Title!", "ERROR", MessageBoxType.TYPE_ERROR);
				return;
			}
			if (txtDescription.text == null || txtDescription.text == "") {
				Dialogs.messageBox("No Description!", "ERROR", MessageBoxType.TYPE_ERROR);
				return;
			}
			if (txtMadeBy.text == null || txtMadeBy.text == "") {
				Dialogs.messageBox("Missing Developer Info!", "ERROR", MessageBoxType.TYPE_ERROR);
				return;
			}
			if (downloadUrl.text == null || downloadUrl.text == "") {
				Dialogs.messageBox("Missing Download URL!", "ERROR", MessageBoxType.TYPE_ERROR);
				return;
			}

			var data:Dynamic = defaultData();
			data.isOpenSource = options[isOpenSourceSelect.listView.selectedIndex];
			data.canMessWithComputer = options[messesWithPC.listView.selectedIndex];
			data.title = txtTitle.text;
			data.description = txtDescription.text;
			data.madeBy = txtMadeBy.text;
			data.externalURL = externalUrl.text ??= "";
			data.githubURL = githubUrl.text ??= "";
			data.madeByURL = madeUrl.text ??= "";
			data.downloadURL = downloadUrl.text;
			data.type = typeOptions[submitType.listView.selectedIndex];

			File.saveContent("./.solar-engine/config.json", Json.stringify(data));
			File.saveContent("./.solar-engine/readme.md", "Has to be filled in.");

			File.saveBytes("./.solar-engine/banner.png", bannerBytes);
			File.saveBytes("./.solar-engine/logo.png", iconBytes);

			Dialogs.messageBox("Info Saved!", "SUCCESS", MessageBoxType.TYPE_INFO);

			clearInfo();
		}
	}

	function defaultData():Data {
		return {
			isOpenSource: "",
			canMessWithComputer: "",
			title: "",
			description: "",
			madeBy: "",
			externalURL: "",
			githubURL: "",
			madeByURL: "",
			downloadURL: "",
			type: ""
		};
	}

	function clearInfo() {
		bannerBytes = null;
		iconBytes = null;

		banner.text = "Banner";
		iconbtn.text = "Icon";

		txtTitle.text = "";
		txtDescription.text = "";
		txtMadeBy.text = "";
		githubUrl.text = "";
		externalUrl.text = "";
		madeUrl.text = "";
		downloadUrl.text = "";

		isOpenSourceSelect.listView.selectedIndex = 0;
		messesWithPC.listView.selectedIndex = 0;
		submitType.listView.selectedIndex = 0;

		PreviewUI.instance.bannerPreview.resource = null;
		PreviewUI.instance.iconPreview.resource = null;

		PreviewUI.instance.bannerLabel.hide();
		PreviewUI.instance.iconLabel.hide();
	}
}
