package utility
{
	import flash.utils.ByteArray;

	public class ByteQueueReader
	{
		private var array:ByteArray;
		private var index:int = 0;
		
		public function ByteQueueReader(array:ByteArray)
		{
			this.array = array;
		}
		
		public function Dequeue() : int
		{
			return this.array[this.index++];
		}
		
		public function DequeueShort() : int
		{
			return (this.array[this.index++]<<8) | this.array[this.index++];
		}
		
		public function get Length() : int
		{
			return this.array.length;
		}
		
		public function get Empty() : Boolean
		{
			return (this.index == this.array.length);
		}
		
		public function get Index() : int
		{
			return this.index;
		}
		
	}
}