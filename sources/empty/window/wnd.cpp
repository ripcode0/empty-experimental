#include "wnd.h"
#include <window/window_config.h>
namespace emt
{
    wnd::wnd(wnd* parent, uint cx, uint cy)
        : m_parent(parent)
    {
    }

    wnd::~wnd()
    {
        ::DestroyWindow(m_hwnd);
    }

    const char *wnd::get_name()
    {
        return "window";
    }

    main_window::main_window()
        : wnd(nullptr, 100, 100)
    {
    }

} // namespace emt
