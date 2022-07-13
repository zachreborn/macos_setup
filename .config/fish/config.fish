if status is-interactive
    # Commands to run in interactive sessions can go here
end

status is-login; and pyenv init --path | source
status is-interactive; and pyenv init - | source
source (pyenv init - | psub)
oh-my-posh --init --shell fish --config ~/.poshthemes/octo-theme.omp.json | source
