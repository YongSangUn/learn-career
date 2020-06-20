#!/bin/bash
# foobar: getopts with short and long options AND arguments

function _cleanup ()
{
  unset -f _usage _cleanup ; return 0
}

## Clear out nested functions on exit
trap _cleanup INT EXIT RETURN

###### some declarations for this example ######
Options=$@
Optnum=$#
sfoo='no '
sbar='no '
sfoobar='no '
sbarfoo='no '
sarguments='no '
sARG=empty
lfoo='no '
lbar='no '
lfoobar='no '
lbarfoo='no '
larguments='no '
lARG=empty

function _usage()
{
  ###### U S A G E : Help and ERROR ######
  cat <<EOF
   foobar $Options
   $*
          Usage: foobar <[options]>
          Options:
                  -b   --bar            Set bar to yes    ($foo)
                    -f   --foo            Set foo to yes    ($bart)
                      -h   --help           Show this message
                  -A   --arguments=...  Set arguments to yes ($arguments) AND get ARGUMENT ($ARG)
                  -B   --barfoo         Set barfoo to yes ($barfoo)
                  -F   --foobar         Set foobar to yes ($foobar)
EOF
}

[ $# = 0 ] && _usage "  >>>>>>>> no options given "

##################################################################
#######  "getopts" with: short options  AND  long options  #######
#######            AND  short/long arguments               #######
while getopts ':bfh-A:BF' OPTION ; do
  case "$OPTION" in
    b  ) sbar=yes                       ;;
    f  ) sfoo=yes                       ;;
    h  ) _usage                         ;;
    A  ) sarguments=yes;sARG="$OPTARG"  ;;
    B  ) sbarfoo=yes                    ;;
    F  ) sfoobar=yes                    ;;
    -  ) [ $OPTIND -ge 1 ] && optind=$(expr $OPTIND - 1 ) || optind=$OPTIND
         eval OPTION="\$$optind"
         OPTARG=$(echo $OPTION | cut -d'=' -f2)
         OPTION=$(echo $OPTION | cut -d'=' -f1)
         case $OPTION in
             --foo       ) lfoo=yes                       ;;
             --bar       ) lbar=yes                       ;;
             --foobar    ) lfoobar=yes                    ;;
             --barfoo    ) lbarfoo=yes                    ;;
             --help      ) _usage                         ;;
               --arguments ) larguments=yes;lARG="$OPTARG"  ;;
             * )  _usage " Long: >>>>>>>> invalid options (long) " ;;
         esac
       OPTIND=1
       shift
      ;;
    ? )  _usage "Short: >>>>>>>> invalid options (short) "  ;;
  esac
done

##################################################################
echo "----------------------------------------------------------"
echo "RESULT short-foo      : $sfoo                                    long-foo      : $lfoo"
echo "RESULT short-bar      : $sbar                                    long-bar      : $lbar"
echo "RESULT short-foobar   : $sfoobar                                 long-foobar   : $lfoobar"
echo "RESULT short-barfoo   : $sbarfoo                                 long-barfoo   : $lbarfoo"
echo "RESULT short-arguments: $sarguments  with Argument = \"$sARG\"   long-arguments: $larguments and $lARG"

$ foob​​ar -f --bar
$ foob​​ar --foo -b
$ foob​​ar -bf --bar --foobar
$ foob​​ar -fbFBAshorty --bar -FB --arguments = longhorn
$ foob​​ar的-FA “文本矮子” -B --arguments = “文本的Longhorn”
$ bash foobar -F --barfoo
$ sh foobar -B --foobar-...
$ bash ./foobar -F --bar