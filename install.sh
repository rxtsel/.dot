#!/bin/bash

INTERRUPTED=false
EXIT_STATUS=0
AUR_HELPER="paru"

on_exit() {
  if [ "$INTERRUPTED" = true ]; then
    echo -e "\n${YELLOW}[WARN]${RESET} Script interrupted by user (Ctrl+C)."
  elif [ "$EXIT_STATUS" -eq 0 ]; then
    cat <<"EOF"



──────▄▀▄─────▄▀▄
─────▄█░░▀▀▀▀▀░░█▄
─▄▄──█░░░░░░░░░░░█──▄▄
█▄▄█─█░░▀░░┬░░▀░░█─█▄▄█

Enjoy your new setup! 🎉
EOF
  else
    echo -e "\n${RED}[ERROR]${RESET} Script failed. No changes were fully applied."
  fi
}

on_interrupt() {
  INTERRUPTED=true
  EXIT_STATUS=130
  exit 130
}

trap 'EXIT_STATUS=$?; on_exit' EXIT
trap on_interrupt INT

cat <<"EOF"

█▄▄▄▄     ▄     ▄▄▄▄▀ ▄▄▄▄▄   ▄███▄   █         ▄█    ▄      ▄▄▄▄▄      ▄▄▄▄▀ ██   █    █     
█  ▄▀ ▀▄   █ ▀▀▀ █   █     ▀▄ █▀   ▀  █         ██     █    █     ▀▄ ▀▀▀ █    █ █  █    █     
█▀▀▌    █ ▀      █ ▄  ▀▀▀▀▄   ██▄▄    █         ██ ██   █ ▄  ▀▀▀▀▄       █    █▄▄█ █    █     
█  █   ▄ █      █   ▀▄▄▄▄▀    █▄   ▄▀ ███▄      ▐█ █ █  █  ▀▄▄▄▄▀       █     █  █ ███▄ ███▄  
  █   █   ▀▄   ▀              ▀███▀       ▀      ▐ █  █ █              ▀         █     ▀    ▀ 
 ▀     ▀                                           █   ██                       █             
                                                                               ▀              
EOF

# ANSI colors
RED='\033[31m'
GREEN='\033[32m'
YELLOW='\033[33m'
RESET='\033[0m'
BLUE='\033[34m'

# For spaces
PADDING="%-8s"

log() {
  printf "$PADDING %s\n" "[*]" "$1"
}

success() {
  printf "${GREEN}$PADDING${RESET} %s\n" "[OK]" "$1"
}

error() {
  printf "${RED}$PADDING${RESET} %s\n" "[ERROR]" "$1" >&2
}

warn() {
  printf "${YELLOW}$PADDING${RESET} %s\n" "[WARN]" "$1"
}

info() {
  printf "${BLUE}$PADDING${RESET} %s\n" "[INFO]" "$1"
}

prompt() {
  local message="$1"
  local arg="$2"
  printf "${YELLOW}$PADDING${RESET} %s" "[?]" "$message [$arg]: "
}

# Flow
install_base_packages() {
  info "Installing essential system packages..."
  sudo pacman -Syyu --noconfirm git neovim qt5-wayland qt6-wayland slurp wofi grim hyprland \
    polkit-kde-agent swaync ghostty xdg-desktop-portal-hyprland chromium yazi fd \
    mpv nautilus ark bluez bluez-utils ripgrep wl-clipboard pavucontrol unzip libnotify fuse2 \
    7zip zsh imagemagick feh bat exa fzf thunderbird bluetui wget tree btop macchina lazygit waybar \
    gst-plugin-pipewire libpipewire pipewire pipewire-alsa pipewire-audio pipewire-jack pipewire-pulse discord aichat \
    darkman xdg-desktop-portal-gtk nwg-look gnome-keyring libsecret
}

