(for /f "tokens=4 " %i in ('route print^|findstr "0.0.0.0.*0.0.0.0"') do @echo %i && hostname && whoami && echo) >> \\192.168.9.30\Scan\汇总数据\userConfig.txt
