#!/usr/bin/env bash
# Install aeas skill to user skill dirs Cursor actually scans.
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SKILL_NAME="aeas"
SRC="${REPO_ROOT}/skills/${SKILL_NAME}"

if [[ ! -d "${SRC}" ]]; then
  echo "Skill source not found: ${SRC}" >&2
  exit 1
fi

install_to() {
  local root="$1"
  local dst="${root}/${SKILL_NAME}"
  mkdir -p "${root}"
  # Retired dirs. Never delete the target itself.
  for legacy in ass ASS Ass ART art artstd art_std dsc-a dsc-b diagstack-c-comment-style; do
    local p="${root}/${legacy}"
    if [[ -e "${p}" || -L "${p}" ]]; then
      if [[ "${p}" != "${dst}" ]]; then
        rm -rf "${p}"
        echo "Removed legacy: ${p}"
      fi
    fi
  done
  rm -rf "${dst}"
  cp -R "${SRC}" "${dst}"
  echo "Installed: ${dst}"
  test -f "${dst}/SKILL.md" || { echo "ERROR: SKILL.md missing at ${dst}" >&2; exit 1; }
  test -f "${dst}/AUTHOR" || { echo "ERROR: AUTHOR missing at ${dst}" >&2; exit 1; }
}

for root in "${HOME}/.cursor/skills" "${HOME}/.agents/skills"; do
  install_to "${root}"
done

echo
echo "Verify:"
echo "  ls ~/.cursor/skills/aeas/SKILL.md"
echo
echo "Then FULLY quit Cursor and reopen. New chat: @aeas or /aeas"
