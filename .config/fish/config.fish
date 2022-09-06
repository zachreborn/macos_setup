if status is-interactive
    # Commands to run in interactive sessions can go here
end

status is-login; and pyenv init --path | source
status is-interactive; and pyenv init - | source
source (pyenv init - | psub)
oh-my-posh --init --shell fish --config ~/.poshthemes/octo-theme.omp.json | source


set PYENV_ROOT $HOME/.pyenv
set -x PATH $PYENV_ROOT/shims $PATH
set -x PATH $PYENV_ROOT/bin $PATH

if command -v pyenv 1>/dev/null 2>&1
    pyenv init - | source
end