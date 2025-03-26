// MinAwsProject.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#undef USE_IMPORT_EXPORT
#include <aws/core/Aws.h>
#include <aws/core/utils/threading/Executor.h>
#include <aws/core/utils/memory/AWSMemory.h>
#include <aws/core/utils/memory/stl/AWSStreamFwd.h>
#include <aws/core/utils/stream/PreallocatedStreamBuf.h>
#include <aws/core/utils/StringUtils.h>
#include <aws/transfer/TransferManager.h>
#include <aws/transfer/TransferHandle.h>
#include <aws/s3/S3Client.h>
#include <Windows.h>
#include <locale>
#include <codecvt>
#include <iostream>



#pragma comment(lib, "aws-cpp-sdk-core.lib")
#pragma comment(lib, "aws-c-auth.lib")
#pragma comment(lib, "aws-c-cal.lib")
#pragma comment(lib, "aws-c-common.lib")
#pragma comment(lib, "aws-c-compression.lib")
#pragma comment(lib, "aws-c-event-stream.lib")
#pragma comment(lib, "aws-checksums.lib")
#pragma comment(lib, "aws-c-http.lib")
#pragma comment(lib, "aws-c-io.lib")
#pragma comment(lib, "aws-c-mqtt.lib")
#pragma comment(lib, "aws-cpp-sdk-core.lib")
#pragma comment(lib, "aws-crt-cpp.lib")
#pragma comment(lib, "aws-c-s3.lib")
#pragma comment(lib, "aws-c-sdkutils.lib")

#pragma comment(lib, "aws-c-s3.lib")
#pragma comment(lib, "aws-c-common.lib")
#pragma comment(lib, "aws-crt-cpp.lib")
#pragma comment(lib, "aws-cpp-sdk-s3.lib")
#pragma comment(lib, "aws-cpp-sdk-s3-encryption.lib")
#pragma comment(lib, "aws-cpp-sdk-s3-crt.lib")
#pragma comment(lib, "aws-cpp-sdk-transfer.lib")

#pragma comment(lib, "Ws2_32.lib")
#pragma comment(lib, "Userenv.lib")
#pragma comment(lib, "Version.lib")
#pragma comment(lib, "Wininet.lib")
#pragma comment(lib, "Winhttp.lib")
#pragma comment(lib, "Bcrypt.lib")
#pragma comment(lib, "Shlwapi.lib")
#pragma comment(lib, "Crypt32.lib")
#pragma comment(lib, "Secur32.lib")
#pragma comment(lib, "Ncrypt.lib")
void SaveFileToS3(std::wstring fileName, std::wstring bucket, std::wstring key, std::wstring mimeType);



int main()
{
    Aws::SDKOptions options;
    options.loggingOptions.logLevel = Aws::Utils::Logging::LogLevel::Info;
    Aws::InitAPI(options);
    Aws::ShutdownAPI(options);
}


void SaveFileToS3(std::wstring fileName, std::wstring bucket, std::wstring key, std::wstring mimeType)
{

    Aws::SDKOptions options;
    options.loggingOptions.logLevel = Aws::Utils::Logging::LogLevel::Info;
    Aws::InitAPI(options);

    std::wstring_convert<std::codecvt_utf8_utf16<wchar_t>> converter;
    Aws::String awsFileName = converter.to_bytes(fileName);
    Aws::String awsMimeType = converter.to_bytes(mimeType);
    Aws::String awsKey = converter.to_bytes(key);
    Aws::String awsBucket = converter.to_bytes(bucket);
    auto configuration = Aws::Client::ClientConfiguration();
    auto signingPolicy = Aws::Client::AWSAuthV4Signer::PayloadSigningPolicy::Never;
    auto s3_client = Aws::MakeShared<Aws::S3::S3Client>("S3Client");
    auto executor = Aws::MakeShared<Aws::Utils::Threading::PooledThreadExecutor>("executor", 25);
    Aws::Transfer::TransferManagerConfiguration transfer_config(executor.get());
    transfer_config.s3Client = s3_client;

    auto transfer_manager = Aws::Transfer::TransferManager::Create(transfer_config);
    auto uploadHandle = transfer_manager->UploadFile(
        awsFileName,
        awsBucket,
        awsKey,
        awsMimeType,
        Aws::Map<Aws::String, Aws::String>()
    );
    uploadHandle->WaitUntilFinished();
    bool success = uploadHandle->GetStatus() == Aws::Transfer::TransferStatus::COMPLETED;
    Aws::ShutdownAPI(options);

}