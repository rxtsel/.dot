#!/usr/bin/env bash
set -euo pipefail

readonly PACKAGE_FILE="modules/home/programs/cli/_codex/package.nix"

readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly NC='\033[0m'

readonly GITHUB_REPO="openai/codex"
readonly NPM_REGISTRY_URL="https://registry.npmjs.org"
readonly NPM_PACKAGE_NAME="@openai/codex"
readonly GITHUB_RELEASE_BASE="https://github.com/${GITHUB_REPO}/releases/download"

readonly NATIVE_PLATFORMS=("aarch64-apple-darwin" "x86_64-apple-darwin" "x86_64-unknown-linux-gnu" "aarch64-unknown-linux-gnu")
readonly NODE_PLATFORMS=("darwin-arm64" "darwin-x64" "linux-x64" "linux-arm64")

usage() {
  cat <<'USAGE'
Usage:
  scripts/update-codex.sh [--check]
  scripts/update-codex.sh [--version VERSION]

Options:
  --check            Report whether the vendored Codex package is current.
  --version VERSION  Update to a specific Codex version.
  -h, --help         Show this help.
USAGE
}

fail() {
  printf '%bError:%b %s\n' "$RED" "$NC" "$*" >&2
  exit 1
}

info() {
  printf '%b==>%b %s\n' "$YELLOW" "$NC" "$*"
}

success() {
  printf '%bOK:%b %s\n' "$GREEN" "$NC" "$*"
}

need_cmd() {
  command -v "$1" >/dev/null 2>&1 || fail "Missing required command: $1"
}

current_version() {
  awk -F'"' '/^[[:space:]]*version = / { print $2; exit }' "$PACKAGE_FILE"
}

latest_version() {
  gh release view --repo "$GITHUB_REPO" --json tagName --jq '.tagName' | sed 's/^rust-v//'
}

prefetch() {
  nix-prefetch-url "$1"
}

replace_version() {
  local version="$1"
  perl -0pi -e "s/version = \"[^\"]+\";/version = \"$version\";/" "$PACKAGE_FILE"
}

replace_hash_entry() {
  local key="$1"
  local hash="$2"
  perl -0pi -e "s/(\"\\Q$key\\E\" = \")[^\"]+\";/\${1}$hash\";/" "$PACKAGE_FILE"
}

replace_npm_hash() {
  local hash="$1"
  perl -0pi -e 's/(npmTarball =.*?sha256 = ")[^"]+(";\n[[:space:]]*\}\n[[:space:]]*else null;)/${1}'"$hash"'${2}/s' "$PACKAGE_FILE"
}

native_url() {
  local version="$1"
  local platform="$2"
  printf '%s/rust-v%s/codex-%s.tar.gz\n' "$GITHUB_RELEASE_BASE" "$version" "$platform"
}

node_optional_url() {
  local version="$1"
  local platform="$2"
  printf '%s/rust-v%s/codex-npm-%s-%s.tgz\n' "$GITHUB_RELEASE_BASE" "$version" "$platform" "$version"
}

npm_url() {
  local version="$1"
  printf '%s/%s/-/codex-%s.tgz\n' "$NPM_REGISTRY_URL" "$NPM_PACKAGE_NAME" "$version"
}

verify_build_if_target_exists() {
  local system
  system="$(nix eval --raw --impure --expr 'builtins.currentSystem' 2>/dev/null || true)"

  if [[ -z "$system" ]]; then
    info "Skipping nix build verification: could not detect current system."
    return 0
  fi

  if nix eval ".#packages.${system}.codex" >/dev/null 2>&1; then
    info "Verifying package with nix build .#packages.${system}.codex"
    nix build ".#packages.${system}.codex"
  elif nix eval ".#codex" >/dev/null 2>&1; then
    info "Verifying package with nix build .#codex"
    nix build ".#codex"
  else
    info "Skipping nix build verification: no straightforward local flake package target found."
  fi
}

update_hashes() {
  local version="$1"
  local platform hash

  for platform in "${NATIVE_PLATFORMS[@]}"; do
    info "Prefetching native ${platform}"
    hash="$(prefetch "$(native_url "$version" "$platform")")"
    replace_hash_entry "$platform" "$hash"
  done

  info "Prefetching npm tarball"
  hash="$(prefetch "$(npm_url "$version")")"
  replace_npm_hash "$hash"

  for platform in "${NODE_PLATFORMS[@]}"; do
    info "Prefetching node optional dependency ${platform}"
    hash="$(prefetch "$(node_optional_url "$version" "$platform")")"
    replace_hash_entry "$platform" "$hash"
  done
}

main() {
  local check_only=false
  local requested_version=""

  while [[ $# -gt 0 ]]; do
    case "$1" in
      --check)
        check_only=true
        shift
        ;;
      --version)
        [[ $# -ge 2 ]] || fail "--version requires a value"
        requested_version="$2"
        shift 2
        ;;
      -h | --help)
        usage
        exit 0
        ;;
      *)
        fail "Unknown argument: $1"
        ;;
    esac
  done

  [[ -f "$PACKAGE_FILE" ]] || fail "Package file not found: $PACKAGE_FILE"
  need_cmd gh
  need_cmd nix-prefetch-url
  need_cmd perl
  need_cmd awk
  need_cmd sed

  local current target
  current="$(current_version)"
  target="${requested_version:-$(latest_version)}"

  [[ -n "$current" ]] || fail "Could not read current version from $PACKAGE_FILE"
  [[ -n "$target" ]] || fail "Could not determine target version"

  if [[ "$check_only" == true ]]; then
    printf 'Current: %s\nLatest:  %s\n' "$current" "$target"
    [[ "$current" == "$target" ]] && success "Codex package is current." && exit 0
    info "Codex package update available."
    exit 1
  fi

  if [[ "$current" == "$target" ]]; then
    success "Codex package already at ${target}."
    exit 0
  fi

  info "Updating Codex package ${current} -> ${target}"
  replace_version "$target"
  update_hashes "$target"
  verify_build_if_target_exists
  success "Updated $PACKAGE_FILE to ${target}."
}

main "$@"
