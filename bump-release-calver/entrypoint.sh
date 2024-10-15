#!/bin/bash
set -e

# Fetch the latest release from the GitHub API
latest_release=$(curl -s -H "Authorization: token $github_token" https://api.github.com/repos/$GITHUB_REPOSITORY/releases/latest)

# Extract the tag_name from the JSON response
current_version=$(echo "$latest_release" | jq -r .tag_name)

# Remove the 'v' from the version if present
current_version=${current_version#v}

# Remove '-[a-zA-Z0-9]*' suffix if present (e.g., '-dev')
current_version=${current_version%-[a-zA-Z0-9]*}

echo "current_version: $current_version"

# Extract the current date (year and month)
current_year=$(date +"%Y")
current_month=$(date +"%m")

echo "current_year: $current_year"
echo "current_month: $current_month"

# Parse the current version to extract its year, month, and minor version
IFS='.' read -r version_year version_month version_minor <<<"$current_version"

echo "version_year: $version_year"
echo "version_month: $version_month"
echo "version_minor: $version_minor"

# If the year and month are the same as the current year and month, increment the minor version
if [[ "$version_year" == "$current_year" && "$version_month" == "$current_month" ]]; then
    echo "Incrementing the minor version."
    next_minor=$((version_minor + 1))
else
    # If it's a new month or year, reset the minor version to 0
    echo "New month or year detected. Resetting the minor version to 1."
    next_minor=1
fi

# Construct the new version in CalVer format
next_version="$current_year.$current_month.$next_minor"

# Output the next version
echo "next_version: $next_version"
echo "next_version=$next_version" >>"$GITHUB_OUTPUT" # Use GITHUB_OUTPUT to set the output

# Export the next version to the environment
echo "next_version=$next_version" >>"$GITHUB_ENV"
