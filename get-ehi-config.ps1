(for /f "tokens=4 " %i in ('route print^|findstr "0.0.0.0.*0.0.0.0"') do @echo %i | findstr \. && hostname && whoami && echo ---------------- ) >> \\192.168.9.30\Scan\汇总数据\userConfig.txt

echo hostname >> \\192.168.9.30\Scan\汇总数据\userConfig.txt
for ($i = 1; $i -le ($a.count / 4); $i++) {
    $ip = $a | Select -Index (4 * $i - 4)
    $user = $a | select -Index (4 * $i - 2)
}