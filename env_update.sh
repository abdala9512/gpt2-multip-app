#!/bin/bash

update_repository (){
    git pull origin ${1:-main}
    py_version = $(python --version)
    if [[ $py_version = 'Python 3.8.5' ]]; then
        echo "correct"
    else
        echo "incorrect"
    fi
}