choose_aur_helper() {
  prompt "Choose AUR helper: [paru/yay]" "paru"
  read -r HELPER

  if [[ "$HELPER" =~ ^[Yy]ay$ ]]; then
    AUR_HELPER="yay"
  else
    AUR_HELPER="paru"
  fi

  if ! command -v "$AUR_HELPER" &>/dev/null; then
    info "Installing AUR helper: $AUR_HELPER..."
    sudo pacman -S --needed git base-devel
    git clone "https://aur.archlinux.org/$AUR_HELPER.git" "$HOME/$AUR_HELPER"
    cd "$HOME/$AUR_HELPER" && makepkg -si --noconfirm
    cd "$HOME"
    rm -rf "$HOME/$AUR_HELPER"
  else
    success "$AUR_HELPER is already installed."
  fi
}

# List of AUR packages to install
install_aur_packages() {
  install_aur_package swww
  install_aur_package gammastep
  install_aur_package wlr-randr
  install_aur_package brave-bin
  install_aur_package ttf-twemoji-color
  install_aur_package wlogout
}

install_aur_package() {
  local package="$1"
  info "Installing AUR package: $package..."
  if ! $AUR_HELPER -S --noconfirm --skipreview "$package"; then
    error "Failed to install $package. You may need to install it manually."
  else
    success "$package installed successfully."
  fi
}

