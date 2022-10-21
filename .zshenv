export PAGER=

a2() {
 nc -G1 -z pub-gw.a2invest.com 22 >/dev/null 2>&1 || knock -d 100 pub-gw.a2invest.com 32690 22206 27000
 ssh -F ~/BoxCryptor/security/ssh/configs/a2 $1
}

a2scp() {
 nc -G1 -z pub-gw.a2invest.com 22 >/dev/null 2>&1 || knock -d 100 pub-gw.a2invest.com 32690 22206 27000
 scp -F ~/BoxCryptor/security/ssh/configs/a2 "$@"
}
