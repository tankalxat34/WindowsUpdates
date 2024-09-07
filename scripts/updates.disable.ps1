Set-Location HKLM:

$path_WindowsUpdate = "HKLM:\HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate"
$path_WindowsUpdateAU = $path_WindowsUpdate + "\AU"

$path_Services = "HKLM:\HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services"

function DefaultLog {
    param (
        $Text
    )
    Write-Host -Object $Text -ForegroundColor DarkGray
}


function SetProp {
    param (
        $Path,
        $Prop,
        $Value,
        $DType
    )

    if (Get-ItemProperty -Path $Path -Name $Prop -ErrorAction Ignore) {
        Set-ItemProperty -Path $Path -Name $Prop -Value $Value
    } else {
        New-ItemProperty -Path $Path -Name $Prop -Value $Value -PropertyType $DType
    }
}


SetProp -Path $path_WindowsUpdate -Prop "DoNotConnectToWindowsUpdateInternetLocations"  -Value 1 -DType "DWord"
SetProp -Path $path_WindowsUpdate -Prop "UpdateServiceUrlAlternate"                     -Value "server.wsus" -DType "String"
SetProp -Path $path_WindowsUpdate -Prop "WUServer"                                      -Value "server.wsus" -DType "String"
SetProp -Path $path_WindowsUpdate -Prop "WUStatusServer"                                -Value "server.wsus" -DType "String"

SetProp -Path $path_WindowsUpdateAU -Prop "NoAutoUpdate" -Value 1 -DType "DWord"
SetProp -Path $path_WindowsUpdateAU -Prop "UseWUServer" -Value 1 -DType "DWord"

SetProp -Path "$($path_Services)\wuauserv"          -Prop "Start" -Value 4 -DType "DWord"
SetProp -Path "$($path_Services)\InstallService"    -Prop "Start" -Value 4 -DType "DWord"
SetProp -Path "$($path_Services)\UsoSvc"            -Prop "Start" -Value 4 -DType "DWord"

DefaultLog "Commited changes into regedit. Stopping services..."

Set-Location C:
Stop-Service -Name wuauserv -Force
Stop-Service -Name InstallService -Force
Stop-Service -Name UsoSvc -Force

DefaultLog "Services stopped"
Write-Host -Object "Windows updates has been disabled" -ForegroundColor Red