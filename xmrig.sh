cd ~ 

git clone https://github.com/alphabitdev/xmrig.git

cd ~/xmrig/scripts && ./build_deps.sh

cd ~
mkdir xmrig/build

cd xmrig/build
cmake .. -DXMRIG_DEPS=scripts/deps
make -j$(nproc)
ldd xmrig
cp ~/tt/files/config.json ~/xmrig/build/config.json
sed "s/workerrrr/$HOSTNAME/" ~/tt/files/config.json > ~/xmrig/build/config.json
