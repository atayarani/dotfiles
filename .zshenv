export ZDOTDIR="${HOME}/.config/zsh"
source $ZDOTDIR/.zshenv

aws_pip(){
 local DOMAIN='mill-pypi-prod'
 local OWNER='195366328548'
 local REPO='mill-pkgs'

 aws codeartifact login --tool pip --domain "${DOMAIN}" --domain-owner "${OWNER}" --repository "${REPO}"
}

