# executed as user root
echo 'export LFS=/mnt/lfs' >> ~/.bashrc

source ~/.bashrc

echo $LFS

mkdir -pv $LFS

mount -v -t ext4 /dev/<xxx> $LFS

mkdir -v $LFS/sources

chmod -v a+wt $LFS/sources
