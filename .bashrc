# BASH COLORS
export LS_OPTIONS='--color=auto'
export CLICOLOR='Yes'
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

# Easier navigation: .., ..., ~ and -
alias ..="cd .."
alias ...="cd ../.."
alias ~="cd ~"
alias -- -="cd -"

# List all files colorized in long format, including dot files
alias la="ls -lah"

# List only directories
alias lsd='ls -l | grep "^d"'

# Shortcuts
alias pa="ps aux"
alias p="cd ~/Projects"
alias zf="~/Projects/PHP/Library/ZendFramework/bin/zf.sh"

# Grep
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;33'
alias grep='grep --color=auto' # Always highlight grep search term

# WELCOME MESSAGE
echo -e ""
echo -ne "Today is "; date
echo -ne "Up time: ";uptime | awk /'up/ {print $3,$4}'
echo "";

