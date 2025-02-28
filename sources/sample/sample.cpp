#include <iostream>
#include <vector>
#include <window/application.h>
#include <window/wnd.h>

int main(int args, char* argv[])
{
    emt::application_create_info info{};

    emt::application app(&info);

    emt::main_window wnd;

    const char* name  = wnd.get_name();

#ifdef __GNUC__
    printf("__GNUC__ detected\n");
    #ifdef __clang__
        printf("clang detected\n");
    #endif
#endif
    system("pause");
    return app.exec();
}