
syn clear scalaspecial
syn match scalaspecial "\%(=\+>\|⇒\|<-\+\|←\|-\+>\|→\)"
syn match scalaspecial /`[^`]\+`/  " backtick literals
hi link scalaspecial preproc

