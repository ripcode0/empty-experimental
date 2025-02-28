#pragma once

#include <core/typedef.h>

namespace emt
{
class emt_api application
{
public:
    application(const application_create_info* info);

    int exec();
private:
    HWND m_hwnd;

};
} // namespace emt
