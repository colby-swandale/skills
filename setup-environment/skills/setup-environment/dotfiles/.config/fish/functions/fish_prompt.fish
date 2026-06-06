function fish_prompt
    set -l last_status $status
    set -l cwd (string replace -r "^$HOME" "~" $PWD)

    # Clear cached branch when the directory changes
    if test "$_pure_prompt_pwd" != "$PWD"
        set -g _pure_prompt_pwd $PWD
        set -g _pure_git_branch ""
    end

    # Path + cached git branch
    echo ""
    if test -n "$_pure_git_branch"
        echo -n (set_color blue)"$cwd "(set_color brblack)"$_pure_git_branch"(set_color normal)
    else
        echo -n (set_color blue)"$cwd"(set_color normal)
    end
    echo ""

    # Prompt character
    if test $last_status -ne 0
        echo -n (set_color red)"❯ "(set_color normal)
    else
        echo -n "❯ "
    end

    _pure_git_update_async
end

# Triggered by SIGUSR1 from the background git job
function _pure_git_signal --on-signal SIGUSR1
    if set -q _pure_git_tmpfile; and test -f $_pure_git_tmpfile
        set -g _pure_git_branch (string trim <$_pure_git_tmpfile)
        rm -f $_pure_git_tmpfile
    end
    commandline -f repaint 2>/dev/null
end

function _pure_git_update_async
    # Cancel any in-flight job
    if set -q _pure_git_job_pid
        kill $_pure_git_job_pid 2>/dev/null
    end

    set -g _pure_git_tmpfile (mktemp)
    set -l tmpfile $_pure_git_tmpfile
    set -l parent_pid $fish_pid
    set -l dir $PWD

    begin
        set -l branch ""
        if git -C $dir rev-parse --is-inside-work-tree &>/dev/null
            set branch (git -C $dir symbolic-ref --short HEAD 2>/dev/null
                        or git -C $dir rev-parse --short HEAD 2>/dev/null)
        end
        echo $branch >$tmpfile
        kill -SIGUSR1 $parent_pid
    end &

    set -g _pure_git_job_pid $last_pid
end
