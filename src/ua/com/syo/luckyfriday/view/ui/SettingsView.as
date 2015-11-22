package ua.com.syo.luckyfriday.view.ui
{
	import flash.display.StageDisplayState;

	import citrus.sounds.CitrusSoundGroup;
	import citrus.sounds.SoundManager;

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

	import ua.com.syo.luckyfriday.controller.Controller;
	import ua.com.syo.luckyfriday.data.Constants;
	import ua.com.syo.luckyfriday.data.SaveData;

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
			//backgroundSkin = new Scale9Image( headerBackgroundTextures );
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
			addSlider(musicSlider, controlsContainer, SoundManager.getInstance().getGroup(CitrusSoundGroup.BGM).volume * 100, 39);
			addSlider(sfxSlider, controlsContainer, SoundManager.getInstance().getGroup(CitrusSoundGroup.SFX).volume * 100);

			windowledCheckBox = new Check();
			windowledCheckBox.isSelected = SaveData.instance.readData(Constants.WINDOWLED_SO) == null ? true : Boolean(SaveData.instance.readData(Constants.WINDOWLED_SO));
			controlsContainer.addChild(windowledCheckBox);
			windowledCheckBox.addEventListener( Event.CHANGE, checkBoxChanged );

			// back
			backBtn = new Button();
			backBtn.label = "Ok";
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
					//UIManager.instance.ce.playing = true;
					break;
			}
		}

		private function checkBoxChanged(event:Event):void   
		{   
			SaveData.instance.writeData(Constants.WINDOWLED_SO, (event.currentTarget as Check).isSelected);
			Controller.instance.ce.stage.displayState = !windowledCheckBox.isSelected ? StageDisplayState.FULL_SCREEN_INTERACTIVE : StageDisplayState.NORMAL;
		}

		private function sliderChanged(event:Event):void   
		{   
			var slider:Slider = event.currentTarget as Slider;
			switch (slider)
			{
				case musicSlider: 
					SoundManager.getInstance().setVolume(Constants.LOOP_MUSIC, musicSlider.value / 100);
					SaveData.instance.writeData(Constants.MUSIC_VOLUME_SO, Math.round(musicSlider.value));
					break;
				case sfxSlider: 
					SoundManager.getInstance().getGroup(CitrusSoundGroup.SFX).volume = sfxSlider.value / 100;
					SaveData.instance.writeData(Constants.SFX_VOLUME_SO, Math.round(sfxSlider.value));
					break;
			}
		}

		private function addLabel(text:String, container:LayoutGroup):void
		{
			var label:Label = new Label();
			label.text = text;
			container.addChild(label);
		}

		private function addSlider(slider:Slider, container:LayoutGroup, value:Number, height:int = 28):void
		{
			slider.width = 180;
			slider.height = height;
			slider.x = 200;
			slider.minimum = 0;
			slider.maximum = 100;
			slider.value = value;
			slider.trackLayoutMode = "directional";
			slider.addEventListener( Event.CHANGE, sliderChanged);
			container.addChild(slider);
		}
	}
}

