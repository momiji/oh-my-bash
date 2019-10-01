THEME_CLOCK_FORMAT="%Y-%m-%d %H:%M:%S"
THEME_CLOCK_COLOR="${yellow}"
CLOCK_THEME_PROMPT_PREFIX=""
CLOCK_THEME_PROMPT_SUFFIX=""
SCM_THEME_PROMPT_PREFIX=""
SCM_THEME_PROMPT_SUFFIX=""

SCM_THEME_PROMPT_DIRTY=" ${bold_red}✗${normal}"
SCM_THEME_PROMPT_CLEAN=" ${bold_green}✓${normal}"
SCM_GIT_CHAR="${bold_cyan}±${normal}"
SCM_SVN_CHAR="${bold_green}⑆${normal}"
SCM_HG_CHAR="${bold_red}☿${normal}"

#Mysql Prompt
export MYSQL_PS1="(\u@\h) [\d]> "

case $TERM in
        xterm*)
        TITLEBAR="\[\033]0;\w\007\]"
        ;;
        *)
        TITLEBAR=""
        ;;
esac

PS3=">> "

__my_rvm_ruby_version() {
    local gemset=$(echo $GEM_HOME | awk -F'@' '{print $2}')
  [ "$gemset" != "" ] && gemset="@$gemset"
    local version=$(echo $MY_RUBY_HOME | awk -F'-' '{print $2}')
    local full="$version$gemset"
  [ "$full" != "" ] && echo "[$full]"
}

__my_venv_prompt() {
  if [ ! -z "$PROMPT_ENVIRONMENT" ]
  then
    echo "[${yellow}@${PROMPT_ENVIRONMENT}${normal}]"
  fi
}

is_vim_shell() {
        if [ ! -z "$VIMRUNTIME" ]
        then
                echo "[${cyan}vim shell${normal}]"
        fi
}

modern_scm_prompt() {
        CHAR=$(scm_char)
        if [ $CHAR = $SCM_NONE_CHAR ]
        then
                return
        else
                echo "[$(scm_char)][$(scm_prompt_info)]"
        fi
}

prompt() {

    local my_ps_status=$?
    local my_ps_host="${green}\h${normal}";
    local my_ps_user="\[\033[01;32m\]\u\[\033[00m\]";
    local my_ps_root="\[\033[01;31m\]\u\[\033[00m\]";
    local my_ps_path="\[\033[01;36m\]\w\[\033[00m\]";

    [ $my_ps_status -ne 0 ] && my_ps_status="${red}$my_ps_status${normal} " || my_ps_status=""

    # nice prompt
    case "`id -u`" in
        0) PS1="${normal}${TITLEBAR}[$(clock_prompt)${normal}][$my_ps_root][$my_ps_host]$(modern_scm_prompt)$(__my_venv_prompt)[${cyan}\w${normal}]$(is_vim_shell)
${my_ps_status}$ "
        ;;
        *) PS1="${normal}${TITLEBAR}[$(clock_prompt)${normal}][$my_ps_user][$my_ps_host]$(modern_scm_prompt)$(__my_venv_prompt)[${cyan}\w${normal}]$(is_vim_shell)
${my_ps_status}$ "
        ;;
    esac
}

PS2="> "



safe_append_prompt_command prompt
