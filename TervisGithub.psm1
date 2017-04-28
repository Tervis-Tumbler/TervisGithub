function Get-TervisGithubPowerShellModules {
    Invoke-GithubSearch -Uri "https://api.github.com/search/repositories?q=language:powershell+user:tervis-tumbler&sort=updated&order=desc&per_page=100"
}

function Invoke-GithubSearch {
    param (
        $Uri
    )
    $Response = Invoke-WebRequest -UseBasicParsing -Uri $Uri
    
    $Response |
    select -ExpandProperty Content | 
    ConvertFrom-Json |
    select -ExpandProperty Items

    $NextLink = $Response.Headers.Link | ConvertFrom-HTTPLinkHeader | where Name -EQ next
    if ($NextLink) {
        Invoke-GithubSearch -Uri $NextLink.URL
    }
}

function Invoke-TervisGithubPowerShellModulesSync {
    [CmdletBinding()]
    param(
        $PowerShellModulesPath = (Get-UserPSModulePath)
    )
    Set-Location $PowerShellModulesPath
    $TervisPowerShellGitHubRepositories = Get-TervisGithubPowerShellModules

    foreach($TervisPowerShellGitHubRepository in $TervisPowerShellGitHubRepositories) {
        $TervisPowerShellGitHubRepository.Name
        if (Test-Path $TervisPowerShellGitHubRepository.Name) {
            Write-Verbose "Pulling $TervisPowerShellGitHubRepository.Name"
            Push-Location $TervisPowerShellGitHubRepository.Name
            git pull
            Pop-Location
        } else {
            Write-Verbose "Cloning $TervisPowerShellGitHubRepository.Name"
            git clone $($TervisPowerShellGitHubRepository.clone_url)
        }
    }
}

Function Get-UserPSModulePath {
    if ($env:PSMODULEPATH -match ":") { 
        ($env:PSMODULEPATH -split ";")[0]
    } else {
        ($env:PSMODULEPATH -split ":")[0]
    }
}
