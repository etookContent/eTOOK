/**
 * Created by mes on 6/15/2017.
 */
package moodelService {
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;
import flash.events.IOErrorEvent;
import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.net.URLRequestMethod;
import flash.net.URLVariables;

[Event(name="complete", type="flash.events.Event")]
[Event(name="ioError", type="flash.events.IOErrorEvent")]
public class ServiceBase extends EventDispatcher {

    public var data:String ;

    protected var loader:URLLoader ;

    protected var request:URLRequest ;

    private static var wstocken:String = null ;
    private static var domain:String = null ;


    public static function setUp(Domain:String,Tocken:String):void
    {
        wstocken = Tocken ;
        domain = Domain ;
    }

    public function ServiceBase(functionName:String) {
        super();

        loader = new URLLoader();
        request = new URLRequest(domain+"/webservice/rest/server.php?wstoken="+wstocken+"&wsfunction="+functionName+"&moodlewsrestformat=json");
        request.method = URLRequestMethod.POST ;

        loader.addEventListener(Event.COMPLETE,imLoaded);
        loader.addEventListener(IOErrorEvent.IO_ERROR, noInternet);
    }

    protected function loadParam(params:Object):void
    {
        data = null ;
        var vars:URLVariables = new URLVariables();
        for(var i:String in params)
        {
            vars[i] = params[i];
        }
        request.data = vars ;
        loader.load(request);
    }

    /**No internet connection available*/
    private function noInternet(event:IOErrorEvent):void {
        trace("No internet connection available");
        this.dispatchEvent(new IOErrorEvent(IOErrorEvent.IO_ERROR));
    }

    /**On connected*/
    private function imLoaded(event:Event):void {
        trace("app is connected to server");
        data = loader.data.toString();
        this.dispatchEvent(new Event(Event.COMPLETE));
    }
}
}
