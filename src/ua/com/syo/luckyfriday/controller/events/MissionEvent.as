package ua.com.syo.luckyfriday.controller.events
{
	import flash.events.Event;

	/**
	 * 
	 * @author Alex
	 * 
	 */
	public class MissionEvent extends Event
	{
	
		public static const MISSION_LOADED:String = "missionLoaded";

		public function MissionEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}

