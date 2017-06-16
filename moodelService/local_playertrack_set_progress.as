/**
 * Created by mes on 6/16/2017.
 */
package moodelService {
public class local_playertrack_set_progress extends ServiceBase {
    public function local_playertrack_set_progress() {
        super("local_playertrack_set_progress");
    }

    public function load(userid:uint,courseid:uint,idnumber:uint,progress:String)
    {
        super.loadParam({userid:userid,courseid:courseid,idnumber:idnumber,progress:progress});
    }
}
}
