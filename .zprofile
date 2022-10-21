export HISTCONTROL=ignoreboth:erasedups

alias mwinit="mwinit --aea"
alias aws_account_id="aws sts get-caller-identity --query 'Account' --output text"

if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi


a2() {
 nc -G1 -z pub-gw.a2invest.com 22 >/dev/null 2>&1 || knock -d 100 pub-gw.a2invest.com 32690 22206 27000
 ssh -F ~/BoxCryptor/security/ssh/configs/a2 $1
}

a2scp() {
 nc -G1 -z pub-gw.a2invest.com 22 >/dev/null 2>&1 || knock -d 100 pub-gw.a2invest.com 32690 22206 27000
 scp -F ~/BoxCryptor/security/ssh/configs/a2 "$@"
}
export JAVA_TOOLS_OPTIONS="-Dlog4j2.formatMsgNoLookups=true"
