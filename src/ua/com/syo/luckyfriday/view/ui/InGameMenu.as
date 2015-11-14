package ua.com.syo.luckyfriday.view.ui
{
	import feathers.controls.Button;
	import feathers.controls.LayoutGroup;
	import feathers.controls.Panel;
	import feathers.core.PopUpManager;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.VerticalLayout;
	
	import starling.events.Event;
	
	import ua.com.syo.luckyfriday.view.UIManager;
	import ua.com.syo.luckyfriday.view.states.GameState;
	import ua.com.syo.luckyfriday.view.states.MenuState;
	
	public class InGameMenu extends Panel
	{
		
		private var showSettings:UIManager;
		private var resumeBtn:Button;
		private var restartBtn:Button;
		private var exitmisBtn:Button;
		private var setingsBtn:Button;
		private var panelWidth:int = 280;
		private var panelHeight:int = 360;
		
		
		public function InGameMenu()
		{
			width = panelWidth;
			height = panelHeight;
			title = "Game Menu";
			
			this.layout = new AnchorLayout();
			
		
			/**
			 * Add butons 
			 */
			resumeBtn = new Button();
			resumeBtn.label = "Resume";
			resumeBtn.width = 230;
			resumeBtn.height = 50;
			resumeBtn.layoutData = new AnchorLayoutData(12, 12, NaN, 12);
			resumeBtn.addEventListener(Event.TRIGGERED, buttonClicked);
			this.addChild(resumeBtn);
			
			restartBtn = new Button();
			restartBtn.label = "Restart Misson";
			restartBtn.width = 230;
			restartBtn.height = 50;
			restartBtn.layoutData = new AnchorLayoutData(74, 12, NaN, 12);
			restartBtn.addEventListener(Event.TRIGGERED, buttonClicked);
			this.addChild(restartBtn);
			
			
			exitmisBtn = new Button();
			exitmisBtn.label = "Exit Misson";
			exitmisBtn.width = 230;
			exitmisBtn.height = 50;
			exitmisBtn.layoutData = new AnchorLayoutData(136, 12, NaN, 12);
			exitmisBtn.addEventListener(Event.TRIGGERED, buttonClicked);
			this.addChild(exitmisBtn);
			
			
			setingsBtn = new Button();
			setingsBtn.label = "Setings";
			setingsBtn.width = 230;
			setingsBtn.height = 50;
			setingsBtn.layoutData = new AnchorLayoutData(198, 12, NaN, 12);
			setingsBtn.addEventListener(Event.TRIGGERED, buttonClicked);
			this.addChild(setingsBtn);
		}
		
		private function buttonClicked(event:Event):void   
		{   
			switch (event.currentTarget as Button)
			{
				case resumeBtn: 
					PopUpManager.removePopUp(this);
					UIManager.instance.ce.playing = true;
					break;
				 case setingsBtn: 
					 UIManager.instance.showSettings();
					 UIManager.instance.ce.playing = false;
					break;
				 case exitmisBtn:
					 UIManager.instance.changeState(MenuState.newInstance);
					 
					 PopUpManager.removePopUp(this);
					break;
				  
			}
		}
	}
}