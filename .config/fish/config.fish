if status is-interactive
    # Commands to run in interactive sessions can go here
    set --global hydro_color_pwd ff5050
    set --global hydro_color_git e0e0a0
    set --global hydro_color_prompt 305070
    set --global hydro_color_duration 005555
end

set -gx PATH "$PATH:/home/sarunas/.cache/scalacli/local-repo/bin/scala-cli"
