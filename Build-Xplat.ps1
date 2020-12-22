Push-Location $PSScriptRoot
$oldPath = $env:Path
try
{
    . .\buildutils.ps1
    $buildInfo = Initialize-BuildEnvironment

    .\Build-Llvm.ps1

    .\Move-LlvmBuild.ps1

    .\Build-LibLlvm.ps1

    $plat = Get-Platform
    if ($plat -ne [platform]::Windows) {
        # Clean up to avoid propagating LLVM build to later pipeline steps.
        Remove-Item -Recurse -Force $buildInfo["BuildOutputPath"]
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
