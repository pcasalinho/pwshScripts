$profiles =
    netsh wlan show profile |
    Select-String -Pattern 'All User Profile\s+:\s+(.*)' |
    ForEach-Object {
        $_.Matches.Groups[1].Value
    }

foreach ($profiles_i in $profiles) {
    netsh wlan show profile name=$profiles_i key=clear |
    Select-String -Pattern 'Key Content\s+:\s+(.*)' |
    ForEach-Object {
        'WiFi {0}: {1}' -f $profiles_i, $_.Matches.Groups[1].Value
    }
}
