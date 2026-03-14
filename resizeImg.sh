#!/bin/zsh
set -euo pipefail

command -v cwebp &>/dev/null && command -v dwebp &>/dev/null || { echo "Erreur : installe webp via brew install webp"; exit 1; }

file_list=$(osascript -e '
  set theFiles to choose file with prompt "Sélectionne une ou plusieurs images" of type {"public.image"} with multiple selections allowed
  set posixList to {}
  repeat with f in theFiles
    set end of posixList to POSIX path of f
  end repeat
  set AppleScript'\''s text item delimiters to linefeed
  return posixList as text
' 2>/dev/null)

[[ -z "$file_list" ]] && exit 1

width=$(osascript -e '
  set r to display dialog "Largeur cible (px) :" default answer "800" buttons {"Annuler", "OK"} default button "OK"
  return text returned of r
' 2>/dev/null)

[[ -z "$width" ]] || ! [[ "$width" =~ ^[0-9]+$ ]] || [[ "$width" -eq 0 ]] && { echo "Largeur invalide."; exit 1; }

compression=$(osascript -e '
  return button returned of (display dialog "Compression WebP :" buttons {"Annuler", "Lossless", "Lossy (75%)"} default button "Lossy (75%)")
' 2>/dev/null)

[[ "$compression" == "Annuler" || -z "$compression" ]] && exit 1
[[ "$compression" == "Lossless" ]] && cwebp_flags="-lossless" || cwebp_flags="-q 75"

output_dir="$(dirname "$(echo "$file_list" | head -n 1)")/resize-output"
mkdir -p "$output_dir"

success=0
fail=0

while IFS= read -r filepath; do
  filename=$(basename "$filepath")
  name_no_ext="${filename%.*}"
  ext_lower="${${filename##*.}:l}"
  tmp_source="$(mktemp /tmp/resizeimg_XXXXXX).png"
  tmp_resized="$(mktemp /tmp/resizeimg_XXXXXX).png"

  if [[ "$ext_lower" == "webp" ]]; then
    dwebp "$filepath" -o "$tmp_source" &>/dev/null || { fail=$((fail + 1)); rm -f "${tmp_source%.png}" "$tmp_source" "${tmp_resized%.png}" "$tmp_resized"; continue; }
    src="$tmp_source"
  else
    src="$filepath"
  fi

  if sips --resampleWidth "$width" "$src" --out "$tmp_resized" &>/dev/null \
     && cwebp $cwebp_flags "$tmp_resized" -o "${output_dir}/${name_no_ext}.webp" &>/dev/null; then
    success=$((success + 1))
  else
    fail=$((fail + 1))
  fi

  rm -f "${tmp_source%.png}" "$tmp_source" "${tmp_resized%.png}" "$tmp_resized"
done <<< "$file_list"

echo "$success converti(es), $fail erreur(s) → $output_dir"
open "$output_dir"
