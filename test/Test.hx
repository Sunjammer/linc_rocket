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
            Sys.sleep(6);
        }
    }

}