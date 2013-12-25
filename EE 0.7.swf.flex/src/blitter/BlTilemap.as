package blitter
{
	import flash.display.*;
	import flash.geom.*;
	
	public class BlTilemap extends BlObject
	{
		protected var rect:Rectangle;
		protected var bmd:BitmapData;
		protected var size:int;
		protected var map:Array;
		protected var hitOffset:int;
		protected var hitEnd:int;
		
		public function BlTilemap(param1:Bitmap, param2:int = 1, param3:int = 99)
		{
			this.map = [[]];
			this.bmd = param1.bitmapData;
			this.rect = new Rectangle(0, 0, this.bmd.height, this.bmd.height);
			this.size = this.bmd.height;
			this.hitOffset = param2;
			this.hitEnd = param3;
			return;
		}// end function
		
		public function setMapArray(param1:Array) : void
		{
			this.map = param1;
			height = param1.length;
			width = param1[0].length;
			return;
		}// end function
		
		public function setMapString(param1:String) : void
		{
			var _loc_5:Array = null;
			var _loc_6:Array = null;
			var _loc_7:int = 0;
			var _loc_2:* = param1.split("\n");
			var _loc_3:* = new Array();
			var _loc_4:int = 0;
			while (_loc_4 < _loc_2.length)
			{
				
				_loc_5 = _loc_2[_loc_4].split(",");
				_loc_6 = [];
				_loc_3.push(_loc_6);
				_loc_7 = 0;
				while (_loc_7 < _loc_5.length)
				{
					
					_loc_6.push(parseInt(_loc_5[_loc_7]));
					_loc_7 = _loc_7 + 1;
				}
				_loc_4 = _loc_4 + 1;
			}
			this.setMapArray(_loc_3);
			return;
		}// end function
		
		public function overlaps(param1:BlObject) : Boolean
		{
			var _loc_5:int = 0;
			var _loc_6:int = 0;
			var _loc_2:* = param1.x / this.size;
			var _loc_3:* = param1.y / this.size;
			var _loc_4:* = _loc_3;
			while (_loc_4 < _loc_3 + (param1.width - 1) / this.size)
			{
				
				_loc_5 = _loc_2;
				while (_loc_5 < _loc_2 + (param1.height - 1) / this.size)
				{
					
					if (this.map[_loc_4 >> 0] != null)
					{
						_loc_6 = this.map[_loc_4 >> 0][_loc_5 >> 0];
						if (_loc_6 >= this.hitOffset)
						{
						}
						if (_loc_6 <= this.hitEnd)
						{
							return true;
						}
					}
					_loc_5 = _loc_5 + 1;
				}
				_loc_4 = _loc_4 + 1;
			}
			return false;
		}// end function
		
		public function setTile(param1:int, param2:int, param3:int) : void
		{
			if (this.map[param2] != null)
			{
				if (this.map[param2][param1] != null)
				{
					this.map[param2][param1] = param3;
				}
			}
			return;
		}// end function
		
		public function getTile(param1:int, param2:int) : int
		{
			if (this.map[param2] != null)
			{
				if (this.map[param2][param1] != null)
				{
					return this.map[param2][param1];
				}
			}
			return 0;
		}// end function
		
		override public function draw(param1:BitmapData, param2:Number, param3:Number) : void
		{
			var _loc_11:Array = null;
			var _loc_12:int = 0;
			var _loc_13:int = 0;
			var _loc_4:* = param2 >> 0;
			var _loc_5:* = param3 >> 0;
			var _loc_6:* = (-param3) / this.size;
			var _loc_7:* = (-param2) / this.size;
			var _loc_8:* = _loc_6 + Bl.height / this.size + 1;
			var _loc_9:* = _loc_7 + Bl.width / this.size + 1;
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
				
				_loc_11 = this.map[_loc_10] as Array;
				_loc_12 = _loc_7;
				while (_loc_12 < _loc_9)
				{
					
					_loc_13 = _loc_11[_loc_12];
					this.rect.x = _loc_13 * this.size;
					param1.copyPixels(this.bmd, this.rect, new Point(_loc_12 * this.size + _loc_4, _loc_10 * this.size + _loc_5));
					_loc_12 = _loc_12 + 1;
				}
				_loc_10 = _loc_10 + 1;
			}
			return;
		}// end function
		
	}
}


