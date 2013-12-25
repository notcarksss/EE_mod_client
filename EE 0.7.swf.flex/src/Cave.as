package 
{
    import blitter.*;
    
    import flash.display.*;
    import flash.geom.*;
    
    public class Cave extends blitter.BlTilemap
    {
		protected var Rocks:Class;
		
		protected var Coin:Class;
		
		protected var BonusCoin:Class;
		
		protected var CoinShadow:Class;
		
		protected var BonusCoinShadow:Class;
		
		protected var InvisibleBricks:Class;
		
		protected var SmileyDoor:Class;
		
		protected var SmileyGate:Class;
		
		private var coin:blitter.BlSprite;
		
		private var bonuscoin:blitter.BlSprite;
		
		private var coinshadow:blitter.BlSprite;
		
		private var bonuscoinshadow:blitter.BlSprite;
		
		private var invisiblebricks:blitter.BlSprite;
		
		private var smileydoor:blitter.BlSprite;
		
		private var smileygate:blitter.BlSprite;
		
		private var offset:Number=0;
		
		public var hideRed:Boolean=false;
		
		public var hideGreen:Boolean=false;
		
		public var hideBlue:Boolean=false;
		
		public var currentFace = 0;
		
		
        public function Cave()
        {
            this.Rocks = Cave_Rocks;
            this.Coin = Cave_Coin;
            this.BonusCoin = Cave_BonusCoin;
            this.CoinShadow = Cave_CoinShadow;
            this.BonusCoinShadow = Cave_BonusCoinShadow;
            this.InvisibleBricks = Cave_InvisibleBricks;
			this.SmileyDoor = Cave_SmileyDoor;
			this.SmileyGate = Cave_SmileyGate;
            this.coin = new blitter.BlSprite(new this.Coin().bitmapData);
            this.bonuscoin = new blitter.BlSprite(new this.BonusCoin().bitmapData);
            this.coinshadow = new blitter.BlSprite(new this.CoinShadow().bitmapData);
            this.bonuscoinshadow = new blitter.BlSprite(new this.BonusCoinShadow().bitmapData);
            this.invisiblebricks = new blitter.BlSprite(new this.InvisibleBricks().bitmapData);
			this.smileydoor = new blitter.BlSprite(new this.SmileyDoor().bitmapData);
			this.smileygate = new blitter.BlSprite(new this.SmileyGate().bitmapData);
            super(new this.Rocks(), 9);
            return;
        }

        public override function update():void
        {
            this.offset = this.offset + 0.03;
            super.update();
            return;
        }

        /*public override function draw(arg1:flash.display.BitmapData, arg2:Number, arg3:Number):void
        {
			if (map == null) //:D
				return;
			
            var loc8:*=null;
            var loc9:*=0;
            var loc10:*=0;
            var loc1:*=arg2 >> 0;
            var loc2:*=arg3 >> 0;
            var loc3:int =(-arg3) / size;
            var loc4:int =(-arg2) / size;
            var loc5:*=loc3 + blitter.Bl.height / size + 1;
            var loc6:*=loc4 + blitter.Bl.width / size + 1;
            if (loc3 < 0) 
            {
                loc3 = 0;
            }
            if (loc4 < 0) 
            {
                loc4 = 0;
            }
            if (loc5 > height) 
            {
                loc5 = height;
            }
            if (loc6 > width) 
            {
                loc6 = width;
            }
            var loc7:*=loc3;
            while (loc7 < loc5) 
            {
                loc8 = map[loc7] as Array;
				
				if (loc8 == null) //:D
					return;
				
                loc9 = loc4;
                while (loc9 < loc6) 
                {
                    loc10 = loc8[loc9];
                    if (loc10 < 100) 
                    {
                        if (loc10 == 23 && this.hideRed) 
                        {
                            this.invisiblebricks.frame = 0;
                            this.invisiblebricks.draw(arg1, loc9 * size + loc1, loc7 * size + loc2);
                        }
                        else if (loc10 == 24 && this.hideGreen) 
                        {
                            this.invisiblebricks.frame = 1;
                            this.invisiblebricks.draw(arg1, loc9 * size + loc1, loc7 * size + loc2);
                        }
                        else if (loc10 == 25 && this.hideBlue) 
                        {
                            this.invisiblebricks.frame = 2;
                            this.invisiblebricks.draw(arg1, loc9 * size + loc1, loc7 * size + loc2);
                        }
                        else 
                        {
                            rect.x = loc10 * size;
                            arg1.copyPixels(bmd, rect, new flash.geom.Point(loc9 * size + loc1, loc7 * size + loc2));
                        }
                    }
                    else 
                    {
                        rect.x = 0;
                        arg1.copyPixels(bmd, rect, new flash.geom.Point(loc9 * size + loc1, loc7 * size + loc2));
                        var loc11:*=loc10;
                    }
                    ++loc9;
                }
                ++loc7;
            }
            return;
        }*/
		
		override public function draw(target:BitmapData, ox:Number, oy:Number) : void
		{
			var _loc_11:Array = null;
			var _loc_12:int = 0;
			var _loc_13:int = 0;
			var _loc_4:int = ox >> 0;
			var _loc_5:int = oy >> 0;
			var _loc_6:int = (-oy) / size;
			var _loc_7:int = (-ox) / size;
			var _loc_8:int = _loc_6 + Bl.height / size + 1;
			var _loc_9:int = _loc_7 + Bl.width / size + 1;
			if (_loc_6 < 0)
			{
				_loc_6 = 0;
			}
			if (_loc_7 < 0)
			{
				_loc_7 = 0;
			}
			if (_loc_8 > height)
			{
				_loc_8 = height;
			}
			if (_loc_9 > width)
			{
				_loc_9 = width;
			}
			var _loc_10:* = _loc_6;
			while (_loc_10 < _loc_8)
			{
				
				_loc_11 = map[_loc_10] as Array;
				_loc_12 = _loc_7;
				while (_loc_12 < _loc_9)
				{
					
					_loc_13 = _loc_11[_loc_12];
					if (_loc_13 < 100)
					{
						if (_loc_13 >= 31 && _loc_13 < 39)
						{
							this.smileydoor.frame = _loc_13-31 + ((_loc_13-31 == currentFace)? 8:0);
							this.smileydoor.draw(target, _loc_12 * size + _loc_4, _loc_10 * size + _loc_5);	
						}
						else if (_loc_13 >= 39 && _loc_13 < 47)
						{
							this.smileygate.frame = _loc_13-39 + ((_loc_13-39 == currentFace)? 8:0);
							this.smileygate.draw(target, _loc_12 * size + _loc_4, _loc_10 * size + _loc_5);	
						}
						else
						{
							if (_loc_13 == 23)
							{
							}
							if (this.hideRed)
							{
								this.invisiblebricks.frame = 0;
								this.invisiblebricks.draw(target, _loc_12 * size + _loc_4, _loc_10 * size + _loc_5);
							}
							if (_loc_13 == 24)
							{
							}
							if (this.hideGreen)
							{
								this.invisiblebricks.frame = 1;
								this.invisiblebricks.draw(target, _loc_12 * size + _loc_4, _loc_10 * size + _loc_5);
							}
							if (_loc_13 == 25)
							{
							}
							if (this.hideBlue)
							{
								this.invisiblebricks.frame = 2;
								this.invisiblebricks.draw(target, _loc_12 * size + _loc_4, _loc_10 * size + _loc_5);
							}
							rect.x = _loc_13 * size;
							target.copyPixels(bmd, rect, new Point(_loc_12 * size + _loc_4, _loc_10 * size + _loc_5));
						}
					}
					else
					{
						rect.x = 0;
						target.copyPixels(bmd, rect, new Point(_loc_12 * size + _loc_4, _loc_10 * size + _loc_5));
						switch(_loc_13)
						{
							case 100:
							{
								this.coin.frame = ((this.offset >> 0) + _loc_12 + _loc_10) % 12;
								this.coin.draw(target, _loc_12 * size + _loc_4 + 3, _loc_10 * size + _loc_5 + 3);
								break;
							}
							default:
							{
								break;
							}
						}
						if (Bl.data.canEdit)
						{
							switch(_loc_13)
							{
								case 110:
								{
									this.coinshadow.frame = ((this.offset >> 0) + _loc_12 + _loc_10) % 12;
									this.coinshadow.draw(target, _loc_12 * size + _loc_4 + 3, _loc_10 * size + _loc_5 + 3);
									break;
								}
								default:
								{
									break;
								}
							}
						}
					}
					_loc_12 = _loc_12 + 1;
				}
				_loc_10 = _loc_10 + 1;
			}
			return;
		}// end function

        public override function overlaps(arg1:blitter.BlObject):Boolean
        {
            /*var loc4:*=0;//bx iterator
            var loc5:*=0;//blockId
            var loc1:*=arg1.x / size;//bx constant
            var loc2:*=arg1.y / size;//by constant
            var loc3:*=loc2;//by iterator
            while (loc3 < loc2 + (arg1.width - 1) / size) 
            {
                loc4 = loc1;//bx iterator
                while (loc4 < loc1 + (arg1.height - 1) / size) 
                {
                    if (map[loc3 >> 0] != null) 
                    {
                        loc5 = map[loc3 >> 0][loc4 >> 0];
                        if (loc5 >= hitOffset && loc5 <= hitEnd) 
                        {
                            if (!(this.hideRed && loc5 == 23)) 
                            {
                                if (!(this.hideGreen && loc5 == 24)) 
                                {
                                    if (!(this.hideBlue && loc5 == 25)) 
                                    {
                                        return true;
                                    }
                                }
                            }
                        }
                    }
                    ++loc4;
                }
                ++loc3;
            }*/
			var bxc:int = Math.ceil(arg1.x/16.0-0.0625);
			var byc:int = Math.ceil(arg1.y/16.0-0.0625);
			var bx:int = Math.floor(arg1.x/16.0);
			var by:int;
			var blockId:int;
			
			for (;bx <= bxc; bx++)
			{
				by = Math.floor(arg1.y/16.0);
				for(;by <= byc; by++)
				{
					if (map[by] != null) 
					{
						blockId = map[by][bx];
						if (blockId >= hitOffset && blockId <= hitEnd) 
						{
							//return true;
							if (arg1 is Player)
							{
								if (blockId >= 31 && blockId < 39) //smiley door
								{
									
									if (blockId-31 == (arg1 as Player).frame)
										continue;
									
								}
								else if (blockId >= 39 && blockId < 47) //smiley gate
								{
									
									if (blockId-39 != (arg1 as Player).frame)
										continue;
									
								}
								
							}
							
							if (!(this.hideRed && blockId == 23)) 
							{
								if (!(this.hideGreen && blockId == 24)) 
								{
									if (!(this.hideBlue && blockId == 25)) 
									{
										return true;
									}
								}
							}
						}
					}
				}
			}
			
            return false;
        }
    }
}
