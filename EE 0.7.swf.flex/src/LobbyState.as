package 
{
    import blitter.*;
    
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.net.*;
    
    import playerio.*;
    import gui.Login;
    
    public class LobbyState extends blitter.BlState
    {
		protected var world:Class;
		protected var levelstate:Class;
		protected var twitter:Class;
		protected var image:flash.display.BitmapData;
		protected var levels:Object;
		protected var callback:Function;
		protected var createCallback:Function;
		protected var subtext:blitter.BlText;
		protected var roomlist:RoomList;
		protected var roomlist2:RoomList;
		protected var bluecoins:BlueCoins;
		protected var createroom:CreateRoom;
		protected var login:Login;		//<	<	<
		protected var filter:WorldsFilter;
		protected var tw:flash.display.Sprite;
		protected var connection:Connection;
		
		public function LobbyState(arg1:Array, arg2:Function, arg3:Function, arg4:Boolean)
        {
            var rooms:Array;
            var callback:Function;
            var createCallback:Function;
            var iseecom:Boolean;
            var t:blitter.BlText;
            var t2:blitter.BlText;
            var t22:blitter.BlText;
            var ownlist:Array;
            var ownlist2:Array;
            var ra:int;
            var r:playerio.RoomInfo;

            var loc1:*;
            r = null;
            rooms = arg1;
            callback = arg2;
            createCallback = arg3;
            iseecom = arg4;
            this.world = LobbyState_world;
            this.levelstate = LobbyState_levelstate;
            this.twitter = LobbyState_twitter;
            this.image = new this.world().bitmapData;
            this.levels = {};
            this.subtext = new blitter.BlText(11, 300, 11184810);
            this.tw = new flash.display.Sprite();
            super();
            this.callback = callback;
            this.createCallback = createCallback;
            t = new blitter.BlText(30, 400, 14179354);
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
            this.subtext.x = 10;
            this.subtext.y = 42;
            add(this.subtext);
            ownlist = [];
            ownlist2 = [];
            ra = 0;
            while (ra < rooms.length) 
            {
                r = rooms[ra] as playerio.RoomInfo;
                if (r.data.needskey) 
                {
                    ownlist.push(r);
                }
                else 
                {
                    ownlist2.push(r);
                }
                ++ra;
            }
            this.roomlist = new RoomList(ownlist, 354, this.joinRoom);
            this.roomlist.x = 420 - 68 - 25;
            this.roomlist.y = 92;
            blitter.Bl.stage.addChild(this.roomlist);
            this.roomlist2 = new RoomList(ownlist2, 244, this.joinRoom);
            this.roomlist2.x = 15;
            this.roomlist2.y = 92;
            blitter.Bl.stage.addChild(this.roomlist2);
            this.createroom = new CreateRoom(this.createRoom);
            this.createroom.x = 15;
            this.createroom.y = 360;
            blitter.Bl.stage.addChild(this.createroom);
			
			/*this.login = new Login(this.createRoom);
			this.login.x = 15;
			this.login.y = 36;
			blitter.Bl.stage.addChild(this.login);*/
			
            this.refresh(rooms);
            this.filter = new WorldsFilter(this.applyFilter);
            this.filter.x = 420 - 68 - 15;
            this.filter.y = 10;
            blitter.Bl.stage.addChild(this.filter);
            this.tw.addChild(new this.twitter());
            this.tw.x = 285;
            this.tw.y = 55;
            this.tw.buttonMode = true;
            this.tw.addEventListener(flash.events.MouseEvent.CLICK, function (arg1:flash.events.Event):void
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
            this;
            return;
        }

        private function applyFilter(arg1:String):void
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
        }

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

        private function joinRoom(arg1:String, arg2:String="", arg3:Boolean=false):void
        {
            this.reset();
            this.callback(arg1);
            return;
        }

        private function createRoom(arg1:String, arg2:String="", arg3:Boolean=false):void
        {
            this.reset();
            this.createCallback(arg1, arg2);
            return;
        }
		
		/*private function login(arg1:String, arg2:string="", arg3:Boolean=false):void
		{
			
		}*/

        private function reset():void
        {
            if (this.bluecoins) 
            {
                blitter.Bl.stage.removeChild(this.bluecoins);
            }
            blitter.Bl.stage.removeChild(this.roomlist);
            blitter.Bl.stage.removeChild(this.roomlist2);
            blitter.Bl.stage.removeChild(this.createroom);
            blitter.Bl.stage.removeChild(this.filter);
            blitter.Bl.stage.removeChild(this.tw);
            return;
        }
    }
}
