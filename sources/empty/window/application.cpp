#include "application.h"
#include <window/window_config.h>

namespace emt
{
    application::application(const application_create_info *info)
    {

    }

    int application::exec()
    {
        MSG msg{};

        while (::PeekMessage(&msg, nullptr, 0, 0, PM_REMOVE))
        {
            ::TranslateMessage(&msg);
            ::DispatchMessage(&msg);
        }
        
        return static_cast<int>(msg.lParam);
    }

} // namespace emt

