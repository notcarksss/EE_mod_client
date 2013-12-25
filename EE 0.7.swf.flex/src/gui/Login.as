package gui // gui_
{
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.text.*;

	[Embed(source="LoginState.swf", symbol = "Login")]
	public class Login extends flash.display.MovieClip
	{
		//public var login:flash.display.SimpleButton;
		public var password:flash.text.TextField;
		public var email:flash.text.TextField;
		public var start:flash.display.SimpleButton;
		public var loginasguest:flash.display.SimpleButton;
		public var rememberme:flash.display.MovieClip;
		
		//public var editkey:flash.text.TextField;
		
		//public var roomname:flash.text.TextField;
		
		protected var fbsave:flash.net.SharedObject;
		
		public function Login(callback:Function)
		{
			super();
			this.email.embedFonts = true;
			this.email.defaultTextFormat = new flash.text.TextFormat(new system().fontName, 14);
			this.email.maxChars = 256;
			
			this.password.embedFonts = true;
			this.password.defaultTextFormat = new flash.text.TextFormat(new system().fontName, 14);
			this.password.maxChars = 256;
			this.password.displayAsPassword = true;
			
			this.fbsave = flash.net.SharedObject.getLocal("logindata");
			
			if (fbsave.data.remember)
			{
				this.email.text = fbsave.data.email;
				this.password.text = "\tsecret\t"
				this.rememberme.gotoAndStop(2);
			}
			else
			{
				this.rememberme.gotoAndStop(1);
			}
			
			this.start.addEventListener(flash.events.MouseEvent.CLICK, function ():void
			{
				//if (email.text.replace(new RegExp(" ", "gi"), "") != "") 
				//{
				var temp_password:String;
				
				if (password.text == "\tsecret\t")
					temp_password = fbsave.data.password;
				else
					temp_password = password.text;
				
				if (rememberme.currentFrame == 2) //true
				{
					fbsave.data.remember = true;
					fbsave.data.email = email.text;
					fbsave.data.password = temp_password;
				}
				else
				{
					fbsave.data.remember = false;
					fbsave.data.email = "";
					fbsave.data.password = "";
				}
				
					callback(email.text, temp_password);
				//}
				//return;
			})
				
			this.loginasguest.addEventListener(flash.events.MouseEvent.CLICK, function ():void
			{
				callback("guest", "guest");
				return;
			})
				
			this.rememberme.addEventListener(flash.events.MouseEvent.CLICK,
				function ():void
				{
					if (rememberme.currentFrame == 1)
						rememberme.gotoAndStop(2);
					else
						rememberme.gotoAndStop(1);
				});
		}
	}
}
