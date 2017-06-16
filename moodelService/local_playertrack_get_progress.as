/**
 * Created by mes on 6/15/2017.
 */
package moodelService {
import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;

public class local_playertrack_get_progress extends ServiceBase {



    public function local_playertrack_get_progress() {
        super("local_playertrack_get_progress");
    }

    public function load(userid:uint,courseid:uint,idnumber:uint)
    {
        trace("Get player progress for : userid="+userid+" courseid="+courseid+" idnumber="+idnumber);
        super.loadParam({userid:userid,courseid:courseid,idnumber:idnumber});
    }
}
}
