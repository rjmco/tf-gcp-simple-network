#!/usr/bin/env bash

# Set safe execution
set -eufo pipefail

# Constants
REQUIRED_BINARIES=(
    "cloud-build-local"
    "terraform"
    "terragrunt"
)
REQUIRED_ENV_VARS=(
    "GOLANG_VERSION"
    "TERRAFORM_VERSION"
    "TERRAGRUNT_VERSION"
)
REQUIRED_FILES=("build/cloudbuild.yaml")

# Check if all binaries exist
for binary in "${REQUIRED_BINARIES[@]}"; do
    if [[ ! -x "$(which "${binary}")" ]]; then
        echo "ERROR: ${binary} is required and was not found in shell's \${PATH}"
        exit 1
    fi
done

# Check if required files exist
for file in "${REQUIRED_FILES[@]}"; do
    if [[ ! -f ${file} ]]; then
        echo "ERROR: Required file ${file} not found. Make sure ${0} is being run from the repository's root folder."
        exit 1
    fi
done

set +u # Allow for unset variable expansion temporarily for the next check

# Check if required environment variables exist
for var in "${REQUIRED_ENV_VARS[@]}"; do
    if [[ -z ${!var} ]]; then
        echo "ERROR: Required environment variable ${var} is not set. The following variables are required:"
        echo "       ${REQUIRED_ENV_VARS[*]}"
        echo "       Make sure you create a local_env.sh file as explained on the README.md file and source it before executing ${0}."
        exit 1
    fi
done

set -u # Protect against unset variable expansion

# Step : Set Cloud Build's substitutions
substitutions=""
for var in "${REQUIRED_ENV_VARS[@]}"; do
    substitutions="${substitutions}_${var}=${!var},"
done
substitutions=${substitutions::$(( ${#substitutions} - 1))}

# Step : Check cloudbuild.yaml's syntax
echo "INFO: Executing: cloud-build-local --config build/cloudbuild.yaml --substitutions=${substitutions} ."
echo
cloud-build-local --config build/cloudbuild.yaml --substitutions="${substitutions}" .
echo

# Step : Make sure .terraform/ directories are not imported into Cloud Build's workspace
echo "INFO: Finding and removing .terraform directories."
echo
find . -type d -name '.terraform' -exec rm -rf '{}' \; || true

# Step : Make sure Cloud Build generates all tg_gen_*.tf files correctly
echo "INFO: Finding and removing tg_gen_*.tf files."
echo
find . -type f -name 'tg_gen_*.tf' -delete

# Step : Execute Cloud Build locally
echo "INFO: Executing: cloud-build-local --config build/cloudbuild.yaml --substitutions=${substitutions} --dryrun=false ."
echo
cloud-build-local --config build/cloudbuild.yaml --substitutions="${substitutions}" --dryrun=false .
echo

# Step : Regenerate the tg_gen_*.tf files inside examples/ with terragrunt
pushd examples > /dev/null
terragrunt validate-all
popd > /dev/null

exit 0