/*package blitter 
{
    import flash.display.*;
    import flash.geom.*;
    
    public class BlTilemap extends blitter.BlObject
    {
        public function BlTilemap(arg1:flash.display.Bitmap, arg2:int=1, arg3:int=99)
        {
            this.map = [[]];
            super();
            this.bmd = arg1.bitmapData;
            this.rect = new flash.geom.Rectangle(0, 0, this.bmd.height, this.bmd.height);
            this.size = this.bmd.height;
            this.hitOffset = arg2;
            this.hitEnd = arg3;
            return;
        }

        public function setMapArray(arg1:Array):void
        {
            this.map = arg1;
            height = arg1.length;
            width = arg1[0].length;
            return;
        }

        public function setMapString(arg1:String):void
        {
            var loc4:*=null;
            var loc5:*=null;
            var loc6:*=0;
            var loc1:*=arg1.split("\n");
            var loc2:*=new Array();
            var loc3:*=0;
            while (loc3 < loc1.length) 
            {
                loc4 = loc1[loc3].split(",");
                loc5 = [];
                loc2.push(loc5);
                loc6 = 0;
                while (loc6 < loc4.length) 
                {
                    loc5.push(parseInt(loc4[loc6]));
                    ++loc6;
                }
                ++loc3;
            }
            this.setMapArray(loc2);
            return;
        }

        public function overlaps(arg1:blitter.BlObject):Boolean
        {
            var loc4:*=0;
            var loc5:*=0;
            var loc1:*=arg1.x / this.size;
            var loc2:*=arg1.y / this.size;
            var loc3:*=loc2;
            while (loc3 < loc2 + (arg1.width - 1) / this.size) 
            {
                loc4 = loc1;
                while (loc4 < loc1 + (arg1.height - 1) / this.size) 
                {
                    if (this.map[loc3 >> 0] != null) 
                    {
                        loc5 = this.map[loc3 >> 0][loc4 >> 0];
                        if (loc5 >= this.hitOffset && loc5 <= this.hitEnd) 
                        {
                            return true;
                        }
                    }
                    ++loc4;
                }
                ++loc3;
            }
            return false;
        }

        public function setTile(arg1:int, arg2:int, arg3:int):void
        {
            if (this.map[arg2] != null) 
            {
                if (this.map[arg2][arg1] != null) 
                {
                    this.map[arg2][arg1] = arg3;
                }
            }
            return;
        }

        public function getTile(arg1:int, arg2:int):int
        {
            if (this.map[arg2] != null) 
            {
                if (this.map[arg2][arg1] != null) 
                {
                    return this.map[arg2][arg1];
                }
            }
            return 0;
        }

        public override function draw(arg1:flash.display.BitmapData, arg2:Number, arg3:Number):void
        {
            var loc8:*=null;
            var loc9:*=0;
            var loc10:*=0;
            var loc1:*=arg2 >> 0;
            var loc2:*=arg3 >> 0;
            var loc3:*=(-arg3) / this.size;
            var loc4:*=(-arg2) / this.size;
            var loc5:*=loc3 + blitter.Bl.height / this.size + 1;
            var loc6:*=loc4 + blitter.Bl.width / this.size + 1;
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
                loc8 = this.map[loc7] as Array;
                loc9 = loc4;
                while (loc9 < loc6) 
                {
                    loc10 = loc8[loc9];
                    this.rect.x = loc10 * this.size;
                    arg1.copyPixels(this.bmd, this.rect, new flash.geom.Point(loc9 * this.size + loc1, loc7 * this.size + loc2));
                    ++loc9;
                }
                ++loc7;
            }
            return;
        }

        protected var rect:flash.geom.Rectangle;

        protected var bmd:flash.display.BitmapData;

        protected var size:int;

        protected var map:Array;

        protected var hitOffset:int;

        protected var hitEnd:int;
    }
}*/
