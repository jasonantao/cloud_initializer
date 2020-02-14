user=$1
echo "Grant User $1 Sudo Access"
echo "$user    ALL=(ALL)       ALL" >> /etc/sudoers
