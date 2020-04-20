
function bobthefish_colors -S -d 'Define a custom bobthefish color scheme'

  # optionally include a base color scheme...
  # __bobthefish_colors base16
  # set -x color_repo                     green black

      set -l base00 181818
      set -l base01 282828
      set -l base02 383838
      set -l base03 585858
      set -l base04 b8b8b8
      set -l base05 d8d8d8
      set -l base06 e8e8e8
      set -l base07 f8f8f8
      set -l base08 9b3632 # red
      set -l base09 cc8646 # orange
      set -l base0A f7ca88 # yellow
      set -l base0B 71853c # green
      set -l base0C 86c1b9 # cyan
      set -l base0D 7cafc2 # blue
      set -l base0E ba8baf # violet
      set -l base0F a16946 # brown

      set -l colorfg $base07

      set -x color_initial_segment_exit     $base05 $base08 --bold
      set -x color_initial_segment_su       $base05 $base0B --bold
      set -x color_initial_segment_jobs     $base05 $base0D --bold

      set -x color_path                     $base02 $base05
      set -x color_path_basename            $base02 $base06 --bold
      set -x color_path_nowrite             $base02 $base08
      set -x color_path_nowrite_basename    $base02 $base08 --bold

      set -x color_repo                     $base0B $base01
      set -x color_repo_work_tree           $base02 $colorfg --bold
      set -x color_repo_dirty               $base08 $base07
      set -x color_repo_staged              $base09 $base01

      set -x color_vi_mode_default          $base03 $colorfg --bold
      set -x color_vi_mode_insert           $base0B $colorfg --bold
      set -x color_vi_mode_visual           $base09 $colorfg --bold

      set -x color_vagrant                  $base0C $colorfg --bold
      set -x color_k8s                      $base0B $colorfg --bold
      set -x color_username                 $base02 $base0D --bold
      set -x color_hostname                 $base02 $base0D
      set -x color_rvm                      $base08 $colorfg --bold
      set -x color_nvm                      $base0B $colorfg --bold
      set -x color_virtualfish              $base0D $colorfg --bold
      set -x color_virtualgo                $base0D $colorfg --bold
      set -x color_desk                     $base0D $colorfg --bold
end
