git diff @~..@ --name-only --relative -- *.cs
prvi
drugi
powershell -ExecutionPolicy Bypass -File .\find-change-and-increment-version.ps1 -ConfigFilePath "azure_pipeline/fajl.ver"
set AZURE_PIPELINE=TRUE