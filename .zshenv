
# source helper for optional files
include() {
    [[ -f "$1" ]] && source "$1"
}

include ~/.ignored/.zshenv
