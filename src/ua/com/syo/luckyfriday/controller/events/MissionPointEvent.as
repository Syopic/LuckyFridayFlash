package ua.com.syo.luckyfriday.controller.events
{
	import starling.events.Event;

	public class MissionPointEvent extends Event
	{
		public var id:String;
		public static const MISSION_SELECT:String = "missionSelect"; 
		
		public function MissionPointEvent(type:String, bubbles:Boolean=false, data:Object=null)
		{
			super(type, bubbles, data);
		}
	}
}