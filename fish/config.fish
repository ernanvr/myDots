if status is-interactive
    # Commands to run in interactive sessions can go here
end

function fish_greeting

end
set -gx ANDROID_SDK_ROOT $HOME/.android_sdk
set -gx ANDROID_HOME $HOME/.android_sdk
set -gx CHROME_EXECUTABLE /snap/bin/brave
set -gx EDITOR nvim
set -gx JAVA_HOME /usr/lib/jvm/java-19-openjdk-amd64/

set SPACEFISH_PROMPT_ADD_NEWLINE false
set SPACEFISH_PROMPT_SEPARATE_LINE false

function la
    exa --icons --long -ha $argv
end

function ls
    exa --icons $argv
end

function r
    batcat $argv
end

function t
    $HOME/.todotxt/todo.sh $argv
end

function tms

    # argument handling
    if test (count $argv) -eq 1
        set selected $argv[1]
    else
        set selected (find ~/Proyectos/ ~/.config/ -mindepth 1 -maxdepth 1 -type d | fzf)
    end

    # check if a directory was selected
    if test -z $selected
        exit 0
    end

    # extract session name and replace dots with underscores
    set selected_name (basename $selected | tr . _)

    # check for existing Tmux session
    if not set -q TMUX
        # Tmux not running, start a new session
        tmux new-session -s $selected_name -c $selected
        exit 0
    end

    # check for existing session with the same name
    if not tmux has-session -t $selected_name 2>/dev/null
        tmux new-session -ds $selected_name -c $selected
    end

    # switch to the session
    tmux switch-client -t $selected_name

end

function fish_remove_path --description "Shows user added PATH entries and removes the selected one"
    echo "User added PATH entries"
    set -l PATH_ENTRIES
    echo $fish_user_paths | sed 's/ \//\n\//g' | nl
    echo "Select the number of entry to be removed, if more than one separate the values by spaces"
    read -d " " -a PATH_ENTRIES
    for entry in $PATH_ENTRIES
        if string match -qr '^[0-9]+$' $entry
            # "$entry it is a number!"
            set -l FISH_ENTRIES (count $fish_user_paths)
            if test $entry -gt $FISH_ENTRIES
                echo "Index out of bounds, must be between 1 and $FISH_ENTRIES" 1>&2
            else
                echo "Erasing $fish_user_paths[$entry]"
                echo "Press y to continue"
                set -l confirmation
                read confirmation
                if test "$confirmation" = y
                    set --erase --universal fish_user_paths[$entry]
                else
                    echo "skipping..."
                end
            end
        else
            echo "Provided argument $entry is not a number" 1>&2
        end
    end
end

# =============================================================================
# Flutter watch command
function flutter-watch
    tmux send-keys "flutter run $argv[1] $argv[2] $argv[3] $argv[4] --pid-file=/tmp/tf1.pid" Enter \;
    tmux split-window -v \;
    tmux send-keys 'npx -y nodemon -e dart -x "cat /tmp/tf1.pid | xargs kill -s USR1"' Enter \;
    tmux resize-pane -y 5 -t 1 \;
    tmux select-pane -t 0 \;
end

# =============================================================================
#
# Utility functions for zoxide.
#

# pwd based on the value of _ZO_RESOLVE_SYMLINKS.
function __zoxide_pwd
    builtin pwd -L
end

# A copy of fish's internal cd function. This makes it possible to use
# `alias cd=z` without causing an infinite loop.
if ! builtin functions --query __zoxide_cd_internal
    if builtin functions --query cd
        builtin functions --copy cd __zoxide_cd_internal
    else
        alias __zoxide_cd_internal='builtin cd'
    end
end

# cd + custom logic based on the value of _ZO_ECHO.
function __zoxide_cd
    __zoxide_cd_internal $argv
end

# =============================================================================
#
# Hook configuration for zoxide.
#

# Initialize hook to add new entries to the database.
function __zoxide_hook --on-variable PWD
    test -z "$fish_private_mode"
    and command zoxide add -- (__zoxide_pwd)
end

# =============================================================================
#
# When using zoxide with --no-cmd, alias these internal functions as desired.
#

if test -z $__zoxide_z_prefix
    set __zoxide_z_prefix 'z!'
end
set __zoxide_z_prefix_regex ^(string escape --style=regex $__zoxide_z_prefix)

# Jump to a directory using only keywords.
function __zoxide_z
    set -l argc (count $argv)
    if test $argc -eq 0
        __zoxide_cd $HOME
    else if test "$argv" = -
        __zoxide_cd -
    else if test $argc -eq 1 -a -d $argv[1]
        __zoxide_cd $argv[1]
    else if set -l result (string replace --regex $__zoxide_z_prefix_regex '' $argv[-1]); and test -n $result
        __zoxide_cd $result
    else
        set -l result (command zoxide query --exclude (__zoxide_pwd) -- $argv)
        and __zoxide_cd $result
    end
end

# Completions.
function __zoxide_z_complete
    set -l tokens (commandline --current-process --tokenize)
    set -l curr_tokens (commandline --cut-at-cursor --current-process --tokenize)
    #
    if test (count $tokens) -le 2 -a (count $curr_tokens) -eq 1
        # If there are < 2 arguments, use `cd` completions.
        complete --do-complete "'' "(commandline --cut-at-cursor --current-token) | string match --regex '.*/$'
    else if test (count $tokens) -eq (count $curr_tokens); and ! string match --quiet --regex $__zoxide_z_prefix_regex. $tokens[-1]
        # If the last argument is empty and the one before doesn't start with
        # $__zoxide_z_prefix, use interactive selection.
        set -l query $tokens[2..-1]
        set -l result (zoxide query --exclude (__zoxide_pwd) --interactive -- $query)
        and echo $__zoxide_z_prefix$result
        commandline --function repaint
    end
end
complete --command __zoxide_z --no-files --arguments '(__zoxide_z_complete)'

# Jump to a directory using interactive search.
function __zoxide_zi
    set -l result (command zoxide query --interactive -- $argv)
    and __zoxide_cd $result
end

# =============================================================================
#
# Commands for zoxide. Disable these using --no-cmd.
#

abbr --erase z &>/dev/null
alias z=__zoxide_z

abbr --erase zi &>/dev/null
alias zi=__zoxide_zi

# =============================================================================
#
# To initialize zoxide, add this to your configuration (usually
# ~/.config/fish/config.fish):
#
zoxide init fish | source

# =============================================================================

oh-my-posh init fish --config '~/.ohmyposh/theme.omp.json' | source
