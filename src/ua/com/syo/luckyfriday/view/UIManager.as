package ua.com.syo.luckyfriday.view {
	import citrus.core.CitrusEngine;
	import citrus.core.starling.StarlingState;
	import citrus.input.controllers.Keyboard;
	import citrus.input.controllers.gamepad.GamePadManager;
	import citrus.input.controllers.gamepad.Gamepad;
	import citrus.input.controllers.gamepad.maps.GamePadMap;
	import citrus.sounds.SoundManager;

	import feathers.core.PopUpManager;

	import ua.com.syo.luckyfriday.LuckyFriday;
	import ua.com.syo.luckyfriday.data.Assets;
	import ua.com.syo.luckyfriday.data.Constants;
	import ua.com.syo.luckyfriday.view.ui.AboutView;
	import ua.com.syo.luckyfriday.view.ui.SettingsView;

	public class UIManager {

		private var settingsView:SettingsView;
		private var aboutView:AboutView;

		public function init():void {
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
		 * Get the keyboard, and add actions
		 */
		protected function initKeyboardActions():void {
			var kb:Keyboard = ce.input.keyboard;
			kb.addKeyAction(Constants.PLAY_ACTION, Keyboard.P);

			kb.addKeyAction(Constants.CONSOLE_ACTION, Keyboard.TAB);
			kb.addKeyAction(Constants.BREAK_ACTION, Keyboard.SPACE);
			kb.addKeyAction(Constants.MENU_ACTION, Keyboard.ESCAPE);

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
		protected function initSounds():void
		{
			SoundManager.getInstance().addSound(Constants.LOOP_EMBIENT, { sound:Assets.LoopSoundC, loops:-1, volume:0.01});
			SoundManager.getInstance().addSound(Constants.ENGINE_SFX, { sound:Assets.EngineSoundC, loops:100000, volume:0.3});

			SoundManager.getInstance().addSound(Constants.CONNECT_SFX, { sound:Assets.ConnectSoundC, volume:0.5});
			SoundManager.getInstance().addSound(Constants.DISCONNECT_SFX, { sound:Assets.DisconnectSoundC, volume:0.1});

			SoundManager.getInstance().playSound(Constants.LOOP_EMBIENT);
			SoundManager.getInstance().playSound(Constants.ENGINE_SFX);
		}

		/**
		 * CitrusEngine instance
		 */
		private function get ce():LuckyFriday {
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

