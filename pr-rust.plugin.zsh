#!/usr/bin/env zsh

typeset -g pr_rust=''

if (( $+commands[rustc] )); then
  function _pr_rust() {
    if is-recursive-exist Cargo.toml; then
      rust_version=$(rustc --version | cut -d' ' -f2)

      pr_rust=" %{${c[red]}${c[bold]}%}RUST%{${c[yellow]}%}:%{${c[blue]}%}${rust_version}%{${c[reset]}%}"

      return 0
    fi

    pr_rust=""
  }

  autoload -Uz add-zsh-hook
  add-zsh-hook chpwd _pr_rust
  _pr_rust
fi
