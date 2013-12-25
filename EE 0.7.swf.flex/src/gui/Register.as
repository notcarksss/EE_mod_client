package gui // gui_
{
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;

	[Embed(source="LoginState.swf", symbol = "Register")]
	public class Register extends flash.display.MovieClip
	{
		//public var login:flash.display.SimpleButton;
		public var passwordA:flash.text.TextField;
		public var passwordB:flash.text.TextField;
		public var email:flash.text.TextField;
		public var username:flash.text.TextField;
		public var start:flash.display.SimpleButton;
		
		public var editkey:flash.text.TextField;
		
		public var roomname:flash.text.TextField;
		
		public function Register(callback:Function)
		{
			super();
			
			this.email.embedFonts = true;
			this.email.defaultTextFormat = new flash.text.TextFormat(new system().fontName, 14);
			this.email.maxChars = 256;
			
			this.username.embedFonts = true;
			this.username.defaultTextFormat = new flash.text.TextFormat(new system().fontName, 14);
			this.username.maxChars = 256;
			this.username.restrict = "0-9a-z_";
			
			this.passwordA.embedFonts = true;
			this.passwordA.defaultTextFormat = new flash.text.TextFormat(new system().fontName, 14);
			this.passwordA.maxChars = 256;
			this.passwordA.displayAsPassword = true;
			
			this.passwordB.embedFonts = true;
			this.passwordB.defaultTextFormat = new flash.text.TextFormat(new system().fontName, 14);
			this.passwordB.maxChars = 256;
			this.passwordB.displayAsPassword = true;
			
			this.start.addEventListener(flash.events.MouseEvent.CLICK, function ():void
			{
				if (passwordA.text == passwordB.text)
				{
					callback(email.text, username.text, passwordA.text);
				}
			})
		}
	}
}
