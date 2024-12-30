#!/bin/bash

functions=()

functions+=(namespace)
function namespace() {
	echo accelerator
}

declare -A profiles

profiles=(
	["admin"]="accelerator-global-automation-admin"
	["developers"]="accelerator-global-automation-developers"
	["devops"]="accelerator-global-automation-devops"
	["terraform"]="accelerator-global-automation-terraform"
)

declare -A role_arns

role_arns=(
	["admin"]="arn:aws:iam::012345678910:role/accelerator-global-automation-admin"
	["developers"]="arn:aws:iam::012345678910:role/accelerator-global-automation-developers"
	["devops"]="arn:aws:iam::012345678910:role/accelerator-global-automation-devops"
	["terraform"]="arn:aws:iam::012345678910:role/accelerator-global-automation-terraform"
)

functions+=("role-names")
function role-names() {
	printf "%s\n" "${!profiles[@]}" | sort
}

functions+=("profiles")
function profiles() {
	printf "%s\n" "${profiles[@]}" | sort
}

functions+=("role-arns")
function role-arns() {
	for name in $(role-names); do
		printf "%s = %s\n" "$name" "${role_arns[$name]}"
	done
}

########### non-template helpers ###########

functions+=("profile")
function profile() {
	local profile="${profiles[$1]}"
	if [[ -n $profile ]]; then
		echo $profile
	else
		echo "Profile for role $1 not found" >&2
		exit 1
	fi
}

functions+=("role-arn")
function role-arn() {
	local arn="${role_arns[$1]}"
	if [[ -n $arn ]]; then
		echo $arn
	else
		echo "Role ARN for role $1 not found" >&2
		exit 1
	fi
}

if printf '%s\0' "${functions[@]}" | grep -Fxqz -- "$1"; then
	"$@"
else
	fns=$(printf '%s\n' "${functions[@]}" | sort)
	usage=${fns//$'\n'/ | }
	echo "Usage: $0 [ $usage ]"
fi
