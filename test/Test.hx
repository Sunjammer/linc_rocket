import rocket.Rocket.*;
import cpp.Pointer;

class Test {
        
    static function main() {

        var device = sync_create_device("Test");
        trace("Device: "+device);
        if(sync_tcp_connect(device, "localhost", SYNC_DEFAULT_PORT) != 0){
            trace("Failed to connect");
            Sys.sleep(1);
            sync_destroy_device(device);
            trace("Destroyed");
            Sys.sleep(1);
        }else{
            trace("Connected");
            
            var r = sync_get_track(device, "power.r");
            var g = sync_get_track(device, "power.g");
            var b = sync_get_track(device, "power.b");
            var row = 0.0;

            var done = false;
            while(!done){
                if (sync_update(device, Math.floor(row), null, null) != 0)
			        sync_tcp_connect(device, "localhost", SYNC_DEFAULT_PORT);

                var rv = sync_get_val(r, 0);
                var gv = sync_get_val(g, 0);
                var bv = sync_get_val(b, 0);
                trace("State: "+rv+","+gv+","+bv);
                if(bv==100)
                    break;
                Sys.sleep(0.016);
            }
            sync_destroy_device(device);
            trace("Destroyed");
        }
    }

}