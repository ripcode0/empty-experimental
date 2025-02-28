#pragma once

#include <stdint.h>
#include <core/defines.h>


typedef unsigned char   uint8, byte; 
typedef unsigned int    uint, uint32;
typedef uint64_t uint64;

//============ OpenGL4 Foward Decalre =============
struct	HWND__;
typedef HWND__ *HWND;
struct HDC__;
typedef HDC__ *HDC;
struct HGLRC__;
typedef HGLRC__ *HGLRC;
typedef unsigned int GLuint;
typedef float GLfloat;
typedef signed char GLbyte;
typedef short GLshort;
typedef int GLint;
typedef int GLsizei;
typedef unsigned int GLenum;

#if defined(_WIN64)
typedef signed long long int GLintptr;
typedef unsigned long long int GLuintptr;
#else
typedef signed long int GLintptr;
typedef unsigned long int GLuintptr;
#endif

// ---------- types ----------

namespace emt
{
    struct application_create_info
    {
        uint cx;
        uint cy;
        const char* title;

        /* data */
    };
    
} // namespace emt
