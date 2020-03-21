#!/usr/bin/env zsh

typeset -g RUST_PREFIX=${RUST_PREFIX:-" "}
typeset -g RUST_SUFIX=${RUST_SUFIX:-""}
typeset -g pr_rust=""

if (( $+functions[zpm] )); then #DO_NOT_INCLUDE_LINE_IN_ZPM_CACHE
  zpm zpm-zsh/helpers zpm-zsh/colors #DO_NOT_INCLUDE_LINE_IN_ZPM_CACHE
fi #DO_NOT_INCLUDE_LINE_IN_ZPM_CACHE

if (( $+commands[rustc] )); then
  function _pr_rust() {
    if is-recursive-exist Cargo.toml; then
      rust_version=$(rustc --version | cut -d' ' -f2)

      pr_rust="${RUST_PREFIX}%{$c[red]${c_bold}%}𝗥%{$c_reset%} %{$c[blue]$c_bold%}${rust_version}%{$c_reset%}${RUST_SUFIX}"

      return 0
    fi

    pr_rust=""
  }

  autoload -Uz add-zsh-hook
  add-zsh-hook chpwd _pr_rust
  _pr_rust
fi
