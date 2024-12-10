uname -a
cat /etc/*ease

dpkg-query -W --showformat='${Installed-Size}\t${Package}\n' | awk '{printf "%10.2f MB \t%s\n", $1/1024, $2}' | sort -n > package_list_size_in_MB.txt

dpkg-query -Wf '${Installed-Size}\t${Package}\n' | sort -n > package_list_size_in_bytes.txt

PACKAGES_TO_KEEP="apparmor apt dbus e2fsprogs netbase sudo systemd systemd-resolved systemd-sysv udev"

# Get all installed packages
PACKAGES_TO_KEEP="apparmor apt dbus e2fsprogs netbase sudo systemd systemd-resolved systemd-sysv udev"

# Get all installed packages
INSTALLED_PACKAGES=$(dpkg-query -W -f='${Package}\n')

# Remove packages not in the list
for package in $INSTALLED_PACKAGES; do
  if ! echo "$PACKAGES_TO_KEEP" | grep -q "$package"; then
     apt purge -y --allow-remove-essential "$package"
  fi
done

# Remove any remaining unnecessary packages
apt autoclean -y
apt clean

dpkg-query -Wf '${Installed-Size}\t${Package}\n' > purge_list_essential.txt

