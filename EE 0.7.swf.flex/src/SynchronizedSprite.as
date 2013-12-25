package 
{
    import flash.display.*;
    import flash.geom.*;
    
    public class SynchronizedSprite extends SynchronizedObject
    {
        public function SynchronizedSprite(arg1:flash.display.BitmapData)
        {
            super();
            this.bmd = arg1;
            this.rect = new flash.geom.Rectangle(0, 0, arg1.height, arg1.height);
            this.size = arg1.height;
            this.frames = arg1.width / this.size;
            width = this.size;
            height = this.size;
            return;
        }

        public function set frame(arg1:int):void
        {
            this.rect.x = arg1 * this.size;
            return;
        }

        public function get frame():int
        {
            return this.rect.x / this.size;
        }

        public function hitTest(arg1:int, arg2:int):Boolean
        {
            return arg1 >= x && arg2 >= y && arg1 <= x + this.size && arg2 <= y + this.size;
        }

        public override function draw(arg1:flash.display.BitmapData, arg2:Number, arg3:Number):void
        {
            arg1.copyPixels(this.bmd, this.rect, new flash.geom.Point(x + arg2, y + arg3));
            return;
        }

        protected var rect:flash.geom.Rectangle;

        protected var bmd:flash.display.BitmapData;

        protected var size:int;

        protected var frames:int;
    }
}
