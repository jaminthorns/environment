function windows_open -a path
    powershell.exe "Invoke-Item '$(wslpath -m $path)'"
end
