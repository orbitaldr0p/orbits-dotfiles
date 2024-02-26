if status is-interactive
    # Commands to run in interactive sessions can go here
end
starship init fish | source
pyenv init - | source
set PATH "$HOME/.local/bin:$PATH"