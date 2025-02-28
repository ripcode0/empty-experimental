#pragma once

#include <core/typedef.h>

namespace emt
{
class emt_api wnd
{
public:
    wnd(wnd* parent, uint cx, uint cy);
    virtual~wnd();
    
    wnd* m_parent{};
    HWND m_hwnd;

    const char* get_name();
};

class emt_api main_window : public wnd
{
public:
    main_window();
};

} // namespace emt
