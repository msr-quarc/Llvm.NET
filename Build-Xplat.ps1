Push-Location $PSScriptRoot
$oldPath = $env:Path
try
{
    . .\buildutils.ps1
    $buildInfo = Initialize-BuildEnvironment

    if ($env:BUILD_LLVM -eq "true") {
        .\Build-Llvm.ps1 -Configuration MinSizeRel
    }

    .\Move-LlvmBuild.ps1 -Configuration MinSizeRel

    if ($env:BUILD_LLVM -ne "true") {
        .\Build-LibLlvm.ps1
    }
}
catch
{
    Write-Host "##vso[task.logissue type=error;]Build-Xplat.ps1 failed: $($_.Exception.Message)"
    Write-Error "Build-Xplat.ps1 failed: $($_.Exception.Message)"
}
finally
{
    Pop-Location
    $env:Path = $oldPath
}
