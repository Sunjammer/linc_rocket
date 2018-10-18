#pragma once

//hxcpp include should always be first    
#ifndef HXCPP_H
#include <hxcpp.h>
#endif
#include "../lib/rocket/lib/device.h"
#include "../lib/rocket/lib/track.h"
#include "../lib/rocket/lib/sync.h"

//include other library includes as needed
// #include "../lib/____"

namespace linc {

    namespace rocket {

        extern int sync_update_helper(
            struct sync_device *d, 
            int row, 
            cpp::Pointer<cpp::Function<void (Dynamic,int)>> pause,
            cpp::Pointer<cpp::Function<void (Dynamic,int)>> set_row,
            cpp::Pointer<cpp::Function<int (Dynamic)>> is_playing,
            void *cb_param);
    } //rocket namespace

} //linc