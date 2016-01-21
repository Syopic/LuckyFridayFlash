package ua.com.syo.luckyfriday.controller.events
{
	import flash.events.Event;

	/**
	 * 
	 * @author Alex
	 * 
	 */
	public class LevelEvent extends Event
	{
		
		public static const LEVEL_LOADED:String = "levelLoaded";

		public function LevelEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}

