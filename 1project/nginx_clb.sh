#!/bin/bash

###############################################################################
#                                                                             #
# Description : Operate on Nginx upstream files by POOL & IP & PORT           #
#               through OPTION and ACTION.                                    #
#                                                                             #
# Auther      : XiangYun.Long                                                 #
#                                                                             #
# Email       ：SangUn.Yong@gmail.com                                         #
#                                                                             #
# LastWrite   ：2020.06.21                                                    #
#                                                                             #
###############################################################################

######################    Step1 : Define Functions   ##########################

# Parameter Description:
# pool_name           : nginx upstream-conf pool-name
# pool_file_with_dir  : the full path of upstream-conf file

# upstream-conf file:
# $ cat /opt/nginx/upstream/testsite.conf
# upstream testsite{
#    server 1.1.1.1:8080   weight=5;
#    server 2.2.2.2        fail_timeout=5s slow_start=30s;
#    server 3.3.3.3:8001   service=http resolve;
#    server 4.4.4.4:8080   down;
#    server 5.5.5.5:80     backup;
# }

### Color print.
red_echo() { echo -e "\033[031;1m$@\033[0m"; }
blue_echo() { echo -e "\033[034;1m$@\033[0m"; }
green_echo() { echo -e "\033[032;1m$@\033[0m"; }
yellow_echo() { echo -e "\033[033;1m$@\033[0m"; }

### get upstream-conf & pool list, the format is:
# /$_upstream_dir/<pool.conf> : <pool>
get_upstream_list() {
    # local pool_name
    local check_pool_name="$1" # If it is not empty, the query pool data is returned
    if [ -z "${check_pool_name}" ]; then
        find "${_upstream_dir}" -name '*.conf' |
            grep -HEi "\<upstream .*{$" "${_upstream_dir}"* # ignore case distinctions in patterns and data
    elif [ -n "${check_pool_name}" ]; then
        grep -HEi "\<${check_pool_name}{$" "${_upstream_dir}"*
    fi
}

### get the full path of pool.
get_pool_file_dir() {
    local pool_name="$1"
    grep -l "\<${pool_name}{$" "${_upstream_dir}"*
}

### check if the pool is in the upstream directory.
check_pool_in_upstream() {
    local pool_name="$1"
    local pool_file_with_dir
    pool_file_with_dir=$(get_pool_file_dir "${pool_name}")

    # no <pool> parameter.
    [ -z "${pool_name}" ] && red_echo "==> Please enter the name of the pool." && return 1

    if get_upstream_list "${pool_name}" > /dev/null; then # existed
        green_echo "==> The directory of pool [ ${pool_name} ] is in [ ${pool_file_with_dir} ]."
        return 0
    else # not existed
        red_echo "==> No pool [ ${pool_name} ] found in the directory [ "${_upstream_dir}" ]."
        return 5
    fi
}

### same as command : { if [ -f pool_file_with_dir ] ;then cat $pool_file_with_dir ; fi}.
get_pool_upstream_conf() {
    local pool_name="$1"
    local pool_file_with_dir
    local check_id # the return value of check_pool_in_upstream.

    pool_file_with_dir=$(get_pool_file_dir "${pool_name}")

    check_pool_in_upstream "${pool_name}" > /dev/null
    check_id=$?

    if [ "${check_id}" == 0 ]; then # file exists
        yellow_echo "$(ls -l "${pool_file_with_dir}" |
            awk '{print "=> [LastWriteTime: " $6,$7,$8 "] " $9 " :"}')"
        cat "${pool_file_with_dir}"

    elif [ "${check_id}" == 1 ]; then
        red_echo "==> Please enter the name of the pool."

    elif [ "${check_id}" == 5 ]; then
        red_echo "==> No conf-file of pool [ ${pool_name} ] found in the directory [ ${_upstream_dir} ]."
    fi
}

