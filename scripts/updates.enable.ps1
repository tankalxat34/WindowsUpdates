Set-Location HKLM:
$path_BasePath_WindowsUpdate = "HKLM:\HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows"
$path_WindowsUpdate = "$($path_BasePath_WindowsUpdate)\WindowsUpdate"
$path_WindowsUpdateAU = "$($path_WindowsUpdate)\AU"

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

if ( -not (Test-Path -Path $path_WindowsUpdate)) {
    New-Item -Path $path_BasePath_WindowsUpdate -Name "WindowsUpdate"
} else {
    Remove-Item -Path $path_WindowsUpdate -Recurse
    New-Item -Path $path_BasePath_WindowsUpdate -Name "WindowsUpdate"
}

if ( -not (Test-Path -Path $path_WindowsUpdateAU)) {
    New-Item -Path $path_WindowsUpdate -Name "AU"
} else {
    Remove-Item -Path $path_WindowsUpdateAU -Recurse
    New-Item -Path $path_WindowsUpdate -Name "AU"
}




SetProp -Path $path_WindowsUpdate -Prop "DoNotConnectToWindowsUpdateInternetLocations"  -Value 0 -DType "DWord"
SetProp -Path $path_WindowsUpdate -Prop "UpdateServiceUrlAlternate"                     -Value "" -DType "String"
SetProp -Path $path_WindowsUpdate -Prop "WUServer"                                      -Value "" -DType "String"
SetProp -Path $path_WindowsUpdate -Prop "WUStatusServer"                                -Value "" -DType "String"

SetProp -Path $path_WindowsUpdateAU -Prop "NoAutoUpdate"    -Value 0 -DType "DWord"
SetProp -Path $path_WindowsUpdateAU -Prop "UseWUServer"     -Value 0 -DType "DWord"

SetProp -Path "$($path_Services)\wuauserv"          -Prop "Start" -Value 2 -DType "DWord"
SetProp -Path "$($path_Services)\UsoSvc"            -Prop "Start" -Value 2 -DType "DWord"
SetProp -Path "$($path_Services)\InstallService"    -Prop "Start" -Value 2 -DType "DWord"

DefaultLog "Commited changes into regedit. Restarting services"

Set-Location C:
Restart-Service -Name wuauserv
Restart-Service -Name InstallService
Restart-Service -Name UsoSvc

DefaultLog "Services restarted"
Write-Host -Object "Windows updates has been enabled" -ForegroundColor Green
