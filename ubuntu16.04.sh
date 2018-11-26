#!/usr/bin/env sh

set -euxo pipefail

sudo apt update
sudo apt install base-develop
sudo apt install llvm-5.0-dev libclang-5.0-dev clang-5.0

sudo apt install -y --no-install-recommends software-properties-common;
sudo apt-add-repository ppa:wpilib/toolchain
sudo apt update
sudo apt install -y --no-install-recommends frc-toolchain


curl https://sh.rustup.rs -sSf | sh
rustup toolchain install nightly
rustup default nightly

rustup target add arm-unknown-linux-gnueabi
rustup component add clippy-preview
cargo clippy --version
rustup component add rustfmt-preview
cargo fmt --version

mkdir -p "$HOME/.cargo/"
cat > "$HOME/.cargo/config" << EOF1
[target.arm-unknown-linux-gnueabi]
linker = "arm-frc-linux-gnueabi-gcc"
EOF1
