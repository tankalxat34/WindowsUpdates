# WindowsUpdates

PowerShell scripts and `regedit` configs to disable and enable Windows Updates

## How to use?

To disable updates open PowerShell with administrator rights and paste here command:
```powershell
irm https://raw.githubusercontent.com/tankalxat34/WindowsUpdates/main/scripts/updates.disable.ps1 | iex
```

Command to enable updates:
```powershell
irm https://raw.githubusercontent.com/tankalxat34/WindowsUpdates/main/scripts/updates.enable.ps1 | iex
```


If you see an error - please perform actons that listed below and try again:

1. Open PowerShell with administrator rights
2. Run the command `Set-ExecutionPolicy RemoteSigned -Force`
3. Confirm the execution by pressing "A" on the keyboard.

### Disable updates

1. Open PowerShell with administrator rights
2. Move into `.\scripts`
3. Perform command `powershell .\updates.disable.ps1`

### Enable updates

1. Open PowerShell with administrator rights
2. Move into `.\scripts`
3. Perform command `powershell .\updates.enable.ps1`
