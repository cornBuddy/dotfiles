# in .config.fish
function fish_prompt
  env FISH_VERSION=$FISH_VERSION shell_prompt_LAST_EXIT_CODE=$status bash ~/.shell_prompt.sh left
    echo -e '\n \e[38;5;243m-> $ '
end

function fish_right_prompt
  env FISH_VERSION=$FISH_VERSION shell_prompt_LAST_EXIT_CODE=$status bash ~/.shell_prompt.sh right
end


alias tree='tree -I "jspm_packages|node_modules|bower_components" --dirsfirst'
alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# some more ls aliases
alias ll='ls -AlFh'
alias la='ls -A'
alias l='ls -CF'
# some git aliases
alias gs='git status'
alias ga='git add'
alias gb='git branch'
alias gc='git commit -m'
alias gd='git diff'
alias go='git checkout'
alias gp='git pull --rebase ; git push'
alias gl='git log --pretty=format:"%h %s, %cr [%cn]" --graph --stat'
