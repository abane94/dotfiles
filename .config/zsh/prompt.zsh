# Enable substitution in prompt variables
setopt prompt_subst

# Helper to wrap non-printing codes
pc() {
  echo "%{$1%}"
}

BG() { pc "%K{$1}"; }
FG() { pc "%F{$1}"; }
RESET="%f%k"

# Colors
BG_HOST=170
BG_USER=39
BG_DIR=29
BG_ICON=63
BG_BUGFIX=160
BG_FEATURE=40
BG_RELEASE=11

FG_HOST=black
FG_USER=239
FG_DIR=black
FG_ICON=236
FG_FINAL=63

# Static segments
HOST_SEG="$(BG $BG_HOST)$(FG $FG_HOST)$HOST$(pc $RESET)"
SEP_HOST="$(BG $BG_USER)$(FG $BG_HOST) $(pc $RESET)"

USER="$(BG $BG_USER)$(FG $FG_USER)%n$(pc $RESET)"
SEP_USER="$(BG $BG_DIR)$(FG $BG_USER) $(pc $RESET)"

DIR="$(BG $BG_DIR)$(FG $FG_DIR)%~$(pc $RESET)"
SEP_DIR="$(BG $BG_ICON)$(FG $BG_DIR) $(pc $RESET)"

SEP_FINAL="$(FG $FG_FINAL) $(pc $RESET)"

# Git branch segment
build_icon_segment() {
  local raw_branch prefix short_name bg

  if command git rev-parse --is-inside-work-tree &>/dev/null; then
    raw_branch=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD)
    prefix="${raw_branch%%/*}/"
    short_name="${raw_branch#*/}"

    case "$prefix" in
      bugfix/)  bg=$BG_BUGFIX ;;
      feature/) bg=$BG_FEATURE ;;
      release/) bg=$BG_RELEASE ;;
      *)        bg=$BG_ICON ;;
    esac

    echo "$(BG $bg)$(FG $FG_ICON) ⎇ ${short_name} $(pc $RESET)"
  else
    echo "$(BG $BG_ICON)$(FG $FG_ICON) > $(pc $RESET)"
  fi
}

# Final prompt builder
build_prompt() {
  local ICON
  ICON=$(build_icon_segment)
  PROMPT="${HOST_SEG}${SEP_HOST}${USER}${SEP_USER}${DIR}${SEP_DIR}${ICON}${SEP_FINAL}"
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd build_prompt
