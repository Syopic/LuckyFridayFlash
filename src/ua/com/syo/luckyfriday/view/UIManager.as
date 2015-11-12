package ua.com.syo.luckyfriday.view {
	import flash.display.StageDisplayState;

	import citrus.core.CitrusEngine;
	import citrus.core.starling.StarlingState;
	import citrus.input.controllers.Keyboard;
	import citrus.input.controllers.gamepad.GamePadManager;
	import citrus.input.controllers.gamepad.Gamepad;
	import citrus.input.controllers.gamepad.maps.GamePadMap;
	import citrus.sounds.CitrusSoundGroup;
	import citrus.sounds.SoundManager;

	import feathers.controls.Alert;
	import feathers.core.PopUpManager;
	import feathers.data.ListCollection;

	import starling.events.Event;

	import ua.com.syo.luckyfriday.LuckyFriday;
	import ua.com.syo.luckyfriday.data.Assets;
	import ua.com.syo.luckyfriday.data.Constants;
	import ua.com.syo.luckyfriday.data.SaveData;
	import ua.com.syo.luckyfriday.view.states.GameState;
	import ua.com.syo.luckyfriday.view.states.MenuState;
	import ua.com.syo.luckyfriday.view.ui.AboutView;
	import ua.com.syo.luckyfriday.view.ui.SettingsView;

	public class UIManager {

		private var settingsView:SettingsView;
		private var aboutView:AboutView;
		private var exitAlert:Alert;

		public function init():void {

			// update settings from saved data in SharedObjects
			SoundManager.getInstance().getGroup(CitrusSoundGroup.BGM).volume = SaveData.instance.readData(Constants.MUSIC_VOLUME_SO) == null ? 0.5 : int(SaveData.instance.readData(Constants.MUSIC_VOLUME_SO)) / 100;
			SoundManager.getInstance().getGroup(CitrusSoundGroup.SFX).volume = SaveData.instance.readData(Constants.SFX_VOLUME_SO) == null ? 0.5 : int(SaveData.instance.readData(Constants.SFX_VOLUME_SO)) / 100;
			UIManager.instance.ce.stage.displayState = SaveData.instance.readData(Constants.WINDOWLED_SO) == null ? StageDisplayState.NORMAL : !Boolean(SaveData.instance.readData(Constants.WINDOWLED_SO)) ? StageDisplayState.FULL_SCREEN_INTERACTIVE : StageDisplayState.NORMAL;
			initKeyboardActions();
			initGamePad();
			initSounds();
		}

		/**
		 * Change state
		 * @param nextState new instance of new state
		 */
		public function changeState(nextState:StarlingState):void {
			// stop all sounds TODO: change sounds by state
			SoundManager.getInstance().stopAllPlayingSounds();
			ce.state = nextState;
		}

		/**
		 * Show settings popup
		 */
		public function showSettings():void {
			if (!settingsView) {
				settingsView = new SettingsView();
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
		 * ESC button pressed
		 */
		public function escPressed():void {
			if (PopUpManager.isTopLevelPopUp(settingsView)) {
				PopUpManager.removePopUp(settingsView);
				//ce.playing = true;
				return;
			} else if (PopUpManager.isTopLevelPopUp(aboutView)) {
				PopUpManager.removePopUp(aboutView);
				return;
			} else if (PopUpManager.isTopLevelPopUp(exitAlert)) {
				PopUpManager.removePopUp(exitAlert);
				return;
			} else if (ce.state == MenuState.instance && !PopUpManager.isTopLevelPopUp(exitAlert)) {
				showExitAlert();
				return;
			} else if (ce.state == GameState.instance && !PopUpManager.isTopLevelPopUp(settingsView)) {
				showSettings();
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
				LuckyFriday.exitApplication();
			}
		}

		/**
		 * Get the keyboard, and add actions
		 */
		protected function initKeyboardActions():void {
			var kb:Keyboard = ce.input.keyboard;
			kb.addKeyAction(Constants.PLAY_ACTION, Keyboard.P);

			kb.addKeyAction(Constants.CONSOLE_ACTION, Keyboard.TAB);
			kb.addKeyAction(Constants.BREAK_ACTION, Keyboard.SPACE);
			kb.addKeyAction(Constants.MENU_ACTION, Keyboard.BACKSPACE);

			kb.addKeyAction(Constants.FORWARD_ACTION, Keyboard.RIGHT);
			kb.addKeyAction(Constants.BACKWARD_ACTION, Keyboard.LEFT);
			kb.addKeyAction(Constants.UP_ACTION, Keyboard.W);
			kb.addKeyAction(Constants.DOWN_ACTION, Keyboard.S);

			kb.addKeyAction(Constants.ROTATECW_ACTION, Keyboard.A);
			kb.addKeyAction(Constants.ROTATECCW_ACTION, Keyboard.D);
		}

		/**
		 * Init Gamepad actions
		 */
		protected function initGamePad():void {
			var gamePadManager:GamePadManager = new GamePadManager(1);
			gamePadManager.onControllerAdded.add(addGamePad);
		}

		protected function addGamePad(gamepad:Gamepad):void {
			gamepad.setStickActions(GamePadMap.STICK_LEFT, Constants.UP_ACTION, Constants.ROTATECCW_ACTION, Constants.DOWN_ACTION, Constants.ROTATECW_ACTION);
			gamepad.setStickActions(GamePadMap.STICK_RIGHT, Constants.UP_ACTION, Constants.FORWARD_ACTION, Constants.DOWN_ACTION, Constants.BACKWARD_ACTION);
			gamepad.setButtonAction(GamePadMap.START, Constants.PLAY_ACTION);
			gamepad.setButtonAction(GamePadMap.SELECT, Constants.MENU_ACTION);
			gamepad.setButtonAction(GamePadMap.L1, Constants.BREAK_ACTION);
			gamepad.setButtonAction(GamePadMap.R1, Constants.BREAK_ACTION);
		}

		/**
		 * Init sounds
		 */
		protected function initSounds():void {
			SoundManager.getInstance().addSound(Constants.LOOP_MUSIC, {sound: Assets.ThemeSoundC, loops: -1, volume: 1, group: CitrusSoundGroup.BGM});

			SoundManager.getInstance().addSound(Constants.LOOP_ENVIRONMENT, {sound: Assets.EnvSoundC, loops: -1, volume: 0.1, permanent: true, group: CitrusSoundGroup.SFX});
			SoundManager.getInstance().addSound(Constants.ENGINE_SFX, {sound: Assets.EngineSoundC, loops: -1, group: CitrusSoundGroup.SFX});
			SoundManager.getInstance().addSound(Constants.CONNECT_SFX, {sound: Assets.ConnectSoundC, group: CitrusSoundGroup.SFX});
			SoundManager.getInstance().addSound(Constants.DISCONNECT_SFX, {sound: Assets.DisconnectSoundC, group: CitrusSoundGroup.SFX});
		}

		/**
		 * CitrusEngine instance
		 */
		public function get ce():LuckyFriday {
			return LuckyFriday(CitrusEngine.getInstance());
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

