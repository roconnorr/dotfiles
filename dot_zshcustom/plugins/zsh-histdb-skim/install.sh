#!/bin/bash
cargo build --release
mkdir -p ~/.local/bin
mv target/release/zsh-histdb-skim ~/.local/bin/zsh-histdb-skim
