#!/usr/bin/env bash


readarray -t modules < definitions/npm_modules.txt

echo "Enter the target directory to scan:"
read TargetDir


echo "checking for compromised packages ..."
echo modules: ${modules[@]}

declare -a findings
total=${#modules[@]}
count=0

for module in ${modules[@]}; do
    ((count++))
    printf "\rProgress: %d/%d modules checked" "$count" "$total"#
    
    result=$(grep -r -l --include="package.json" "${module}" "$TargetDir" 2>/dev/null)
    
    if [ -n "$result" ]; then
        findings["${module}"]="${result}"
    fi
done

printf "\n\nScan complete.\n\n"

if [ ${#findings[@]} -ne 0 ]; then
    echo "⚠️  Compromised packages found in the following files:"
    echo "======================================================="
    for module in "${!findings[@]}"; do
        echo ""
        echo "Module: ${module}"
        echo "${findings[$module]}" | while read -r filepath; do
            echo "  └─ ${filepath}"
        done
    done
    echo ""
    exit 1
else
    echo "✓ Scan complete. No compromised packages found."
    exit 0
fi
