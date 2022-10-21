# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

export PATH=$HOME/.toolbox/bin:$HOME/IdeaProjects/Github/darken99/misc/:$PATH
export JAVA_TOOLS_OPTIONS="-Dlog4j2.formatMsgNoLookups=true"
