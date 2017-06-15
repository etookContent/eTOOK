/**
 * Created by mes on 6/15/2017.
 */
package moodelService {
import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;

public class GetSavedInfo extends ServiceBase {



    public function GetSavedInfo() {
        super("local_playertrack_get_progress");
    }

    public function load(userid:uint,courseid:uint,idnumber:uint)
    {
        super.loadParam({userid:userid,courseid:courseid,idnumber:idnumber});
    }
}
}
