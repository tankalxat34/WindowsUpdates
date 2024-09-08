# Disable or Enable Windows updates

PowerShell scripts and `regedit` configs to disable and enable Windows Updates

## How to use?

To disable updates open PowerShell with administrator rights and paste here command:
```cmd
irm bit.ly/win-updates-disable | iex
```

Command to enable updates:
```cmd
irm bit.ly/win-updates-enable | iex
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
