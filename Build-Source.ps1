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

    .\Move-LlvmBuild.ps1

    $plat = Get-Platform
    if ($plat -eq [platform]::Windows) {

        .\Build-Interop.ps1

        .\Build-DotNet.ps1

        .\Pack-NuGet.ps1
    }
}
catch
{
    Write-Host "##vso[task.logissue type=error;]Build-Source.ps1 failed: $($_.Exception.Message)"
    Write-Error "Build-Source.ps1 failed: $($_.Exception.Message)"
}
finally
{
    Pop-Location
    $env:Path = $oldPath
}
