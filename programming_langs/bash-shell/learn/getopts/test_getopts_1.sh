# #!/bin/bash
# while getopts ':b:d:' OPT &> /dev/null; do
#     case $OPT in
#         b)
#             echo "The options is b"
#             echo $OPTARG
#             ;;
#         d)
#             echo "The options is d"
#             echo $OPTARG
#             ;;
#         *)
#             echo "Wrong Options"
#             exit 7
#             ;;
#     esac
#     # echo $OPT
#     # echo $OPTARG
# done
# echo $OPTIND
# shift $(($OPTIND - 1))
# echo $1

#!/bin/bash
echo $*
while getopts ":a:bc:" opt; do
    case $opt in
        a)
            echo $OPTARG $OPTIND
            ;;
        b)
            echo "b $OPTIND"
            ;;
        c)
            echo "c $OPTIND"
            ;;
        ?)
            echo "error"
            exit 1
            ;;
    esac
done
echo $OPTIND
shift $(($OPTIND - 1))
echo $0
echo $*
