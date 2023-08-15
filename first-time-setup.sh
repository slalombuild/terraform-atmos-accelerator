#!/usr/bin/env bash

echo "========================================"
echo "Terraform Accelerator - first time setup"
echo "========================================"
echo ""
echo "Run this script when you're setting up a new project based on the accelerator."
echo "It will remove unnecessary scaffolding files and folders, leaving you with a "
echo "clean project template."
echo ""
echo "Refer to the documentation for usage/help:"
echo "https://github.com/slalombuild/terraform-accelerator/docs/GETTING-STARTED.md"
echo ""
read -n 1 -s -r -p "Press any key to continue, or CTRL+C to abort"
echo ""
echo "Here we go..."

TICK="\e[32m✔\e[0m"

removeGitFolder() {
    if [ -d ".git" ]; then
        rm -rf .git
        echo -e "${TICK} .git folder removed"
    fi
}

removeGitHubFolder() {
    if [ -d ".github" ]; then
        rm -rf .github
        echo -e "${TICK} .github folder removed"
    fi
}

removeUnnecessaryFiles() {
    files=("renovate.json" ".pre-commit-config.yaml")
    for file in "${files[@]}"; do
        if [ -f "${file}" ]; then
            rm "${file}"
            echo -e "${TICK} ${file} removed"
        fi
    done

}

removeDevelopmentStacks() {
    find ./stacks -type f -delete
}

removeThisScript() {
    rm -- "$0"
    echo -e "${TICK} $0 removed"
}

removeGitFolder
removeGitHubFolder
removeUnnecessaryFiles
removeDevelopmentStacks
removeThisScript

echo "========================================"
echo "All done! Live long and prosper 🖖"
