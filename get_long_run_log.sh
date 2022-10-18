#!/bin/bash
#################################################################
# Author: SHIH CHENG YE(terry)
# Email: terry54147@outlook.com
# github: https://github.com/TerryYeh54147

# Purpose: find out wich log file is long run job
#################################################################

# default setup
POSITIONAL_ARGS=()
LOGFOLDER_PATH='./'
LIMITED_TIME='5' # seconds


usage() {
    echo "$0 options:
        -f|--file_path:
            target file path
        -d|--directory_path:
            [optoin] log directory path(default: $LOGFOLDER_PATH)
        -t|--limited_time:
            [optoin] job limited runtime(default: $LOGFOLDER_PATH)
        -h|--help:
            show all options detail
    "
    exit
}

if [[ $# -lt 1 ]]; then
    usage
fi

# setup options
while [[ $# -ge 1 ]]; do
    case $1 in
        -f|--file_path)
            FILE_PATH="$2"
            shift # past argument
            shift # past value
        ;;
        -d|--directory_path)
            LOGFOLDER_PATH="$2"
            shift # past argument
            shift # past value
        ;;
        -t|--limited_time)
            LIMITED_TIME="$2"
            shift # past argument
            shift # past value
        ;;
        -h|--help)
            usage
        ;;
        -*|--*)
            echo "Unknown option $1"
            exit 1
        ;;
        *)
            POSITIONAL_ARGS+=("$1") # save positional arg
            shift # past argument
        ;;
    esac
done

set -- "${POSITIONAL_ARGS[@]}" # restore positional parameters

##### main #####

if [[ -d $LOGFOLDER_PATH ]]; then
    cd $LOGFOLDER_PATH
else
    echo `ls -l $LOGFOLDER_PATH`
    exit
fi

if [[ ! -f $FILE_PATH  ]]; then
    echo `ls -l $FILE_PATH`
    exit
else
    if [[ $FILE_PATH != *.log ]]; then
        echo "[ERROR] It's not log file: $FILE_PATH"
        exit
    fi
fi