### get the number of [ offline & online ] in the upstream-conf file through [ ip_list ].
get_server_line_num_from_iplist() {
    local ip_list_online_num=0  # the number of incoming ip_list contains onlined servers.
    local ip_list_offline_num=0 # the number of incoming ip_list contains offlined servers.

    local file="$1"    # upstream-conf file
    local ip_list="$2" # IP_ARRAY, split by ",". E.g: 1.1.1.1,2.2.2.2,3.3.3.3

    # ${ip_list//,/ } mean is: turns ip_list(1.1.1.1,2.2.2.2,3.3.3.3) -
    # - into (1.1.1.1 2.2.2.2 3.3.3.3)
    # google or baidu: [ bash Operations on variables ].
    for ip in ${ip_list//,/ }; do
        if grep -qE "[^#]+server ${ip}:[0-9]+;$" "${file}"; then
            ((ip_list_online_num++))
        elif grep -qE "[^#]+server ${ip}:[0-9]+ *down;$" "${file}"; then
            ((ip_list_offline_num++))
        elif grep -qE "#.*server ${ip}:[0-9]+;$" "${file}"; then
            ((ip_list_offline_num++))
        fi
    done

    echo "${ip_list_online_num},${ip_list_offline_num}"
}

### sort upstream-conf file server by ip address.
sort_upstream_conf() {
    local pool_file_with_dir="$1"
    local sort_server_line

    ## get all server lines in the upstream-conf file.
    sort_server_line=$(sed -n '/server .*;$/p' "${pool_file_with_dir}" | sort -nr -t . -k 4)
    # echo "${sort_server_line}"
    sed -i '/server .*;$/d' "${pool_file_with_dir}" # remove all server lines.
    printf "%s\n" "$sort_server_line" |             # need to user printf, otherwise there will be format problems.
        while IFS= read -r line; do
            sed -i "1a\\$line" "${pool_file_with_dir}"
        done
}

### add server to upstream-conf file.
add_upstream_conf_server() {
    local pool_name="$1"
    local pool_file_with_dir

    local ip_add_list="$2"
    local port="$3" # must specify port.

    check_pool_in_upstream "${pool_name}" || exit 1 # check the file, exit if it fails.
    pool_file_with_dir=$(get_pool_file_dir "${pool_name}")

    # cat upstream-conf file before modify.
    blue_echo "\n############################    Before modify    ###############################"
    get_pool_upstream_conf "${pool_name}"

    # start add.
    for ip in ${ip_add_list//,/ }; do
        if grep -qE "server ${ip}:.*;" "${pool_file_with_dir}"; then
            red_echo "IP [ ${ip} ] already exists in the file."
        else
            green_echo "Add the server [ ${ip} ]."
            sed -i '/upstream .*{/a\\tserver '"${ip}"':'"${port}"';' "${pool_file_with_dir}"
        fi
    done

    # sort and echo upstream-conf file after modify.
    blue_echo "\n############################    After modify    ###############################"
    yellow_echo "    NOTE : The [server ip:port] line in the file will be sorted."
    sort_upstream_conf "${pool_file_with_dir}"
    get_pool_upstream_conf "${pool_name}"
}

### del server from upstream-conf file.
del_upstream_conf_server() {
    local pool_name="$1"
    local pool_file_with_dir

    local ip_del_list="$2"
    local server_online_num # the number of online servers(before modify).
    local del_server_num    # the number of incoming ip_list.

    local del_server_online_num=0   # the number of incoming ip_del_list contains onlined servers.
    local del_server_offline_num=0  # the number of incoming ip_del_list contains offlined servers.
    local del_server_no_match_num=0 # the number of incoming ip_del_list is not included in the upstream-conf file.

    check_pool_in_upstream "${pool_name}" || exit 1
    pool_file_with_dir=$(get_pool_file_dir "${pool_name}")

    line_num=$(get_server_line_num_from_iplist "${pool_file_with_dir}" "${ip_del_list}") # get the number of online & offline.
    del_server_online_num=$(echo "${line_num}" | cut -d"," -f1)
    del_server_offline_num=$(echo "${line_num}" | cut -d"," -f2)

    del_server_num=$(echo "${ip_del_list//,/ }" | wc -w)
    del_server_no_match_num=$((del_server_num - del_server_online_num - del_server_offline_num))

    server_online_num=$(grep -cE '[^#]server .*;$' "${pool_file_with_dir}")
    # echo $server_online_num $del_server_online_num $del_server_offline_num $del_server_no_match_num

    ## must keep at least one online server running.
    if [ $((server_online_num - del_server_online_num)) -lt 1 ]; then
        red_echo "After delete, only one server will be online and cannot perform operations."
        return 111

    elif [ $((server_online_num - del_server_online_num)) -gt 0 ]; then

        blue_echo "\n############################    Before modify    ###############################"
        get_pool_upstream_conf "${pool_name}"

        # start delete
        for ip in ${ip_del_list//,/ }; do
            grep -q "server ${ip}.*;$" "${pool_file_with_dir}" &&
                green_echo "Delete the server [ ${ip} ]."
            sed -i "/server ${ip}.*;$/d" "${pool_file_with_dir}"
        done

        blue_echo "\n############################    After modify    ###############################"
        yellow_echo "    NOTE : The [server ip:port] line in the file will be sorted."
        sort_upstream_conf "${pool_file_with_dir}"
        get_pool_upstream_conf "${pool_name}"

    fi

    printf "\n=> Delete Total:
        Delete online server    : %d
        Delete Offline server   : %d
        Server not found        : %d
" "${del_server_online_num}" "${del_server_offline_num}" "${del_server_no_match_num}"
}

### online the [ offlined server ] in the upstream-conf file.
online_upstream_conf_server() {
    local pool_name="$1"
    local pool_file_with_dir

    local ip_online_list="$2"

    check_pool_in_upstream "${pool_name}" || exit 1
    pool_file_with_dir=$(get_pool_file_dir "${pool_name}")

    blue_echo "\n############################    Before modify    ###############################"
    get_pool_upstream_conf "${pool_name}"

    # start online
    for ip in ${ip_online_list//,/ }; do
        if grep -qE "[^#]+server ${ip}:[0-9]+ *down;$" "${pool_file_with_dir}"; then
            green_echo "Online the server [ ${ip} ]."
            sed -i "s/\(server ${ip}:[0-9]\+\) *down;$/\1;/g" "${pool_file_with_dir}"
        elif grep -qE "#.*server ${ip}:[0-9]+;$" "${pool_file_with_dir}"; then
            green_echo "Online the server [ ${ip} ]."
            sed -i "s/#.*\(server ${ip}:[0-9]\+;$\)/\1/g" "${pool_file_with_dir}"
        fi
    done

    blue_echo "\n############################    After modify    ###############################"
    yellow_echo "    NOTE : The [server ip:port] line in the file will be sorted."
    sort_upstream_conf "${pool_file_with_dir}"
    get_pool_upstream_conf "${pool_name}"
}

### offline the [ offlined server ] in the upstream-conf file.
## no comments, the method and principle are the same as the delete.
offline_upstream_conf_server() {
    local pool_name="$1"
    local pool_file_with_dir

    local ip_offline_list="$2"
    local off_server_num

    local off_server_online_num=0
    local off_server_offline_num=0
    local off_server_no_match_num=0

    check_pool_in_upstream "${pool_name}" || exit 1
    pool_file_with_dir=$(get_pool_file_dir "${pool_name}")

    line_num=$(get_server_line_num_from_iplist "${pool_file_with_dir}" "${ip_offline_list}")
    off_server_online_num=$(echo "${line_num}" | cut -d"," -f1)
    off_server_offline_num=$(echo "${line_num}" | cut -d"," -f2)

    off_server_num=$(echo "${ip_offline_list//,/ }" | wc -w)
    off_server_no_match_num=$((off_server_num - off_server_online_num - off_server_offline_num))

    # echo $server_online_num $off_server_online_num $off_server_offline_num $off_server_no_match_num

    server_online_num=$(grep -cE '[^#]server .*;$' "${pool_file_with_dir}")
    if [ $((server_online_num - off_server_online_num)) -lt 1 ]; then
        return 111
    elif [ $((server_online_num - off_server_online_num)) -gt 0 ]; then

        blue_echo "\n############################    Before modify    ###############################"
        get_pool_upstream_conf "${pool_name}"

        for ip in ${ip_offline_list//,/ }; do
            grep -qE "[^#]+server ${ip}:[0-9]+;$" "${pool_file_with_dir}" &&
                green_echo "Offline the ${ip} server [ ${ip} ]."
            sed -i "s/\([^#]*server $ip:[0-9]\+\);$/\1 down;/g" "${pool_file_with_dir}"
        done

        blue_echo "\n############################    After modify    ###############################"
        yellow_echo "    NOTE : The [server ip:port] line in the file will be sorted."
        sort_upstream_conf "${pool_file_with_dir}"
        get_pool_upstream_conf "${pool_name}"
    fi

    printf "\n=> Offline Total:
        Offline server                      : %d
        Server is offlined before opreate   : %d
        Server not found                    : %d
" "${off_server_online_num}" "${off_server_offline_num}" "${off_server_no_match_num}"

}

###############################################################################
##########################    usage & getopts   ###############################

usage() {
    echo "Usage:
        $ $0 [ OPTION | ACTION ] ... [ POOL ] ... [ IP | PORT ]
    Operate on Nginx upstream files by POOL & IP & PORT through OPTION and ACTION.

Examples:
    => show priceapi upstream-conf
        $ $0 -l priceapi
    => show all upstream-conf
        $ $0 -L
    => add iplist port 8080 to priceapi.
        $ $0 -a add -p priceapi -i 1.1.1.1,2.2.2.2,3.3.3.3 -o 8080
    => offline iplist from priceapi.
        $ $0 -a offline -p priceapi -i 4.4.4.4,5.5.5.5

    The last two above command can be abbreviated as:
        $ $0 --add priceapi -i 1.1.1.1,2.2.2.2,3.3.3.3 -o 8080
        $ $0 --offline priceapi -i 4.4.4.4,5.5.5.5

OPTION:
    -l <POOL>           Display the upstream-conf file of the pool.
    -L                  Display all upstream-conf in the upstream-dir.
    -a <ACTION>         Operate the upstream-conf file of the pool by ACTION.
    -p <POOL>           Specify the POOL_NAME parameter.
    -i <IP_LIST>        Specify the IP_ARRAY parameter, split by [,].
    -o <PORT>           Specify the SERVER_PORT parameter Only when ACTION is [ add ].
    -?, -h              Display this help and exit.

    <ACTION>
            add         Add the servers to upstream-conf file;
                        you must specify the PORT.
            del         Delete the servers from upstream-conf file.
            online      Online the servers from upstream-conf file.
            offline     Offline the servers from upstream-conf file.

    --add <POOL>        Same as { -a add -p <POOL> }.
    --del <POOL>        Same as { -a del -p <POOL> }.
    --online <POOL>     Same as { -a online -p <POOL> }.
    --offline <POOL>    Same as { -a offline -p <POOL> }.
"
    exit 2
}

### parameter check: if set, an error will be thrown.
set_variable() {
    local varname=$1
    shift
    if [ -z "${!varname}" ]; then
        eval "$varname=\"$@\""
    else
        echo "Error: $varname already set"
        # usage
    fi
}
# The reason for the unset is that the script does not want to be influenced by any env-variables which may be already set.
unset ACTION POOL IP_ARRAY SERVER_PORT

# use getopts, browse above USAGE.
while getopts 'l:Lp:a:i:o:-s?h' OPTION; do
    case "$OPTION" in
        l)
            set_variable ACTION SHOW_POOL_LIST
            set_variable POOL "$OPTARG"
            ;;
        L) set_variable ACTION SHOW_UPSTREAM_LIST ;;
        p) set_variable POOL "$OPTARG" ;;
        a) set_variable ACTION "$OPTARG" ;;
        i) set_variable IP_ARRAY "$OPTARG" ;;
        o) set_variable SERVER_PORT "$OPTARG" ;;
        -) # use long options.
            # [ $OPTIND -ge 1 ] && optind=$(expr $OPTIND - 1) || optind=$OPTIND
            # OPTARG=$(echo "$OPTION" | cut -d'=' -f2)
            # OPTION=$(echo "$OPTION" | cut -d'=' -f1)
            optind=$OPTIND
            eval OPTION="\$$optind"
            eval OPTARG="\$$((optind + 1))"
            case $OPTION in
                --add)
                    set_variable ACTION "add"
                    set_variable POOL "$OPTARG"
                    ;;
                --del)
                    set_variable ACTION "del"
                    set_variable POOL "$OPTARG"
                    ;;
                --offline)
                    set_variable ACTION "offline"
                    set_variable POOL "$OPTARG"
                    ;;
                --online)
                    set_variable ACTION "online"
                    set_variable POOL "$OPTARG"
                    ;;
                *) red_echo " Long: >>>>>>>> invalid options (long) " ;;
            esac
            # echo "$OPTIND, $OPTION ,$OPTARG,"
            # shift 1
            shift 2
            ;;
        s) set_variable ACTION RELOAD_NGINX ;;
        h | ?) usage ;;
    esac
