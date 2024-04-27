
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="ys"



plugins=(vscode catimg extract copypath web-search copyfile sudo git z zsh-syntax-highlighting zsh-autosuggestions)


source $ZSH/oh-my-zsh.sh

# 简化命令
alias ...=../..
alias ....=../../..
alias .....=../../../..
alias ......=../../../../..
alias 1='cd -'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'
alias _='sudo '
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias gc1='git clone --recursive --depth=1'
alias globurl='noglob urlglobber '
alias grep='grep --color=auto'


# 比ls和cat更好的替代品
if [[ $(command -v exa) ]] {
	DISABLE_LS_COLORS=true
	unset LS_BIN_FILE
	for i (/bin/ls ${PREFIX}/bin/ls /usr/bin/ls /usr/local/bin/ls) {
		[[ ! -x ${i} ]] || {
			local LS_BIN_FILE=${i}
					break
				}
			}
			[[ -n ${LS_BIN_FILE} ]] || local LS_BIN_FILE=$(whereis ls 2>/dev/null | awk '{print $2}')
			alias lls=${LS_BIN_FILE} 
			# lls is the original ls. lls为原版ls
			alias ls="exa --color=auto" 
			# Exa is a modern version of ls. exa是一款优秀的ls替代品,拥有更好的文件展示体验,输出结果更快,使用rust编写。
			alias l='exa -lbah --icons'
			alias la='exa -labgh --icons'
			alias ll='exa -lbg --icons'
			alias lsa='exa -lbagR --icons'
			alias lst='exa -lTabgh --icons' # 输入lst,将展示类似于tree的树状列表。
		} else {
		alias ls='ls --color=auto'
		alias lst='tree -pCsh'
		alias l='ls -lah'
		alias la='ls -lAh'
		alias ll='ls -lh'
		alias lsa='ls -lah'
	}

	set_bat_paper_variable() {
		unset CAT_BIN_FILE i
		for i (/bin/cat ${PREFIX}/bin/cat /usr/bin/cat /usr/local/bin/cat) {
			[[ ! -x ${i} ]] || {
				local CAT_BIN_FILE=${i}
							unset i
							break
						}
					}
					[[ -n ${CAT_BIN_FILE} ]] || local CAT_BIN_FILE=$(whereis cat 2>/dev/null | awk '{print $2}')
					alias lcat=${CAT_BIN_FILE} 
					# lcat is the original cat.
					typeset -g BAT_PAGER="less -m -RFQ" # 输q退出bat的页面视图
				}
				# bat是cat的替代品，支持多语言语法高亮。
				for i (batcat bat) {
					if [[ $(command -v ${i}) ]] {
						alias cat="${i} -pp"
						set_bat_paper_variable
						break
					}
				}


## 兼容dos命令
alias md='mkdir -p'
alias rd='rmdir'
alias cls='clear'
alias dir='ls'
alias copy='cp'
alias move='mv'
alias del='rm -i'
alias taskkill='kill'
alias ipconfig='ifconfig'
alias rename='mv'

## 文件安全配置
alias rm='rm -i'
function rm() {
	if [ "$#" -eq 0 ]; then
		command rm -i
	else
		local args=()
		for arg in "$@"; do
			case "$arg" in
				-r) args+=(-ir) ;;
				-rf) args+=(-ir) ;;
				-f) args+=(-i) ;;
				*) args+=("$arg") ;;
			esac
		done
		command rm "${args[@]}"
	fi
}
# 嫌麻烦直接用Trash-put,然后Trash-empty


## 欢迎语
neofetch | lolcat
figlet -f big "        TZGML" | lolcat

