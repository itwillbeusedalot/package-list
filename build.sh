dpkg-query -W --showformat='${Installed-Size}\t${Package}\n' | awk '{printf "%10.2f MB \t%s\n", $1/1024, $2}' | sort -n
