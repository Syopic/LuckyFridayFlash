package ua.com.syo.luckyfriday.model.mission
{
	public class Mission
	{
		public var id:String; 
		public var linkId:String; // mission is additional, if linkId is not empty
		public var locationId:String;
		public var name:String; 
		public var description:String; 
		public var bgImageUrl:String; 
		public var fgImageUrl:String; 
		public var rate:int;
		public var locX:int;
		public var locY:int;
		public var isEnable:Boolean;
		public var isComplete:Boolean;
	}
}

