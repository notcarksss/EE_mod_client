package 
{
    import blitter.*;
    
    import flash.display.*;
    import flash.geom.*;
    import flash.media.*;
    import flash.text.*;
    
    import playerio.*;
    
    public class Player extends SynchronizedSprite
    {
        public function Player(arg1:Cave, name:String, arg2:Boolean=false, arg3:playerio.Connection=null)
        {
            this.Ding = Player_Ding;
            this.PlayerImage = Player_PlayerImage;
            this.Crown = Player_Crown;
            this.ding = new this.Ding();
            this.crown = new this.Crown().bitmapData;
            super(new this.PlayerImage().bitmapData);
            this.connection = arg3;
            this.cave = arg1;
            this.hitmap = arg1;
			
			this.name = new BlText(8, 256, 16777215, "center");
			this.name.text = name;
			//this.name.defaultTextFormat = new flash.text.TextFormat(new system().fontName, 14);
			//this.name.
			
            this.x = 16;
            this.y = 16;
            this.dragX = 0.998;
            this.dragY = 0.998;
            this.isme = arg2;
            return;
        }

        /*public override function tick():void
        {
            var loc2:*=0;
            var loc3:*=0;
            var loc4:*=0;
            var loc5:*=0;
            var loc1:*=0;
            while (loc1 < blitter.Bl.elapsed) 
            {
                update();
                if (this.isme) 
                {
                    loc2 = (x + 8) / 16;
                    loc3 = (y + 8) / 16;
                    loc4 = this.cave.getTile(loc2, loc3);
                    if (loc4 >= 100) 
                    {
                        if (loc4 != 100) 
                        {
                            if (loc4 == 101) 
                            {
                                this.ding.play();
                                this.cave.setTile(loc2, loc3, loc4 + 10);
                            }
                        }
                        else 
                        {
                            this.ding.play();
                            this.cave.setTile(loc2, loc3, loc4 + 10);
                            var loc6:*;
                            var loc7:*=((loc6 = this).coins + 1);
                            loc6.coins = loc7;
                        }
                    }
                }
                if (this.isme) 
                {
                    loc5 = this.cave.getTile(this.x + 8 >> 4, this.y + 8 >> 4);
                    if (this.past != loc5) 
                    {
                        loc6 = loc5;
						enterFrame();
                    }
                }
                ++loc1;
            }
            return;
        }*/
		
		override public function tick() : void
		{
			var _loc_2:int = 0;
			var _loc_3:int = 0;
			var _loc_4:int = 0;
			var _loc_5:int = 0;
			var _loc_1:int = 0;
			while (_loc_1 < Bl.elapsed)
			{
				
				update();
				if (this.isme)
				{
					_loc_2 = (x + 8) / 16;
					_loc_3 = (y + 8) / 16;
					_loc_4 = this.cave.getTile(_loc_2, _loc_3);
					if (_loc_4 >= 100)
					{
						if (_loc_4 == 100)
						{
							this.ding.play();
							this.cave.setTile(_loc_2, _loc_3, _loc_4 + 10);
							var _loc_6:Player = this;
							var _loc_7:* = this.coins + 1;
							_loc_6.coins = _loc_7;
						}
						else if (_loc_4 == 101)
						{
							this.ding.play();
							this.cave.setTile(_loc_2, _loc_3, _loc_4 + 10);
						}
					}
				}
				if (this.isme)
				{
					_loc_5 = this.cave.getTile(this.x + 8 >> 4, this.y + 8 >> 4);
					if (this.past != _loc_5)
					{
						switch(_loc_5)
						{
							case 5:
							{
								if (!this.hascrown)
								{
									this.connection.send("k");
								}
								break;
							}
							case 6:
							{
								this.connection.send("hide","r");
								break;
							}
							case 7:
							{
								this.connection.send("hide", "g");
								break;
							}
							case 8:
							{
								this.connection.send("hide", "b");
								break;
							}
							default:
							{
								break;
							}
						}
						this.past = _loc_5;
					}
				}
				_loc_1 = _loc_1 + 1;
			}
			
			name.x = this.x;
			name.y = this.y;
			return;
		}// end function

        /*public override function enterFrame():void
        {
            var loc1:*=this.cave.getTile(this.x + 8 >> 4, this.y + 8 >> 4);
            var loc2:*=1.75;
            var loc3:*=loc1;
        }*/
		
		override public function enterFrame() : void
		{
			var current:int = this.cave.getTile(this.x + 8 >> 4,this.y + 8 >> 4);
			var so:Number = 1.75;
			switch(current)
			{
				case 1:
					this.modifierX = -so;
					this.modifierY = 0;
					break;
				case 2:
					this.modifierX = 0;
					this.modifierY = -so;
					break;
				case 3:
					this.modifierX = so;
					this.modifierY = 0;
					break;
				case 4:
					this.modifierX = 0;
					this.modifierY = 0;
					break;
				default:
					this.modifierX = 0;
					this.modifierY = so;
			}
			
			this.mox = modifierX;
			this.moy = modifierY;
			this.modifierX = this.modifierX + mx;
			this.modifierY = this.modifierY + my;
		}

        public override function draw(arg1:flash.display.BitmapData, arg2:Number, arg3:Number):void
        {
            super.draw(arg1, arg2, arg3);
			name.x = 320;//this.x + arg2;
			name.y = 200;//this.y + arg3;
			name.draw(arg1, this.x + arg2-320-128+8, this.y + arg3-186);
            if (this.hascrown) 
            {
                arg1.copyPixels(this.crown, this.crown.rect, new flash.geom.Point(x + arg2, y + arg3 - 6));
            }
            return;
        }

		protected var name:BlText;
		
        protected var Ding:Class;

        protected var PlayerImage:Class;

        protected var Crown:Class;

        protected var ding:flash.media.Sound;

        private var cave:Cave;

        private var isme:Boolean;

        private var crown:flash.display.BitmapData;

        private var connection:playerio.Connection;

        public var coins:int=0;

        public var hascrown:Boolean=false;

        private var past:int=0;
    }
}
