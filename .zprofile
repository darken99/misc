export HISTCONTROL=ignoreboth:erasedups

alias mwinit="mwinit --aea"
alias aws_account_id="aws sts get-caller-identity --query 'Account' --output text"

if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi

export JAVA_TOOLS_OPTIONS="-Dlog4j2.formatMsgNoLookups=true"
