#!/bin/bash

# --- Colores ANSI ---
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
MAGENTA="\e[35m"
CYAN="\e[36m"
BOLD="\e[1m"
RESET="\e[0m"

# Sources
ARTIX_NEWS_URL="https://artixlinux.org/news.php"
ARCH_NEWS_URL="https://archlinux.org/news/"

# Keywords
KEYWORDS=(
  "manual intervention" "openrc" "runit" "s6" "s6-rc" "elogind" "udev" "eudev"
  "pacman" "glibc" "gcc" "kernel" "init" "boot" "firmware"
  "plasma" "wine" "valkey" "redis" "linux-firmware" "wow64" "sshd" "openssh"
)

# Checks the availability of commands
command -v curl >/dev/null 2>&1 || { echo -e "${RED}❌ Falta 'curl'.${RESET}"; exit 1; }
command -v htmlq >/dev/null 2>&1 || { echo -e "${RED}❌ Falta 'htmlq'.${RESET}"; exit 1; }

echo -e "${CYAN}${BOLD}🔍 Comprobando noticias de Artix...${RESET}"

# Unified arrays
titles=()
dates=()
urls=()
sources=()

add_item() {
  local src="$1" date="$2" title="$3" url="$4"
  titles+=("$title")
  dates+=("$date")
  urls+=("$url")
  sources+=("$src")
}

fetch_artix() {
  local html
  html=$(curl -fsSL "$ARTIX_NEWS_URL") || { echo -e "${RED}❌ No pude descargar Artix News.${RESET}"; return 1; }

  # Titles
  local _titles=()
  local i=0
  while IFS= read -r line; do
    _titles+=("$line")
    (( ++i >= 5 )) && break
  done < <(echo "$html" | htmlq -t 'div.news > p')

  # Dates
  local _dates=()
  i=0
  while IFS= read -r line; do
    _dates+=("$line")
    (( ++i >= 5 )) && break
  done < <(echo "$html" | htmlq -t 'div.news .timestamp span')

  # Paths
  local _paths=()
  i=0
  while IFS= read -r line; do
    _paths+=("$line")
    (( ++i >= 5 )) && break
  done < <(echo "$html" | htmlq --attribute href 'div.news .timestamp a')

  if [[ ${#_titles[@]} -eq 0 || ${#_dates[@]} -eq 0 || ${#_paths[@]} -eq 0 ]]; then
    echo -e "${RED}❌ No se pudieron parsear noticias de Artix (cambió el HTML?).${RESET}"
    return 1
  fi

  for i in "${!_titles[@]}"; do
    local href="${_paths[$i]}"
    local full_url
    if [[ "$href" =~ ^https?:// ]]; then
      full_url="$href"
    else
      full_url="https://artixlinux.org/${href#./}"
    fi
    add_item "Artix" "${_dates[$i]}" "${_titles[$i]}" "$full_url"
  done
}

fetch_arch() {
  echo -e "${CYAN}${BOLD}🔍 Comprobando noticias de Arch...${RESET}"
  local html
  html=$(curl -fsSL "$ARCH_NEWS_URL") || { echo -e "${RED}❌ No pude descargar Arch News.${RESET}"; return 1; }

  local _dates=()
  local i=0
  while IFS= read -r line; do
    _dates+=("$line")
    (( ++i >= 5 )) && break
  done < <(echo "$html" | htmlq -t '#article-list tbody tr td:nth-child(1)')

  local _titles=()
  i=0
  while IFS= read -r line; do
    _titles+=("$line")
    (( ++i >= 5 )) && break
  done < <(echo "$html" | htmlq -t '#article-list tbody tr td.wrap a')

  local _hrefs=()
  i=0
  while IFS= read -r line; do
    _hrefs+=("$line")
    (( ++i >= 5 )) && break
  done < <(echo "$html" | htmlq --attribute href '#article-list tbody tr td.wrap a')

  if [[ ${#_titles[@]} -eq 0 || ${#_dates[@]} -eq 0 || ${#_hrefs[@]} -eq 0 ]]; then
    echo -e "${RED}❌ No se pudieron parsear noticias de Arch (cambió el HTML?).${RESET}"
    return 1
  fi

  for i in "${!_titles[@]}"; do
    local href="${_hrefs[$i]}"
    local full_url
    if [[ "$href" =~ ^https?:// ]]; then
      full_url="$href"
    else
      full_url="https://archlinux.org${href}"
    fi
    add_item "Arch" "${_dates[$i]}" "${_titles[$i]}" "$full_url"
  done
}

# === Scraps all the data ===
fetch_artix || true
fetch_arch  || true

# If there's no news
if [[ ${#titles[@]} -eq 0 ]]; then
  echo -e "${RED}❌ No se obtuvieron noticias de ninguna fuente.${RESET}"
  exit 1
fi

# --- Show news ---
echo -e "\n${YELLOW}${BOLD}--- Últimas noticias (Artix + Arch) ---${RESET}"
for i in "${!titles[@]}"; do
  fecha_arg=$(date -d "${dates[$i]}" "+%d/%m/%Y" 2>/dev/null || echo "${dates[$i]}")
  echo -e "${MAGENTA}📅 [$fecha_arg]${RESET} ${CYAN}[${sources[$i]}]${RESET} - ${BLUE}${urls[$i]}${RESET} - ${BOLD}${titles[$i]}${RESET}"
done
echo -e "${YELLOW}${BOLD}----------------------------------------${RESET}"

# --- Finds news with any keyword ---
alert=false
for word in "${KEYWORDS[@]}"; do
  lw="${word,,}"
  for title in "${titles[@]}"; do
    if [[ "${title,,}" == *"$lw"* ]]; then
      alert=true
      break 2
    fi
  done
done

if [ "$alert" = true ]; then
  echo -e "\n${RED}${BOLD}⚠️  Se detectaron noticias que podrían requerir intervención manual.${RESET}"
  read -p "$(echo -e "${YELLOW}¿Estás seguro de que querés actualizar? (s/N): ${RESET}")" confirm
  [[ "$confirm" =~ ^[sS]$ ]] || { echo -e "${RED}❌ Cancelado.${RESET}"; exit 1; }
fi

echo -e "\n${GREEN}${BOLD}🚀 Ejecutando 'yay'...${RESET}"
sleep 1
yay || true
