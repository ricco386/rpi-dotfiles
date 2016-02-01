# OS specific aliases
case ${OSTYPE} in

	solaris*)
		alias ls='ls -G'
		if which ggrep &>/dev/null; then 
			alias grep='ggrep --color=auto'
			alias fgrep='gfgrep --color=auto'
			alias egrep='gegrep --color=auto'
		fi
	;;

	darwin*)
		alias ls='ls -GF'
	;;

	*)
		alias ls='ls --color=auto'
		alias dir='dir --color=auto'
		alias vdir='vdir --color=auto'
		alias grep='grep --color=auto'
		alias fgrep='fgrep --color=auto'
		alias egrep='egrep --color=auto'
	;;

esac

# Add some other handy aliases
alias ll='ls -lh'
alias la='ll -a'
alias lp='ll -p'

alias df='df -h'

#shortcuts
alias lsd='ls -F | ls -d */'
alias nsu='sudo -s'
alias j=jobs
alias h=history
alias vi=vim

#fixing typos
alias cd..='cd ..'
alias ...='../..'


