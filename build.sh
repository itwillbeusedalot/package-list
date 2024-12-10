uname -a
cat /etc/*ease

dpkg-query -W --showformat='${Installed-Size}\t${Package}\n' | awk '{printf "%10.2f MB \t%s\n", $1/1024, $2}' | sort -n > package_list_size_in_MB.txt

dpkg-query -Wf '${Installed-Size}\t${Package}\n' | sort -n > package_list_size_in_bytes.txt

apt purge -y --allow-remove-essential libaudit-common
apt purge -y --allow-remove-essential libsemanage-common
apt purge -y --allow-remove-essential ubuntu-keyring
apt purge -y --allow-remove-essential libdebconfclient0
apt purge -y --allow-remove-essential libnpth0t64
apt purge -y --allow-remove-essential hostname
apt purge -y --allow-remove-essential logsave
apt purge -y --allow-remove-essential libcom-err2
apt purge -y --allow-remove-essential libattr1
apt purge -y --allow-remove-essential libcap-ng0
apt purge -y --allow-remove-essential sensible-utils
apt purge -y --allow-remove-essential libss2
apt purge -y --allow-remove-essential libffi8
apt purge -y --allow-remove-essential libacl1
apt purge -y --allow-remove-essential libmd0
apt purge -y --allow-remove-essential libuuid1
apt purge -y --allow-remove-essential libxxhash0
apt purge -y --allow-remove-essential libbz2-1.0
apt purge -y --allow-remove-essential libcap2
apt purge -y --allow-remove-essential libassuan0
apt purge -y --allow-remove-essential sysvinit-utils
apt purge -y --allow-remove-essential gcc-14-base
apt purge -y --allow-remove-essential libtasn1-6
apt purge -y --allow-remove-essential init-system-helpers
apt purge -y --allow-remove-essential libseccomp2
apt purge -y --allow-remove-essential libaudit1
apt purge -y --allow-remove-essential liblz4-1
apt purge -y --allow-remove-essential zlib1g
apt purge -y --allow-remove-essential libsmartcols1
apt purge -y --allow-remove-essential libgpg-error0
apt purge -y --allow-remove-essential dash
apt purge -y --allow-remove-essential libgcc-s1
apt purge -y --allow-remove-essential libselinux1
apt purge -y --allow-remove-essential libpam0g
apt purge -y --allow-remove-essential debianutils
apt purge -y --allow-remove-essential libidn2-0
apt purge -y --allow-remove-essential libcrypt1
apt purge -y --allow-remove-essential libproc2-0
apt purge -y --allow-remove-essential gzip
apt purge -y --allow-remove-essential base-passwd
apt purge -y --allow-remove-essential libpam-modules-bin
apt purge -y --allow-remove-essential mawk
apt purge -y --allow-remove-essential libpam-runtime
apt purge -y --allow-remove-essential bsdutils
apt purge -y --allow-remove-essential libsemanage2
apt purge -y --allow-remove-essential libblkid1
apt purge -y --allow-remove-essential libudev1
apt purge -y --allow-remove-essential gpgv
apt purge -y --allow-remove-essential libhogweed6t64
apt purge -y --allow-remove-essential sed
apt purge -y --allow-remove-essential grep
apt purge -y --allow-remove-essential mount
apt purge -y --allow-remove-essential libmount1
apt purge -y --allow-remove-essential liblzma5
apt purge -y --allow-remove-essential ncurses-base
apt purge -y --allow-remove-essential libncursesw6
apt purge -y --allow-remove-essential libnettle8t64
apt purge -y --allow-remove-essential base-files
apt purge -y --allow-remove-essential diffutils
apt purge -y --allow-remove-essential debconf
apt purge -y --allow-remove-essential libext2fs2t64
apt purge -y --allow-remove-essential libgmp10
apt purge -y --allow-remove-essential findutils
apt purge -y --allow-remove-essential libtinfo6
apt purge -y --allow-remove-essential libpcre2-8-0
apt purge -y --allow-remove-essential ncurses-bin
apt purge -y --allow-remove-essential tar
apt purge -y --allow-remove-essential libsepol2
apt purge -y --allow-remove-essential libzstd1
apt purge -y --allow-remove-essential login
apt purge -y --allow-remove-essential libsystemd0
apt purge -y --allow-remove-essential libpam-modules
apt purge -y --allow-remove-essential libgcrypt20
apt purge -y --allow-remove-essential e2fsprogs
apt purge -y --allow-remove-essential libp11-kit0
apt purge -y --allow-remove-essential libunistring5
apt purge -y --allow-remove-essential libdb5.3t64
apt purge -y --allow-remove-essential procps
apt purge -y --allow-remove-essential bash
apt purge -y --allow-remove-essential libc-bin
apt purge -y --allow-remove-essential libgnutls30t64
apt purge -y --allow-remove-essential passwd
apt purge -y --allow-remove-essential libstdc++6
apt purge -y --allow-remove-essential libapt-pkg6.0t64
apt purge -y --allow-remove-essential util-linux
apt purge -y --allow-remove-essential apt
apt purge -y --allow-remove-essential dpkg
apt purge -y --allow-remove-essential libssl3t64
apt purge -y --allow-remove-essential coreutils
apt purge -y --allow-remove-essential perl-base
apt purge -y --allow-remove-essential libc6


dpkg-query -Wf '${Installed-Size}\t${Package}\n' | sort -n > purge_list.txt

df -h

# Initialize total size variable
total_size=0
# Function to calculate size
calculate_size() {
    # Use find to iterate over files, ignoring virtual filesystems and permission errors
    while IFS= read -r -d '' file; do
        # Get the size of the file and add it to total_size
        size=$(stat --format="%s" "$file" 2>/dev/null)
        total_size=$((total_size + size))
    done < <(find / -xdev -type f -print0 2>/dev/null)
    echo "Total size of files: $total_size bytes"
}
# Call the function
calculate_size > total_size.txt
ls -la
cat total_size.txt

du -sh /* 2>/dev/null | sort -rh

cat purge_list.txt
