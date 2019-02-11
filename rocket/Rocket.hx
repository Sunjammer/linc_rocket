package rocket;
import cpp.*;

typedef VoidPtr = Pointer<cpp.Void>;

class SyncCB{
    public static var _pause:Dynamic->Int->Void;
    public static var _set_row:Dynamic->Int->Void;
    public static var _is_playing:Dynamic->Int;

    static function pause(d:Dynamic, i:Int):Void{
        _pause(d, i);
    }
    static function set_row(d:Dynamic, i:Int):Void{
        _set_row(d, i);
    }
    static function is_playing(d:Dynamic):Int{
        return _is_playing(d);
    }
    
    public static var pause_callable = Callable.fromStaticFunction(pause);
    public static var set_row_callable = Callable.fromStaticFunction(set_row);
    public static var is_playing_callable = Callable.fromStaticFunction(is_playing);

}

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

    @:native('sync_save_tracks')
    static function sync_save_tracks(device:Pointer<SyncDevice>): Int;

    @:native('sync_tcp_connect')
    static function sync_tcp_connect(device:Pointer<SyncDevice>, host:String, port:UInt):Int;

    @:native('sync_get_track')
    static function sync_get_track(device:Pointer<SyncDevice>, name:String):Pointer<SyncTrack>;

    @:native('sync_get_val')
    static function sync_get_val(track:Pointer<SyncTrack>, row:Float):Float;
    
    static inline function sync_update(device:Pointer<SyncDevice>, row:Int,
        sync_cb:{ 
            pause:Dynamic->Int->Void, 
            set_row:Dynamic->Int->Void, 
            is_playing:Dynamic->Int
        }, cp_param:Pointer<Dynamic>):Int
    {
        force_include();
        SyncCB._pause = sync_cb.pause;
        SyncCB._set_row = sync_cb.set_row;
        SyncCB._is_playing = sync_cb.is_playing;
        return untyped __cpp__("linc::rocket::sync_update_helper({0}, {1}, {2}, {3}, {4}, {5})", device, row, Pointer.addressOf(SyncCB.pause_callable), Pointer.addressOf(SyncCB.set_row_callable), Pointer.addressOf(SyncCB.is_playing_callable), cp_param);
    }
    
	@:native("void") 
	public static function force_include():Void;

} //rocket

@:unreflective
@:structAccess
@:include('../lib/rocket/lib/sync.h')
@:native("sync_device")
extern class SyncDevice { }

@:unreflective
@:structAccess
@:native("track_key")
extern class TrackKey { }

@:unreflective
@:structAccess
@:include('../lib/rocket/lib/track.h')
@:native("sync_track")
extern class SyncTrack { }