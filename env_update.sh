#!/bin/bash

update_repository (){

    py_version = $( python --version )    
    git_remote = $( git remote -v )

    if [[ -f requirements.txt ]]; then
        for lib in $( cat requirements.txt )
        do
            echo $lib
        done
    else
        echo "requirements.txt file not found"
    fi
    git pull origin ${1:-main}
    
    if [[ $py_version = 'Python 3.8.5' ]]; then
        pip install
    else
        echo "incorrect"
    fi
}