package 
{
    import blitter.*;
    
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.net.*;
    
    import gui.*;
    
    import playerio.*;
    
    public class LoginState extends blitter.BlState
    {
		protected var world:Class;
		protected var image:flash.display.BitmapData;
		protected var callback:Function;
		protected var setusername:SetUsername;
		//protected var loginCallback:Function;
		protected var login:Login;		//<	<
		protected var register:Register;
		
        public function LoginState(arg2:Function/*, arg3:Function, arg4:Boolean*/)
        {
            var callback:Function;
            var loginCallback:Function;
           /* var iseecom:Boolean;
            var t:blitter.BlText;
            var t2:blitter.BlText;
            var t22:blitter.BlText;
            var ownlist:Array;
            var ownlist2:Array;
            var ra:int;
            var r:playerio.RoomInfo;*/

            //var loc1:*;
            //r = null;
            callback = arg2;
            //loginCallback = arg3;
            //iseecom = arg4;

			this.world = LobbyState_world;
			this.image = new this.world().bitmapData;
			
            super();
            this.callback = callback;
			
			this.image = new this.world().bitmapData;
            //this.loginCallback = loginCallback;
            /*t = new blitter.BlText(30, 400, 14179354);
            t.text = "Everybody Edits";
            t.x = 10;
            t.y = 5;
            add(t);
            t2 = new blitter.BlText(14, 400);
            t2.text = "Locked worlds";
            t2.x = 420 - 69 - 20 - 5;
            t2.y = 68;
            add(t2);
            t22 = new blitter.BlText(15, 400);
            t22.text = "Open worlds";
            t22.x = 19 - 5;
            t22.y = 68;
            add(t22);
            ownlist = [];
            ownlist2 = [];
            ra = 0;*/

         
			LoadLogin();

			
            /*this.refresh(rooms);
            {
                var e:flash.events.Event;
                var url:String;
                var request:flash.net.URLRequest;

                var loc1:*;
                e = arg1;
                url = "http://twitter.com/everybodyedits";
                request = new flash.net.URLRequest(url);
                try 
                {
                    flash.net.navigateToURL(request, "_new");
                }
                catch (e:Error)
                {
                    trace("Error occurred!");
                }
                return;
            })
            blitter.Bl.stage.addChild(this.tw);
            if (!iseecom) 
            {
            };
            this;*/
            return;
        }
		
		public function LoadLogin()
		{
			this.login = new Login(this.loginCallback);
			this.login.x = 20;
			this.login.y = 290;
			blitter.Bl.stage.addChild(this.login);
			
			this.register = new Register(this.registerCallback);
			this.register.x = 326;
			this.register.y = 290;
			blitter.Bl.stage.addChild(this.register);
		}

        /*private function applyFilter(arg1:String):void
        {
            this.roomlist.render(arg1);
            this.roomlist2.render(arg1);
            return;
        }

        public function refresh(arg1:Array):void
        {
            var loc2:*=null;
            var loc1:*=0;
            var loc3:*=0;
            var loc4:*=arg1;
            for each (loc2 in loc4) 
            {
                loc1 = loc1 + loc2.onlineUsers;
            }
            this.subtext.text = loc1 + " Online - Click a world to join it!";
            return;
        }*/

        public override function enterFrame():void
        {
            return;
        }

        public override function draw(arg1:flash.display.BitmapData, arg2:Number, arg3:Number):void
        {
            arg1.copyPixels(this.image, this.image.rect, new flash.geom.Point(0, 0));
            super.draw(arg1, arg2, arg3);
            return;
        }
		
		
		private function loginCallback(email:String, password:String)
		{
			
			//Login for a user with QuickConnect for Simple Users
			PlayerIO.quickConnect.simpleConnect(
				blitter.Bl.stage, 
				'eeo-ruiegvlaw0sdzzak1msc3a', 
				email, 
				password,
				onLogin,
				function(e:PlayerIOError):void
				{
					trace("Error: ", e)
				});
		}
		
		private function registerCallback(email:String, username:String, password:String)
		{
			
			//Login for a user with QuickConnect for Simple Users
			PlayerIO.quickConnect.simpleRegister(//simpleConnect(
				blitter.Bl.stage,
				'eeo-ruiegvlaw0sdzzak1msc3a',
				username,
				password,
				email,
				"",
				"",
				null,
				"",
				onLogin,
				function(e:PlayerIOError):void
				{
					trace("Error: ", e)
					//trace("Error: ", e.)
				});

		}
		
		private function onLogin(client:Client)
		{
			reset();
			callback(client);
			
			/*reset();
			
			client.bigDB.loadMyPlayerObject(function (arg1:playerio.DatabaseObject):void
			{
				Bl.data.name = arg1.name || "";
				
				var name:*=Bl.data.name;
				
				if (Bl.data.name == "")
				{
					reset();
					setusername = new SetUsername(client,
						function() : void 
						{
							reset();
							callback(client);
						},
						function() : void
						{
							reset();
							LoadLogin();
						});
					
					setusername.x = 153;
					setusername.y = 275;
					blitter.Bl.stage.addChild(setusername);
				}
				else
				{
					callback(client);
				};
			});*/
		}
		
		
        /*private function joinRoom(arg1:String, arg2:String="", arg3:Boolean=false):void
        {
            this.reset();
            this.callback(arg1);
            return;
        }

        private function createRoom(arg1:String, arg2:String="", arg3:Boolean=false):void
        {
            this.reset();
            this.loginCallback(arg1, arg2);
            return;
        }*/
		
		/*private function login(arg1:String, arg2:string="", arg3:Boolean=false):void
		{
			
		}*/

        private function reset():void
        {
			if (this.setusername)
			{
				blitter.Bl.stage.removeChild(this.setusername);
				this.setusername = null;
			}
				
			if (this.login)
			{
            	blitter.Bl.stage.removeChild(this.login);
				this.login = null;
			}
			
			if (this.register)
			{
				blitter.Bl.stage.removeChild(this.register);
				this.register = null;
			}
			
            return;
        }
    }
}
