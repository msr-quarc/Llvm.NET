try
{
    . .\buildutils.ps1
    $buildInfo = Initialize-BuildEnvironment

    if ($env:OUTPUT_LLVM -eq "true") {
        Write-Host '##vso[task.logissue type=warning;]Exiting early after building LLVM'
        return
    }

    Write-Information 'Running Interop tests as x64'
    Invoke-DotNetTest $buildInfo 'src\Interop\InteropTests\InteropTests.csproj'
}
catch
{
    Write-Host "##vso[task.logissue type=error;]Invoke-InteropTests.ps1 failed: $($_.Exception.Message)"
    Write-Error $_.Exception.Message
}

