package ua.com.syo.luckyfriday.view {
	import feathers.controls.Alert;
	import feathers.controls.Header;
	import feathers.core.PopUpManager;
	import feathers.data.ListCollection;
	import feathers.themes.MetalWorksDesktopTheme;

	import starling.events.Event;

	import ua.com.syo.luckyfriday.controller.Controller;
	import ua.com.syo.luckyfriday.view.states.GameState;
	import ua.com.syo.luckyfriday.view.states.MenuState;
	import ua.com.syo.luckyfriday.view.states.MissionsState;
	import ua.com.syo.luckyfriday.view.ui.AboutView;
	import ua.com.syo.luckyfriday.view.ui.InGameMenu;
	import ua.com.syo.luckyfriday.view.ui.SettingsView;

	public class UIManager {

		private var settingsView:SettingsView;
		private var aboutView:AboutView;
		private var exitAlert:Alert;
		private var ingameMenu:InGameMenu;


		public function init():void {
			// init ui theme
			var theme:MetalWorksDesktopTheme = new MetalWorksDesktopTheme();
		}

		/**
		 * Show settings popup
		 */
		public function showSettings():void {
			if (!settingsView) {
				settingsView = new SettingsView();
				settingsView.headerFactory = function():Header {
					var header:Header = new Header();
					header.visible = false;
					return header;
				}
			}

			PopUpManager.addPopUp(settingsView);
			//ce.playing = false;
		}

		/**
		 * Show About popup
		 */
		public function showAbout():void {
			if (!aboutView) {
				aboutView = new AboutView();
			}
			PopUpManager.addPopUp(aboutView);
		}

		/**
		 * Show InGameMenu popup
		 */
		public function showIngameMenu():void {
			if (!ingameMenu) {
				ingameMenu = new InGameMenu();
			}
			PopUpManager.addPopUp(ingameMenu);
			ingameMenu.arrange();
		}

		/**
		 * ESC button pressed
		 */
		public function escPressed():void {
			if (PopUpManager.isTopLevelPopUp(settingsView)) {
				PopUpManager.removePopUp(settingsView);
				return;
			} else if (PopUpManager.isTopLevelPopUp(aboutView)) {
				PopUpManager.removePopUp(aboutView);
				return;
			} else if (PopUpManager.isTopLevelPopUp(exitAlert)) {
				PopUpManager.removePopUp(exitAlert);
				return;
			} else if (Controller.instance.ce.state == MissionsState.instance && !PopUpManager.isTopLevelPopUp(ingameMenu)) {
				showIngameMenu();
				return;
			} else if (Controller.instance.ce.state == MenuState.instance && !PopUpManager.isTopLevelPopUp(exitAlert)) {
				showExitAlert();
				return;
			} else if (Controller.instance.ce.state == GameState.instance && !PopUpManager.isTopLevelPopUp(ingameMenu)) {
				showIngameMenu();
				Controller.instance.pause();
				return;
			} else if (PopUpManager.isTopLevelPopUp(ingameMenu)) {
				PopUpManager.removePopUp(ingameMenu);
				Controller.instance.resume();
				return;
			}
		}

		public function showExitAlert():void {
			exitAlert = Alert.show("Do you want to exit?", "Exit to system", new ListCollection([{label: "OK"}, {label: "Cancel"}]));
			exitAlert.width = 400;
			exitAlert.height = 200;
			exitAlert.addEventListener(Event.CLOSE, alertCloseHandler);
		}

		private function alertCloseHandler(event:Event, data:Object):void {
			if (data.label == "OK") {
				Controller.instance.exitApplication();
			}
		}

		/**
		 * Singleton
		 */
		private static var _instance:UIManager;

		public static function get instance():UIManager {
			if (_instance == null) {
				_instance = new UIManager();
			}
			return _instance;
		}
	}
}

