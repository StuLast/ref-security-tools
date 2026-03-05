#!/bin/bash

searchPath="."
if [[ $1 != "" ]]; then
    searchPath=$1
fi  

echo "🔍 Scanning $searchPath for React / Next.js versions..."
echo

# Simple semantic version comparator
ver() {
    # split X.Y.Z into three numbers safely without octal
    IFS='.' read -r major minor patch <<< "$1"
    printf "%d%03d%03d" "$major" "$minor" "$patch"
}
echo

find $searchPath -name "package.json" | while read pkg; do
    dir=$(dirname "$pkg")

    # extract versions
    next_version=$(grep '"next"' "$pkg" 2>/dev/null | sed -n 's/.*"next"[ ]*:[ ]*"\([0-9.]*\)".*/\1/p')
    react_version=$(grep '"react"' "$pkg" 2>/dev/null | sed -n 's/.*"react"[ ]*:[ ]*"\([0-9.]*\)".*/\1/p')

    # skip if neither exists
    if [[ -z "$next_version" && -z "$react_version" ]]; then
        continue
    fi

    # determine if vulnerable
    alert="NO"

    if [[ -n "$next_version" ]] && [[ $(ver "$next_version") -ge $(ver "14.0.0") ]]; then
        alert="YES"
    fi

    if [[ -n "$react_version" ]] && [[ $(ver "$react_version") -ge $(ver "19.0.0") ]]; then
        alert="YES"
    fi

    echo "📁 Project: $dir"
    echo "   Next.js: ${next_version:-not present}"
    echo "   React:   ${react_version:-not present}"

    if [[ "$alert" == "YES" ]]; then
        echo "   ❌ ALERT: Vulnerable version detected!"
    else
        echo "   ✅ Safe (no vulnerable versions)"
    fi

    if [[ "$alert" == "NO" ]]; then
        echo "No versions of Next or React found in $dir"
    fi
done
