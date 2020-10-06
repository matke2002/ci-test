# example run: powershell -ExecutionPolicy Bypass -File .\find-change-and-increment-version.ps1 -ConfigFilePath "CorningEagleEye.DataAccess/CorningEagleEye.DataAccess.csproj"

param(
	$ConfigFilePath
)

function Does-Changes-Exist {
	Write-output "T1" > $null
	$git_diff = "git diff --name-only --relative -- *.cs" 
	$result = Invoke-Expression $git_diff # | Measure-Object -Line -Character -Word
	$cnt = $result.length #Measure-Object -Line -Character -Word $result
	Write-output "promene: $cnt" > $null
	if ($cnt -gt 0) {
		return $true
	}
	return $false
}

function Is-Version-The-Same  {
	param (
        [String] $CurrentVersion
    )

	# $git_diff = "git diff --relative -U0 " 
	$git_show_current_branch = "git branch --show-current"
	$current_branch =  Invoke-Expression $git_show_current_branch
	$git_show_orig_csproj = "git show ${current_branch}:${ConfigFilePath}"
	$orig_csproj = Invoke-Expression $git_show_orig_csproj      # | Measure-Object -Line -Character -Word
	Write-output "u verzijama" > $null      # "promene: $result"
	[XML]$xml_orig_csproj = $orig_csproj
	$OrigVersion = $xml_orig_csproj.Project.PropertyGroup.Version
	#Write-output "orig verz: $OrigVersion"
	if ($CurrentVersion -eq $OrigVersion) {
	#	Write-output "obe verzije su iste: $OrigVersion"
		return $true
	}
	else {
	#	Write-output "verzije se razlikuju: orig - $OrigVersion ; nova - CurrentVersion"
		return $false
	}
}


$does_exist = Does-Changes-Exist
Write-output "does change in .cs exist?  $does_exist"

if ( $does_exist -eq $true ) {
	$XMLfile = $ConfigFilePath
	[XML]$empDetails = Get-Content $XMLfile

	$version = $empDetails.Project.PropertyGroup.Version
	$is_same_version = Is-Version-The-Same -CurrentVersion $version
	Write-output "same lib version?  $is_same_version"
	if ( $is_same_version -eq $true) {
		$ver = [version]($version | Select -First 1)
		$newVersion = "{0}.{1}.{2}" -f $ver.Major, $ver.Minor, ($ver.Build + 1)
		# $newVersion | Set-Content $file
		Write-output "old version $ver   new version $newVersion"
		$empDetails.Project.PropertyGroup.Version = $newVersion
		$empDetails.save($XMLfile)
	}
}
