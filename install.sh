#!/bin/bash


create_symlinks() {
    # Get the directory in which this script lives.
    script_dir=$(dirname "$(readlink -f "$0")")

    # Get a list of all files in this directory that start with a dot.
    files=$(find -maxdepth 1 -type f -name ".*")

    # Create a symbolic link to each file in the home directory.
    for file in $files; do
        name=$(basename $file)
        echo "Creating symlink to $name in home directory."
        rm -rf ~/$name
        ln -s $script_dir/$name ~/$name
    done
}

create_symlinks

echo "Installing fonts."
FONT_DIR="$HOME/.fonts"
git clone https://github.com/powerline/fonts.git $FONT_DIR --depth=1
cd $FONT_DIR
./install.sh

echo "Setting up the theme."
ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"
ln -s ./.tmux $HOME/.tmux
git clone https://github.com/ChesterYue/ohmyzsh-theme-passion.git "$ZSH_CUSTOM/themes/passion" --depth=1
ln -s "$ZSH_CUSTOM/themes/passion/passion.zsh-theme" "$ZSH_CUSTOM/themes/passion.zsh-theme"
git clone https://github.com/zsh-users/zsh-autosuggestions.git "$ZSH_CUSTOM/plugins/zsh-autosuggestions" --depth=1
ln -s "$ZSH_CUSTOM/plugins/zsh-autosuggestions" "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" --depth=1
ln -s "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"