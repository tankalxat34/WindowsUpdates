# WindowsUpdates

PowerShell scripts and `rededit` configs to disable and enable Windows Updates

## How to use?

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