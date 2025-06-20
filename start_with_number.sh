#!/bin/bash

if [ $# -ne 1 ]; then
  echo "Usage: $0 <number>"
  exit 1
fi

number=$1

cd ~ || { echo "Failed to cd ~"; exit 1; }

cp "cysic/$number/prover_0x0b1D3fE48d417b9f3AD7d2Ba28f705EA04Dc9521.key" "~/cysic/~/.cysic/assets/" || {
  echo "Failed to copy key file"
  exit 1
}

cd cysic-prover/ || { echo "Failed to cd cysic-prover"; exit 1; }

screen -dmS "$number" sh start.sh
