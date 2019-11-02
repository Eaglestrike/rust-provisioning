#!/usr/bin/env bash

set -euxo pipefail

cd "$HOME"

# Necessary packages
sudo apt update
sudo apt install -y curl unzip gcc

# Install Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
# Add ARM
export PATH="$PATH:$HOME/.cargo/bin"
rustup target add arm-unknown-linux-gnueabi

# Get ARM linker
curl -L https://github.com/wpilibsuite/toolchain-builder/releases/download/v2019-3/FRC-2019-Linux-Toolchain-6.3.0.tar.gz | tar -xvz
# Configure it
mkdir -p "$HOME/.cargo/"
cat >> "$HOME/.cargo/config" << EOF
[target.arm-unknown-linux-gnueabi]
linker = "~/frc2019/roborio/bin/arm-frc2019-linux-gnueabi-gcc"
EOF

# Get deploy tool
cargo install cargo-frc

mkdir project
cd project
curl -L https://github.com/Lytigas/first-rust-competition/raw/master/quickstart.zip > temp.zip
unzip temp.zip
rm temp.zip
sed -i 's/YOUR_NUMBER/114/g' Cargo.toml
cargo build
# will probably fail with no RIO found, but good to test it's installed
cargo frc deploy --release
