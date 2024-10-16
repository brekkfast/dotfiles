# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
# ///////// \///// \\/////// \\/// \\/// \
# /// \\\\\\\\/// \\/// \\\\\\\/// \\/// \
# /////// \\\\/// \\\/////// \\///////// \
# /// \\\\\\\\/// \\\\\\\\/// \/// \\/// \
# /// \\\\\\\///// \\/////// \\/// \\/// \
# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

# BREW
set PATH /opt/homebrew/bin $PATH

# FNM
set PATH /Users/brekk/.fnm $PATH
fnm env | source

# fisher
if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

# starship theme
eval (starship init fish)

# snang
alias lsnang="~/work/snang/snang.js"

# the fuck
thefuck --alias | source

# meta utilities

alias bashpro="ni ~/work/dotfiles/config.fish"
alias bashsource="source ~/work/dotfiles/config.fish"
alias bashcat="bat ~/.config/fish/config.fish"
alias bashgat="bat ~/.config/fish/config.fish | rg"
alias ni="nvim"
# overthrown
alias vi="nvim"

# the best editor on the planet

alias vivify="vi ~/.config/nvim/init.lua"
# alias nivify="ni ~/.config/nvim/init.vim"
# alias vivify="nivify"

# git

alias gs="git status"
alias branch="git branch | grep '*' | snang -P 'split(C._) | last'"
alias gitpurty="git log --oneline --decorate --graph"
alias flush="git push --set-upstream origin $branch --force-with-lease"

# ping ping ping
alias ping="prettyping --nolegend"

# let them know you're repping flipmode
set -gx EDITOR nvim

alias sed="gsed"

# alias cargo="$HOME/.cargo/bin/cargo"
# alias rustup="$HOME/.cargo/bin/rustup"
alias knock="~/work/binoculars/binocular.js"

alias gpsup="git push -u origin (branch)"
function nname
  available $1 -r
end



# meta utilities
if not functions -q tmux
  alias whodat="tmux ls"
  alias sup="tmux attach -t"
  alias peace="tmux detach"
end
if not functions -q bat
  alias ccat="cat"
  alias cat="bat --tabs=2"
end
if not functions -q eza
  alias ls=eza
  alias ll='eza --all --long --header --grid --ignore-glob="*.un~|*node_modules|*.git*" --git-ignore'
  alias lx='eza --all --long --header --grid --ignore-glob="*.un~|*node_modules"'
else
  alias ll="ls -Agplash"
end

alias fishpro="ni ~/.config/fish/config.fish"
alias fishsource="source ~/.config/fish/config.fish"
alias fishbat="cat ~/.config/fish/config.fish"
alias fishgat="cat ~/.config/fish/config.fish | rg"

# old habits die hard

alias ..="cd .."

alias bashpro="fishpro"
alias bashsource="fishsource"
# alias j="z" # never washed
function j
  z $argv[1]
  pwd
end

# ripgrep
set -x RIPGREP_CONFIG_PATH ~/.ripgreprc

# other languages

## javasc-- oh, gross
# set JAVA_HOME /Library/Java/JavaVirtualMachines/adoptopenjdk-11.jdk/Contents/Home
# ruby
set PATH usr/local/opt/ruby/bin $PATH

## why would I ever want an infinite list?
# set GHCUP_INSTALL_BASE_PREFIX = $HOME
set PATH $HOME/.cabal/bin $PATH
# set PATH $HOME/.ghcup/bin $PATH
set PATH $HOME/.local/bin $PATH

## make sure you have tetanus
# source $HOME/.cargo/env
set PATH $HOME/.cargo/bin $PATH


set -x GOPATH $HOME/go
set -x PATH $PATH /usr/local/go/bin $GOPATH/bin

# fun

function figfont
  figlet -l | sort -R | head -1
end

function figtext
  figlet -f (figfont) $argv[1]
end

function figtest
  set TEST_FONT (figfont)
  echo "figlet -f \"$TEST_FONT\" $argv[1]"
  figlet -f "$TEST_FONT" $argv[1] | lolcat
end

function fish_greeting
  pwd
end

alias xovi="xargs -o nvim"
alias xoni="xargs -o nvim"
alias yoni="xargs -o nvim"

function crumb
  tee last-run.log && cat last-run.log
end

function where
  find . -iname $argv[1]
end
function swhere
  find . -iname $argv[1] -maxdepth 2
end
alias swear=swhere
function vhere
  where $argv[1] | xovi
end
function fhere
  echo $argv[1] | xargs rg -l | xovi
end

function vislow
  echo "vim rules, except when it sucks"
  set vimpro ~/work/vim-profiler/vim-profiler.py
  $vimpro $argv[1]
end

# inspired by:
# https://github.com/srid/neuron/blob/master/neuron/src-bash/neuron-search
function rf --description 'interactive file contents `rg` searching via `fzf`'
  set match (rg -i --no-heading --no-line-number --with-filename --sort path $argv[1] | fzf)
  if test $status -eq 0
    echo $match | awk -F: "{printf \$1}" | xovi
  end
end

function gdiff --description 'diff yer shit'
  git difftool $argv[1] $argv[2] -y
end

# ghcup-env
set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME
test -f /Users/brekkbockrath/.ghcup/env ; and set -gx PATH $HOME/.cabal/bin /Users/brekkbockrath/.ghcup/bin $PATH

function kaldiff --description 'compare shit'
  git difftool -y -t Kaleidoscope $argv[1] $argv[2]
end

#source ~/.iterm2_shell_integration.(basename $SHELL)

function gitsplit --description 'checkout a fresh copy'
  git checkout $argv[1]
  git pull
  git checkout -b $argv[2]
end

alias mastersplit='gitsplit master'

alias 'tofix'="snang -P 'lines | filter(includes(\'both modified\')) | map(split(C._)) | map(filter(I)) | map(last) | join(C._)'"
alias squeal='docker exec -it ironfish_postgres psql -U postgres'

# fishy pathing
# https://superuser.com/questions/776008/how-to-remove-a-path-from-path-variable-in-fish

function addpaths
    contains -- $argv $fish_user_paths
       or set -U fish_user_paths $fish_user_paths $argv
    echo "Updated PATH: $PATH"
end

function removepath
    if set -l index (contains -i $argv[1] $PATH)
        set --erase --universal fish_user_paths[$index]
        echo "Updated PATH: $PATH"
    else
        echo "$argv[1] not found in PATH: $PATH"
    end
end

# funcsave addpaths; funcsave removepath
