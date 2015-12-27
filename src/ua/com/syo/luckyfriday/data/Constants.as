package ua.com.syo.luckyfriday.data
{
	public class Constants
	{
		/**
		 * First x.x.x - last version of game patch
		 * Next x - subversion
		 * Next xxxx xx xx - year month date
		 * Next xx - version of daily build
		 */
		public static const VERSION:String = "0.1.20151227.1";

		// game objects names
		public static const SHIP_OBJ_NAME:String = "ship";

		// key actions
		public static const PLAY_ACTION:String = "play";
		public static const CONSOLE_ACTION:String = "console";
		public static const BREAK_ACTION:String = "break";
		public static const MENU_ACTION:String = "menu";
		public static const FORWARD_ACTION:String = "forward";
		public static const BACKWARD_ACTION:String = "backward";
		public static const UP_ACTION:String = "up";
		public static const DOWN_ACTION:String = "down";
		public static const ROTATECW_ACTION:String = "rotateCW";
		public static const ROTATECCW_ACTION:String = "rotateCCW";
		public static const LEFT_ACTION:String = "left";
		public static const RIGHT_ACTION:String = "right";
		public static const LEFT_TURN_ACTION:String = "leftTurn";
		public static const RIGHT_TURN_ACTION:String = "rightTurn";

		// animations
		public static const IDLE_RIGHT_ANIMATION:String = "idleright";
		public static const IDLE_LEFT_ANIMATION:String = "idleleft";
		public static const KREN_ANIMATION:String = "kren";
		public static const ROTATE_ANIMATION:String = "rotate";
		public static const RROTATER_ANIMATION:String = "rrotater";

		// music
		public static const LOOP_MUSIC:String = "musicLoop";
		// environment
		public static const LOOP_ENVIRONMENT:String = "environmentLoop";
		// sfx
		public static const ENGINE_SFX:String = "engine";
		public static const CONNECT_SFX:String = "connect";
		public static const DISCONNECT_SFX:String = "disconnect";
		// ui

		// sharedObjects
		public static const NAME_SO:String = "lf";
		public static const MUSIC_VOLUME_SO:String = "musicVolume";
		public static const SFX_VOLUME_SO:String = "sfxVolume";
		public static const WINDOWLED_SO:String = "windowled";
	}
}

