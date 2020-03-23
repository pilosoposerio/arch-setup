#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

source ~/.bash_functions
source ~/.bash_aliases

shopt -s checkwinsize
#====================================================#
# create custom PS1                                  #
#====================================================#

#
# helper functions 
#
# function to get color code
function color() {
    # sample call: color <fg> <bg> <format?>
    colorCode="\e["
    # text formatting
    case "${3}" in
        bold)        format+='1' ;;
        underline)   format+='4' ;;
        *)           format+='0' ;;
    esac
    colorCode+=';'
    # foreground color
    case "${1}" in
        black)          colorCode+='30' ;;
        transparent)    colorCode+='30' ;;
        red)            colorCode+='31' ;;
        green)          colorCode+='32' ;;
        blue)           colorCode+='34' ;;
        yellow)         colorCode+='33' ;;
        magenta)        colorCode+='95' ;;
        purple)         colorCode+='95' ;;
        cyan)           colorCode+='36' ;;
        white)          colorCode+='37' ;;
        orange)         colorCode+='33' ;;
        violet)         colorCode+='95' ;;
        *)              colorCode+='39';;
    esac 
    case "${2}" in
        default)        colorCode+=';49' ;;
        black)          colorCode+=';40' ;;
        red)            colorCode+=';41' ;;
        green)          colorCode+=';42' ;;
        blue)           colorCode+=';44' ;;
        yellow)         colorCode+=';43' ;;
        magenta)        colorCode+=';105' ;;
        purple)         colorCode+=';105' ;;
        cyan)           colorCode+=';46' ;;
        white)          colorCode+=';47' ;;
        orange)         colorCode+=';43' ;;
        violet)         colorCode+=';105' ;;
    esac
    colorCode+='m'

    printf "${colorCode}"
}

# get current status of git repo
function parse_git_dirty {
    status=`git status 2>&1 | tee`
    dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
    untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
    ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
    newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
    renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
    deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
    bits=''
    if [ "${renamed}" == "0" ]; then
      bits=">${bits}"
    fi
    if [ "${ahead}" == "0" ]; then
      bits="*${bits}"
    fi
    if [ "${newfile}" == "0" ]; then
      bits="+${bits}"
    fi
    if [ "${untracked}" == "0" ]; then
      bits="?${bits}"
    fi  
    if [ "${deleted}" == "0" ]; then
      bits="x${bits}"
    fi  
    if [ "${dirty}" == "0" ]; then
      bits="!${bits}"
    fi  
    if [ ! "${bits}" == "" ]; then
      echo " ${bits}" 
    else
      echo ""
    fi
}  

# function for git status in PS1
# get current branch in git repo
function parse_git_branch() {
    BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
    if [ ! "${BRANCH}" == "" ]
    then
      STAT=`parse_git_dirty`
      echo "[  ${BRANCH}${STAT}]"
    else
      echo ""
    fi
}

# special characters used in bash prompt
buntot="🭨"
ulo="🭬"
king="🨀 "
folder=" "
pin="📍"
tao=" "
pc="  "

# start building bash_prompt
rst="\e[m"
# initialize prompt
p=""
# add username
p+="\[$(color red black)\]"
p+="${buntot}"
p+="\[$(color cyan red)\]"
p+="${tao} \u "
p+="\[$(color red cyan)\]"
p+="${ulo}"
# add hostname
p+="\[$(color red cyan)\]"
p+="${pc} \h "
p+="\[$(color cyan yellow)\]"
p+="${ulo}"
# add working directory
p+="\[$(color black yellow)\]"
p+=${folder}
p+=" \w "
p+="\[$(color yellow default)\]"
p+="${ulo} "
# add it stuff
p+="\[$(color green default)\]" 
p+="\`parse_git_branch\`"

p+="\[${rst}\]"
# add new line for the King's command
p+="\n ${king}\[${rst}\] "
export PS1="${p}"

