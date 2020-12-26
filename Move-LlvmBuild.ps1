Param(
    [string]$Configuration="Release",
    [string]$BuildName="x64-Release",
    [string]$BuildRoot=(Join-Path ($PSScriptRoot) "llvm-project" "llvm" "BuildOutput"))

$InformationPreference = "Continue"
$VerbosePreference = "Continue"

function Get-RelativePath ([string]$base, [string]$path)
{
    $rel = ""
    while ($path.StartsWith($base) -and ($path -ne $base))
    {
        if ($rel -eq "")
        {
            $rel = Split-Path $path -Leaf
        }
        else 
        {
            $rel = (Join-Path (Split-Path $path -Leaf) $rel)            
        }
        $path = Split-Path $path -Parent
    }
    return $rel
}

function Copy-Tree ([string]$source, [string]$dest, [string[]]$filter = @("*"), [string[]]$exclude = @())
{
    $items = Get-ChildItem $source -Recurse -Include $filter -Exclude $exclude | %{ Get-RelativePath $source $_ }
    ForEach ($itemSrc in $items)
    {
        $itemDest = Join-Path $dest $itemSrc
        $destDir = Split-Path $itemDest -Parent
        if (!(Test-Path $destDir))
        {
            Write-Verbose "Creating directory $($destDir)"
            New-Item -Path $destDir -ItemType "directory" -Force
        }
        Copy-Item -Path (Join-Path $source $itemSrc) -Destination $itemDest
    }
}

function Move-Tree ([string]$source, [string]$dest, [string[]]$filter = @("*"), [string[]]$exclude = @())
{
    $items = Get-ChildItem $source -Recurse -Include $filter -Exclude $exclude -Attributes !Directory | %{ Get-RelativePath $source $_ }
    ForEach ($itemSrc in $items)
    {
        $itemDest = Join-Path $dest $itemSrc
        $destDir = Split-Path $itemDest -Parent
        if (!(Test-Path $destDir))
        {
            Write-Verbose "Creating directory $($destDir)"
            New-Item -Path $destDir -ItemType "directory" -Force
        }
        Move-Item -Path (Join-Path $source $itemSrc) -Destination $itemDest -Verbose
    }
}

Write-Information "Moving LLVM build outputs to the expected location"

. $PSScriptRoot\buildutils.ps1

$destBase = (Join-Path $PSScriptRoot "llvm")

if (Test-Path $destBase) {
    Write-Verbose "Cleaning out the old data from $($destbase)"
    Remove-Item -Path $destbase -Recurse -Force | Out-Null
}

$sourceConfiguration = $Configuration
$libIncFilter = @("*")
$platform = Get-Platform
if ($platform -eq [platform]::Linux) {
    $sourceConfiguration = ""
    $libIncfilter = @("*.a")
} elseif ($platform -eq [platform]::Mac) {
    $sourceConfiguration = ""
    $libIncFilter = @("*.a", "*.dylib")
} elseif ($sourceConfiguration = "Release") {
    $sourceConfiguration = "RelWithDebInfo"
}


$libSource = (Join-Path ($BuildRoot) ($BuildName) ($sourceConfiguration) "lib")
$libDest = (Join-Path ($destBase) ($BuildName) ($Configuration) "lib")
Write-Verbose "Moving built libraries from $($libSource) to $($libDest)"
Move-Tree $libSource $libDest ($libIncFilter)

$incSource = (Join-Path ($BuildRoot) ($BuildName) "include")
$incDest = (Join-Path ($destbase) ($BuildName) "include")
$incFilter = @( '*.h', '*.gen', '*.def', '*.inc' )
Write-Verbose "Moving headers from $($incSource) to $($incDest)"
Move-Tree $incSource $incDest ($incFilter)

$inc2Source = (Join-Path (Split-Path $BuildRoot -Parent) "include")
$inc2Dest = (Join-Path ($destbase) "include")
$inc2Exclude = @( '*.txt')
Write-Verbose "Moving headers from $($inc2Source) to $($inc2Dest)"
Copy-Tree $inc2Source $inc2Dest -exclude ($inc2Exclude)

$cfgSource = (Join-Path $BuildRoot ($BuildName) "NATIVE" "include" "llvm" "Config")
$cfgDest = (Join-Path ($destbase) "include" "llvm" "Config")
Write-Verbose "Moving config headers from $($cfgSource) to $($cfgDest)"
Copy-Tree $cfgSource $cfgDest

Write-Verbose "Copying OrcCBindingsStack.h"
$orcSource = (Join-Path $PSScriptRoot "llvm-project" "llvm" "lib" "ExecutionEngine" "Orc" "OrcCBindingsStack.h")
$orcDest = (Join-Path ($destBase) "lib" "ExecutionEngine" "Orc")
if (!(Test-Path $orcDest))
{
    Write-Verbose "Creating directory $($orcDest)"
    New-Item -Path $orcDest -ItemType "directory" -Force
}
Copy-Item -Path $orcSource -Destination $orcDest -Force

Write-Verbose "Copying Llvm-Libs props and targets"
$llvmLibsProps = (Join-Path $PSScriptRoot "Llvm-Libs.props")
Copy-Item -Path $llvmLibsProps -Destination $destBase -Force
