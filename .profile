export ANDROID_HOME=~/android_sdk/
export WELKIN_VIRTUALENV_PATH=$HOME/ENV
export PYRAMID_RELOAD_TEMPLATES=1
export CONFIG='dev.ini'
alias envactivate='source $WELKIN_VIRTUALENV_PATH/bin/activate'
export PATH=$PATH:/Users/awans/bin:/Users/awans/android_sdk/tools:/Users/awans/android_sdk/platform-tools
alias enter_welkin_env='cd ~/welkin; envactivate'
export WELKIN_ROOT='/Users/awans/welkin'

alias koala="$WELKIN_ROOT/start_server.sh --attached --reload --app koala"
alias kangaroo="~/welkin/start_server.sh --attached --reload --app kangaroo"
alias dugong="( cd $WELKIN_ROOT/dugong && brunch w -s)"
alias shortfin="( cd $WELKIN_ROOT/shortfin && brunch w )"
alias wlocal="~/welkin/wallaby/scripts/setprop on w_local_dev"
alias wstaging="~/welkin/wallaby/scripts/setprop off w_local_dev"
alias welcat="pidcat -l E com.welkin.android"


alias pull="git pull --rebase"
alias push="git push origin"
alias st="git st"
alias co="git co"
alias br="git br"
alias ci="git ci"
alias vim="nvim"

export AWS_ACCESS_KEY="AKIAJLWV422VWUPCUDRQ"
export AWS_SECRET_KEY="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"
enter_welkin_env

alias ct="ctags --options=$WELKIN_ROOT/.ctags.conf $WELKIN_ROOT"
alias unit="(py.test -x */test/unit && osascript -e 'display notification \"oh wonderful\" with title \"Unit tests pass\"') || osascript -e 'display notification \"ha ha ha\" with title \"Unit tests failed\"'"
ssh-add ~/.ssh/welkin-new-servers.pem &> /dev/null

function frameworkpython {
    if [[ ! -z "$VIRTUAL_ENV" ]]; then
        PYTHONHOME=$VIRTUAL_ENV /usr/local/bin/python "$@"
    else
        /usr/local/bin/python "$@"
    fi
}

export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
alias prune="git branch --merged | grep -v \"\\\*\" | grep -v master | xargs -n 1 git branch -d"
ssh-add -A 2>/dev/null
export EDITOR=nvim
alias staged='git shortlog $(deploy current-hash prod)..HEAD'
export FZF_DEFAULT_COMMAND='ag -g ""'

