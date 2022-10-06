#!/usr/bin/env bash

type python3 > /dev/null || { echo "Executable \"python3\" not in PATH or installed, aborting." && exit 1; }

odir="$(pwd)"
ddir="$(dirname "$(readlink -f "${0}")")"

cd "${ddir}" || { echo "Directory \"${ddir}\" does not exist, aborting." && exit 1; }

if [[ ! -d ".venv" ]]; then
  echo "Creating virtual environment..."
  python3 -m venv .venv
fi

source .venv/bin/activate || { echo "Can not activate virtual environment, aborting." && exit 1; }

if [[ ! -f ".venv/bin/dotdrop" ]]; then
  echo "Installing Dotdrop into virtual environment..."
  python3 -m pip install dotdrop
fi

dotdrop "$@"
exit_code="$?"

cd "${odir}" || { echo "Directory \"${odir}\" does not exist, aborting." && exit 1; }

