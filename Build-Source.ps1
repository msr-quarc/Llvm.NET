Push-Location $PSScriptRoot
$oldPath = $env:Path
try
{
    . .\buildutils.ps1
    $buildInfo = Initialize-BuildEnvironment

    .\Build-Interop.ps1

    Remove-Item -Force -Recurse -Path (Join-Path $buildInfo["BuildOutputPath"] bin)

    .\Build-DotNet.ps1

    .\Pack-NuGet.ps1
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
