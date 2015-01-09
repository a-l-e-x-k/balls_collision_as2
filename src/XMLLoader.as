/**
 * ...
 * @author Alex K
 */
class XMLLoader
{	
	public function XMLLoader(url:String, callback:Function) 
	{
		var xml:XML = new XML();
		xml.ignoreWhite = true;
		xml.onLoad = function (success:Boolean)
		{
			if (success)
				callback(this);
			else
				trace("XMLLoader: XML load failed.");
		};
		xml.load(url);
	}
}