oh_my_zsh() {
  info "Installing Oh My Zsh..."
  rm -rf "$HOME/.oh-my-zsh"
  CHSH=yes RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

oh_my_zsh_plugins() {
  info "Installing Oh My Zsh plugins..."
  git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
  git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
}

safe_rm_dir() {
  info "Removing directory: $1"
  if [ -d "$1" ]; then
    rm -rf "$1"
  fi
}

delete_needed_dot_files() {
  [ -f "$HOME/.zshrc" ] && log "Backing up existing .zshrc file..." && mv "$HOME/.zshrc" "$HOME/.zshrc.bk"
  safe_rm_dir "$HOME/.config/gammastep"
  safe_rm_dir "$HOME/.config/ghostty"
  safe_rm_dir "$HOME/.config/hypr"
  safe_rm_dir "$HOME/.config/lazygit"
  safe_rm_dir "$HOME/.config/swaync"
  safe_rm_dir "$HOME/.config/waybar"
  safe_rm_dir "$HOME/.config/wlogout"
  safe_rm_dir "$HOME/.config/wofi"
  safe_rm_dir "$HOME/.config/yazi"
  safe_rm_dir "$HOME/.config/zellij"
}

create_symlinks() {
  info "Creating symlinks for dotfiles..."
  ln -s "$HOME/.dot/.zshrc" "$HOME/.zshrc"
  ln -s "$HOME/.dot/.config/"{gammastep,ghostty,hypr,lazygit,swaync,waybar,wlogout,wofi,yazi,zellij} "$HOME/.config"
}

zlogin_tty() {
  prompt "Do you want to start Hyprland automatically on TTY1 after login?" "Y/n"
  read -r TTY
  if [[ "$TTY" =~ ^[Yy]$ || -z "$TTY" ]]; then
    info "Creating .zlogin file to start Hyprland on TTY1..."
    [ -f "$HOME/.zlogin" ] && mv "$HOME/.zlogin" "$HOME/.zlogin.bk"
    ln -s "$HOME/.dot/.zlogin" "$HOME/.zlogin"
    success ".zlogin created successfully."
  else
    success "Skipping .zlogin creation."
  fi
}

install_emojis_support() {
  info "Installing needed fonts for emoji support..."
  sudo pacman -S noto-fonts noto-fonts-emoji unicode-emoji ttf-cascadia-code-nerd ttf-nerd-fonts-symbols ttf-font-awesome powerline-fonts --noconfirm
  paru -S ttf-twemoji-color --noconfirm
}

install_fnm() {
  prompt "Do you want to install fnm (Node.js version manager)?" "Y/n"

  read -r FNM

  if [[ "$FNM" =~ ^[Yy]$ || -z "$FNM" ]]; then
    info "Installing fnm..."
    curl -fsSL https://fnm.vercel.app/install | sh -s -- --skip-shell &&
      success "fnm installed successfully."
    log "After finally script install, do you need re-open term or run:"
    log "source ~/.zshrc"
  else
    success "Skipping fnm installation."
  fi
}

install_python() {
  prompt "Do you want to install Python and pip?" "Y/n"

  read -r PYTHON

  if [[ "$PYTHON" =~ ^[Yy]$ || -z "$PYTHON" ]]; then
    info "Installing python and python-pip..."
    paru -S python python-pip --noconfirm &&
      success "Python and pip installed successfully."
  else
    success "Skipping Python and pip installation."
  fi
}

install_ni() {
  info "Installing @antfu/ni fast package manager..."
  if npm install -g @antfu/ni; then
    success "@antfu/ni installed successfully."
  else
    error "Failed to install @antfu/ni."
  fi
}

install_ni_package_manager() {
  prompt "Do you want to install @antfu/ni (Fast package manager)?" "Y/n"

  read -r NI

  if [[ "$NI" =~ ^[Yy]$ || -z "$NI" ]]; then

    # Check if Node.js is installed
    if ! command -v node &>/dev/null; then
      if command -v fnm &>/dev/null; then
        warn "Node.js is not installed. Installing Node.js v22 with fnm..."
        if fnm install v22 && fnm use v22; then
          success "Node.js v22 installed successfully with fnm."
        else
          error "Failed to install Node.js v22 with fnm."
          return 1
        fi
      else
        error "Node.js is not installed and fnm is not available. Cannot continue."
        return 1
      fi
    fi

    install_ni
  else
    success "Skipping @antfu/ni installation."
  fi
}

install_cz_cli() {
  prompt "Do you want to install cz-cli (Commitizen CLI)?" "Y/n"

  read -r CZ_CLI

  if [[ "$CZ_CLI" =~ ^[Yy]$ || -z "$CZ_CLI" ]]; then
    info "Installing cz-cli..."
    npm install -g commitizen cz-conventional-changelog && echo '{ "path": "cz-conventional-changelog" }' >~/.czrc &&
      success "cz-cli installed successfully."
    log "Now, you can use 'cz' command into your git repositories to create conventional commits."
  else
    success "Skipping cz-cli installation."
  fi
}

install_icons() {
  info "Installing icons and cursor theme..."
  install_mkos_icons
  install_macos_cursor
}

install_mkos_icons() {
  info "Installing Mkos-Big-Sur icon theme..."
  cd ~/Downloads/ &&
    ICON_VERSION=$(curl -s https://api.github.com/repos/zayronxio/Mkos-Big-Sur/releases/latest | grep -Po '"tag_name": "\K.*?(?=")') &&
    wget https://github.com/zayronxio/Mkos-Big-Sur/releases/download/$ICON_VERSION/Mkos-Big-Sur.tar.xz &&
    7z x ~/Downloads/Mkos-Big-Sur.tar.xz &&
    7z x ~/Downloads/Mkos-Big-Sur.tar &&
    mkdir -p ~/.icons &&
    rm -rf ~/Downloads/Mkos-Big-Sur.tar ~/Downloads/Mkos-Big-Sur.tar.xz &&
    mv ~/Downloads/Mkos-Big-Sur* ~/.icons/ &&
    success "Mkos-Big-Sur icon theme installed successfully."
}

install_macos_cursor() {
  info "Installing macOS cursor theme..."
  cd ~/Downloads/ &&
    CURSOR_VERSION=$(curl -s https://api.github.com/repos/ful1e5/apple_cursor/releases/latest | grep -Po '"tag_name": "\K.*?(?=")') &&
    wget https://github.com/ful1e5/apple_cursor/releases/download/$CURSOR_VERSION/macOS.tar.xz &&
    7z x ~/Downloads/macOS.tar.xz &&
    7z x ~/Downloads/macOS.tar &&
    mkdir -p ~/.icons &&
    rm -rf ~/Downloads/macOS.tar ~/Downloads/macOS.tar.xz &&
    mv ~/Downloads/macOS* ~/.icons/ &&
    success "macOS cursor theme installed successfully."
  info "Cursor theme environment variables are already configured in Hyprland."
}

dev_utils() {
  install_fnm
  install_python
  install_ni_package_manager
  install_cz_cli
}

# RUN
install_base_packages &&
  choose_aur_helper &&
  install_aur_packages &&
  oh_my_zsh &&
  oh_my_zsh_plugins &&
  delete_needed_dot_files &&
  create_symlinks &&
  zlogin_tty &&
  install_emojis_support &&
  install_icons &&
  dev_utils
