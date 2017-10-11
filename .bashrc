alias safari="open -a /Applications/Safari.app"
alias finder="open -a /Applications/Finder.app"
alias chrome="open -a /Applications/Google Chrome.app"
alias atom="open -a /Applications/Atom.app"
alias serial="screen /dev/cu.usbmodem*"

#:set foldmethod=marker

# Terminal Color
tco() {  # {{{
    ## echo $(tco RED)Hello$(tco)
    ## echo $(tco RED Hello)
    ## PS1="$(tco -e RED \u@\h)"

    local output=
    local i=0 c= opt_e=
    local colors=(black red green yellow blue magenta cyan white \
                  BLACK RED GREEN YELLOW BLUE MAGENTA CYAN WHITE)  # Bolded

    [[ $1 = "-e" ]] && opt_e=1 && shift

    for c in ${colors[@]}; do
        if [[ $1 == $c ]]; then
            [[ $i -gt 7 ]] && output+="\[$(tput bold)\]"
            output+="\[$(tput setaf $((i % 8)))\]"
            shift
            break
        fi
        ((i++))
    done
    if [[ ( $# -ne 0 ) || ( $i -eq ${#colors[@]} ) ]]; then
        output+="$@\[$(tput sgr0)\]"
    fi
    if [[ -z $opt_e ]]; then
        output="$(echo "$output" | sed -E 's/\\\[|\\\]//g')"
    fi
    echo -n "$output"
}  # }}}

#---------------------------------------------------------
# プロンプト (PS1) #{{{
# mac)    \h:\W \u\$
# cygwin) \u@\h \w\n\$
# debian|ubuntu|suse)   \u@\h:\w\$
# redhat|fedora|centos) [\u@\h \W]\$
if [[ -x /usr/bin/tput ]] && $(tput setaf 1 >& /dev/null); then
    if [[ $USER = "root" ]]; then
        PS1="$(tco -e RED '\u@'):$(tco -e blue '\w')\$ "
    elif [[ -n $SSH_CLIENT ]]; then
        PS1="$(tco -e MAGENTA '\u@'):$(tco -e blue '\w')\$ "
    else
        PS1="$(tco -e GREEN '\u@'):$(tco -e blue '\w')\$ "
    fi
else
    PS1="\u@:\w\$ "
fi #}}}
#-----------------------------------
#エラーメッセージの色付き表示
dump() {  # {{{
    # dump RED "Error! File not found."
    echo "$(tco $@)" 1>&2
} # }}}
#-----------------------------------
#存在するコマンドを返す
getcmd() {  # {{{
    for cmd in "$@";do
        if [[ -n "$(which "$cmd")" ]];then
            echo "$cmd"
            return 0
        fi
    done
    return 1
}

#使い方
# emacs が無ければ vim を探し、無ければ vi を探し...
export EDITOR=$(getcmd emacs vim vi nano) #}}}
#-----------------------------------


#旧
#PS1='\u@:\W\$ '

# コマンドサーチパスの追加
# MacPortsのパスを追加
#PATH=/opt/local/bin:$PATH

# エイリアスの設定 #{{{
alias ls='ls -aF'
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'
alias ..='cd ..'
alias ...='cd -'
alias cot='open -a CotEditor'
alias screensaver='/System/Library/Frameworks/ScreenSaver.framework/Resources/ScreenSaverEngine.app/Contents/MacOS/ScreenSaverEngine'
#}}}

# 関数の読み込み
#. /usr/local/bin/saykanji.sh

# シェルオプションの設定
# *ワイルドカードで、.不可視ファイルにもヒットする設定 #{{{
#   $ ls *bash*
#   .bash_history  .bash_profile  .bashrc
shopt -s dotglob #}}}

