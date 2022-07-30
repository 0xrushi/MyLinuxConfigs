# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="gnzh"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

plugins=(git)

source $ZSH/oh-my-zsh.sh

export PATH=$PATH:~/.local/bin

plugins=(zsh_codex)
zle -N create_completion
bindkey '^X' create_completion

# ----------- NNN ----------------------
export PATH=$PATH:/home/pi/.local/bin
export PATH=$PATH:/usr/bin

#set --export NNN_FIFO "/tmp/nnn.fifo"
export NNN_PLUG='u:davecloud;o:fzopen;c:fcd;j:jump;p:preview-tui;t:prev,v:-!vim'

export NNN_OPTS="H" # 'H' shows the hidden files. Same as option -H (so 'nnn -deH')
export LC_COLLATE="C" # hidden files on top
export NNN_FIFO="/tmp/nnn.fifo" # temporary buffer for the previews
export NNN_FCOLORS="AAAAE631BBBBCCCCDDDD9999" # feel free to change the colors
export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
alias nnn="nnn -e"
alias ls="nnn -e"

n () # to cd on quit
{
    
if [ -n $NNNLVL ] && [ "${NNNLVL:-0}" -ge 1 ]; then
        
echo "nnn is already running"
        
return
    
fi
    
export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    nnn "$@"
    
if [ -f "$NNN_TMPFILE" ]; then
            
. "$NNN_TMPFILE"
            rm -f "$NNN_TMPFILE" > /dev/null
    
fi
}
# ----------------NNN end --------------------
