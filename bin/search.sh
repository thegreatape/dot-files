# deps: fzf, rg, mdless

RG_COMMAND="rg --column --no-line-number --no-heading --color=always --smart-case "
selected=$(
FZF_DEFAULT_COMMAND="$RG_COMMAND ''" \
  fzf --bind "change:reload:$RG_COMMAND {q} || echo 'New Note: {q}.md'" \
      --ansi \
      --phony \
      --delimiter=":" \
      --preview="mdless {1}"
)

[[ -n $selected ]] && nvim "$(echo $selected | cut -f 1 -d:)"
