#pragma once

// macros
#ifdef _MSC_VER
#define stdcall __stdcall
#elif defined(__clang__) || defined(__GNUC__)
#define stdcall __attribute__((stdcall))
#else
#define stdcall
#endif

// memory leak
#if defined(_DEBUG) && defined(_MSC_VER) 
#include <crtdbg.h>
#define emt_new new(_NORMAL_BLOCK, __FILE__, __LINE__)
#else
#define emt_new new
#endif

// discard
#define safe_delete(x) { if((x)) { delete (x); (x) = nullptr; } }
#define safe_release(x) { if((x)) { (x)->Release(); (x) = nullptr; } }
#define emt_release(x) if(x) { x->release();}

// export
// #ifdef DLL_EXPORT
// #define emt_api __declspec(dllexport)
// #else
// #define emt_api __declspec(dllimport)
// #endif

#ifdef EMT_SHARED_LIB
    #ifdef EMT_EXPORT_DLL
        #define emt_api __declspec(dllexport)
    #else
        #define emt_api __declspec(dllimport)
    #endif
#else
    #define emt_api
#endif


