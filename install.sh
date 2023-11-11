#!/bin/bash

set -e

ROOT_DIR="$(dirname -- "$(readlink --canonicalize-existing -- "$0")")"
readonly ROOT_DIR

readonly INSTALL_DIR="${HOME}/.local/share/dotfiles"

readonly ANSIBLE_HOME="${ANSIBLE_HOME:-${INSTALL_DIR}/ansible}"
readonly PYTHON="${PYTHON:-python3}"
readonly PYTHON_VENV="${PYTHON_VENV:-${INSTALL_DIR}/venv}"

export ANSIBLE_HOME

function initialize_ansible {
  if [[ ! -e "${PYTHON_VENV}" ]]; then
    log v "creating ${PYTHON_VENV}"
    mkdir --parents "$(dirname "${PYTHON_VENV}")"
    "${PYTHON}" -m venv "${PYTHON_VENV}"
  fi
  log vv "activating ${PYTHON_VENV}"
  . "${PYTHON_VENV}/bin/activate"

  if [[ -v REINSTALL_ANSIBLE ]] || ! ansible --version &> /dev/null; then
    log v "installing ansible in ${PYTHON_VENV}"
    python -m pip install --upgrade pip
    python -m pip install ansible-core
  fi
  log vvv "using ansible $(ansible --version)"
}

function log {
  local verbosity=$1
  local message=$2

  if [[ "${LOG_VERBOSITY:-x}" =~ ^${verbosity} ]]; then
    >&2 printf "%s [%3s] %s: %b\n" \
      "$(date +%H:%M:%S)" \
      "${verbosity}" \
      "$(caller 0 | awk '{print $2}')" \
      "${message}"
  fi
}

function main {
  initialize_ansible
  (
    cd "${ROOT_DIR}"
    ansible-playbook ./install.yml
  )
}

main

