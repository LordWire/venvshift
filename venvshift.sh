#!/usr/bin/env bash

# please set these paths according to your preferences. 
__venvshift_venv_path=~/.venvs
mkdir -p $__venvshift_venv_path



# check for prerequisites. 
__venvshift_checkenv() {
    if ! command -v fzf &> /dev/null; then echo missing fzf; return 1; fi
    if ! command -v virtualenv &> /dev/null; then echo missing virtualenv; return 1; fi
}

# get an environment list and maybe feed it to bash completion too.
__venvshift_environment_list() {
    
    # there are two ways to use this function. 
    # Either by invoking it and getting a list of environments, or by asking it 
    # to setup a COMPREPLY for the bash completion subsystem. 

    # ls throws a silly error if there are no environments yet. Hence, mute them. 
    local envlist=$(ls -1d -- $__venvshift_venv_path/*/ 2>/dev/null |sed 's!/$!!g' |sed 's!.*/!!g')
    
    if [[ "$1" == "raw" ]]; then
        echo $envlist | tr ' ' '\n' # echo the list in a fzf consumable format. Oh well.
      return
    fi


    if [ "${#COMP_WORDS[@]}" != "2" ]; then
     return
    fi
    
    
    COMPREPLY=( $(compgen -W "$envlist" -- "${COMP_WORDS[1]}" ) )
    
}
complete -F __venvshift_environment_list venvshift


__venvshift_handle_environment() {
    
    # check if path exists
    if [ -d $__venvshift_venv_path/$1 ]
    then
        source $__venvshift_venv_path/$1/bin/activate
    else
        echo environment does not exist. Creating...
        virtualenv $__venvshift_venv_path/$1
        source $__venvshift_venv_path/$1/bin/activate
    fi

}

__venvshift_trigger_fzf() {
    local selection=`__venvshift_environment_list raw  | fzf`

    if [ -z $selection ]; then
        echo you did not choose any environment
        return
    else
        venvshift $selection
        return
    fi

    
}

venvshift () {
    __venvshift_checkenv || return 1
    
   
    case "$1" in
        "") __venvshift_trigger_fzf;;
        *)  __venvshift_handle_environment $1;;
    esac

    
    
}
