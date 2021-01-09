#!/bin/bash

# Package installation function
python_package_install () {
    package=$1
    if [[  $( pip freeze | grep -w $package ) ]]; then
        pip install $package
    fi

}

os_system_ver () {
    if [[ "$OSTYPE" == "linux-gnu"]]; then
        echo " OK "
    fi
}

# verify Python 3.8.5 version used in the project
# Update requirements.txt 
# check correct remote
# Perfom git pull operation in the current branch to avoid possible errors
update_project_env (){

    py_version=$( python -c 'import sys; print(sys.version_info[:3])' )
    c_branch=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')
    git_remote=$( git remote -v )

    if [[ "$py_version" = '(3, 8, 5)' ]]; then
        echo -e "Incorrect python environment. Make sure you're working with Python 3.8.5"
    else
        echo "incorrect"
        exit 1
    fi
  
    if [[ ! $( echo ${git_remote[0]} | cut -d ' ' -f2 ) == 'https://github.com/abdala9512/gpt2-multip-app.git' ]]; then
        echo "You're remote isn't GPT2 project. Verify"
        exit 1
    else   
        git pull origin $c_branch
    fi

    if [[ -f requirements.txt ]]; then
        for lib in $( cat requirements.txt )
        do
            python_package_install $lib
        done
    else
        echo "requirements.txt file not found"
        exit 1
    fi

}

export -f update_project_env
update_project_env
