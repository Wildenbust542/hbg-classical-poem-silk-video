#!/bin/sh
set -eu

repo="Mr-funny/hbg-classical-poem-silk-video"
skill_name="classical-poem-silk-video"
mode="codex"
explicit_target=""
temp_dir=""

usage() {
  cat <<'EOF'
Usage: install.sh [--claude] [--target DIR]

Installs classical-poem-silk-video into Codex by default.
Use --claude for ~/.claude/skills or --target for an explicit directory.
EOF
}

while [ "$#" -gt 0 ]; do
  case "$1" in
    --claude) mode="claude" ;;
    --target)
      shift
      [ "$#" -gt 0 ] || { echo "--target requires a directory" >&2; exit 2; }
      explicit_target="$1"
      ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown option: $1" >&2; usage >&2; exit 2 ;;
  esac
  shift
done

cleanup() {
  if [ -n "$temp_dir" ] && [ -d "$temp_dir" ]; then
    rm -rf "$temp_dir"
  fi
}
trap cleanup EXIT INT TERM

script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" 2>/dev/null && pwd || true)
if [ -n "$script_dir" ] && [ -f "$script_dir/skill/$skill_name/SKILL.md" ]; then
  source_skill="$script_dir/skill/$skill_name"
else
  command -v curl >/dev/null 2>&1 || { echo "curl is required" >&2; exit 1; }
  command -v tar >/dev/null 2>&1 || { echo "tar is required" >&2; exit 1; }
  temp_dir=$(mktemp -d)
  curl -fsSL "https://github.com/$repo/archive/refs/heads/main.tar.gz" \
    | tar -xz -C "$temp_dir"
  source_skill="$temp_dir/hbg-classical-poem-silk-video-main/skill/$skill_name"
fi

if [ -n "$explicit_target" ]; then
  target="$explicit_target"
elif [ "$mode" = "claude" ]; then
  target="${CLAUDE_HOME:-$HOME/.claude}/skills/$skill_name"
else
  target="${CODEX_HOME:-$HOME/.codex}/skills/$skill_name"
fi

if [ -e "$target" ]; then
  backup="${target}.backup-$(date +%Y%m%d-%H%M%S)"
  mv "$target" "$backup"
  echo "Backed up existing skill: $backup"
fi

mkdir -p "$target"
cp -R "$source_skill"/. "$target"/
chmod +x "$target"/scripts/*.sh

test -f "$target/SKILL.md"
test -f "$target/agents/openai.yaml"
test -f "$target/references/runtime-contract.md"
test -f "$target/assets/MaShanZheng-Regular.ttf"

for script in "$target"/scripts/*.sh; do
  sh -n "$script"
done
python3 -m py_compile "$target"/scripts/*.py

echo "Installed $skill_name to $target"
echo "Use: Use \$$skill_name to turn this Chinese poem into a vertical Chinese-art video."
