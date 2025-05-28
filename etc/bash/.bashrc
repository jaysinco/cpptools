#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

export NNN_OPTS="Adeor"
export EDITOR=/usr/bin/code
export CHROME_EXECUTABLE=/usr/bin/microsoft-edge-stable
export PUB_HOSTED_URL=https://pub.flutter-io.cn
export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
export LIBTORCH_HOME=$HOME/opt/libtorch
export PATH=$PATH:$HOME/opt:$HOME/opt/kubo:$HOME/opt/flutter/bin:$HOME/opt/flutter-elinux/bin

if [[ $(ps --no-header --pid=$PPID --format=comm) != "fish" && -z ${BASH_EXECUTION_STRING} ]]
then
    shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=''
    exec fish $LOGIN_OPTION
fi
