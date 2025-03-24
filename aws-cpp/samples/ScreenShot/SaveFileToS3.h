#pragma once
#include <string>


void SaveFileToS3(std::wstring fileName, std::wstring bucket, std::wstring key, std::wstring mimeType);
