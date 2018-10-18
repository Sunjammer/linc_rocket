package rocket;
import cpp.*;
import cpp.VirtualArray;

typedef VoidPtr = Pointer<cpp.Void>;

@:keep
@:include('linc_rocket.h')
#if !display
@:build(linc.Linc.touch())
@:build(linc.Linc.xml('rocket'))
#end
extern class Rocket {
    public static inline var SYNC_DEFAULT_PORT:Int = 1338;
    @:native('sync_create_device')
    static function sync_create_device(name:String) : Pointer<SyncDevice>;

    @:native('sync_destroy_device')
    static function sync_destroy_device(device:Pointer<SyncDevice>): Void;

    @:native('sync_tcp_connect')
    static function sync_tcp_connect(device:Pointer<SyncDevice>, host:String, port:UInt):Int;

    @:native('sync_get_track')
    static function sync_get_track(device:Pointer<SyncDevice>, name:String):Pointer<SyncTrack>;

    @:native('sync_get_val')
    static function sync_get_val(track:Pointer<SyncTrack>, row:Float):Float;

    @:native('sync_update')
    static function sync_update(device:Pointer<SyncDevice>, row:Int, sync_cb:Pointer<SyncCb>, cp_param:Pointer<Dynamic>):Int;

} //rocket

@:unreflective
@:structAccess
@:native("sync_cb")
extern class SyncCb {
}

@:unreflective
@:structAccess
@:native("sync_device")
extern class SyncDevice {
	public var base:Dynamic;
    public var tracks:Dynamic;
	public var num_tracks:UInt;
	public var sync_io_cb:Dynamic;
}

@:unreflective
@:structAccess
@:native("track_key")
extern class TrackKey {

}

@:unreflective
@:structAccess
@:native("sync_track")
extern class SyncTrack {
}