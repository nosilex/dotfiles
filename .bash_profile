#  ---------------------------------------------------------------------------
#
#  Description:  This file holds all my BASH configurations and aliases
#
#  ---------------------------------------------------------------------------

#   -------------------------------
#   ENVIRONMENT CONFIGURATION
#   -------------------------------

#   Change Prompt
#   ------------------------------------------------------------
# export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "

#   Set Paths
#   ------------------------------------------------------------
export PATH="$PATH:/Users/nosilex/shell:/usr/local/opt/mysql-client/bin"

export HOMEBREW_FORCE_BREWED_CURL=1

#   Set Default Editor (change 'Nano' to the editor of your choice)
#   ------------------------------------------------------------
export EDITOR=/usr/bin/nano

#   Set default blocksize for ls, df, du
#   from this: http://hints.macworld.com/comment.php?mode=view&cid=24491
#   ------------------------------------------------------------
export BLOCKSIZE=1k

#   Add color to terminal
#   (this is all commented out as I use Mac Terminal Profiles)
#   from http://osxdaily.com/2012/02/21/add-color-to-the-terminal-in-mac-os-x/
#   ------------------------------------------------------------
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
#
export PROMPT_COMMAND='echo -ne "\033]0;${PWD##*/}\007"'    # Show working directory in tab

#   -----------------------------
#   MAKE TERMINAL BETTER
#   -----------------------------

alias cp='cp -iv'                                   # Preferred 'cp' implementation
alias mv='mv -iv'                                   # Preferred 'mv' implementation
alias la="eza --icons --long --all --group"         # Preferred 'ls' implementation with eza
alias lt="eza --long --tree"                        # Preferred 'ls' implementation with eza
alias lsd='eza --icons --long --all --only-dirs'    # Preferred 'ls' implementation (only directories)
alias ll='ls -FGlAhp'                               # Preferred 'ls' implementation
alias less='less -FSRXc'                            # Preferred 'less' implementation
alias mkdir='mkdir -pv'                             # Preferred 'mkdir' implementation
alias f='open -a Finder ./'                         # f:            Opens current directory in MacOS Finder
alias h="cd ~"                                      #Go to Home folder
alias c='clear'                                     # c:            Clear terminal display
alias path='echo -e ${PATH//:/\\n}'                 # path:         Echo all executable Paths
alias show_options='shopt'                          # Show_options: display bash options settings
alias fix_stty='stty sane'                          # fix_stty:     Restore terminal settings when screwed up
alias cic='set completion-ignore-case On'           # cic:          Make tab-completion case-insensitive
mcd () { mkdir -p "$1" && cd "$1"; }                # mcd:          Makes new Dir and jumps inside
trash () { command mv "$@" ~/.Trash ; }             # trash:        Moves a file to the MacOS trash
ql () { qlmanage -p "$*" >& /dev/null; }            # ql:           Opens any file in MacOS Quicklook Preview
alias grep='grep --color=auto'                      # Always highlight grep search term


#   lr:  Full Recursive Directory Listing
#   ------------------------------------------
alias lr='ls -R | grep ":$" | sed -e '\''s/:$//'\'' -e '\''s/[^-][^\/]*\//--/g'\'' -e '\''s/^/   /'\'' -e '\''s/-/|/'\'' | less'

#   cdf:  'Cd's to frontmost window of MacOS Finder
#   ------------------------------------------------------
cdf () {
    currFolderPath=$( /usr/bin/osascript <<EOT
        tell application "Finder"
            try
        set currFolder to (folder of the front window as alias)
            on error
        set currFolder to (path to desktop folder as alias)
            end try
            POSIX path of currFolder
        end tell
EOT
    )
    echo "cd to \"$currFolderPath\""
    cd "$currFolderPath"
}


#   ---------------------------
#   SEARCHING
#   ---------------------------

alias qfind="find . -name "                 # qfind:    Quickly search for file
ff () { /usr/bin/find . -name "$@" ; }      # ff:       Find file under the current directory
ffs () { /usr/bin/find . -name "$@"'*' ; }  # ffs:      Find file whose name starts with a given string
ffe () { /usr/bin/find . -name '*'"$@" ; }  # ffe:      Find file whose name ends with a given string

#   spotlight: Search for a file using MacOS Spotlight's metadata
#   -----------------------------------------------------------
spotlight () { mdfind "kMDItemDisplayName == '$@'wc"; }

#   ---------------------------
#   NETWORKING
#   ---------------------------

alias myip='curl ip.appspot.com'                    # myip:         Public facing IP Address
alias netCons='lsof -i'                             # netCons:      Show all open TCP/IP sockets
alias flushDNS='dscacheutil -flushcache'            # flushDNS:     Flush out the DNS Cache
alias lsock='sudo /usr/sbin/lsof -i -P'             # lsock:        Display open sockets
alias lsockU='sudo /usr/sbin/lsof -nP | grep UDP'   # lsockU:       Display only open UDP sockets
alias lsockT='sudo /usr/sbin/lsof -nP | grep TCP'   # lsockT:       Display only open TCP sockets
alias ipInfo0='ipconfig getpacket en0'              # ipInfo0:      Get info on connections for en0
alias ipInfo1='ipconfig getpacket en1'              # ipInfo1:      Get info on connections for en1
alias openPorts='sudo lsof -i | grep LISTEN'        # openPorts:    All listening connections
alias showBlocked='sudo ipfw list'                  # showBlocked:  All ipfw rules inc/ blocked IPs

checkPort () { sudo /usr/sbin/lsof -i :$@ ; }
closePort () { sudo kill -9 $(/usr/sbin/lsof -ti:$@) ; }
httpHeaders () { /usr/bin/curl -I -L $@ ; }             # httpHeaders:      Grabs headers from web page


#   ---------------------------------------
#   SYSTEMS OPERATIONS & INFORMATION
#   ---------------------------------------
alias lockFile='sudo chflags uchg,schg '
alias unlockFile='sudo chflags nouchg,noschg '

#   cleanupDS:  Recursively delete .DS_Store files
#   -------------------------------------------------------------------
alias cleanupDS="find . -type f -name '*.DS_Store' -ls -delete"

#   cleanupDOT:  Recursively delete ._* dot files
#   -------------------------------------------------------------------
alias cleanupDOT="find . -type f -name '._*' -ls -delete"

#   cleanupLS:  Clean up LaunchServices to remove duplicates in the "Open With" menu
#   -----------------------------------------------------------------------------------
alias cleanupLS="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user && killall Finder"

#   ---------------------------------------
#   WEB DEVELOPMENT
#   ---------------------------------------

alias desk="cd ~/Desktop"                                         #Go to Desktop folder
alias dld="cd ~/Downloads"                                        #Go to Downloads folder
alias dev="cd ~/Developer"                                        #Go to Developer folder
alias web="cd ~/Sites"                                            #Go to Web folder

alias lg="lazygit"
alias ld="lazydocker"

getuuid () {
    uuid=$(uuidgen | tr 'A-Z' 'a-z' | tr -d '\n')
    (osascript -e "display notification with title \"⌘-V to paste\" subtitle \"$uuid\"" &) >/dev/null 2>&1
    echo -n "$uuid" | pbcopy
}

#   ---------------------------------------
#   GO DEVELOPMENT
#   ---------------------------------------
export GOPATH="${HOME}/.go"
export GOROOT=/opt/homebrew/opt/go/libexec
export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"

[ -f ~/.kubectl_aliases ] && source ~/.kubectl_aliases

#   ---------------------------------------
#   OTHER
#   ---------------------------------------
. "$HOME/.cargo/env"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
