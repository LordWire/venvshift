# venvshift




### introduction

This is a simple bash wrapper script for python virtualenv. Its purpose is to shorten the tedious commands used to create and switch between different virtualenvs, without actually introducing any extra functionality (and hence, complexity). 



### installation

##### prerequisites
In order for this to work, you need the following: 

1. python
2. virtualenv
3. fzf

Installing the prerequisites is out of the scope of this document, so feel free to install them in any way you prefer.


##### setup 
Setting this up is as simple as sourcing the script from your `.bashrc` or `.bash_profile`:

```bash
source /script/path/venvshift.sh`
```

By default, all virtual environments will be installed in `~/.venvs`. If you wish to install environments to a different place, you can set where the  variable `__venvshift_venv_path` points at. 


### Usage

The script provides one simple command, `venvshift`, which can be invoked with a single argument or no argument at all. There is also tab completion and fzf completion available, which is discussed below.


###### Invoking with an argument
When called with an argument, venvshift will create it if it doesn't exist and/or activate it. Tab completion will provide all the available virtualenvs inside `__venvshift_venv_path`.


###### Invoking without arguments
Calling without arguments will trigger fzf, showing a list of all available environments. Selecting one will activate it. 

###### Conventions

The purpose of this command is to speed up the creation of environments and switching between them. For this, the following conventions are followed:
- Virtualenvs are always activated with the activate command
- You can activate environment **b** directly from environment **a**, just like when sourcing the actual activate script. No more intelligence here.
- A simple `deactivate` command will deactivate your environment.  


### Future work

- Cleanup function for environments that aren't used anymore.
- Control for 3rd party folders in the `__venvshift_venv_path` that aren't actually virtual environments.
