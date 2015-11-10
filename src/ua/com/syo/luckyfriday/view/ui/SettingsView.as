package ua.com.syo.luckyfriday.view.ui
{
	import feathers.controls.Button;
	import feathers.controls.Check;
	import feathers.controls.Label;
	import feathers.controls.LayoutGroup;
	import feathers.controls.Panel;
	import feathers.controls.PickerList;
	import feathers.controls.Slider;
	import feathers.core.PopUpManager;
	import feathers.data.ListCollection;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.VerticalLayout;

	import starling.events.Event;

	public class SettingsView extends Panel
	{
		private var backBtn:Button;
		private var okBtn:Button;

		private var panelWidth:int = 500;
		private var panelHeight:int = 470;

		private var slider1:Slider, slider2:Slider;

		public function SettingsView()
		{
			width = panelWidth;
			height = panelHeight;
			title = "Settings";

			this.layout = new AnchorLayout();

			var labelsVLayout:VerticalLayout = new VerticalLayout();
			var labelsContainer:LayoutGroup = new LayoutGroup();
			labelsVLayout.padding = 20;
			labelsVLayout.gap = 28;
			labelsContainer.width = 240;
			labelsVLayout.horizontalAlign = HorizontalLayout.HORIZONTAL_ALIGN_RIGHT;
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


			addLabel("Music volume:", labelsContainer);
			addLabel("SFX volume:", labelsContainer);
			addLabel("Resolution:", labelsContainer);
			addLabel("Window mode:", labelsContainer);
			addLabel("Controls:", labelsContainer);

			addSlider(controlsContainer, 40);
			addSlider(controlsContainer);
			addPickerList(controlsContainer);
			addCheckBox(controlsContainer);

			var button:Button = new Button();
			button.label = "→";
			button.width = 70;
			button.height = 42;
			controlsContainer.addChild(button);


			// back
			backBtn = new Button();
			backBtn.label = "Back";
			backBtn.width = 150;
			backBtn.height = 50;
			backBtn.layoutData = new AnchorLayoutData(NaN, NaN, 12, 10);
			backBtn.addEventListener(Event.TRIGGERED, buttonClicked);
			this.addChild(backBtn);

			// ok
			okBtn = new Button();
			okBtn.label = "Ok";
			okBtn.width = 150;
			okBtn.height = 50;
			okBtn.layoutData = new AnchorLayoutData(NaN, 12, 12);
			okBtn.addEventListener(Event.TRIGGERED, buttonClicked);
			this.addChild(okBtn);

		}

		private function buttonClicked(event:Event):void   
		{   
			switch (event.currentTarget as Button)
			{
				case backBtn: 
					PopUpManager.removePopUp(this);
					break;
				case okBtn: 
					PopUpManager.removePopUp(this);
					break;
			}

		}

		private function addLabel(text:String, container:LayoutGroup):void
		{
			var label:Label = new Label();
			label.text = text;
			container.addChild(label);
		}

		private function addSlider(container:LayoutGroup, height:int = 28):void
		{
			var slider:Slider = new Slider();
			slider.width = 200;
			slider.height = height;
			slider.x = 200;
			slider.minimum = 0;
			slider.maximum = 100;
			slider.value = 50;
			slider.trackLayoutMode = "directional";
			container.addChild(slider);
		}

		private function addCheckBox(container:LayoutGroup):void
		{
			var checkBox:Check = new Check();
			checkBox.height = 28;
			checkBox.width = 36;
			checkBox.isSelected = true;
			container.addChild(checkBox);
		}

		private function addPickerList(container:LayoutGroup):void
		{
			var pList:PickerList = new PickerList();
			pList.dataProvider = new ListCollection(
				[
				{ text: "1024 x 768"},
				{ text: "1280 x 720"},
				{ text: "1680 x 900"},
				{ text: "1920 x 1080"}
				]);
			pList.listProperties.@itemRendererProperties.labelField = "text";
			pList.labelField = "text";
			container.addChild(pList);
		}
	}
}

