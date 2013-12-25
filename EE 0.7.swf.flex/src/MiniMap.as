package 
{
    import blitter.*;
    import flash.display.*;
    import flash.geom.*;
    import playerio.*;
    
    public class MiniMap extends blitter.BlObject
    {
        public function MiniMap(arg1:Array, arg2:playerio.Connection)
        {
            var level:Array;
            var connection:playerio.Connection;
            var cols:Array;
            var a:int;
            var row:Array;
            var b:int;

            var loc1:*;
            row = null;
            b = 0;
            level = arg1;
            connection = arg2;
            this.bmd = new flash.display.BitmapData(200, 200, false, 0);
            this.playermap = new flash.display.BitmapData(200, 200, true, 0);
            this.colors = [
				0x000000, 0x000000, 0x000000, 0x000000, //down, left, up, right
				0x000000, 0x43391F, 0x2C1A1A, 0x1A2C1A, //dot, crown, red key, green key						////dot, gray, blue, purple(basic)
				0x1A1A2C, 0x6E6E6E, 0x3552A8, 0x9735A7, //blue key, gray, blue, purple(basic),					////red, yellow, green, cyan(basic)
				0xA83554, 0x93A835, 0x42A836, 0x359EA6, //red, yellow, green, cyan - (basic)					////brown, cyan, purple, green(brick)
				0x8B3E09, 0x246F4D, 0x4E246F, 0x438310, //brown, cyan purple, green - (brick) 					//red, yellow, warning(22), red door
				0x6F2429, 0x6F5D24, 0x895B12, 0x9C2D46, //red, yellow, warning, red door						////green door, blue door, white silver, red silver
				0x379C30, 0x2D449C, 0xA1A3A5, 0xDF7A41, //green door, blue door, white silver 		//yellow silver, smiley, black
				0xF0A927, 0xCF9022]; //red silver, yellow silver
            super();
            this.x = 640 - 202;
            this.y = 470 - 202;
            cols = level;
            a = 0;
            while (a < cols.length) 
            {
                row = cols[a];
                b = 0;
                while (b < row.length) 
                {
                    this.bmd.setPixel(b, a, this.colors[parseInt(row[b])]);
                    ++b;
                }
                ++a;
            }
            connection.addMessageHandler("c", function (arg1:playerio.Message, arg2:int, arg3:int, arg4:int):void
            {
                bmd.setPixel(arg2, arg3, colors[arg4]);
                return;
            })
            return;
        }

        public function showPlayer(arg1:Player, arg2:Number):void
        {
            this.playermap.setPixel32(arg1.x >> 4, arg1.y >> 4, arg2);
            return;
        }

        public function clear():void
        {
            this.playermap.colorTransform(this.playermap.rect, new flash.geom.ColorTransform(1, 1, 1, 1 - 1 / 64));
            return;
        }

        public override function draw(arg1:flash.display.BitmapData, arg2:Number, arg3:Number):void
        {
            arg1.copyPixels(this.bmd, this.bmd.rect, new flash.geom.Point(x, y));
            arg1.copyPixels(this.playermap, this.playermap.rect, new flash.geom.Point(x, y));
            this.clear();
            return;
        }

        private var bmd:flash.display.BitmapData;

        private var playermap:flash.display.BitmapData;

        private var colors:Array;
    }
}
