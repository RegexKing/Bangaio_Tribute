package util
{
	import adobe.utils.CustomActions;
   /**
    * A queue that works by the FIFO (first in, first out) principle.
    * It can store any type of data and has no fixed size.
    * @author Tox, webcodesign.de
    */
   public class Queue 
   {
      private var q:Vector.<Line> = new Vector.<Line>();
      public var l:uint = 0;
      
      /**
       * CTOR
       */
      public function Queue() { }
      
      /**
       * Writes data to the end of the queue.
       * @param   d   Data to write, can be of any type.
       */
      public function write(d:Line):void { q[q.length] = d; l++; }
      
      /**
       * Reads data from the beginning of the queue.
       * @return   Data stored at the beginning of the queue.
       */      
      public function read():Line 
      {
        if (empty)
        {
          return  null;
        }
        else
        {
          l--;
          return q.shift(); 
        }
      }
	  
	  public function analyze(index:int):Line
	  {
		  return q[index];
	  }

      /**
       * Checks if the queue is empty and returns the result.
       */
      public function get empty():Boolean { return (l <= 0); }
      
      /**
       * Returns the data of the first queue element without removing it.
       * @return   Data of the first queue element.
       */
      public function spy():Line { return (empty) ? null : q[0]; }
	  
	  public function destroy():void
	  {
		  q.length = 0;
	  }
   }
}