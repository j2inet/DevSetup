// v8monolithlinktest.cpp : This file contains the 'main' function. Program execution begins and ends there.
//
#define _ITERATOR_DEBUG_LEVEL 0
#define V8_COMPRESS_POINTERS
//#define V8_ENABLE_SANDBOX_BOOL true
#define V8_ENABLE_CHECKS true
#include <iostream>
#include <libplatform/libplatform.h>
#include <v8-context.h>
#include <v8-initialization.h>
#include <v8-isolate.h>
#include <v8-local-handle.h>
#include <v8-primitive.h>
#include <v8-script.h>


#pragma comment(lib, "v8_monolith.lib")
#pragma comment(lib, "WinMM.lib")

int main(int argc, char** argv)
{
	v8::V8::InitializeExternalStartupData(argv[0]);
	std::unique_ptr<v8::Platform> platform = v8::platform::NewSingleThreadedDefaultPlatform();
	v8::V8::InitializePlatform(platform.get());
	v8::V8::Initialize();
	v8::Isolate::CreateParams create_params;
	v8::V8::Dispose();
	v8::V8::DisposePlatform();
	delete create_params.array_buffer_allocator;
	return 0;
}
