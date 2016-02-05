package ua.com.syo.luckyfriday.controller {
	import flash.desktop.NativeApplication;
	import flash.display.StageDisplayState;
	import flash.filesystem.File;

	import citrus.core.CitrusEngine;
	import citrus.core.starling.StarlingState;
	import citrus.input.controllers.Keyboard;
	import citrus.input.controllers.gamepad.GamePadManager;
	import citrus.input.controllers.gamepad.Gamepad;
	import citrus.input.controllers.gamepad.maps.GamePadMap;
	import citrus.sounds.CitrusSoundGroup;
	import citrus.sounds.SoundManager;

	import starling.events.EventDispatcher;

	import ua.com.syo.luckyfriday.LuckyFriday;
	import ua.com.syo.luckyfriday.controller.events.AssetsLoadingEvent;
	import ua.com.syo.luckyfriday.data.Constants;
	import ua.com.syo.luckyfriday.data.EmbeddedAssets;
	import ua.com.syo.luckyfriday.data.SaveData;
	import ua.com.syo.luckyfriday.model.Model;
	import ua.com.syo.luckyfriday.view.UIManager;
	import ua.com.syo.luckyfriday.view.states.GameState;

	public class Controller extends EventDispatcher {

		private var _currentMissionId:String = "1.1";

		public function init():void {
			// update settings from saved data in SharedObjects
			SoundManager.getInstance().getGroup(CitrusSoundGroup.BGM).volume = SaveData.instance.readData(Constants.MUSIC_VOLUME_SO) == null ? 0.5 : Number(SaveData.instance.readData(Constants.MUSIC_VOLUME_SO)) / 100;
			SoundManager.getInstance().getGroup(CitrusSoundGroup.SFX).volume = SaveData.instance.readData(Constants.SFX_VOLUME_SO) == null ? 0.5 : Number(SaveData.instance.readData(Constants.SFX_VOLUME_SO)) / 100;
			ce.stage.displayState = SaveData.instance.readData(Constants.WINDOWLED_SO) == null ? StageDisplayState.NORMAL : !Boolean(SaveData.instance.readData(Constants.WINDOWLED_SO)) ? StageDisplayState.FULL_SCREEN_INTERACTIVE : StageDisplayState.NORMAL;
			initKeyboardActions();
			initGamePadActions();
			initCommonSounds();

			trace("File.userDirectory.name: " + File.userDirectory.name)
			if (File.userDirectory.name == "Syo")
			{
				//startLoadLevel(currentLevelId);
			}
			//startLoadMissions();
		}

		/**
		 * CitrusEngine instance
		 */
		public function get ce():LuckyFriday {
			return LuckyFriday(CitrusEngine.getInstance());
		}


		/**
		 * Pause game
		 */
		public function pause():void {
			ce.playing = false;
		}

		/**
		 * Resume game
		 */
		public function resume():void {
			ce.playing = true;
		}

		/**
		 * Exit to system
		 */
		public function exitApplication():void {
			NativeApplication.nativeApplication.exit();
		}

		/**
		 * Change state
		 * @param nextState new instance of new state
		 */
		public function changeState(nextState:StarlingState):void {
			SoundManager.getInstance().stopAllPlayingSounds();
			ce.state = nextState;
		}


		public function startLoadLevel(missionId:String):void {
			trace("START LEVEL: " + missionId);
			_currentMissionId = missionId;
			Model.instance.addEventListener(AssetsLoadingEvent.LEVEL_LOADED, levelLoadedComplete);
			Model.instance.loadLevelAssets(missionId);
		}

		/**
		 * Level load complete
		 */
		protected function levelLoadedComplete(event:AssetsLoadingEvent):void {
			changeState(GameState.newInstance);
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

			kb.addKeyAction(Constants.LEFT_TURN_ACTION, Keyboard.Q);
			kb.addKeyAction(Constants.RIGHT_TURN_ACTION, Keyboard.E);
		}

		/**
		 * Init Gamepad actions
		 */
		protected function initGamePadActions():void {
			var gamePadManager:GamePadManager = new GamePadManager(1);
			gamePadManager.onControllerAdded.add(addGamePad);
		}

		protected function addGamePad(gamepad:Gamepad):void {
			gamepad.setButtonAction(GamePadMap.BUTTON_LEFT, Constants.BACKWARD_ACTION);
			gamepad.setButtonAction(GamePadMap.BUTTON_RIGHT, Constants.FORWARD_ACTION);
			gamepad.setButtonAction(GamePadMap.BUTTON_TOP, Constants.UP_ACTION);
			gamepad.setButtonAction(GamePadMap.BUTTON_BOTTOM, Constants.BREAK_ACTION);

			gamepad.setButtonAction(GamePadMap.DPAD_LEFT, Constants.ROTATECW_ACTION);
			gamepad.setButtonAction(GamePadMap.DPAD_RIGHT, Constants.ROTATECCW_ACTION);
			gamepad.setStickActions(GamePadMap.STICK_LEFT, Constants.UP_ACTION, Constants.ROTATECCW_ACTION, Constants.DOWN_ACTION, Constants.ROTATECW_ACTION);
			gamepad.setStickActions(GamePadMap.STICK_RIGHT, Constants.UP_ACTION, Constants.FORWARD_ACTION, Constants.DOWN_ACTION, Constants.BACKWARD_ACTION);
			gamepad.setButtonAction(GamePadMap.START, Constants.PLAY_ACTION);
			gamepad.setButtonAction(GamePadMap.SELECT, Constants.MENU_ACTION);
			gamepad.setButtonAction(GamePadMap.L1, Constants.LEFT_TURN_ACTION);
			gamepad.setButtonAction(GamePadMap.R1, Constants.RIGHT_TURN_ACTION);
			//gamepad.setButtonAction(GamePadMap.L2, Constants.BREAK_ACTION);
			//gamepad.setButtonAction(GamePadMap.R2, Constants.BREAK_ACTION);
		}

		/**
		 * Init sounds
		 */
		protected function initCommonSounds():void {
			SoundManager.getInstance().addSound(Constants.LOOP_MUSIC, {sound: EmbeddedAssets.ThemeSoundC, loops: -1, volume: 1, group: CitrusSoundGroup.BGM});

			SoundManager.getInstance().addSound(Constants.LOOP_ENVIRONMENT, {sound: EmbeddedAssets.EnvSoundC, loops: -1, volume: 0.1, permanent: true, group: CitrusSoundGroup.SFX});
			SoundManager.getInstance().addSound(Constants.ENGINE_SFX, {sound: EmbeddedAssets.EngineSoundC, loops: -1, group: CitrusSoundGroup.SFX});
			SoundManager.getInstance().addSound(Constants.CONNECT_SFX, {sound: EmbeddedAssets.ConnectSoundC, group: CitrusSoundGroup.SFX});
			SoundManager.getInstance().addSound(Constants.DISCONNECT_SFX, {sound: EmbeddedAssets.DisconnectSoundC, group: CitrusSoundGroup.SFX});
		}

		public function get currentMissionId():String {
			return _currentMissionId;
		}

		public function isDoing(actionName:String, channel:int = -1):Boolean
		{
			var result:Boolean = false;
			if(ce.input.isDoing(actionName, channel))
			{
				result = true;
			}

			if (UIManager.instance.joystick)
			{

				if (actionName == Constants.UP_ACTION && UIManager.instance.joystick.velocityY < 0)
				{
					result = true;
				}
				if (actionName == Constants.DOWN_ACTION && UIManager.instance.joystick.velocityY > 0)
				{
					result = true;
				}
				if (actionName == Constants.BACKWARD_ACTION && UIManager.instance.joystick.velocityX < 0)
				{
					result = true;
				}
				if (actionName == Constants.FORWARD_ACTION && UIManager.instance.joystick.velocityX > 0)
				{
					result = true;
				}
			}

			return result;
		}

		public function hasDone(actionName:String, channel:int = -1):Boolean
		{
			var result:Boolean = false;
			if(ce.input.hasDone(actionName, channel))
			{
				result = true;
			}

			return result;
		}


		/**
		 * Singleton
		 */
		private static var _instance:Controller;

		public static function get instance():Controller {
			if (_instance == null) {
				_instance = new Controller();
			}
			return _instance;
		}

	}
}

