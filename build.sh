#!/bin/bash

project="Game"
root=~/repos/github/bitmal/snes_game

cd "${root}"

mkdir "${root}/build"

cd "${root}/src"

wla-65816 -v -o "${root}/build/${project}.obj" \
  "${root}/src/${project}.asm"

echo "[objects]                
${root}/build/${project}.obj" > "${root}/build/${project}.link"

wlalink -v "${root}/build/${project}.link" "${root}/build/${project}.smc"

cd "${root}"
