# Add `~/bin` to the `$PATH`
export PATH="$HOME/bin:$PATH"

#cycle through commands and dirs
#bind '"\t":menu-complete'

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{bash_prompt,exports,aliases,functions} /etc/bash_completion $(brew --prefix)/etc/bash_completion; do
	[[ -f "$file" ]] && source "$file"
done
unset file

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# Append to the Bash history file, rather than overwriting it
shopt -s histappend

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

#Allow forward incremental search
stty -ixon -ixoff

#set emacs mode for bash shortcuts i like
set -o emacs

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
	shopt -s "$option" 2> /dev/null
done

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
#[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^[Hh]ost" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2 | tr ' ' '\n')" scp sftp ssh
_complete_hosts() {
	COMPREPLY=()
	cur="${COMP_WORDS[COMP_CWORD]}"
	host_list=$({ 
		for c in /etc/ssh_config /etc/ssh/ssh_config ~/.ssh/config
		do [ -r $c ] && sed -n -e 's/^[hH]ost[[:space:]]//p' -e 's/^[[:space:]]*[hH]ostname[[:space:]]//p' $c
		done
		for k in /etc/ssh_known_hosts /etc/ssh/ssh_known_hosts ~/.ssh/known_hosts
		do [ -r $k ] && egrep -v '^[#\[]' $k|cut -f 1 -d ' '|sed -e 's/[,:].*//g'
		done
		sed -n -e 's/^[0-9][0-9\.]*//p' /etc/hosts; }|tr ' ' '\n'|grep -v '\*')
	COMPREPLY=( $(compgen -W "${host_list}" -- "$cur"))
	return 0
}
complete -F _complete_hosts ssh sftp host scp

# Add tab completion for `defaults read|write NSGlobalDomain`
# You could just use `-g` instead, but I like being explicit
complete -W "NSGlobalDomain" defaults

# Add `killall` tab completion for common apps
complete -o "nospace" -W "Contacts Calendar Dock Finder Mail Safari iTunes SystemUIServer Terminal Twitter" killall
