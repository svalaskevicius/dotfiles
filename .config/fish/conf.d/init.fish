if status --is-login
	for p in ~/bin ~/.config/fish/bin ~/.cargo/bin ~/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/bin/ ~/go/bin ~/.local/bin ~/.local/share/coursier/bin
		if test -d $p
			set -x PATH $p $PATH
		end
	end
end


# set fish_greeting ""
set -x _JAVA_AWT_WM_NONREPARENTING 1
set -x JAVA_HOME /usr/lib/jvm/java-21-openjdk
set -x CLICOLOR 1
set -x EDITOR vim
set -x BROWSER firefox
# set -x LS_COLORS "bd=38;5;68:ca=38;5;17:cd=38;5;113;1:di=38;5;30:do=38;5;127:ex=38;5;208;1:pi=38;5;126:fi=0:ln=target:mh=38;5;222;1:no=0:or=48;5;196;38;5;232;1:ow=38;5;220;1:sg=48;5;3;38;5;0:su=38;5;220;1;3;100;1:so=38;5;197:st=38;5;86;48;5;234:tw=48;5;235;38;5;139;3:*LS_COLORS=48;5;89;38;5;197;1;3;4;7:*README=38;5;220;1:*README.rst=38;5;220;1:*LICENSE=38;5;220;1:*COPYING=38;5;220;1:*INSTALL=38;5;220;1:*COPYRIGHT=38;5;220;1:*AUTHORS=38;5;220;1:*HISTORY=38;5;220;1:*CONTRIBUTORS=38;5;220;1:*PATENTS=38;5;220;1:*VERSION=38;5;220;1:*NOTICE=38;5;220;1:*CHANGES=38;5;220;1:*.log=38;5;190:*.txt=38;5;253:*.etx=38;5;184:*.info=38;5;184:*.markdown=38;5;184:*.md=38;5;184:*.mkd=38;5;184:*.nfo=38;5;184:*.pod=38;5;184:*.rst=38;5;184:*.tex=38;5;184:*.textile=38;5;184:*.json=38;5;178:*.msg=38;5;178:*.pgn=38;5;178:*.rss=38;5;178:*.xml=38;5;178:*.yaml=38;5;178:*.yml=38;5;178:*.RData=38;5;178:*.rdata=38;5;178:*.cbr=38;5;141:*.cbz=38;5;141:*.chm=38;5;141:*.djvu=38;5;141:*.pdf=38;5;141:*.PDF=38;5;141:*.docm=38;5;111;4:*.doc=38;5;111:*.docx=38;5;111:*.eps=38;5;111:*.ps=38;5;111:*.odb=38;5;111:*.odt=38;5;111:*.rtf=38;5;111:*.odp=38;5;166:*.pps=38;5;166:*.ppt=38;5;166:*.pptx=38;5;166:*.ppts=38;5;166:*.pptxm=38;5;166;4:*.pptsm=38;5;166;4:*.csv=38;5;78:*.ods=38;5;112:*.xla=38;5;76:*.xls=38;5;112:*.xlsx=38;5;112:*.xlsxm=38;5;112;4:*.xltm=38;5;73;4:*.xltx=38;5;73:*cfg=1:*conf=1:*rc=1:*.ini=1:*.plist=1:*.viminfo=1:*.pcf=1:*.psf=1:*.git=38;5;197:*.gitignore=38;5;240:*.gitattributes=38;5;240:*.gitmodules=38;5;240:*.awk=38;5;172:*.bash=38;5;172:*.bat=38;5;172:*.BAT=38;5;172:*.sed=38;5;172:*.sh=38;5;172:*.zsh=38;5;172:*.vim=38;5;172:*.ahk=38;5;41:*.py=38;5;41:*.pl=38;5;208:*.PL=38;5;160:*.t=38;5;114:*.msql=38;5;222:*.mysql=38;5;222:*.pgsql=38;5;222:*.sql=38;5;222:*.tcl=38;5;64;1:*.r=38;5;49:*.R=38;5;49:*.gs=38;5;81:*.asm=38;5;81:*.cl=38;5;81:*.lisp=38;5;81:*.lua=38;5;81:*.moon=38;5;81:*.c=38;5;81:*.C=38;5;81:*.h=38;5;110:*.H=38;5;110:*.tcc=38;5;110:*.c++=38;5;81:*.h++=38;5;110:*.hpp=38;5;110:*.hxx=38;5;110:*.ii=38;5;110:*.M=38;5;110:*.m=38;5;110:*.cc=38;5;81:*.cs=38;5;81:*.cp=38;5;81:*.cpp=38;5;81:*.cxx=38;5;81:*.cr=38;5;81:*.go=38;5;81:*.f=38;5;81:*.for=38;5;81:*.ftn=38;5;81:*.s=38;5;110:*.S=38;5;110:*.rs=38;5;81:*.swift=38;5;219:*.sx=38;5;81:*.hi=38;5;110:*.hs=38;5;81:*.lhs=38;5;81:*.pyc=38;5;240:*.css=38;5;125;1:*.less=38;5;125;1:*.sass=38;5;125;1:*.scss=38;5;125;1:*.htm=38;5;125;1:*.html=38;5;125;1:*.jhtm=38;5;125;1:*.mht=38;5;125;1:*.eml=38;5;125;1:*.mustache=38;5;125;1:*.coffee=38;5;074;1:*.java=38;5;074;1:*.js=38;5;074;1:*.mjs=38;5;074;1:*.jsm=38;5;074;1:*.jsm=38;5;074;1:*.jsp=38;5;074;1:*.php=38;5;81:*.ctp=38;5;81:*.twig=38;5;81:*.vb=38;5;81:*.vba=38;5;81:*.vbs=38;5;81:*Dockerfile=38;5;155:*.dockerignore=38;5;240:*Makefile=38;5;155:*MANIFEST=38;5;243:*pm_to_blib=38;5;240:*.am=38;5;242:*.in=38;5;242:*.hin=38;5;242:*.scan=38;5;242:*.m4=38;5;242:*.old=38;5;242:*.out=38;5;242:*.SKIP=38;5;244:*.diff=48;5;197;38;5;232:*.patch=48;5;197;38;5;232;1:*.bmp=38;5;97:*.tiff=38;5;97:*.tif=38;5;97:*.TIFF=38;5;97:*.cdr=38;5;97:*.gif=38;5;97:*.ico=38;5;97:*.jpeg=38;5;97:*.JPG=38;5;97:*.jpg=38;5;97:*.nth=38;5;97:*.png=38;5;97:*.psd=38;5;97:*.xpm=38;5;97:*.ai=38;5;99:*.eps=38;5;99:*.epsf=38;5;99:*.drw=38;5;99:*.ps=38;5;99:*.svg=38;5;99:*.avi=38;5;114:*.divx=38;5;114:*.IFO=38;5;114:*.m2v=38;5;114:*.m4v=38;5;114:*.mkv=38;5;114:*.MOV=38;5;114:*.mov=38;5;114:*.mp4=38;5;114:*.mpeg=38;5;114:*.mpg=38;5;114:*.ogm=38;5;114:*.rmvb=38;5;114:*.sample=38;5;114:*.wmv=38;5;114:*.3g2=38;5;115:*.3gp=38;5;115:*.gp3=38;5;115:*.webm=38;5;115:*.gp4=38;5;115:*.asf=38;5;115:*.flv=38;5;115:*.ts=38;5;115:*.ogv=38;5;115:*.f4v=38;5;115:*.VOB=38;5;115;1:*.vob=38;5;115;1:*.3ga=38;5;137;1:*.S3M=38;5;137;1:*.aac=38;5;137;1:*.au=38;5;137;1:*.dat=38;5;137;1:*.dts=38;5;137;1:*.fcm=38;5;137;1:*.m4a=38;5;137;1:*.mid=38;5;137;1:*.midi=38;5;137;1:*.mod=38;5;137;1:*.mp3=38;5;137;1:*.mp4a=38;5;137;1:*.oga=38;5;137;1:*.ogg=38;5;137;1:*.opus=38;5;137;1:*.s3m=38;5;137;1:*.sid=38;5;137;1:*.wma=38;5;137;1:*.ape=38;5;136;1:*.aiff=38;5;136;1:*.cda=38;5;136;1:*.flac=38;5;136;1:*.alac=38;5;136;1:*.midi=38;5;136;1:*.pcm=38;5;136;1:*.wav=38;5;136;1:*.wv=38;5;136;1:*.wvc=38;5;136;1:*.afm=38;5;66:*.fon=38;5;66:*.fnt=38;5;66:*.pfb=38;5;66:*.pfm=38;5;66:*.ttf=38;5;66:*.otf=38;5;66:*.PFA=38;5;66:*.pfa=38;5;66:*.7z=38;5;40:*.a=38;5;40:*.arj=38;5;40:*.bz2=38;5;40:*.cpio=38;5;40:*.gz=38;5;40:*.lrz=38;5;40:*.lz=38;5;40:*.lzma=38;5;40:*.lzo=38;5;40:*.rar=38;5;40:*.s7z=38;5;40:*.sz=38;5;40:*.tar=38;5;40:*.tgz=38;5;40:*.xz=38;5;40:*.z=38;5;40:*.Z=38;5;40:*.zip=38;5;40:*.zipx=38;5;40:*.zoo=38;5;40:*.zpaq=38;5;40:*.zz=38;5;40:*.apk=38;5;215:*.deb=38;5;215:*.rpm=38;5;215:*.jad=38;5;215:*.jar=38;5;215:*.cab=38;5;215:*.pak=38;5;215:*.pk3=38;5;215:*.vdf=38;5;215:*.vpk=38;5;215:*.bsp=38;5;215:*.dmg=38;5;215:*.r[0-9]{0,2}=38;5;239:*.zx[0-9]{0,2}=38;5;239:*.z[0-9]{0,2}=38;5;239:*.part=38;5;239:*.dmg=38;5;124:*.iso=38;5;124:*.bin=38;5;124:*.nrg=38;5;124:*.qcow=38;5;124:*.sparseimage=38;5;124:*.toast=38;5;124:*.vcd=38;5;124:*.vmdk=38;5;124:*.accdb=38;5;60:*.accde=38;5;60:*.accdr=38;5;60:*.accdt=38;5;60:*.db=38;5;60:*.fmp12=38;5;60:*.fp7=38;5;60:*.localstorage=38;5;60:*.mdb=38;5;60:*.mde=38;5;60:*.sqlite=38;5;60:*.typelib=38;5;60:*.nc=38;5;60:*.pacnew=38;5;33:*.un~=38;5;241:*.orig=38;5;241:*.BUP=38;5;241:*.bak=38;5;241:*.o=38;5;241:*.rlib=38;5;241:*.swp=38;5;244:*.swo=38;5;244:*.tmp=38;5;244:*.sassc=38;5;244:*.pid=38;5;248:*.state=38;5;248:*lockfile=38;5;248:*.err=38;5;160;1:*.error=38;5;160;1:*.stderr=38;5;160;1:*.dump=38;5;241:*.stackdump=38;5;241:*.zcompdump=38;5;241:*.zwc=38;5;241:*.pcap=38;5;29:*.cap=38;5;29:*.dmp=38;5;29:*.DS_Store=38;5;239:*.localized=38;5;239:*.CFUserTextEncoding=38;5;239:*.allow=38;5;112:*.deny=38;5;196:*.service=38;5;45:*@.service=38;5;45:*.socket=38;5;45:*.swap=38;5;45:*.device=38;5;45:*.mount=38;5;45:*.automount=38;5;45:*.target=38;5;45:*.path=38;5;45:*.timer=38;5;45:*.snapshot=38;5;45:*.application=38;5;116:*.cue=38;5;116:*.description=38;5;116:*.directory=38;5;116:*.m3u=38;5;116:*.m3u8=38;5;116:*.md5=38;5;116:*.properties=38;5;116:*.sfv=38;5;116:*.srt=38;5;116:*.theme=38;5;116:*.torrent=38;5;116:*.urlview=38;5;116:*.asc=38;5;192;3:*.bfe=38;5;192;3:*.enc=38;5;192;3:*.gpg=38;5;192;3:*.signature=38;5;192;3:*.sig=38;5;192;3:*.p12=38;5;192;3:*.pem=38;5;192;3:*.pgp=38;5;192;3:*.asc=38;5;192;3:*.enc=38;5;192;3:*.sig=38;5;192;3:*.32x=38;5;213:*.cdi=38;5;213:*.fm2=38;5;213:*.rom=38;5;213:*.sav=38;5;213:*.st=38;5;213:*.a00=38;5;213:*.a52=38;5;213:*.A64=38;5;213:*.a64=38;5;213:*.a78=38;5;213:*.adf=38;5;213:*.atr=38;5;213:*.gb=38;5;213:*.gba=38;5;213:*.gbc=38;5;213:*.gel=38;5;213:*.gg=38;5;213:*.ggl=38;5;213:*.ipk=38;5;213:*.j64=38;5;213:*.nds=38;5;213:*.nes=38;5;213:*.sms=38;5;213:*.pot=38;5;7:*.pcb=38;5;7:*.mm=38;5;7:*.pod=38;5;7:*.gbr=38;5;7:*.spl=38;5;7:*.scm=38;5;7:*.Rproj=38;5;11:*.sis=38;5;7:*.1p=38;5;7:*.3p=38;5;7:*.cnc=38;5;7:*.def=38;5;7:*.ex=38;5;7:*.example=38;5;7:*.feature=38;5;7:*.ger=38;5;7:*.map=38;5;7:*.mf=38;5;7:*.mfasl=38;5;7:*.mi=38;5;7:*.mtx=38;5;7:*.pc=38;5;7:*.pi=38;5;7:*.plt=38;5;7:*.pm=38;5;7:*.rb=38;5;7:*.rdf=38;5;7:*.rst=38;5;7:*.ru=38;5;7:*.sch=38;5;7:*.sty=38;5;7:*.sug=38;5;7:*.t=38;5;7:*.tdy=38;5;7:*.tfm=38;5;7:*.tfnt=38;5;7:*.tg=38;5;7:*.vcard=38;5;7:*.vcf=38;5;7:*.xln=38;5;7:*.iml=38;5;166:*.xcconfig=1:*.entitlements=1:*.strings=1:*.storyboard=38;5;196:*.xcsettings=1:*.xib=38;5;208:"
# vivid generate ayu
set -x LS_COLORS "pi=0;38;2;0;0;0;48;2;27;125;196:mi=0;38;2;0;0;0;48;2;237;102;106:*~=0;38;2;170;170;170:di=0;38;2;27;125;196:ex=1;38;2;237;102;106:ln=0;38;2;240;113;113:or=0;38;2;0;0;0;48;2;237;102;106:fi=0:no=0:so=0;38;2;0;0;0;48;2;240;113;113:*.c=0;38;2;49;136;102:*.o=0;38;2;170;170;170:*.r=0;38;2;49;136;102:*.d=0;38;2;49;136;102:*.p=0;38;2;49;136;102:*.z=4;38;2;134;179;0:*.t=0;38;2;49;136;102:*.h=0;38;2;49;136;102:*.a=1;38;2;237;102;106:*.m=0;38;2;49;136;102:*.cp=0;38;2;49;136;102:*.fs=0;38;2;49;136;102:*.cr=0;38;2;49;136;102:*.hh=0;38;2;49;136;102:*.la=0;38;2;170;170;170:*.nb=0;38;2;49;136;102:*.ml=0;38;2;49;136;102:*.sh=0;38;2;49;136;102:*.ex=0;38;2;49;136;102:*.hi=0;38;2;170;170;170:*.7z=4;38;2;134;179;0:*.xz=4;38;2;134;179;0:*.as=0;38;2;49;136;102:*.kt=0;38;2;49;136;102:*.vb=0;38;2;49;136;102:*.cc=0;38;2;49;136;102:*.ko=1;38;2;237;102;106:*.bz=4;38;2;134;179;0:*.lo=0;38;2;170;170;170:*.rb=0;38;2;49;136;102:*.ps=0;38;2;237;102;106:*.so=1;38;2;237;102;106:*.pp=0;38;2;49;136;102:*.js=0;38;2;49;136;102:*.go=0;38;2;49;136;102:*.ui=0;38;2;237;147;102:*.gv=0;38;2;49;136;102:*css=0;38;2;49;136;102:*.md=0;38;2;237;147;102:*.di=0;38;2;49;136;102:*.mn=0;38;2;49;136;102:*.rm=0;38;2;240;113;113:*.py=0;38;2;49;136;102:*.el=0;38;2;49;136;102:*.gz=4;38;2;134;179;0:*.rs=0;38;2;49;136;102:*.jl=0;38;2;49;136;102:*.ts=0;38;2;49;136;102:*.cs=0;38;2;49;136;102:*.hs=0;38;2;49;136;102:*.pl=0;38;2;49;136;102:*.pm=0;38;2;49;136;102:*.exs=0;38;2;49;136;102:*.asa=0;38;2;49;136;102:*.ltx=0;38;2;49;136;102:*.ipp=0;38;2;49;136;102:*.idx=0;38;2;170;170;170:*.rar=4;38;2;134;179;0:*.com=1;38;2;237;102;106:*.rpm=4;38;2;134;179;0:*.hxx=0;38;2;49;136;102:*.gif=0;38;2;240;113;113:*.png=0;38;2;240;113;113:*.csv=0;38;2;237;147;102:*.cpp=0;38;2;49;136;102:*.vcd=4;38;2;134;179;0:*.pod=0;38;2;49;136;102:*.elm=0;38;2;49;136;102:*.xmp=0;38;2;237;147;102:*.c++=0;38;2;49;136;102:*.pps=0;38;2;237;102;106:*.bcf=0;38;2;170;170;170:*.pas=0;38;2;49;136;102:*.htm=0;38;2;237;147;102:*.bin=4;38;2;134;179;0:*.fnt=0;38;2;240;113;113:*.vim=0;38;2;49;136;102:*hgrc=0;38;2;154;232;69:*.ini=0;38;2;237;147;102:*.log=0;38;2;170;170;170:*.arj=4;38;2;134;179;0:*.fls=0;38;2;170;170;170:*.iso=4;38;2;134;179;0:*.bak=0;38;2;170;170;170:*.php=0;38;2;49;136;102:*.wmv=0;38;2;240;113;113:*.bsh=0;38;2;49;136;102:*.tgz=4;38;2;134;179;0:*.odp=0;38;2;237;102;106:*.mkv=0;38;2;240;113;113:*.mpg=0;38;2;240;113;113:*.pyc=0;38;2;170;170;170:*.htc=0;38;2;49;136;102:*.toc=0;38;2;170;170;170:*.img=4;38;2;134;179;0:*.sbt=0;38;2;49;136;102:*.ods=0;38;2;237;102;106:*.ilg=0;38;2;170;170;170:*.blg=0;38;2;170;170;170:*.xml=0;38;2;237;147;102:*.exe=1;38;2;237;102;106:*.aux=0;38;2;170;170;170:*.mid=0;38;2;240;113;113:*.kts=0;38;2;49;136;102:*.rst=0;38;2;237;147;102:*.otf=0;38;2;240;113;113:*.dll=1;38;2;237;102;106:*.fsi=0;38;2;49;136;102:*.dot=0;38;2;49;136;102:*.sxi=0;38;2;237;102;106:*.svg=0;38;2;240;113;113:*.ico=0;38;2;240;113;113:*.bmp=0;38;2;240;113;113:*.aif=0;38;2;240;113;113:*.tbz=4;38;2;134;179;0:*.pgm=0;38;2;240;113;113:*.fsx=0;38;2;49;136;102:*.pdf=0;38;2;237;102;106:*.apk=4;38;2;134;179;0:*.git=0;38;2;170;170;170:*.bag=4;38;2;134;179;0:*.clj=0;38;2;49;136;102:*.deb=4;38;2;134;179;0:*.bst=0;38;2;237;147;102:*.zsh=0;38;2;49;136;102:*.ics=0;38;2;237;102;106:*.fon=0;38;2;240;113;113:*.csx=0;38;2;49;136;102:*.rtf=0;38;2;237;102;106:*.dmg=4;38;2;134;179;0:*.kex=0;38;2;237;102;106:*.dox=0;38;2;154;232;69:*.txt=0;38;2;237;147;102:*.gvy=0;38;2;49;136;102:*.m4v=0;38;2;240;113;113:*.pro=0;38;2;154;232;69:*.tar=4;38;2;134;179;0:*.ps1=0;38;2;49;136;102:*.pkg=4;38;2;134;179;0:*.dpr=0;38;2;49;136;102:*.ppt=0;38;2;237;102;106:*.sxw=0;38;2;237;102;106:*.avi=0;38;2;240;113;113:*.bat=1;38;2;237;102;106:*TODO=1:*.bbl=0;38;2;170;170;170:*.epp=0;38;2;49;136;102:*.h++=0;38;2;49;136;102:*.cxx=0;38;2;49;136;102:*.erl=0;38;2;49;136;102:*.pbm=0;38;2;240;113;113:*.tif=0;38;2;240;113;113:*.mp4=0;38;2;240;113;113:*.tcl=0;38;2;49;136;102:*.bib=0;38;2;237;147;102:*.cgi=0;38;2;49;136;102:*.wav=0;38;2;240;113;113:*.mp3=0;38;2;240;113;113:*.sty=0;38;2;170;170;170:*.tsx=0;38;2;49;136;102:*.yml=0;38;2;237;147;102:*.jpg=0;38;2;240;113;113:*.lua=0;38;2;49;136;102:*.xls=0;38;2;237;102;106:*.cfg=0;38;2;237;147;102:*.tex=0;38;2;49;136;102:*.xlr=0;38;2;237;102;106:*.out=0;38;2;170;170;170:*.vob=0;38;2;240;113;113:*.ogg=0;38;2;240;113;113:*.swf=0;38;2;240;113;113:*.awk=0;38;2;49;136;102:*.wma=0;38;2;240;113;113:*.swp=0;38;2;170;170;170:*.mov=0;38;2;240;113;113:*.bz2=4;38;2;134;179;0:*.nix=0;38;2;237;147;102:*.zip=4;38;2;134;179;0:*.xcf=0;38;2;240;113;113:*.mli=0;38;2;49;136;102:*.doc=0;38;2;237;102;106:*.flv=0;38;2;240;113;113:*.jar=4;38;2;134;179;0:*.tmp=0;38;2;170;170;170:*.sql=0;38;2;49;136;102:*.hpp=0;38;2;49;136;102:*.ind=0;38;2;170;170;170:*.ttf=0;38;2;240;113;113:*.pid=0;38;2;170;170;170:*.tml=0;38;2;237;147;102:*.odt=0;38;2;237;102;106:*.ppm=0;38;2;240;113;113:*.inl=0;38;2;49;136;102:*.h264=0;38;2;240;113;113:*.mpeg=0;38;2;240;113;113:*.dart=0;38;2;49;136;102:*.psd1=0;38;2;49;136;102:*.xlsx=0;38;2;237;102;106:*.json=0;38;2;237;147;102:*.java=0;38;2;49;136;102:*.toml=0;38;2;237;147;102:*.less=0;38;2;49;136;102:*.yaml=0;38;2;237;147;102:*.flac=0;38;2;240;113;113:*.diff=0;38;2;49;136;102:*.docx=0;38;2;237;102;106:*.make=0;38;2;154;232;69:*.html=0;38;2;237;147;102:*.jpeg=0;38;2;240;113;113:*.hgrc=0;38;2;154;232;69:*.conf=0;38;2;237;147;102:*.pptx=0;38;2;237;102;106:*.lisp=0;38;2;49;136;102:*.orig=0;38;2;170;170;170:*.rlib=0;38;2;170;170;170:*.fish=0;38;2;49;136;102:*.purs=0;38;2;49;136;102:*.epub=0;38;2;237;102;106:*.tbz2=4;38;2;134;179;0:*.lock=0;38;2;170;170;170:*.bash=0;38;2;49;136;102:*.psm1=0;38;2;49;136;102:*.patch=0;38;2;49;136;102:*.scala=0;38;2;49;136;102:*README=0;38;2;0;0;0;48;2;237;147;102:*.toast=4;38;2;134;179;0:*.shtml=0;38;2;237;147;102:*.dyn_o=0;38;2;170;170;170:*.swift=0;38;2;49;136;102:*shadow=0;38;2;237;147;102:*.mdown=0;38;2;237;147;102:*passwd=0;38;2;237;147;102:*.cmake=0;38;2;154;232;69:*.ipynb=0;38;2;49;136;102:*.class=0;38;2;170;170;170:*.cache=0;38;2;170;170;170:*.xhtml=0;38;2;237;147;102:*.cabal=0;38;2;49;136;102:*LICENSE=0;38;2;102;102;102:*.matlab=0;38;2;49;136;102:*.flake8=0;38;2;154;232;69:*COPYING=0;38;2;102;102;102:*.dyn_hi=0;38;2;170;170;170:*.groovy=0;38;2;49;136;102:*.gradle=0;38;2;49;136;102:*INSTALL=0;38;2;0;0;0;48;2;237;147;102:*.ignore=0;38;2;154;232;69:*.config=0;38;2;237;147;102:*TODO.md=1:*TODO.txt=1:*Makefile=0;38;2;154;232;69:*setup.py=0;38;2;154;232;69:*.desktop=0;38;2;237;147;102:*Doxyfile=0;38;2;154;232;69:*.gemspec=0;38;2;154;232;69:*.rgignore=0;38;2;154;232;69:*README.md=0;38;2;0;0;0;48;2;237;147;102:*configure=0;38;2;154;232;69:*.markdown=0;38;2;237;147;102:*.cmake.in=0;38;2;154;232;69:*COPYRIGHT=0;38;2;102;102;102:*.fdignore=0;38;2;154;232;69:*.kdevelop=0;38;2;154;232;69:*SConstruct=0;38;2;154;232;69:*.scons_opt=0;38;2;170;170;170:*Dockerfile=0;38;2;237;147;102:*CODEOWNERS=0;38;2;154;232;69:*INSTALL.md=0;38;2;0;0;0;48;2;237;147;102:*.gitconfig=0;38;2;154;232;69:*.gitignore=0;38;2;154;232;69:*README.txt=0;38;2;0;0;0;48;2;237;147;102:*SConscript=0;38;2;154;232;69:*.travis.yml=0;38;2;49;136;102:*.gitmodules=0;38;2;154;232;69:*.synctex.gz=0;38;2;170;170;170:*Makefile.in=0;38;2;170;170;170:*Makefile.am=0;38;2;154;232;69:*LICENSE-MIT=0;38;2;102;102;102:*MANIFEST.in=0;38;2;154;232;69:*appveyor.yml=0;38;2;49;136;102:*configure.ac=0;38;2;154;232;69:*.applescript=0;38;2;49;136;102:*.fdb_latexmk=0;38;2;170;170;170:*CONTRIBUTORS=0;38;2;0;0;0;48;2;237;147;102:*.clang-format=0;38;2;154;232;69:*LICENSE-APACHE=0;38;2;102;102;102:*CMakeCache.txt=0;38;2;170;170;170:*CMakeLists.txt=0;38;2;154;232;69:*.gitattributes=0;38;2;154;232;69:*INSTALL.md.txt=0;38;2;0;0;0;48;2;237;147;102:*CONTRIBUTORS.md=0;38;2;0;0;0;48;2;237;147;102:*CONTRIBUTORS.txt=0;38;2;0;0;0;48;2;237;147;102:*requirements.txt=0;38;2;154;232;69:*.sconsign.dblite=0;38;2;170;170;170:*package-lock.json=0;38;2;170;170;170"
# vivid -m 8-bit generate ayu
set -x EZA_COLORS "fi=0:so=0;38;5;16;48;5;203:ln=0;38;5;203:ex=1;38;5;203:no=0:mi=0;38;5;16;48;5;203:pi=0;38;5;16;48;5;32:di=0;38;5;32:or=0;38;5;16;48;5;203:*~=0;38;5;248:*.c=0;38;5;65:*.o=0;38;5;248:*.h=0;38;5;65:*.p=0;38;5;65:*.m=0;38;5;65:*.d=0;38;5;65:*.t=0;38;5;65:*.z=4;38;5;106:*.a=1;38;5;203:*.r=0;38;5;65:*.rs=0;38;5;65:*.kt=0;38;5;65:*.nb=0;38;5;65:*.hi=0;38;5;248:*.vb=0;38;5;65:*.so=1;38;5;203:*css=0;38;5;65:*.gz=4;38;5;106:*.jl=0;38;5;65:*.pp=0;38;5;65:*.cp=0;38;5;65:*.cc=0;38;5;65:*.ts=0;38;5;65:*.rm=0;38;5;203:*.ml=0;38;5;65:*.bz=4;38;5;106:*.fs=0;38;5;65:*.py=0;38;5;65:*.hs=0;38;5;65:*.xz=4;38;5;106:*.as=0;38;5;65:*.sh=0;38;5;65:*.pl=0;38;5;65:*.la=0;38;5;248:*.js=0;38;5;65:*.el=0;38;5;65:*.ps=0;38;5;203:*.pm=0;38;5;65:*.ex=0;38;5;65:*.lo=0;38;5;248:*.7z=4;38;5;106:*.rb=0;38;5;65:*.mn=0;38;5;65:*.ui=0;38;5;209:*.hh=0;38;5;65:*.cs=0;38;5;65:*.di=0;38;5;65:*.ko=1;38;5;203:*.cr=0;38;5;65:*.md=0;38;5;209:*.go=0;38;5;65:*.gv=0;38;5;65:*.log=0;38;5;248:*.awk=0;38;5;65:*.bib=0;38;5;209:*.sql=0;38;5;65:*.xlr=0;38;5;203:*.h++=0;38;5;65:*.img=4;38;5;106:*.cfg=0;38;5;209:*.iso=4;38;5;106:*.arj=4;38;5;106:*.ps1=0;38;5;65:*.doc=0;38;5;203:*.avi=0;38;5;203:*.bz2=4;38;5;106:*.bbl=0;38;5;248:*.vim=0;38;5;65:*.kex=0;38;5;203:*.xls=0;38;5;203:*.com=1;38;5;203:*.cxx=0;38;5;65:*.elm=0;38;5;65:*.sty=0;38;5;248:*.bst=0;38;5;209:*.tcl=0;38;5;65:*.swp=0;38;5;248:*.mov=0;38;5;203:*.pps=0;38;5;203:*.ics=0;38;5;203:*.kts=0;38;5;65:*.fsx=0;38;5;65:*.rtf=0;38;5;203:*.dpr=0;38;5;65:*.htm=0;38;5;209:*.sbt=0;38;5;65:*TODO=1:*.asa=0;38;5;65:*.ltx=0;38;5;65:*.csx=0;38;5;65:*.mid=0;38;5;203:*.dot=0;38;5;65:*.fls=0;38;5;248:*.rar=4;38;5;106:*.ttf=0;38;5;203:*.fon=0;38;5;203:*.jpg=0;38;5;203:*.out=0;38;5;248:*.bat=1;38;5;203:*.toc=0;38;5;248:*.flv=0;38;5;203:*.dox=0;38;5;113:*.wav=0;38;5;203:*.zsh=0;38;5;65:*.epp=0;38;5;65:*.wmv=0;38;5;203:*.csv=0;38;5;209:*.ilg=0;38;5;248:*.deb=4;38;5;106:*.dll=1;38;5;203:*.mli=0;38;5;65:*.rst=0;38;5;209:*.exs=0;38;5;65:*.mp4=0;38;5;203:*.wma=0;38;5;203:*.lua=0;38;5;65:*.git=0;38;5;248:*.m4v=0;38;5;203:*.ogg=0;38;5;203:*.bin=4;38;5;106:*.idx=0;38;5;248:*.pdf=0;38;5;203:*.ipp=0;38;5;65:*.tsx=0;38;5;65:*.ind=0;38;5;248:*.apk=4;38;5;106:*.tif=0;38;5;203:*.tbz=4;38;5;106:*.tml=0;38;5;209:*.blg=0;38;5;248:*.ppt=0;38;5;203:*.cpp=0;38;5;65:*.php=0;38;5;65:*.txt=0;38;5;209:*.xml=0;38;5;209:*hgrc=0;38;5;113:*.hxx=0;38;5;65:*.mkv=0;38;5;203:*.otf=0;38;5;203:*.xcf=0;38;5;203:*.cgi=0;38;5;65:*.odt=0;38;5;203:*.swf=0;38;5;203:*.pbm=0;38;5;203:*.gif=0;38;5;203:*.pod=0;38;5;65:*.erl=0;38;5;65:*.fnt=0;38;5;203:*.zip=4;38;5;106:*.vcd=4;38;5;106:*.bag=4;38;5;106:*.mp3=0;38;5;203:*.pro=0;38;5;113:*.ini=0;38;5;209:*.pas=0;38;5;65:*.hpp=0;38;5;65:*.tar=4;38;5;106:*.rpm=4;38;5;106:*.aif=0;38;5;203:*.sxi=0;38;5;203:*.bcf=0;38;5;248:*.bsh=0;38;5;65:*.ico=0;38;5;203:*.bak=0;38;5;248:*.c++=0;38;5;65:*.pyc=0;38;5;248:*.nix=0;38;5;209:*.dmg=4;38;5;106:*.gvy=0;38;5;65:*.pid=0;38;5;248:*.pgm=0;38;5;203:*.bmp=0;38;5;203:*.ppm=0;38;5;203:*.odp=0;38;5;203:*.svg=0;38;5;203:*.htc=0;38;5;65:*.tex=0;38;5;65:*.jar=4;38;5;106:*.clj=0;38;5;65:*.inl=0;38;5;65:*.exe=1;38;5;203:*.fsi=0;38;5;65:*.yml=0;38;5;209:*.mpg=0;38;5;203:*.vob=0;38;5;203:*.xmp=0;38;5;209:*.sxw=0;38;5;203:*.ods=0;38;5;203:*.png=0;38;5;203:*.pkg=4;38;5;106:*.aux=0;38;5;248:*.tgz=4;38;5;106:*.tmp=0;38;5;248:*.xlsx=0;38;5;203:*.fish=0;38;5;65:*.mpeg=0;38;5;203:*.tbz2=4;38;5;106:*.hgrc=0;38;5;113:*.purs=0;38;5;65:*.diff=0;38;5;65:*.html=0;38;5;209:*.lisp=0;38;5;65:*.less=0;38;5;65:*.java=0;38;5;65:*.epub=0;38;5;203:*.bash=0;38;5;65:*.pptx=0;38;5;203:*.psd1=0;38;5;65:*.conf=0;38;5;209:*.h264=0;38;5;203:*.make=0;38;5;113:*.psm1=0;38;5;65:*.docx=0;38;5;203:*.json=0;38;5;209:*.lock=0;38;5;248:*.yaml=0;38;5;209:*.orig=0;38;5;248:*.flac=0;38;5;203:*.rlib=0;38;5;248:*.jpeg=0;38;5;203:*.toml=0;38;5;209:*.dart=0;38;5;65:*.ipynb=0;38;5;65:*.scala=0;38;5;65:*passwd=0;38;5;209:*.shtml=0;38;5;209:*.dyn_o=0;38;5;248:*.mdown=0;38;5;209:*.patch=0;38;5;65:*shadow=0;38;5;209:*.swift=0;38;5;65:*.cache=0;38;5;248:*.cabal=0;38;5;65:*README=0;38;5;16;48;5;209:*.toast=4;38;5;106:*.class=0;38;5;248:*.cmake=0;38;5;113:*.xhtml=0;38;5;209:*.flake8=0;38;5;113:*.ignore=0;38;5;113:*.config=0;38;5;209:*.dyn_hi=0;38;5;248:*LICENSE=0;38;5;241:*INSTALL=0;38;5;16;48;5;209:*.matlab=0;38;5;65:*TODO.md=1:*COPYING=0;38;5;241:*.gradle=0;38;5;65:*.groovy=0;38;5;65:*.gemspec=0;38;5;113:*.desktop=0;38;5;209:*TODO.txt=1:*Makefile=0;38;5;113:*Doxyfile=0;38;5;113:*setup.py=0;38;5;113:*.cmake.in=0;38;5;113:*COPYRIGHT=0;38;5;241:*.kdevelop=0;38;5;113:*configure=0;38;5;113:*.fdignore=0;38;5;113:*README.md=0;38;5;16;48;5;209:*.markdown=0;38;5;209:*.rgignore=0;38;5;113:*SConscript=0;38;5;113:*.gitignore=0;38;5;113:*README.txt=0;38;5;16;48;5;209:*CODEOWNERS=0;38;5;113:*Dockerfile=0;38;5;209:*INSTALL.md=0;38;5;16;48;5;209:*SConstruct=0;38;5;113:*.scons_opt=0;38;5;248:*.gitconfig=0;38;5;113:*Makefile.in=0;38;5;248:*Makefile.am=0;38;5;113:*.synctex.gz=0;38;5;248:*.gitmodules=0;38;5;113:*MANIFEST.in=0;38;5;113:*LICENSE-MIT=0;38;5;241:*.travis.yml=0;38;5;65:*configure.ac=0;38;5;113:*.applescript=0;38;5;65:*appveyor.yml=0;38;5;65:*.fdb_latexmk=0;38;5;248:*CONTRIBUTORS=0;38;5;16;48;5;209:*.clang-format=0;38;5;113:*.gitattributes=0;38;5;113:*CMakeLists.txt=0;38;5;113:*CMakeCache.txt=0;38;5;248:*LICENSE-APACHE=0;38;5;241:*INSTALL.md.txt=0;38;5;16;48;5;209:*CONTRIBUTORS.md=0;38;5;16;48;5;209:*.sconsign.dblite=0;38;5;248:*requirements.txt=0;38;5;113:*CONTRIBUTORS.txt=0;38;5;16;48;5;209:*package-lock.json=0;38;5;248"




set -x LSCOLORS ExFxCxDxBxegedabagacad

set -x LESS_TERMCAP_so (set_color  -b 004050 ; set_color -o 60f0ff)
set -x LESS_TERMCAP_se (set_color normal)

alias ls=eza
alias !!=xdg-open

alias g=git


# set -g theme_nerd_fonts yes
# set -g theme_color_scheme dark

set -x FZF_DEFAULT_COMMAND 'fd --type f'

#stty susp '^Z'  

if which kubectl >/dev/null 2>&1 ; kubectl completion fish | source ; end

direnv hook fish | source
