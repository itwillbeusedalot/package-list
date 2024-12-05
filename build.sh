uname -a

cat /etc/*ease

dpkg-query -W --showformat='${Installed-Size}\t${Package}\n' | awk '{printf "%10.2f MB \t%s\n", $1/1024, $2}' | sort -n > package_list_size_in_MB.txt

dpkg-query -Wf '${Installed-Size}\t${Package}\n' | sort -n > package_list_size_in_bytes.txt


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
pwd
cat total_size.txt

du -sh /* 2>/dev/null | sort -rh
