. .\buildutils.ps1
$buildInfo = Initialize-BuildEnvironment

# Push-Location $buildInfo['NuGetOutputPath']
# Compress-Archive -Force -Path *.* -DestinationPath (join-path $buildInfo['ArtifactDrops'] Nuget.Packages.zip)
$dest = Join-Path $buildInfo['ArtifactDrops'] (Split-Path $buildInfo['NugetOutputPath'] -Leaf)
if (Test-Path $dest) {
    Remove-Item -Recurse -Force $dest
}
Move-Item -Force -Path $buildInfo['NugetOutputPath'] -Destination $buildInfo['ArtifactDrops']
# Pop-Location
