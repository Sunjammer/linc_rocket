import rocket.Rocket.*;
import cpp.Pointer;
import cpp.Callable;

class Boof{
    public function new() { }
    public function test(){
        trace("Boof");
    }
}

class Test {
    
    static var bpm = 125.0; /* beats per minute */
    static var rpb = 8; /* rows per beat */
    static var row_rate = (bpm / 60.0) * rpb;

    static function main() {
        var time = 0.0;
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

            
            var isPlaying:Int = 1;
            var row = 0;
            var paused = 0;
            function pause(a:Dynamic, value:Int){
                paused = value;
            }

            function set_row(a:Dynamic, value:Int){
                row = value;
                time = row / row_rate;
            }

            function is_playing(a:Dynamic):Int{
                return 1-paused;
            }

            var done = false;
            while(!done){
                if (sync_update(device, Math.floor(row), { pause:pause, set_row:set_row, is_playing:is_playing }, null) != 0)
			        sync_tcp_connect(device, "localhost", SYNC_DEFAULT_PORT);

                var rv = sync_get_val(r, row);
                var gv = sync_get_val(g, row);
                var bv = sync_get_val(b, row);
                trace("State: "+row+" "+paused+" -- "+rv+","+gv+","+bv);
                if(bv==100)
                    break;
                Sys.sleep(0.016);
                if(paused==0){
                    time += 0.016;
                    row = Math.floor(time * row_rate);
                }
            }
            sync_destroy_device(device);
            trace("Destroyed");
        }
    }

}