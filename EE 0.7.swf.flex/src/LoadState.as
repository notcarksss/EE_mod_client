package 
{
    import blitter.*;
    import flash.display.*;
    import flash.geom.*;
    import flash.net.*;
    
    public class LoadState extends blitter.BlState
    {
		protected var loading:Class;
		protected var image:flash.display.BitmapData;
		protected var color:Number=0;
		protected var modifier:Number=0.05;
		protected var callback:Function;
		
        public function LoadState()
        {
            this.loading = LoadState_loading;
            this.image = new this.loading().bitmapData;
            super();
            return;
        }

        public override function enterFrame():void
        {
            if (blitter.Bl.isMouseJustPressed) 
            {
                //flash.net.navigateToURL(new flash.net.URLRequest("http://everybodyedits.com"), "_blank");
            }
            return;
        }

        public override function draw(arg1:flash.display.BitmapData, arg2:Number, arg3:Number):void
        {
            this.color = this.color + this.modifier;
            arg1.copyPixels(this.image, this.image.rect, new flash.geom.Point(0, 0));
            arg1.colorTransform(arg1.rect, new flash.geom.ColorTransform(1, 1, 1, this.color));
            if (this.color < 0 && !(this.callback == null)) 
            {
                this.callback();
                this.callback = null;
            }
            return;
        }

        public function fadeOut(arg1:Function):void
        {
            this.color = 1;
            this.modifier = -0.05;
            this.callback = arg1;
            return;
        }
    }
}
