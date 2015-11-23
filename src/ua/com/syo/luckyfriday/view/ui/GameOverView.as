package ua.com.syo.luckyfriday.view.ui
{
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.LayoutGroup;
	import feathers.controls.Panel;
	import feathers.core.PopUpManager;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	import feathers.layout.HorizontalLayout;
	
	import starling.events.Event;
	
	import ua.com.syo.luckyfriday.controller.Controller;
	import ua.com.syo.luckyfriday.view.states.MenuState;

	public class GameOverView extends Panel
	{
		private var playagainBtn:Button;
		private var menuBtn:Button;
		private var panelWidth:int = 600;
		private var panelHeight:int = 300;
		private var containerBtn:LayoutGroup;
		
		public function GameOverView() 
		{
			
			width = panelWidth;
			height = panelHeight;
			
			
			var labelsVLayout:HorizontalLayout = new HorizontalLayout();
			var labelsContainer:LayoutGroup = new LayoutGroup();
			labelsVLayout.padding = 20;
			labelsVLayout.gap = 8;
			labelsContainer.y = 0;
			labelsContainer.width = 550;
			labelsVLayout.horizontalAlign = HorizontalLayout.HORIZONTAL_ALIGN_CENTER;
			labelsContainer.layout = labelsVLayout;
			this.addChild(labelsContainer);
			
			
			addLabel("Game Over", labelsContainer);
			
			initButtons()
			// menu button
			menuBtn = new Button();
			menuBtn.label = "Menu";
			menuBtn.width = 170;
			//menuBtn.height = 50;
			menuBtn.layoutData = new AnchorLayoutData(NaN, 12, 12, NaN, NaN);
			menuBtn.addEventListener(Event.TRIGGERED, buttonClicked);
			containerBtn.addChild(menuBtn);
			
			
			// playagain button
			playagainBtn = new Button();
			playagainBtn.label = "Play Again";
			playagainBtn.width = 170;
			//playagainBtn.height = 50;
			playagainBtn.layoutData = new AnchorLayoutData(NaN, NaN, 20, NaN, NaN);
			playagainBtn.addEventListener(Event.TRIGGERED, buttonClicked);
			containerBtn.addChild(playagainBtn);
			
			
		}
		private function addLabel(text:String, container:LayoutGroup):void
		{
			var label:Label = new Label();
			label.text = text;
			container.addChild(label);
		}	
		private function initButtons():void {
			var containerVLayout:HorizontalLayout = new HorizontalLayout();
			containerBtn = new LayoutGroup();
			containerBtn.layout = new AnchorLayout();
			containerBtn.y = 190;
			containerBtn.width = 550;
			containerBtn.height = 78;
			containerVLayout.gap = 20; 
			containerVLayout.padding = 8;
			containerVLayout.horizontalAlign = HorizontalLayout.HORIZONTAL_ALIGN_CENTER;
			containerBtn.layout = containerVLayout;
			this.addChild(containerBtn);
		}
		private function buttonClicked(event:Event):void   
		{
			switch (event.currentTarget as Button){
				case menuBtn: 
					Controller.instance.changeState(MenuState.newInstance);
					PopUpManager.removePopUp(this);
					Controller.instance.ce.playing = true;
					break;
				case playagainBtn:
					Controller.instance.startLevel(Controller.instance.currentLevelId);  
					PopUpManager.removePopUp(this);
					Controller.instance.ce.playing = true;
					break;
			}
		
		}   
	}
}