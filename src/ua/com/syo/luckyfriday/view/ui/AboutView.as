package ua.com.syo.luckyfriday.view.ui
{	
	
	import citrus.objects.CitrusSprite;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.LayoutGroup;
	import feathers.controls.Panel;
	import feathers.core.PopUpManager;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.VerticalLayout;
	import feathers.themes.HyperlinkTextFieldTextRenderer;
	
	import starling.display.Image;
	import starling.events.Event;
	import starling.textures.Texture;
	
	import ua.com.syo.luckyfriday.data.Assets;
	
	
	public class AboutView extends Panel
	{
		private var donateBtn:Button;
		private var backBtn:Button;
		
		private var panelWidth:int = 500;
		private var panelHeight:int = 470;
		private var img:Image;
		
		//public function HyperlinkTextFieldTextRenderer()	
		
		public function AboutView()
		{
			width = panelWidth;
			height = panelHeight;
			title = "About";
			
			
			
			this.layout = new AnchorLayout();
			
			var labelsVLayout:VerticalLayout = new VerticalLayout();
 			var labelsContainer:LayoutGroup = new LayoutGroup();
			//labelsVLayout.padding = 80;
			labelsVLayout.gap = 5;
			labelsContainer.x = 120;
			labelsContainer.y = 120;
			labelsContainer.width = 240;
			labelsVLayout.horizontalAlign = HorizontalLayout.HORIZONTAL_ALIGN_CENTER;
			labelsContainer.layout = labelsVLayout;
			this.addChild(labelsContainer);
			
			var controlsVLayout:VerticalLayout = new VerticalLayout();
			var controlsContainer:LayoutGroup = new LayoutGroup();
			controlsVLayout.padding = 15;
			controlsVLayout.horizontalAlign = HorizontalLayout.HORIZONTAL_ALIGN_LEFT;
			controlsVLayout.gap = 21;
			controlsContainer.width = 210;
			controlsContainer.x = 230;
			controlsContainer.layout = controlsVLayout;
			this.addChild(controlsContainer);
			
			
			addLabel("Lucky Friday v.0.0.0", labelsContainer);
			addLabel("Myzika Slava", labelsContainer);
			addLabel("Gonhcar Urii", labelsContainer);
			addLabel("Kryvosheya Volodymyr", labelsContainer);
			addLabel("Kryvosheya (Syo) Serhii", labelsContainer);
			
				
			// add Logo
			img = new Image(Texture.fromEmbeddedAsset(Assets.LogoC));
			img.pivotX = 4;
			img.pivotY = 12;
			img.width = 110;
			img.height = 100;
			img.x = 180;
			addChild(img);
			
			// add Hyperlink Text
			var abtxt:HyperlinkTextFieldTextRenderer = new HyperlinkTextFieldTextRenderer();
			abtxt.text = "<u><a href=\"http://lyuckyfriday.net\">LyuckyFriday.net</a></u>.";
			abtxt.x = 185;
			abtxt.y = 280;
			this.addChild(abtxt);
		
			// back
			backBtn = new Button();
			backBtn.label = "Back";
			backBtn.width = 150;
			backBtn.height = 50;
			backBtn.layoutData = new AnchorLayoutData(NaN, 12, 12);
			backBtn.addEventListener(Event.TRIGGERED, buttonClicked);
			this.addChild(backBtn);

			
			// donate button
			donateBtn = new Button();
			donateBtn.label = "Donate";
			donateBtn.width = 150;
			donateBtn.height = 50;
			donateBtn.layoutData = new AnchorLayoutData(NaN, NaN, 12, 10);
			donateBtn.addEventListener(Event.TRIGGERED, buttonClicked);
			this.addChild(donateBtn);
			
		}
		
		private function add(bgSprite:CitrusSprite):void
		{
			// TODO Auto Generated method stub
			
		}
		
		private function buttonClicked(event:Event):void   
		{   
			switch (event.currentTarget as Button)
			{
				
				//case donateBtn: 
				//	PopUpManager.removePopUp(this);
				//	break;
				case backBtn: 
					PopUpManager.removePopUp(this);
					break;
			}
			
		}
		
		private function addLabel(text:String, container:LayoutGroup):void
		{
			var label:Label = new Label();
			label.scaleX =0.7;
			label.scaleY =0.7;
			label.text = text;
			container.addChild(label);
		}
		
				
		
		
		private function addButton(label:String, container:LayoutGroup):void
		{
			var button:Button = new Button();
			button.label = label;
			button.width = 70;
			button.height = 42;
			container.addChild(button);
		}
		
		
	}
}


