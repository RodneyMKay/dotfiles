explorer() {
    if ! command -v explorer.exe > /dev/null; then
        echo "Windows explorer could not be found!" >&2
    fi

    if [ $# -lt 0 ]; then
        explorer.exe "$@"
    else
        explorer.exe .
    fi
}

alias e=explorer

