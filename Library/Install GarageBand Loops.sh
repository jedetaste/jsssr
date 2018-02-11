#!/bin/bash

  die() {
    local _ret=$2
    test -n "$_ret" || _ret=1
    test "$_PRINT_HELP" = yes && print_help >&2
    echo "$1" >&2
    exit ${_ret}
  }
  
  begins_with_short_option() {
    local first_option all_short_options
    all_short_options='h'
    first_option="${1:0:1}"
    test "$all_short_options" = "${all_short_options/$first_option/}" && return 1 || return 0
  }
  
  _positionals=()
  
  print_help () {
    printf "\t%s\n" "<optional>: Download optional content beside the mandatory"
    printf "\t%s\n" "-h,--help: Prints help"
  }
  
  parse_commandline () {
    while test $# -gt 0
    do
      _key="$1"
      case "$_key" in
        -h|--help)
          print_help
          exit 0
          ;;
        -h*)
          print_help
          exit 0
          ;;
        *)
          _positionals+=("$1")
          ;;
      esac
      shift
    done
  }
  
  assign_positional_args () {
    _positional_names=('_arg_first' )
  
    for (( ii = 0; ii < ${#_positionals[@]}; ii++))
    do
      eval "${_positional_names[ii]}=\${_positionals[ii]}" || die "Error during argument parsing, possibly an Argbash bug." 1
    done
  }
  
  parse_commandline "$@"
  assign_positional_args
  
  # Download mandatory content only
  
  "/usr/local/bin/appleLoops" --deployment --mandatory-only
  
  # Download optional content only if _arg_first == optional
  
  if [ "${_arg_first}" == "optional" ]; then
    "/usr/local/bin/appleLoops" --deployment --optional-only
  fi