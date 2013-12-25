package sample.ui.components.scroll 
{
    import sample.ui.components.*;
    
    public class ScrollTracker extends sample.ui.components.SampleButton
    {
        public function ScrollTracker(arg1:Function=null)
        {
            super(arg1);
            _width = 20;
            _height = 20;
            this.upState = new sample.ui.components.Box().margin(0, 0, 0, 0).fill(10066329, 1, 3);
            this.downState = new sample.ui.components.Box().margin(0, 0, 0, 0).fill(8947848, 1, 3);
            this.overState = new sample.ui.components.Box().margin(0, 0, 0, 0).fill(16777215, 1, 3);
            this.hitTestState = new sample.ui.components.Box().margin(0, 0, 0, 0).fill(12303291, 1, 3);
            return;
        }
    }
}
