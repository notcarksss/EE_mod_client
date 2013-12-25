package 
{
    import blitter.*;
    
    import chat.SideChat;
    
    import flash.display.*;
    import flash.geom.Rectangle;
    
    import mx.states.AddChild;
    
    import playerio.*;
    
    public class PlayState extends blitter.BlState
    {
		protected var player:Player;
		protected var cave:Cave;
		protected var connection:playerio.Connection;
		protected var players:Object;
		protected var map:MiniMap;
		protected var totalCoins:int=0;
		protected var cointext:blitter.BlText;
		protected var cointextcontainer:blitter.BlContainer;
		private var queue:Array;
		
        public function PlayState(arg1:playerio.Connection, arg2:Array, arg3:int, name:String)
        {
            var c:playerio.Connection;
            var level:Array;
            var myid:int;
            var a:int;
            var tcoin:blitter.BlSprite;
            var row:Array;
            var b:int;
            var t:int;
			
			
			////////////////////////////////////
			//var roomid:String;
			//var direct:Boolean=false;
			//var isLockedRoom:Boolean=false;
			//var self:EverybodyEditsBeta;
			
			//var loc1:*;
			//self = null;
			//connection = arg1;
			//roomid = arg2;
			//direct = arg3;
			//isLockedRoom = arg4;
			
			////////////////////////

			//this.disconnectRPC();
			//this.deltas = [];
			//this.inited = false;
			//self = this;
			//this.connection = connection;
			//SWFStats.Log.Play();
			//////////////////////////////

            var loc1:*;
            row = null;
            b = 0;
            t = 0;
            c = arg1;
            level = arg2;
            myid = arg3;
            this.TCoin = PlayState_TCoin;
            this.players = {};
            this.cointextcontainer = new blitter.BlContainer();
            this.queue = [];
            super();
            a = 0;
            while (a < level.length) 
            {
                row = level[a];
                b = 0;
                while (b < row.length) 
                {
                    t = row[b];
                    if (t == 100) 
                    {
                        var loc2:*;
                        var loc3:*=((loc2 = this).totalCoins + 1);
                        loc2.totalCoins = loc3;
                    }
                    ++b;
                }
                ++a;
            }
            this.connection = c;
			
			//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

			
            this.cave = new Cave();
            this.cave.setMapArray(level);
            add(this.cave);
            this.player = new Player(this.cave, name, true, c);
            add(this.player);
            target = this.player;
            cameraLag = 200;
            this.player.hitmap = this.cave;
            this.map = new MiniMap(level, c);
            add(this.map);
            this.cointext = new blitter.BlText(12, 100, 16777215, "right");
            this.cointext.x = 526;
            this.cointextcontainer.add(this.cointext);
            tcoin = new blitter.BlSprite(new this.TCoin().bitmapData);
            tcoin.x = 626;
            tcoin.y = 4;
            this.cointextcontainer.add(tcoin);
            this.connection.addMessageHandler("u", function (arg1:playerio.Message, arg2:int, arg3:Number, arg4:Number, arg5:Number, arg6:Number, arg7:Number, arg8:Number, arg9:Number, arg10:Number):void
            {
                var loc1:*=null;
                if (arg2 != myid) 
                {
                    loc1 = players[arg2] as Player;
                    if (!loc1) 
                    {
                        loc1 = new Player(cave, "[error]");
                        players[arg2] = loc1;
                        addBefore(loc1, player);
                    }
                    loc1.x = arg3;
                    loc1.y = arg4;
                    loc1.speedX = arg5;
                    loc1.speedY = arg6;
                    loc1.modifierX = arg7;
                    loc1.modifierY = arg8;
                    loc1.mx = arg9;
                    loc1.my = arg10;
                }
                return;
            })
            this.connection.addMessageHandler("add", function (arg1:playerio.Message, id:int, name:String , face:int, x:Number, y:Number):void
            {
                var loc1:*=players[id] as Player;
                if (!loc1) 
                {
                    loc1 = new Player(cave, name);
                    players[id] = loc1;
                    loc1.x = Math.min(x, 198 * 16);
                    loc1.y = Math.min(y, 198 * 16);
                    loc1.frame = face;
                    addBefore(loc1, player);
                }
                return;
            })
            this.connection.addMessageHandler("k", function (arg1:playerio.Message, arg2:int):void
            {
                var loc1:*=null;
                var loc2:*=null;
                player.hascrown = arg2 == myid;
                var loc3:*=0;
                var loc4:*=players;
                for (loc1 in loc4) 
                {
                    loc2 = players[loc1] as Player;
                    loc2.hascrown = parseInt(loc1) == arg2;
                }
                return;
            })
            this.connection.addMessageHandler("c", function (arg1:playerio.Message, arg2:int, arg3:int, arg4:int):void
            {
                setTile(arg2, arg3, arg4);
                return;
            })
            this.connection.addMessageHandler("left", function (arg1:playerio.Message, arg2:int):void
            {
                var loc1:*=players[arg2];
                if (loc1 != null) 
                {
                    delete players[arg2];
                    remove(loc1);
                }
                return;
            })
            this.connection.addMessageHandler("face", function (arg1:playerio.Message, arg2:int, arg3:int):void
            {
                var loc1:*=null;
                if (arg2 != myid) 
                {
                    loc1 = players[arg2] as Player;
                    if (loc1) 
                    {
                        loc1.frame = arg3;
                    }
                }
                else 
                {
                    player.frame = arg3;
					cave.currentFace = arg3;
                }
                return;
            })
            this.connection.addMessageHandler("hide", function (arg1:playerio.Message, arg2:String):void
            {
                switch(arg2)
				{
					case "r":
						cave.hideRed = true;
						hideRed();
						break;
					case "g":
						cave.hideGreen = true;
						hideGreen();
						break;
					case "b":
						cave.hideBlue = true;
						hideBlue();
						break;
				}
            })
            this.connection.addMessageHandler("show", function (arg1:playerio.Message, arg2:String):void
            {
				switch(arg2)
				{
				case "r":
					cave.hideRed = false;
					break;
				case "g":
					cave.hideGreen = false;
					break;
				case "b":
					cave.hideBlue = false;
					break;
				}
            })
            this.connection.send("init2");
            return;
        }

        private function hideRed():void
        {
            this.cave.hideRed = false;
            if (this.cave.overlaps(this.player)) 
            {
                this.cave.hideRed = true;
                this.queue.push(this.hideRed);
            }
            return;
        }

        private function hideGreen():void
        {
            this.cave.hideGreen = false;
            if (this.cave.overlaps(this.player)) 
            {
                this.cave.hideGreen = true;
                this.queue.push(this.hideGreen);
            }
            return;
        }

        private function hideBlue():void
        {
            this.cave.hideBlue = false;
            if (this.cave.overlaps(this.player)) 
            {
                this.cave.hideBlue = true;
                this.queue.push(this.hideBlue);
            }
            return;
        }

        public function setTile(arg1:int, arg2:int, arg3:int):void
        {
            var xo:int;
            var yo:int;
            var value:int;
            var old:int;

            var loc1:*;
            xo = arg1;
            yo = arg2;
            value = arg3;
            old = this.cave.getTile(xo, yo);
            if (old == value) 
            {
                return;
            }
            this.cave.setTile(xo, yo, value);
            if (this.cave.overlaps(this.player)) 
            {
                this.cave.setTile(xo, yo, old);
                this.queue.push(function ():void
                {
                    setTile(xo, yo, value);
                    return;
                })
            }
            else if (value != 100) 
            {
                if (old == 100 && !(value == 110) || old == 110) 
                {
                    loc3 = ((loc2 = this).totalCoins - 1);
                    loc2.totalCoins = loc3;
                    if (old == 110) 
                    {
                        loc3 = ((loc2 = this.player).coins - 1);
                        loc2.coins = loc3;
                    }
                }
            }
            else if (old != 110) 
            {
                loc3 = ((loc2 = this).totalCoins + 1);
                loc2.totalCoins = loc3;
            }
            else 
            {
                var loc2:*;
                var loc3:*=((loc2 = this.player).coins - 1);
                loc2.coins = loc3;
            }
            return;
        }

        public override function enterFrame():void
        {
            var loc6:*=null;
            var loc7:*=0;
            var loc8:*=0;
            this.cointext.text = this.player.coins + "/" + this.totalCoins;
            var loc1:*=this.queue.length;
            while (loc1--) 
            {
                this.queue.shift()();
            }
            var loc2:*=1;
            var loc3:*=0;
            var loc4:*=0;
            var loc5:*=false;
            if (this.player.moy) 
            {
                if (blitter.Bl.isKeyJustPressed(32) && this.player.speedY == 0) 
                {
                    this.player.speedY = this.player.speedY - this.player.modifierY * 280;
                    loc5 = true;
                }
                if (blitter.Bl.isKeyDown(37) || blitter.Bl.isKeyDown(65)) 
                {
                    loc3 = -loc2;
                }
                else if (blitter.Bl.isKeyDown(39) || blitter.Bl.isKeyDown(68)) 
                {
                    loc3 = loc2;
                }
            }
            else if (this.player.mox) 
            {
                if (blitter.Bl.isKeyJustPressed(32) && this.player.speedX == 0) 
                {
                    this.player.speedX = this.player.speedX - this.player.modifierX * 280;
                    loc5 = true;
                }
                if (blitter.Bl.isKeyDown(38) || blitter.Bl.isKeyDown(87)) 
                {
                    loc4 = -loc2;
                }
                else if (blitter.Bl.isKeyDown(40) || blitter.Bl.isKeyDown(83)) 
                {
                    loc4 = loc2;
                }
            }
            else 
            {
                if (blitter.Bl.isKeyDown(37) || blitter.Bl.isKeyDown(65)) 
                {
                    loc3 = -loc2;
                }
                else if (blitter.Bl.isKeyDown(39) || blitter.Bl.isKeyDown(68)) 
                {
                    loc3 = loc2;
                }
                if (blitter.Bl.isKeyDown(38) || blitter.Bl.isKeyDown(87)) 
                {
                    loc4 = -loc2;
                }
                else if (blitter.Bl.isKeyDown(40) || blitter.Bl.isKeyDown(83)) 
                {
                    loc4 = loc2;
                }
            }
            if (!(this.player.mx == loc3) || !(this.player.my == loc4) || loc5) 
            {
                this.player.mx = loc3;
                this.player.my = loc4;
                if (this.connection.connected) 
                {
                    this.connection.send("u", this.player.x, this.player.y, this.player.speedX, this.player.speedY, this.player.modifierX, this.player.modifierY, this.player.mx, this.player.my);
                }
            }
            if (blitter.Bl.isMouseJustPressed || blitter.Bl.data.isLockedRoom && blitter.Bl.isMouseDown) 
            {
                if (!(blitter.Bl.mouseX > 640 || blitter.Bl.mouseX < 0 || blitter.Bl.mouseY > 470 || blitter.Bl.mouseY < 0)) 
                {
                    loc7 = (blitter.Bl.mouseX - this.x) / 16 >> 0;
                    loc8 = (blitter.Bl.mouseY - this.y) / 16 >> 0;
                    if (this.Brick == 100 && this.cave.getTile(loc7, loc8) == 110) 
                    {
                        this.setTile(loc7, loc8, 100);
                    }
                    if (this.connection.connected && !(this.cave.getTile(loc7, loc8) == this.Brick)) 
                    {
                        this.connection.send("c", loc7, loc8, this.Brick);
                    }
                }
            }
            remove(this.map);
            if (blitter.Bl.data.showMap) 
            {
                add(this.map);
            }
            else 
            {
                this.map.clear();
            }
            var loc9:*=0;
            var loc10:*=this.players;
            for each (loc6 in loc10) 
            {
                this.map.showPlayer(loc6, 4294967295);
            }
            this.map.showPlayer(this.player, 4278255360);
            super.enterFrame();
            return;
        }

        public override function draw(arg1:flash.display.BitmapData, arg2:Number, arg3:Number):void
        {
            super.draw(arg1, arg2, arg3);
			//this.sidechat.x = 320;
			//arg1.draw(this.sidechat);
            if (this.totalCoins > 0) 
            {
                this.cointextcontainer.draw(arg1, 0, 0);
            }
            return;
        }

		protected function get Brick():int
		{
			if (Bl.data.selectedBrick < 31)
				return Bl.data.selectedBrick;
			else if (Bl.data.selectedBrick == 31)
				return 31 + cave.currentFace;
			else if (Bl.data.selectedBrick == 32)
				return 39 + cave.currentFace;
			else if (Bl.data.selectedBrick < 100)
				return Bl.data.selectedBrick + 16;
			else
				return Bl.data.selectedBrick;
		}
		
        protected var TCoin:Class;


		

		
    }
}
