#!/usr/bin/env zsh

: ${PR_RUST_SYMBOL:=''}


typeset -g pr_rust=''

if (( $+commands[rustc] )); then
  function _pr_rust() {
    pr_rust=''

    if is-recursive-exist Cargo.toml; then
      pr_rust=" %{${c[base3]}${c[bold]}%}(%{${c[reset]}%}"

      rust_version=$(rustc --version | cut -d' ' -f2)

      pr_rust+="%{${c[orange]}${c[bold]}%}${PR_RUST_SYMBOL}%{${c[reset]}%} %{${c[orange]}${c[bold]}%}${rust_version}%{${c[reset]}%}"

      pr_rust+="%{${c[base3]}${c[bold]}%})%{${c[reset]}%}"
    fi

  }

  autoload -Uz add-zsh-hook
  add-zsh-hook chpwd _pr_rust
  _pr_rust
fi
