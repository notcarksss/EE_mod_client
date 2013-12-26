package utility
{
	import flash.utils.ByteArray;

	public class Compressor
	{
		/*public function Compressor()
		{
		}*/
			/// <summary>
			/// Only posetive values are allowed!
			/// Data stored as:
			/// [quad] main;
			/// [quad(complex)] = [(byte) isSimple-booleans], [quad], [quad], [quad], [quad];
			/// [quad(simple)] = [(short) blockoutput];
			/// </summary>
			/// <param name="input"></param>
			/// <param name="output"></param>
			/// <param name="x"></param>
			/// <param name="y"></param>
			/// <param name="width"></param>
			/// <param name="height"></param>
			public static function CompressQuadTree(input:Array, output:ByteArray, x1:int, y1:int, x2:int, y2:int) : void

			{
				var width:int = x2 - x1;
				var height:int = y2 - y1;
				
				var middleX:int;
				var middleY:int;
				
				var finalQuadDataByte:int;
				
				if (width <= 2 && height <= 2)
				{
					if (width == 1 && height == 1)
					{
						AddShortToByteStack(output, input[x1][y1]);
					}
					else if (width == 2 && height == 1)
					{
						AddShortToByteStack(output, input[x1][y1]);
						AddShortToByteStack(output, input[x2][y1]);
					}
					else if (width == 1 && height == 2)
					{
						AddShortToByteStack(output, input[x1][y1]);
						AddShortToByteStack(output, input[x1][y2]);
					}
					else if (width == 2 && height == 2)
					{
						AddShortToByteStack(output, input[x1][y1]);
						AddShortToByteStack(output, input[x2][y1]);
						AddShortToByteStack(output, input[x1][y2]);
						AddShortToByteStack(output, input[x2][y2]);
					}
					return;
				}
				
				middleX = x1 + (width >> 1);//(x1) - (x1+x2 >> 1);
				middleY = y1 + (height >> 1);//(y1) - (y1+y2 >> 1);
				
				
				// This is also 4 booleans(rather 8, to be precise).
				// They tell if the area is filled with 1 simple block or more complex. (True: simple, False: complex)
				finalQuadDataByte = 0;
				
				var lambda:Function = null;
				lambda = function(b:int) : void
					{
						var l_x1:int;
						var l_y1:int;
						var l_x2:int;
						var l_y2:int;
						var l_id:int;
						
						switch (b)
						{
							// Strong values take half or more than half of the size,
							// weak values are take half or more than half of the size.
							// Example: weak: 3/2 = 1, strong: 3-3/2 = 2 
							case 0:
								//weak x, weak y
								if (width == 1 || height == 1)
								{
									output.writeByte(finalQuadDataByte);//.Push(finalQuadDataByte);
									return;
								}
								
								l_x1 = x1;
								l_y1 = y1;
								l_x2 = middleX;
								l_y2 = middleY;
								break;
							
							case 1:
								//strong x, weak y
								if (height == 1)
								{
									// Goes to back to the beginning...
									lambda(0);
									return;
								}
								
								l_x1 = middleX;
								l_y1 = y1;
								l_x2 = x2;
								l_y2 = middleY;
								break;
							
							case 2:
								//weak x, strong y
								if (width == 1)
								{
									// Goes to back to the beginning...
									lambda(1);
									return;
								}
								
								l_x1 = x1;
								l_y1 = middleY;
								l_x2 = middleX;
								l_y2 = y2;
								break;
							
							case 3:
								//strong x, strong y
								l_x1 = middleX;
								l_y1 = middleY;
								l_x2 = x2;
								l_y2 = y2;
								break;
							
							default:
								trace(b.toString() + " is an invalid quadtree child index. It can only be 0,1,2 or 3.");
						}
						
						l_id = getType2d(input, l_x1, l_y1, l_x2, l_y2);
						
						var isSimple:Boolean = (l_id != -1);
						
						if (isSimple)
							finalQuadDataByte |= 1 << b;
						
						if (b > 0) //quadtree does not have more than 4 children!
						{
							// Goes to back to the beginning...
							lambda((b - 1));
						}
						else
						{
							output.writeByte(finalQuadDataByte);//output.Push(finalQuadDataByte);
						}
						
						if (isSimple)
						{
							AddShortToByteStack(output, l_id);
						}
						else
						{
							// declares another quad inside the square
							CompressQuadTree(input, output, l_x1, l_y1, l_x2, l_x2);
						}
						
						// Goes back to the end...
						return;
						
					};
				
				// starts from the end and ends with the end.
				// 3-> 2-> 1-> 0-> 1-> 2-> 3
				lambda(3);
			}
			
			public static function DecompressQuadTree(output:Array, input:ByteArray, x1:int, y1:int, x2:int, y2:int, pos2:int = 0) : int //public static void DecompressQuadTree(short[,] output, Stack<byte> input, short x, short y, short width, short height)
			{
				var width:int = x2 - x1;
				var height:int = y2 - y1;
				
				var middleX:int;
				var middleY:int;
				
				var binaryDataByte:int;
				
				var pos:int = pos2;
				
				if (width == 0 || height == 0)
					return pos;
				
				if (width <= 2 && height <= 2)
				{
					for (; y1 < y2; y1++) //output[x, y] = input.Pop();
					{
						for (var xx:int = x1; xx < x2; xx++)
							output[xx][y1] = input[pos++];
					}
					return pos;
				}
				
				middleX = x1 + (x2-x1 >> 1);//(x1) - (x1+x2 >> 1);
				middleY = y1 + (y2-y1 >> 1);//(y1) - (y1+y2 >> 1);
				
				//pos = input.length-1;
				
				binaryDataByte = input[pos++];
			
				
				var lambda:Function = function(b:int) : void
					{
						var l_id:int = 0;
						var l_x1:int = 0;
						var l_y1:int = 0;
						var l_x2:int = 0;
						var l_y2:int = 0;
						//var l_id:int;
						
						switch (b)
						{
							case 0:
								l_x1 = x1;
								l_y1 = y1;
								l_x2 = middleX;
								l_y2 = middleY;
								break;
							case 1:
								l_x1 = middleX;
								l_y1 = y1;
								l_x2 = x2;
								l_y2 = middleY;
								break;
							case 2:
								l_x1 = x1;
								l_y1 = middleY;
								l_x2 = middleX;
								l_y2 = y2;
								break;
							case 3:
								//strong x, strong y
								l_x1 = middleX;
								l_y1 = middleY;
								l_x2 = x2;
								l_y2 = y2;
								break;
							default:
								trace(b.toString() + " is an invalid quadtree child index. It can only be 0,1,2 or 3.");
						}
						
						
						
						if ((binaryDataByte & (1 << b)) == (1 << b))
						{
							
							l_id = input[pos++];
							//return;
							for (; l_y1 < l_y2; l_y1++)
							{
								for (; l_x1 < l_x2; l_x1++)
								{
									output[l_x1][l_y1] = l_id;
								}
							}
						}
						else
						{
							//return pos;
							pos = DecompressQuadTree(output, input, l_x1, l_y1, l_x2, l_y2, pos);
						}
					};
				
				lambda(0);
				lambda(1);
				lambda(2);
				lambda(3);
				
				return pos;
			}
			
			public static function CompressBinaryTree(input:Array, output:ByteArray, start:int, end:int) : void
			{
				var length:int = (end - start);
				var middle:int;
				
				var finalBinaryDataByte:int;
				
				if (length <= 2)
				{
					if (length == 1)
					{
						AddShortToByteStack(output, input[start]);
					}
					else if (length == 2)
					{
						AddShortToByteStack(output, input[start]);
					}
					return;
				}
				
				
				middle = (start + length / 2);
				
				// This is also 2 booleans(rather 8, to be precise).
				// They tell if the array is filled with 1 simple block or more complex. (True: simple, False: complex)
				finalBinaryDataByte = 0;
				
				var lambda:Function = null;
				lambda = function(b:int) : void
					{
						var l_start:int;
						var l_end:int;
						var l_id:int;
						
						if (b == 0)
						{
							if (length == 1)
							{
								output.writeByte(finalBinaryDataByte);
								return;
							}
							l_start = start;
							l_end = middle;
						}
						else
						{
							l_start = middle;
							l_end = end;
						}
						
						l_id = getType(input, l_start, l_end);
						
						//if (l_id == -1)
						//    throw new Exception("Negative value(-1) found in data! Only possetive values should be used. Negative values may be allowed, but -1 is forbidden!");
						
						var isSimple:Boolean = (l_id != -1);
						
						if (isSimple)
							finalBinaryDataByte |= (1 << b);
						
						if (b > 0) //quadtree does not have more than 4 children!
						{
							// Goes to back to the beginning...
							lambda(b - 1);
						}
						else
						{
							output.writeByte(finalBinaryDataByte);
						}
						
						if (isSimple)
						{
							AddShortToByteStack(output, l_id);
						}
						else
						{
							// declares another quad inside the square
							CompressBinaryTree(input, output, l_start, l_end);
						}
						
						// Goes back to the end...
						return;
					};
				
				lambda(1);
			}
			
			public static function DecompressBinaryTree(output:Array, input:ByteArray, start:int, end:int, pos:int = 0) : int
			{
				var length:int = (start - end);
				var middle:int;
				
				//tells if the children are simple(true) or complex(false).
				var binaryDataByte:int;
				var id:int;
				
				if (length <= 2)
				{
					if (length == 0)
						return pos;
					
					if (length == 1)
					{
						output[start] = input[pos++];
					}
					else // length must be 2
					{
						output[start] = input[pos++];
						output[start + 1] = input[pos++];
					}
					
					return pos;
				}
				
				middle = start + length / 2;
				
				binaryDataByte = input[pos++];
				
				if ((binaryDataByte & 1) == 1)
				{
					id = input[pos++]
					for (var i:int = start; i < middle; i++)
						output[i] = id;
				}
				else
				{
					pos = DecompressBinaryTree(output, input, start, middle, pos);
				}
				
				
				if ((binaryDataByte & 2) == 2)
				{
					//id = input[pos++]
					//for (var i:int = middle; i < end; i++)
					//	output[i] = id;
				}
				else
				{
					pos = DecompressBinaryTree(output, input, middle, end, pos);
				}
				
				return pos;
				
			}
			
			private static function getType(input:Array, start:int, end:int) : int
			{
				var blockId:int = input[start++];
				
				if (blockId == -1)
					trace("Negative value(-1) found in data! Only positive values should be used. Negative values may be allowed, but -1 is forbidden!");
				
				for (; start < end; start++)
				{
					if (input[start] != blockId)
						return -1;
				}
				
				return blockId;
			}
			
			private static function getType2d(input:Array, x1:int, y1:int, x2:int, y2:int) : int
			{
				var blockId:int = input[x1][y1];
				
				if (blockId == -1)
					trace("Negative value(-1) found in data! Only positive values should be used. Negative values may be allowed, but -1 is forbidden!");
				
				for (; y1 < y2; y1++)
				{
					for (var xx:int = x1; xx < x2; xx++)
					{
						if (input[xx][y1] != blockId)
							return -1;
					}
				}
				
				return blockId;
			}
			
			private static function AddShortToByteStack(output:ByteArray, value:int):void
			{
				output.writeByte((value >> 8)&0xFF);
				output.writeByte(value & 0xFF);
			}
		
	}
}