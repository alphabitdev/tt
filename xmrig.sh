sudo apt-get install git build-essential cmake libuv1-dev libssl-dev libhwloc-dev automake libtool autoconf

cd ~ 

git clone https://github.com/xmrig/xmrig.git

cd ~/xmrig/scripts && ./build_deps.sh

cd ~
mkdir xmrig/build

cd xmrig/build
cmake .. -DXMRIG_DEPS=scripts/deps
make -j$(nproc)
ldd xmrig

cp ~/tt/files/config.json ~/xmrig/build/config.json
sed "s/worker/$HOSTNAME/" ~/xmrig/build/config.json
