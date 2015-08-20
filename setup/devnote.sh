#!/bin/bash

SCRIPT_BASE_PATH=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
SCRIPT_NAME="${0##*/}"
DOC_FOLDER="../"
PY_ENV_FOLDER="python"
SVN_URL=https://github.com/emawind84/devnote-doc.git

set -e

while getopts ":p:d:" optname
    do
      case "$optname" in
        "d")
          echo "Document folder $OPTARG specified"
          DOC_FOLDER=$OPTARG
          ;;
        "p")
          echo "Python folder $OPTARG specified"
	  PY_ENV_FOLDER=$OPTARG
          ;;
        "?")
          echo "Unknown option $OPTARG"
          ;;
        ":")
          echo "No argument value for option $OPTARG"
          ;;
        *)
        # Should not occur
          echo "Unknown error while processing options"
          ;;
      esac
    done

shift $(($OPTIND - 1))

PKG_MANAGER=""

if command -v apt-get >/dev/null 2>&1; then
	PKG_MANAGER="apt-get"
elif command -v yum >/dev/null 2>&1; then
	PKG_MANAGER="yum"
else
	echo "Package manager not supported!"
fi

echo "Doc folder: $DOC_FOLDER"
echo "Python env folder: $PY_ENV_FOLDER"
echo "Package manager: $PKG_MANAGER"

cd $SCRIPT_BASE_PATH
echo "Current folder: $(pwd)"

create (){

	if ! command -v pip >/dev/null 2>&1; then
		echo "Installing pip..."
		wget https://bootstrap.pypa.io/get-pip.py
		sudo python get-pip.py
		rm get-pip.py
	fi

	if ! command -v git >/dev/null 2>&1 && -z $PKG_MANAGER; then
		echo "Installing git..."
		sudo $PKG_MANAGER install git
	fi

	if ! command -v virtualenv >/dev/null 2>&1; then
		echo "Installing virtualenv..."
		sudo pip install -U virtualenv
	fi

	echo "Creating virtual environment..."
	virtualenv $PY_ENV_FOLDER

	echo "Activating environment..."
	source $PY_ENV_FOLDER/bin/activate

	echo "Installing sphinx package..."
	pip install -U sphinx

	deactivate

	#if [ -d "$DOC_FOLDER" ]; then
	#	echo "$DOC_FOLDER already exists!"
	#	exit 1
	#fi

	#echo "Cloning svn repo..."
	#git clone $SVN_URL $DOC_FOLDER

	#cd $DOC_FOLDER

	#echo "Pulling source almost done..."
	#git pull

	echo "Environment installed, documentation ready to build!"
}

build (){

	# activate python environment
        echo "Activating Python environment..."
        source $PY_ENV_FOLDER/bin/activate

	if [ ! -d "$DOC_FOLDER" ]; then
		echo "Doc folder not found, install first!"
		exit 1
	fi
	# go to the doc folder
	cd $DOC_FOLDER

	# check for update
	echo "Checking for updates..."
	git pull

	# build documentation
	echo "Building documentation..."
	make html

	# deactivate python environment
	echo "Deactivating Python environment..."
	deactivate

	#chgrp -R users _build

	if [[ ! -d '_build/html/_script' ]]
	then
		cp -R _script _build/html/
	fi

	echo "Script terminated."
}

case "$1" in
	create|install)
		create
		;;
	
	build|update)
		build
		;;
	
	pkgmng)
		$PKG_MANAGER -V
		;;
	
	*)
		echo "Usage: $NAME {create|install|build|update}" >&2
		exit 1
		;;

esac

exit $?
