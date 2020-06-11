#!/usr/bin/bash

type python > /dev/null || { echo "Executable \"python\" not in PATH or installed, aborting." && exit 1; }
type pip > /dev/null || { echo "Exectuable \"pip\" not in PATH or installed, aborting." && exit 1; }

odir="$(pwd)"
ddir="$(dirname "$(readlink -f "${0}")")"

cd "${ddir}" || { echo "Directory \"${ddir}\" does not exist, aborting." && exit 1; }

if [[ ! -d ".venv" ]]; then
  echo "Creating virtual environment..."
  python -m venv .venv
fi

source .venv/bin/activate || { echo "Can not activate virtual environment, aborting." && exit 1; }

if [[ ! -f ".venv/bin/dotdrop" ]]; then
  echo "Installing Dotdrop into virtual environment..."
  pip install dotdrop
fi

dotdrop "$@"
exit_code="$?"

cd "${odir}" || { echo "Directory \"${odir}\" does not exist, aborting." && exit 1; }

