projects() { 
    # Dotfiles are always first
    echo "~/dotfiles"

    # Then search all .git dirs in ~/projects and return their parents
    # as a list sorted by their modification time
    find ~/projects -maxdepth 4 -type d -name .git -printf "%Ts %p\n" \
        | sort -n \
        | sed 's:^[0-9]\+ ::g' \
        | sed 's:/.git$::g'
} 

find_projects() { 
    # Allow fuzzy finding the right project
    cd "$(projects \
        | sed "s:^$HOME:~:g" \
        | fzf --preview "cat {}/README.md" \
        | sed "s:^~:$HOME:g")"

    # Update the prompt
    zle accept-line 
}

# Bind find_projects as zsh widget/keybind to CTRL + P
zle -N find_projects
bindkey '^P' find_projects

