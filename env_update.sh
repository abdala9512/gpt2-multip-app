#!/bin/bash

python_package_install () {
    package=$1
    if [[  $( pip freeze | grep -w $package ) ]]; then
        pip install $package
    fi

}

update_repository (){

    py_version=$( python -c 'import sys; print(sys.version_info[:3])' )
    git pull origin ${1:-main}
    if [[ "$py_version" = '(3, 8, 5)' ]]; then
        echo -e "Incorrect python environment. Make sure you're working with Python 3.8.5"
    else
        echo "incorrect"
    fi
  
    git_remote = $( git remote -v )

    if [[ -f requirements.txt ]]; then
        for lib in $( cat requirements.txt )
        do
            python_package_install $lib
        done
    else
        echo "requirements.txt file not found"
    fi

}

export -f update_repository
