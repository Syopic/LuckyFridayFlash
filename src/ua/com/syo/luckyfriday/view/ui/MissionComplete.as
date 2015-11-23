package ua.com.syo.luckyfriday.view.ui
{
	import citrus.view.starlingview.AnimationSequence;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.LayoutGroup;
	import feathers.controls.Panel;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.VerticalLayout;
	
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	import ua.com.syo.luckyfriday.data.Assets;
	import ua.com.syo.luckyfriday.data.Constants;

	public class MissionComplete extends Panel
		
	{
		private var menuBtn:Button;
		private var playagainBtn:Button;
		private var nextBtn:Button;
		private var panelWidth:int = 600;
		private var panelHeight:int = 300;
		private var containerBtn:LayoutGroup;
		private var mMovie:MovieClip;
		
		
		
		
		public function MissionComplete()
		{
			
			width = panelWidth;
			height = panelHeight;
			//title = "Settings";
			
				
			this.layout = new AnchorLayout();
			
			var labelsVLayout:HorizontalLayout = new HorizontalLayout();
			var labelsContainer:LayoutGroup = new LayoutGroup();
			labelsVLayout.padding = 20;
			labelsVLayout.gap = 8;
			labelsContainer.y = 0;
			labelsContainer.width = 550;
			labelsVLayout.horizontalAlign = HorizontalLayout.HORIZONTAL_ALIGN_CENTER;
			labelsContainer.layout = labelsVLayout;
			this.addChild(labelsContainer);
			
			/**
			
			var controlsVLayout:VerticalLayout = new VerticalLayout();
			var controlsContainer:LayoutGroup = new LayoutGroup();
			controlsVLayout.padding = 15;
			controlsVLayout.horizontalAlign = HorizontalLayout.HORIZONTAL_ALIGN_CENTER;
			controlsVLayout.gap = 2;
			controlsContainer.width = 480;
			controlsContainer.x = 300;
			controlsContainer.layout = controlsVLayout;
			this.addChild(controlsContainer);
*/
			addLabel("Mission Complete", labelsContainer);
			
			initAnimations()
			// animate them
			Starling.juggler.add ( mMovie );
			
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
			
			// next button
			nextBtn = new Button();
			nextBtn.label = "Next";
			nextBtn.width = 170;
			//nextBtn.height = 50;
			nextBtn.layoutData = new AnchorLayoutData(NaN, NaN, 12, NaN, 12);
			nextBtn.addEventListener(Event.TRIGGERED, buttonClicked);
			containerBtn.addChild(nextBtn);
			
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
		
		
		private function addLabel(text:String, container:LayoutGroup):void
		{
			var label:Label = new Label();
			label.text = text;
			container.addChild(label);
		}	
		
		private function buttonClicked(event:Event):void   
		{   
			switch (event.currentTarget as Button)
			{
				case menuBtn: 
					//PopUpManager.removePopUp(this);
					//UIManager.instance.ce.playing = true;
					break;
			}
		}
			private function initAnimations():void {
				var sTextureAtlas:TextureAtlas = Assets.getShipHeroAtlas();
				var frames:Vector.<Texture> = sTextureAtlas.getTextures(Constants.ROTATE_ANIMATION);
				mMovie = new MovieClip(frames, 10);
				mMovie.x = 170;
				mMovie.y = 60;
				addChild(mMovie);
			}
			 
		
	}
}