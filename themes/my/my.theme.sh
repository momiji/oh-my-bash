_orange="\[\033[48;5;202m\]"
_green="\[\033[48;5;35m\]"
_blue="\[\033[48;5;25m\]"
_purple="\[\033[48;5;92m\]"
_red="\[\033[48;5;52m\]"
_gray="\[\033[48;5;240m\]"
_violet="\[\033[48;5;197m\]"

THEME_CLOCK_FORMAT="%Y-%m-%d %H:%M:%S"
THEME_CLOCK_COLOR="${_gray}"
CLOCK_THEME_PROMPT_PREFIX=" "
CLOCK_THEME_PROMPT_SUFFIX=" "

SCM_THEME_CHAR_PREFIX=""
SCM_THEME_CHAR_SUFFIX=""
SCM_THEME_PROMPT_PREFIX=""
SCM_THEME_PROMPT_SUFFIX=""
SCM_THEME_PROMPT_DIRTY=""
SCM_THEME_PROMPT_CLEAN=""

SCM_GIT_CHAR="±"
SCM_SVN_CHAR="⑆"
SCM_HG_CHAR="☿"

#Mysql Prompt
export MYSQL_PS1="(\u@\h) [\d]> "

PS3=">> "

__my_venv_prompt() {
  local p=${PROMPT_ENVIRONMENT:-$VIRTUAL_ENV}
  if [ ! -z "$p" ]
  then
    echo "${_violet} ${p##*/} "
  fi
}

is_vim_shell() {
        if [ ! -z "$VIMRUNTIME" ]
        then
                echo "${_blue} vim shell "
        fi
}

modern_scm_prompt() {
        scm_prompt_vars &> /dev/null
        if [ $SCM_CHAR = $SCM_NONE_CHAR ]
        then
                return
        elif [ $SCM_DIRTY -eq 0 ]; then
                echo "${_blue} ${SCM_CHAR} $(scm_prompt_info) "
        else
                echo "${_purple} ${SCM_CHAR} $(scm_prompt_info) "
        fi
}

prompt() {
    local my_ps_status=$?
    local my_ps_host="${_green} \h ";
    local my_ps_user="${_orange} \u ";
    local my_ps_path="${_gray} \w ";
    local my_ps_prompt="${bold_green}\$ "

    [ $my_ps_status -ne 0 ] && my_ps_status="${_red} $my_ps_status " && my_ps_prompt="${bold_red}\$ " || my_ps_status=""

    # nice prompt
    PS1="${normal}${TITLEBAR}$(clock_prompt)$my_ps_user$my_ps_host$(modern_scm_prompt)$(__my_venv_prompt)${my_ps_path}${is_vim_shell}${my_ps_status}\033[K\n\033[?7711h${normal}${my_ps_prompt}${normal}"
}

PS2="> "

safe_append_prompt_command prompt

