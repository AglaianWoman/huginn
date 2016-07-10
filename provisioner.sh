# Show commands executed
set -x

# Setup swap file so it works better on lower memory VMs
fallocate -l 4G /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
echo "/swapfile   none    swap    sw    0   0" >> /etc/fstab

sysctl vm.swappiness=10
echo "vm.swappiness=10" >> /etc/sysctl.conf

useradd -s/bin/bash -m huginn

# Run the huginn docker container on port 3000, map the MySQL data to the host machine in /home/huginn/mysql-data
# So the data is persisted across runs/updates (handy)
docker run -i -p 80:3000 -v /home/huginn/mysql-data:/var/lib/mysql cantino/huginn
