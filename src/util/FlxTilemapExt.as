package util
{	
	import org.flixel.*;
	import org.flixel.system.FlxTile;
	import weapons.BounceBullet;
	import weapons.BulletExt;
	
	/**
	 * extended <code>FlxTilemap</code> class that provides collision detection against slopes
	 * @author	Dirk Bunk
	 */
	public class FlxTilemapExt extends FlxTilemap
	{		
		//slope related variables		
		private var _snapping:uint = 2;		
		private var _slopePoint:FlxPoint = new FlxPoint();
		private var _objPoint:FlxPoint = new FlxPoint();
		
		public static const SLOPE_FLOOR_LEFT:uint  = 10;
		public static const SLOPE_FLOOR_RIGHT:uint = 11;
		public static const SLOPE_CEIL_LEFT:uint   = 12;
		public static const SLOPE_CEIL_RIGHT:uint  = 13;
		
		override public function loadMap(MapData:String, TileGraphic:Class, TileWidth:uint=0, TileHeight:uint=0, AutoTile:uint=OFF, StartingIndex:uint=0, DrawIndex:uint=1, CollideIndex:uint=1):FlxTilemap
		{
			var tmpTileMap:FlxTilemap = super.loadMap(MapData, TileGraphic, TileWidth, TileHeight, AutoTile, StartingIndex, DrawIndex, CollideIndex);
			
			//set properties for slope tiles (to use our own collision detection)
			setTileProperties(SLOPE_FLOOR_LEFT | 2, RIGHT | FLOOR, solveCollisionSlopeFloorLeft);
			setTileProperties(SLOPE_FLOOR_RIGHT | 3, LEFT | FLOOR, solveCollisionSlopeFloorRight);
			setTileProperties(SLOPE_CEIL_LEFT | 4, RIGHT | CEILING, solveCollisionSlopeCeilLeft);
			setTileProperties(SLOPE_CEIL_RIGHT| 5, LEFT | CEILING, solveCollisionSlopeCeilRight);
			
			setTileProperties(1, ANY, solveCollisionInBlock);
			
			return tmpTileMap;
		}
		
		protected function solveCollisionInBlock(slope:FlxTile, obj:FlxObject):void
		{
			if (obj is BulletExt) obj.kill();
		}
		
		/**
		 * THIS IS A COPY FROM <code>FlxTilemap</code> BUT IT SOLVES SLOPE COLLISION TOO
		 * Checks if the Object overlaps any tiles with any collision flags set,
		 * and calls the specified callback function (if there is one).
		 * Also calls the tile's registered callback if the filter matches.
		 * 
		 * @param	Object				The <code>FlxObject</code> you are checking for overlaps against.
		 * @param	Callback			An optional function that takes the form "myCallback(Object1:FlxObject,Object2:FlxObject)", where Object1 is a FlxTile object, and Object2 is the object passed in in the first parameter of this method.
		 * @param	FlipCallbackParams	Used to preserve A-B list ordering from FlxObject.separate() - returns the FlxTile object as the second parameter instead.
		 * @param	Position			Optional, specify a custom position for the tilemap (useful for overlapsAt()-type funcitonality).
		 * 
		 * @return	Whether there were overlaps, or if a callback was specified, whatever the return value of the callback was.
		 */
		override public function overlapsWithCallback(Object:FlxObject, Callback:Function = null, FlipCallbackParams:Boolean = false, Position:FlxPoint = null):Boolean
		{
			var results:Boolean = false;
			
			var X:Number = x;
			var Y:Number = y;
			if(Position != null)
			{
				X = Position.x;
				Y = Position.y;
			}
			
			//Figure out what tiles we need to check against
			var selectionX:int = FlxU.floor((Object.x - X)/_tileWidth);
			var selectionY:int = FlxU.floor((Object.y - Y)/_tileHeight);
			var selectionWidth:uint = selectionX + (FlxU.ceil(Object.width/_tileWidth)) + 1;
			var selectionHeight:uint = selectionY + FlxU.ceil(Object.height/_tileHeight) + 1;
						
			//Then bound these coordinates by the map edges
			if(selectionX < 0)
				selectionX = 0;
			if(selectionY < 0)
				selectionY = 0;
			if(selectionWidth > widthInTiles)
				selectionWidth = widthInTiles;
			if(selectionHeight > heightInTiles)
				selectionHeight = heightInTiles;
			
			//Then loop through this selection of tiles and call FlxObject.separate() accordingly
			var rowStart:uint = selectionY*widthInTiles;
			var row:uint = selectionY;
			var column:uint;
			var tile:FlxTile;
			var overlapFound:Boolean;
			var deltaX:Number = X - last.x;
			var deltaY:Number = Y - last.y;
			while(row < selectionHeight)
			{
				column = selectionX;
				while(column < selectionWidth)
				{
					overlapFound = false;
					tile = _tileObjects[_data[rowStart+column]] as FlxTile;
					if(tile.allowCollisions)
					{
						tile.x = X+column*_tileWidth;
						tile.y = Y+row*_tileHeight;
						tile.last.x = tile.x - deltaX;
						tile.last.y = tile.y - deltaY;
						if(Callback != null)
						{
							if(FlipCallbackParams)
								overlapFound = Callback(Object,tile);
							else
								overlapFound = Callback(tile,Object);
						}
						else
							overlapFound = (Object.x + Object.width > tile.x) && (Object.x < tile.x + tile.width) && (Object.y + Object.height > tile.y) && (Object.y < tile.y + tile.height);

						//solve slope collisions if no overlap was found
						if (overlapFound 
						|| (!overlapFound && (tile.index == SLOPE_FLOOR_LEFT || tile.index == SLOPE_FLOOR_RIGHT || tile.index == SLOPE_CEIL_LEFT || tile.index == SLOPE_CEIL_RIGHT)))
						{
							if((tile.callback != null) && ((tile.filter == null) || (Object is tile.filter)))
							{
								tile.mapIndex = rowStart+column;
								tile.callback(tile,Object);
							}
							results = true;
						}
					}
					else if((tile.callback != null) && ((tile.filter == null) || (Object is tile.filter)))
					{
						tile.mapIndex = rowStart+column;
						tile.callback(tile,Object);
					}
					column++;
				}
				rowStart += widthInTiles;
				row++;
			}
			return results;
		}
			
		/**
		 * bounds the slope point to the slope
		 * @param	slope	the slope to fix the slopePoint for
		 */
		final private function fixSlopePoint(slope:FlxTile):void
		{
			_slopePoint.x = FlxU.bound(_slopePoint.x, slope.x, slope.x + _tileWidth);
			_slopePoint.y = FlxU.bound(_slopePoint.y, slope.y, slope.y + _tileHeight);	
		}
		
		/**
		 * is called if an object collides with a floor slope
		 * @param	slope	the floor slope
		 * @param	obj		the object that collides with that slope
		 */
		protected function onCollideFloorSlope(slope:FlxTile, obj:FlxObject, slopeType:uint):void
		{
			if(!(obj is BulletExt))
			{	
				//set the object's touching flag
				obj.touching = FLOOR;
				
				//adjust the object's velocity
				obj.velocity.y = 0;
				
				//reposition the object
				obj.y = _slopePoint.y - obj.height;
				if (obj.y < slope.y - obj.height) { obj.y = slope.y - obj.height };
			}
			
			else if (obj is BounceBullet)
			{
					
					if (obj.angle == 0 && obj.velocity.y == 0 && slopeType == SLOPE_FLOOR_LEFT && ((obj as BounceBullet).parity == 1 || (obj as BounceBullet).parity == -1))
					{
						obj.velocity.y = -(obj.velocity.x);
						obj.velocity.x = 0;	
						
						(obj as BounceBullet).parity = 1;
					}
					else if(obj.angle == 180 && obj.velocity.y == 0 && slopeType == SLOPE_FLOOR_RIGHT && ((obj as BounceBullet).parity == 0 || (obj as BounceBullet).parity == -1)) 
					{	
						obj.velocity.y = obj.velocity.x;
						obj.velocity.x = 0;	
						
						(obj as BounceBullet).parity = 0;
					}
				
				
					if (obj.angle == 90 && obj.velocity.x == 0 && slopeType == SLOPE_FLOOR_LEFT && ((obj as BounceBullet).parity == 0 || (obj as BounceBullet).parity == -1))
					{	
						obj.velocity.x = -(obj.velocity.y);
						obj.velocity.y = 0;
						
						(obj as BounceBullet).parity = 0;
					}
					else if (obj.angle == 90 && obj.velocity.x == 0 && slopeType == SLOPE_FLOOR_RIGHT && ((obj as BounceBullet).parity == 1 || (obj as BounceBullet).parity == -1))
					{
						obj.velocity.x = obj.velocity.y;
						obj.velocity.y = 0;
						
						(obj as BounceBullet).parity = 1;
					}
					
					obj.angle = GameUtil.findAngleByVelocity(obj.velocity.x, obj.velocity.y);
				}
				
			
			
		}
		
		/**
		 * is called if an object collides with a ceiling slope
		 * @param	slope	the ceiling slope
		 * @param	obj		the object that collides with that slope
		 */
		protected function onCollideCeilSlope(slope:FlxTile, obj:FlxObject, slopeType:uint):void
		{
			
			if (!(obj is BulletExt) && !(obj is FlxParticle))
			{
				//set the object's touching flag
				obj.touching = CEILING;
				
				//adjust the object's velocity
				obj.velocity.y = 0;
				
				//reposition the object
				obj.y = _slopePoint.y;
				if (obj.y > slope.y + _tileHeight) { obj.y = slope.y + _tileHeight };
			}
			
			else if (obj is BounceBullet)
			{

					
					if (obj.velocity.y == 0 &&  obj.angle == 180 && slopeType == SLOPE_CEIL_RIGHT && ((obj as BounceBullet).parity == 1 || (obj as BounceBullet).parity == -1)) 
					{
						obj.velocity.y = -(obj.velocity.x);
						obj.velocity.x = 0;
						
						(obj as BounceBullet).parity = 1;
					}
					else if (obj.velocity.y == 0 &&  obj.angle == 0 && slopeType == SLOPE_CEIL_LEFT && ((obj as BounceBullet).parity == 0 || (obj as BounceBullet).parity == -1)) 
					{
						obj.velocity.y = obj.velocity.x;
						obj.velocity.x = 0;
						
						(obj as BounceBullet).parity = 0;
					}

				
					if (obj.velocity.x == 0 && obj.angle == -90 && slopeType == SLOPE_CEIL_RIGHT && ((obj as BounceBullet).parity == 0 || (obj as BounceBullet).parity == -1))
					{
						obj.velocity.x = -(obj.velocity.y);
						obj.velocity.y = 0;
						
						(obj as BounceBullet).parity = 0;
						
					}
					else if (obj.velocity.x == 0 && obj.angle == -90 && slopeType == SLOPE_CEIL_LEFT &&((obj as BounceBullet).parity == 1 || (obj as BounceBullet).parity == -1))
					{
						obj.velocity.x = obj.velocity.y;
						obj.velocity.y = 0;
						
						(obj as BounceBullet).parity = 1;
					}
						
				
				obj.angle = GameUtil.findAngleByVelocity(obj.velocity.x, obj.velocity.y);
			}
		}
		
		/**
		 * solves collision against a left-sided floor slope
		 * @param	slope	the slope to check against
		 * @param	obj		the object that collides with the slope
		 */
		final private function solveCollisionSlopeFloorLeft(slope:FlxTile, obj:FlxObject):void
		{						
			//calculate the corner point of the object
			_objPoint.x = FlxU.floor(obj.x + obj.width + _snapping);
			_objPoint.y = FlxU.floor(obj.y + obj.height);
			
			//calculate position of the point on the slope that the object might overlap
			//this would be one side of the object projected onto the slope's surface
			_slopePoint.x = _objPoint.x;
			_slopePoint.y = (slope.y + _tileHeight) - (_slopePoint.x - slope.x);
			
			//fix the slope point to the slope tile
			fixSlopePoint(slope);
				
			//check if the object is inside the slope
			if (_objPoint.x > slope.x + _snapping
			&& _objPoint.x < slope.x + _tileWidth + obj.width + _snapping
			&& _objPoint.y >= _slopePoint.y
			&& _objPoint.y <= slope.y + _tileHeight)
			{				
				//call the collide function for the floor slope
				onCollideFloorSlope(slope, obj, SLOPE_FLOOR_LEFT);
			}
		}
		
		/**
		 * solves collision against a right-sided floor slope
		 * @param	slope	the slope to check against
		 * @param	obj		the object that collides with the slope
		 */
		final private function solveCollisionSlopeFloorRight(slope:FlxTile, obj:FlxObject):void
		{							
			//calculate the corner point of the object
			_objPoint.x = FlxU.floor(obj.x - _snapping);
			_objPoint.y = FlxU.floor(obj.y + obj.height);
			
			//calculate position of the point on the slope that the object might overlap
			//this would be one side of the object projected onto the slope's surface
			_slopePoint.x = _objPoint.x;
			_slopePoint.y = (slope.y + _tileHeight) - (slope.x - _slopePoint.x + _tileWidth);
			
			//fix the slope point to the slope tile
			fixSlopePoint(slope);
				
			//check if the object is inside the slope
			if (_objPoint.x > slope.x - obj.width - _snapping
			&& _objPoint.x < slope.x + _tileWidth + _snapping
			&& _objPoint.y >= _slopePoint.y
			&& _objPoint.y <= slope.y + _tileHeight)
			{
				//call the collide function for the floor slope
				onCollideFloorSlope(slope, obj, SLOPE_FLOOR_RIGHT);
			}
		}
		
		/**
		 * solves collision against a left-sided ceiling slope
		 * @param	slope	the slope to check against
		 * @param	obj		the object that collides with the slope
		 */
		final private function solveCollisionSlopeCeilLeft(slope:FlxTile, obj:FlxObject):void
		{							
			//calculate the corner point of the object
			_objPoint.x = FlxU.floor(obj.x + obj.width + _snapping);
			_objPoint.y = FlxU.ceil(obj.y);
			
			//calculate position of the point on the slope that the object might overlap
			//this would be one side of the object projected onto the slope's surface
			_slopePoint.x = _objPoint.x;
			_slopePoint.y = (slope.y) + (_slopePoint.x - slope.x);
			
			//fix the slope point to the slope tile
			fixSlopePoint(slope);
				
			//check if the object is inside the slope
			if (_objPoint.x > slope.x + _snapping
			&& _objPoint.x < slope.x + _tileWidth + obj.width + _snapping
			&& _objPoint.y <= _slopePoint.y
			&& _objPoint.y >= slope.y)
			{
				//call the collide function for the floor slope
				onCollideCeilSlope(slope, obj, SLOPE_CEIL_LEFT);
			}
		}
		
		/**
		 * solves collision against a right-sided ceiling slope
		 * @param	slope	the slope to check against
		 * @param	obj		the object that collides with the slope
		 */
		final private function solveCollisionSlopeCeilRight(slope:FlxTile, obj:FlxObject):void
		{																
			//calculate the corner point of the object
			_objPoint.x = FlxU.floor(obj.x - _snapping);
			_objPoint.y = FlxU.ceil(obj.y);
			
			//calculate position of the point on the slope that the object might overlap
			//this would be one side of the object projected onto the slope's surface
			_slopePoint.x = _objPoint.x;
			_slopePoint.y = (slope.y) + (slope.x - _slopePoint.x + _tileWidth);
			
			//fix the slope point to the slope tile
			fixSlopePoint(slope);
				
			//check if the object is inside the slope
			if (_objPoint.x > slope.x - obj.width - _snapping
			&& _objPoint.x < slope.x + _tileWidth + _snapping
			&& _objPoint.y <= _slopePoint.y
			&& _objPoint.y >= slope.y)
			{
				//call the collide function for the floor slope
				onCollideCeilSlope(slope, obj, SLOPE_CEIL_RIGHT);
			}
		}
		
		override public function destroy():void
		{
			super.destroy();
			_slopePoint = null;
			_objPoint = null;
		}
	}
}