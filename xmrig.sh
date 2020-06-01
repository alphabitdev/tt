sudo apt-get -y install git build-essential cmake libuv1-dev libssl-dev libhwloc-dev automake libtool autoconf

cd ~ 

git clone https://github.com/alphabitdev/xmrig.git

cd ~/xmrig/scripts && ./build_deps.sh

cd ~
mkdir xmrig/build

cd xmrig/build
cmake .. -DXMRIG_DEPS=scripts/deps
make -j$(nproc)
ldd xmrig
h=$(hostname -f)
cp ~/tt/files/config.json ~/xmrig/build/config.json
sed "s/workerrrr/$h/" ~/xmrig/build/config.json
