#!/bin/bash

set -e

export DOCKER_CLI_EXPERIMENTAL="enabled"

if [[ -z "$DOCKER_USERNAME" ]]; then
    echo "Set the DOCKER_USERNAME environment variable."
    exit 1
fi

if [[ -z "$DOCKER_PASSWORD" ]]; then
    echo "Set the DOCKER_PASSWORD environment variable."
    exit 1
fi

if [[ -z "$GHCR_TOKEN" ]]; then
    echo "Set the GHCR_TOKEN environment variable."
    exit 1
fi

if [[ -z "$GITHUB_REPOSITORY" ]]; then
    echo "Set the GITHUB_REPOSITORY environment variable."
    exit 1
fi

GITHUB_OWNER=$(echo "${GITHUB_REPOSITORY}" | cut -d'/' -f1)

python_versions=( "$@" )
if [ ${#python_versions[@]} -eq 0 ]; then
    mapfile -t python_versions < PYTHON_VERSIONS
fi
python_versions=( "${python_versions[@]%/}" )

mapfile -t debian_versions < DEBIAN_VERSIONS

platforms="linux/amd64,linux/arm/v7,linux/arm64/v8"

# Login to Docker Hub
echo "${DOCKER_PASSWORD}" | docker login -u "${DOCKER_USERNAME}" --password-stdin "docker.io"
# Login to GitHub Container registry
echo "${GHCR_TOKEN}" | docker login -u "${GITHUB_OWNER}" --password-stdin "ghcr.io"

docker_base_repo="docker.io/${DOCKER_USERNAME}/python"
ghcr_base_repo="ghcr.io/${GITHUB_OWNER}/python"

for python_version in "${python_versions[@]}"; do
    echo "${python_version}"
    
    for debian_version in "${debian_versions[@]}"; do
        echo "  ${debian_version}"
        pattern='^ARG PYTHON_VERSION="(.*)"'
        full_python_version=`grep -E "${pattern}" "slim/${python_version}/${debian_version}/Dockerfile"`
        [[ "$full_python_version" =~ $pattern ]]
        full_python_version="${BASH_REMATCH[1]}"
        echo $full_python_version

        for variant in {slim,minimal,busybox}; do
            matching_python_version=`grep -E "${pattern}" "${variant}/${python_version}/${debian_version}/Dockerfile"`
            [[ "$matching_python_version" =~ $pattern ]]
            matching_python_version="${BASH_REMATCH[1]}"

            if [ "$matching_python_version" == "$full_python_version" ]; then
                echo "Building for python version ${full_python_version}-${variant}-${debian_version}..."
                docker buildx build --platform "${platforms}" \
                    --push \
                    --tag "${docker_base_repo}:${python_version}-${variant}-${debian_version}" \
                    --tag "${docker_base_repo}:${full_python_version}-${variant}-${debian_version}" \
                    --tag "${ghcr_base_repo}:${python_version}-${variant}-${debian_version}" \
                    --tag "${ghcr_base_repo}:${full_python_version}-${variant}-${debian_version}" \
                    --file "${variant}/${python_version}/${debian_version}/Dockerfile" \
                    "${variant}/${python_version}/${debian_version}/"
            else
                echo "${matching_python_version} does not match slim for variant ${variant}."
            fi
        done
    done
done
