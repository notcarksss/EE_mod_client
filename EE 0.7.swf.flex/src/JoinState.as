package 
{
    import blitter.*;
    import flash.display.*;
    import flash.geom.*;
    
    public class JoinState extends blitter.BlState
    {
        public function JoinState()
        {
            this.bg = JoinState_bg;
            this.background = new this.bg().bitmapData;
            super();
            return;
        }

        public override function draw(arg1:flash.display.BitmapData, arg2:Number, arg3:Number):void
        {
            arg1.copyPixels(this.background, this.background.rect, new flash.geom.Point(0, 0));
            return;
        }

        protected var bg:Class;

        protected var background:flash.display.BitmapData;
    }
}
