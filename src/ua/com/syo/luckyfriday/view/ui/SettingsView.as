package ua.com.syo.luckyfriday.view.ui
{
	import flash.display.StageDisplayState;

	import feathers.controls.Button;
	import feathers.controls.Check;
	import feathers.controls.Label;
	import feathers.controls.LayoutGroup;
	import feathers.controls.Panel;
	import feathers.controls.Slider;
	import feathers.core.PopUpManager;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.VerticalLayout;

	import starling.events.Event;

	import ua.com.syo.luckyfriday.view.UIManager;

	public class SettingsView extends Panel
	{
		private var backBtn:Button;
		private var panelWidth:int = 460;
		private var panelHeight:int = 360;

		private var musicSlider:Slider, sfxSlider:Slider;

		private var windowledCheckBox:Check;

		public function SettingsView()
		{
			width = panelWidth;
			height = panelHeight;
			title = "Settings";

			this.layout = new AnchorLayout();

			var labelsVLayout:VerticalLayout = new VerticalLayout();
			var labelsContainer:LayoutGroup = new LayoutGroup();
			labelsVLayout.padding = 20;
			labelsVLayout.gap = 32;
			labelsContainer.width = 220;
			labelsVLayout.horizontalAlign = HorizontalLayout.HORIZONTAL_ALIGN_RIGHT;
			labelsContainer.layout = labelsVLayout;
			this.addChild(labelsContainer);

			var controlsVLayout:VerticalLayout = new VerticalLayout();
			var controlsContainer:LayoutGroup = new LayoutGroup();
			controlsVLayout.padding = 15;
			controlsVLayout.horizontalAlign = HorizontalLayout.HORIZONTAL_ALIGN_LEFT;
			controlsVLayout.gap = 25;
			controlsContainer.width = 210;
			controlsContainer.x = 210;
			controlsContainer.layout = controlsVLayout;
			this.addChild(controlsContainer);


			addLabel("Music volume", labelsContainer);
			addLabel("SFX volume", labelsContainer);
			addLabel("Window mode", labelsContainer);

			musicSlider = new Slider();
			sfxSlider = new Slider();
			addSlider(musicSlider, controlsContainer, 39);
			addSlider(sfxSlider, controlsContainer);

			windowledCheckBox = new Check();
			windowledCheckBox.isSelected = true;
			controlsContainer.addChild(windowledCheckBox);
			windowledCheckBox.addEventListener( Event.CHANGE, checkBoxChanged );

			// back
			backBtn = new Button();
			backBtn.label = "Back";
			backBtn.width = 130;
			backBtn.height = 50;
			backBtn.layoutData = new AnchorLayoutData(NaN, NaN, 12, NaN, 0);
			backBtn.addEventListener(Event.TRIGGERED, buttonClicked);
			this.addChild(backBtn);

		}

		private function buttonClicked(event:Event):void   
		{   
			switch (event.currentTarget as Button)
			{
				case backBtn: 
					PopUpManager.removePopUp(this);
					break;
			}
		}

		private function checkBoxChanged(event:Event):void   
		{   
			if ((event.currentTarget as Check).isSelected)
			{	
				UIManager.instance.ce.stage.displayState = StageDisplayState.NORMAL; 
			} else
			{
				UIManager.instance.ce.stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE; 
			}
		}

		private function sliderChanged(event:Event):void   
		{   
			var slider:Slider = event.currentTarget as Slider;
			switch (slider)
			{
				case musicSlider: 
					trace("music slider: " + slider.value);
					break;
				case sfxSlider: 
					trace("sfx slider: " + slider.value);
					break;
			}
		}

		private function addLabel(text:String, container:LayoutGroup):void
		{
			var label:Label = new Label();
			label.text = text;
			container.addChild(label);
		}

		private function addSlider(slider:Slider, container:LayoutGroup, height:int = 28):void
		{
			slider.width = 180;
			slider.height = height;
			slider.x = 200;
			slider.minimum = 0;
			slider.maximum = 100;
			slider.value = 50;
			slider.trackLayoutMode = "directional";
			slider.addEventListener( Event.CHANGE, sliderChanged);
			container.addChild(slider);
		}
	}
}

