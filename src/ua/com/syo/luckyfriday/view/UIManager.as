package ua.com.syo.luckyfriday.view {


	import feathers.controls.Alert;
	import feathers.controls.Header;
	import feathers.core.PopUpManager;
	import feathers.data.ListCollection;
	import feathers.themes.MetalWorksDesktopTheme;
	
	import starling.core.Starling;
	import starling.events.Event;
	import starling.events.EventDispatcher;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	import ua.com.syo.luckyfriday.controller.Controller;
	import ua.com.syo.luckyfriday.controller.events.ProfileEvent;
	import ua.com.syo.luckyfriday.data.Globals;
	import ua.com.syo.luckyfriday.view.states.GameState;
	import ua.com.syo.luckyfriday.view.states.LocationsState;
	import ua.com.syo.luckyfriday.view.states.MenuState;
	import ua.com.syo.luckyfriday.view.states.MissionsState;
	import ua.com.syo.luckyfriday.view.ui.AboutView;
	import ua.com.syo.luckyfriday.view.ui.GameOverView;
	import ua.com.syo.luckyfriday.view.ui.InGameMenu;
	import ua.com.syo.luckyfriday.view.ui.MissionCompleteView;
	import ua.com.syo.luckyfriday.view.ui.ProfileView;
	import ua.com.syo.luckyfriday.view.ui.SettingsView;

	public class UIManager extends EventDispatcher  {

		private var settingsView:SettingsView;
		private var aboutView:AboutView;
		private var exitAlert:Alert;
		private var ingameMenu:InGameMenu;
		private var missionComplete:MissionCompleteView;
		private var gameOver:GameOverView;
		private var profileView:ProfileView;

		public function init():void {
			// init ui theme
			var theme:MetalWorksDesktopTheme = new MetalWorksDesktopTheme();
			initProfileView();
			
			
		}
		public function initProfileView():void {
			if (!profileView) {
				profileView = new ProfileView();
			}
			Controller.instance.addEventListener(ProfileEvent.PROFILE_LOADED, arrageProfileView);
		}

		/**
		 * Show settings popup
		 */
		public function showSettings():void {
			if (!settingsView) {
				settingsView = new SettingsView();
				/*settingsView.headerFactory = function():Header {
					var header:Header = new Header();
					header.visible = false;
					return header;
				}*/
			}

			PopUpManager.addPopUp(settingsView);
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
		 *
		 * Show GameOver popup
		 */
		public function showGameOver():void {
			if (!gameOver) {
				gameOver = new GameOverView();
			}
			PopUpManager.addPopUp(gameOver);
		}


		/**
		 *
		 * Show MissionComplete popup
		 */
		public function showMissionComplete():void {
			if (!missionComplete) {
				missionComplete = new MissionCompleteView();
				missionComplete.headerFactory = function():Header {
					var header:Header = new Header();
					header.scaleY = 0.2;
					header.visible = false;
					return header;
				}
			}
			PopUpManager.addPopUp(missionComplete);
		}

		/**
		 * Show ProfileView UI
		 */
		public function showProfileView():void {
			if (!profileView) {
				profileView = new ProfileView();
			}
			PopUpManager.addPopUp(profileView);
		}

		/**
		 * Arrage ProfileView Data
		 */

		public function arrageProfileView():void {
			profileView.arrange();
			MenuState.instance.arrange();
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
			} else if (PopUpManager.isTopLevelPopUp(missionComplete)) {
				PopUpManager.removePopUp(missionComplete);
				return;
			} else if (PopUpManager.isTopLevelPopUp(exitAlert)) {
				PopUpManager.removePopUp(exitAlert);
				return;
			} else if (PopUpManager.isTopLevelPopUp(profileView)) {
				PopUpManager.removePopUp(profileView);
				return;
			} else if (Controller.instance.ce.state == MissionsState.instance && !PopUpManager.isTopLevelPopUp(ingameMenu)) {
				showIngameMenu();
				return;
			} else if (Controller.instance.ce.state == LocationsState.instance && !PopUpManager.isTopLevelPopUp(ingameMenu)) {
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
		public function resizeListener():void
		{
			
			this.dispatchEvent(new Event(Event.RESIZE));
			
			// TODO Auto Generated method stub
			
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

