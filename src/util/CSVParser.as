package util
{
    public class CSVParser
    {
        
        public static function parse ( data : String, newLine : String = "\n" ) : Array
        {
            var arr : Array = data.split ( newLine );
            var len : uint = arr.length;
            
            for ( var i : uint = 0; i < len; i++ ) {
                arr[i] = parseRow ( arr[i] );
            }
            
            return arr;
        }
        
        private static function parseRow ( data : String ) : Array
        {
            var arr : Array = [];
            var arrLen : uint = 0;
            
            var len : uint = data.length;
            
            var isLast : Boolean = false;
            var isComplex : Boolean = false;
            var wasComplex : Boolean = false;
            
            var char : String;
            var lastIndex : int = -1;
            
            for ( var i : uint = 0; i < len; i++ ) {
                char = data.charAt ( i );
                
                isLast = i == ( len - 1 );
                
                if ( char == '"' && !isLast ) {
                    wasComplex = isComplex;
                    isComplex = !isComplex;
                } else if ( char == ',' && !isComplex && !isLast ) {
                    arr[arrLen] = data.substring ( lastIndex + ( wasComplex ? 2 : 1 ), i + ( wasComplex ? -1 : 0 ) );
                    arrLen++;
                    lastIndex = i;
                } else if ( isLast ) {
                    arr[arrLen] = data.substring ( lastIndex + ( isComplex ? 2 : 1 ), i + ( isComplex ? 0 : 1 ) );
                } else {
                    wasComplex = false;
                }
            }
            
            return arr;
        }

    }
}