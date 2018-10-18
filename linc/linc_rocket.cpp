//hxcpp include should be first
#include <hxcpp.h>
#include "./linc_rocket.h"

namespace linc {

    namespace rocket {
        static cpp::Function<void (Dynamic,int)> * Pause;
        static cpp::Function<void (Dynamic,int)> * Set_row;
        static cpp::Function<int (Dynamic)> * Is_playing;

        static void CallPause(void* d, int v){
            return Pause->call(d, v);
        }

        static void CallSetRow(void* d, int v){
            return Set_row->call(d, v);
        }

        static int CallIsPlaying(void* d){
            return Is_playing->call(d);
        }

        extern int sync_update_helper(
            struct sync_device *d, 
            int row, 
            cpp::Pointer<cpp::Function<void (Dynamic,int)>> pause,
            cpp::Pointer<cpp::Function<void (Dynamic,int)>> set_row,
            cpp::Pointer<cpp::Function<int (Dynamic)>> is_playing,
            void *cb_param
            )
        {
            Pause = pause;
            Set_row = set_row;
            Is_playing = is_playing;
            sync_cb cb = {
                &CallPause, 
                &CallSetRow, 
                &CallIsPlaying
            };
            return sync_update(d, row, &cb, cb_param);
        }
    } //rocket namespace

} //linc