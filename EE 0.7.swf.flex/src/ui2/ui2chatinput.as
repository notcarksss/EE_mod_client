package ui2 
{
	import flash.display.*;
	
	[Embed(source="ui2chatinput.swf", symbol = "ui2.ui2chatinput")]
	public dynamic class ui2chatinput extends flash.display.MovieClip
	{
		public function ui2chatinput()
		{
			super();
			return;
		}
		
		public var say:flash.display.SimpleButton;
	}
}