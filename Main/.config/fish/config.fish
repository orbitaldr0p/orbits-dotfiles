if status is-interactive
    # Commands to run in interactive sessions can go here
end
starship init fish | source
pyenv init - | source
set PATH "$HOME/.local/bin:$PATH"
set PATH "/usr/local/texlive/2024/bin/x86_64-linux:$PATH"
set MANPATH "/usr/local/texlive/2024/texmf-dist/doc/man:$MANPATH"
set INFOPATH "/usr/local/texlive/2024/texmf-dist/doc/info:$INFOPATH"