done
shift $((OPTIND - 1))

# echo "=====> action: $ACTION, pool: $POOL  ip:$IP_ARRAY, port: $SERVER_PORT"

[ -z "$ACTION" ] &&
    red_echo "ACTION is null, please specify it." &&
    exit 1
[ "$ACTION" != "SHOW_POOL_LIST" ] &&
    [ "$ACTION" != "SHOW_UPSTREAM_LIST" ] &&
    [ "$ACTION" != "RELOAD_NGINX" ] &&
    [ -z "$IP_ARRAY" ] &&
    red_echo "POOL & IP_LIST must be specify, use [--<ACTION> <POOL> & -i <IP_LIST>] options." &&
    exit 2
[ "$ACTION" == "add" ] && [ -z "$SERVER_PORT" ] &&
    red_echo "You must specify the PORT when you set the ACTION is [add]. [ -o <PORT> ]" &&
    exit 88

# exit 1

###############################################################################

###################    Main script starts here    #############################

_nginx_dir="/opt/nginx"
_upstream_dir=$_nginx_dir/upstream/

_reload_nginx() {
    ${_nginx_dir}/sbin/nginx -s reload
}

# use the specified ACTION to operation.
case "$ACTION" in
    add) add_upstream_conf_server "$POOL" "$IP_ARRAY" "$SERVER_PORT" ;;
    del) del_upstream_conf_server "$POOL" "$IP_ARRAY" ;;
    online) online_upstream_conf_server "$POOL" "$IP_ARRAY" ;;
    offline) offline_upstream_conf_server "$POOL" "$IP_ARRAY" ;;
    SHOW_POOL_LIST)
        check_pool_in_upstream "$POOL"
        get_pool_upstream_conf "$POOL"
        ;;
    SHOW_UPSTREAM_LIST)
        printf "%-25s| %s\n" "Pool name" "The full dir of the pool"
        printf "%-25s| %s\n" "--------------------" "--------------------"
        get_upstream_list | awk -F '[: {]' '{printf "%-25s| %s\n",$3,$1}'
        ;;
    RELOAD_NGINX) _reload_nginx ;;
    *)
        red_echo "Unknown ACTION."
        usage
        ;;
esac
