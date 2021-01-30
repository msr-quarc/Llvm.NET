Param(
    [string]$Configuration="Release",
    [switch]$AllowVsPreReleases
)

Push-Location $PSScriptRoot
$oldPath = $env:Path
try
{
    . ./buildutils.ps1
    $buildInfo = Initialize-BuildEnvironment

    $msBuildProperties = @{ Configuration = $Configuration
                            LlvmVersion = $buildInfo['LlvmVersion']
                          }

    $buildLogPath = Join-Path $buildInfo['BinLogsPath'] Ubiquity.ArgValidators.binlog
    Write-Information "Building Ubiquity.ArgValidators"
    Invoke-MSBuild -Targets "Restore;Build" -Project src/Argument.Validators/Ubiquity.ArgValidators.csproj -Properties $msBuildProperties -LoggerArgs ($buildInfo['MsBuildLoggerArgs'] + @("/bl:$buildLogPath") )
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

Write-Information "Done build"
