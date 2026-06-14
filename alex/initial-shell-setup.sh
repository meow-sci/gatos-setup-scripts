#!/bin/sh

set -e

echo "Changing default shell to zsh for root user"
chsh -s /bin/zsh root

pkgs_to_install="starship"

echo "Installing packages: ${pkgs_to_install}"
apk update
apk add ${pkgs_to_install}

script_dir=$(dirname "$0")
mkdir -p ~/.config

echo "Setting up starship"
echo 'eval "$(starship init zsh)"' >> ~/.zshrc
cp "${script_dir}/starship.toml" ~/.config/starship.toml

echo "Installing and setting up atuin"
curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh -s -- --non-interactive
cp "${script_dir}/atuin_config.toml" ~/.config/atuin/config.toml
