#!/bin/sh
# Build automation based on marechal-p, lordloki, youle31 instructions at
#  https://github.com/UPBGE/blender/wiki/Build-UPBGE-on-Linux
# Reworked into script by CeDeROM to work on FreeBSD too :-)

# Eject on error.
set -e

export SRC="`pwd`/build/src"
export INST="`pwd`/build/inst"
mkdir -p $SRC $INST

# Confirm the build branch/tag.
echo "=================================================="
echo "Have you selected/updated desired Repo/Branch/Tag?"
echo "=================================================="
git remote -v
git branch -v
git log -n 1
echo "Press Ctrl+C to abort, Enter to proceed."
read a

# Update the sources and submodules.
git submodule sync
git submodule update --init --recursive --force
git submodule foreach git pull --rebase origin master
(
    cd build_files/build_environment
    ./install_deps.sh --source $SRC --install $INST
)

