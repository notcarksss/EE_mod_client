package utility
{
	import flash.utils.ByteArray;

	public class CompressedData
	{
		public var isDeflated:Boolean;
		public var data:ByteArray;
		
		public function CompressedData(isDeflated:Boolean, data:ByteArray)
		{
			this.isDeflated = isDeflated;
			this.data = data;
		}
	}
}