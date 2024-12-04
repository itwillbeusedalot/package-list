uname -a

cat /etc/*ease

dpkg-query -W --showformat='${Installed-Size}\t${Package}\n' | awk '{printf "%10.2f MB \t%s\n", $1/1024, $2}' | sort -n

dpkg-query -Wf '${Installed-Size}\t${Package}\n' | sort -n > package_list.txt


df -h
