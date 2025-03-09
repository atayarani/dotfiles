export ADDITIONAL_ZSH_CONFIGS="${ZDOTDIR}/configs"
source ${ADDITIONAL_ZSH_CONFIGS}/xdg ### Set XDG Paths
source ${ADDITIONAL_ZSH_CONFIGS}/fzf ### Configure fzf


source ${ADDITIONAL_ZSH_CONFIGS}/homebrew ### Configure Homebrew


export STARSHIP_CONFIG=$XDG_CONFIG_HOME/starship/starship.toml

source ${ADDITIONAL_ZSH_CONFIGS}/compinstall ### Configure zsh completion
source ${ADDITIONAL_ZSH_CONFIGS}/pyenv ### Configure pyenv

export _ZO_DATA_DIR=$XDG_DATA_HOME
eval "$(zoxide init zsh)"

export SHELDON_PROFILE=Work
eval "$(sheldon source)"
