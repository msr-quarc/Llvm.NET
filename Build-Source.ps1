Param(
    [string]$Configuration="Release",
    [switch]$AllowVsPreReleases
)

Push-Location $PSScriptRoot
$oldPath = $env:Path
try
{
    . .\buildutils.ps1
    $buildInfo = Initialize-BuildEnvironment

    $packProperties = @{ version=$($buildInfo['PackageVersion'])
                         llvmversion=$($buildInfo['LlvmVersion'])
                         buildbinoutput=(Join-path $($buildInfo['BuildOutputPath']) 'bin')
                         configuration=$Configuration
                       }

    $msBuildProperties = @{ Configuration = $Configuration
                            LlvmVersion = $buildInfo['LlvmVersion']
                          }

    .\Build-Llvm.ps1

    .\Build-Interop.ps1

    .\Build-DotNet.ps1

    .\Pack-NuGet.ps1
}
catch
{
    Write-Error $_.Exception.Message
}
finally
{
    Pop-Location
    $env:Path = $oldPath
}
