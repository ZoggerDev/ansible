Export-ModuleMember -Function Start-MylifeWindowsUpdate
#Check Requierments:
# - PSWindowsUpdate installed
# - PSWindowsUpdate imported
# - Custom Functions import


function Import-Modules { #Copie of Nessesary files is handel bei Ansible
    $MandatoryModules = @(
        "PSWindowsUpdate"
    )

    foreach ($MandatoryModule in $MandatoryModules) {
        $Check = Get-Module -Name $MandatoryModule
        if ($false -eq $Check) {
            Import-Module -Name $MandatoryModule
        }
    }
}
    

function Test-Requierments {
    if ( $ModuleCheck.Count -eq 0 ) {
        Write-Host "PSWindowsUpdate Installed: " -NoNewline
        Write-Host "False" -ForegroundColor Red
        
        try {
            Install-Module PSWindowsUpdate -Scope CurrentUser -Force
        }
        catch {
            Write-Host "Could not install PSWindowsUpdate" -ForegroundColor Red
            Write-Host "Install PSWindowsUpdate manuel" -ForegroundColor Red
            Pause
            Exit
        }
    }
    else {
        Write-Host "PSWindowsUpdate Installed: " -NoNewline
        Write-Host "True" -ForegroundColor Green
    }

    Write-Host "I have everything I need" -ForegroundColor Green
    Start-Sleep -Seconds 2
}

function Start-MylifeWindowsUpdate {
    Write-Host "Start Module Import"
    Import-Modules
    Get-WindowsUpdate
}
#Setup Data:
# - Collect data
# - Create json

#Update (Every step is saved in json):
# - Get Updates
# - Start updates
# - setup after reboot event
# - reboot if nessessary

#Logs:
# - write log from json
# - clean up files
# - send report email 