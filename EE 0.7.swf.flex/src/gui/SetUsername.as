package gui // gui_
{
	import blitter.Bl;
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	import playerio.*;

	[Embed(source="LoginState.swf", symbol = "SetUsername")]
	public class SetUsername extends flash.display.MovieClip
	{
		//public var login:flash.display.SimpleButton;
		//protected var connection:Connection;
		public var setusername:flash.text.TextField;
		public var start:flash.display.SimpleButton;
		//public var errorCallback:Function;
		
		public function SetUsername(client:Client, callback:Function, error:Function)
		{
			//errorCallback = error;
			
			super();
			this.setusername.embedFonts = true;
			this.setusername.defaultTextFormat = new flash.text.TextFormat(new system().fontName, 14);
			this.setusername.maxChars = 24;
			this.setusername.restrict = "0-9A-Za-z";
			
			this.start.visible = false;
			
			client.multiplayer.createJoinRoom(client.connectUserId, "Lobby", false, {}, {},
				function(c:Connection) : void
				{
					//connection = c;
					c.addMessageHandler("username", function(m:Message, username:String) : void
					{
						c.disconnect();
						
						Bl.data.name = username;
						
						callback();
					});
					
					start.addEventListener(flash.events.MouseEvent.CLICK, function ():void
					{
						if (c)
							c.send("setusername", setusername.text);
						else
							error();
					})
					
					start.visible = true;
				},
				error);
			
		}
	}
}
