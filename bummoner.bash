# LLM Backend System for Bummoner
# Supports: llcat, lms, llm

# ============================================================
# llcat backend
# ============================================================
_ll_backend_llcat_detect() {
  which llcat >& /dev/null
}

_ll_backend_llcat_model() {
  echo "$LLC_MODEL"
}

_ll_backend_llcat_invoke() {
  local model="$1"
  local prompt="$2"
  llcat -k "$LLC_KEY" -u "$LLC_SERVER" ${LLC_MCP:+-mf "$LLC_MCP"} -m "$model" "$prompt"
}

# ============================================================
# lms backend (LMStudio CLI)
# ============================================================
_ll_backend_lms_detect() {
  which lms >& /dev/null
}

_ll_backend_lms_model() {
  if [[ -n "$LMS_MODEL" ]]; then
    echo "$LMS_MODEL"
  else
    lms ls 2>/dev/null | head -n 1
  fi
}

_ll_backend_lms_invoke() {
  local model="$1"
  local prompt="$2"
  if [[ -z "$model" ]]; then
    echo "Error: No model specified. Set LMS_MODEL or load a model in LMStudio." >&2
    return 1
  fi
  lms chat "$model" -p "$prompt"
}

# ============================================================
# llm backend (Simonw's llm)
# ============================================================
_ll_backend_llm_detect() {
  which llm >& /dev/null
}

_ll_backend_llm_model() {
  if [[ -r "$HOME/.config/io.datasette.llm/default_model.txt" ]]; then
    cat "$HOME/.config/io.datasette.llm/default_model.txt"
  else
    llm models default
  fi
}

_ll_backend_llm_invoke() {
  local model="$1"
  local prompt="$2"
  llm -m "$model" "$prompt"
}

# ============================================================
# Backend auto-selection
# ============================================================
_ll_select_backend() {
  # If user specified a backend, use it
  if [[ -n "$ZUMMONER_BACKEND" && "$ZUMMONER_BACKEND" != "auto" ]]; then
    if _ll_backend_${ZUMMONER_BACKEND}_detect 2>/dev/null; then
      echo "$ZUMMONER_BACKEND"
      return 0
    fi
    return 1
  fi

  # Otherwise auto-detect by priority
  for backend in llcat llm lms; do
    if _ll_backend_${backend}_detect 2>/dev/null; then
      echo "$backend"
      return 0
    fi
  done
  return 1
}

# Get model for selected backend
_ll_get_model() {
  local backend="$1"
  _ll_backend_${backend}_model
}

# Invoke LLM with model and prompt
_ll_invoke() {
  local backend="$1"
  local model="$2"
  local prompt="$3"
  _ll_backend_${backend}_invoke "$model" "$prompt"
}

bummoner() {
  local QUESTION="${READLINE_LINE:-}"
  local PROMPT="
  You are an experienced Linux engineer with expertise in all Linux
  commands and their functionality across different Linux systems.

  Given a task, generate a single command or a pipeline
  of commands that accomplish the task efficiently.
  This command is to be executed in the current shell, bash.
  For complex tasks or those requiring multiple
  steps, provide a pipeline of commands.
  Ensure all commands are safe and prefer modern ways. For instance,
  homectl instead of adduser, ip instead of ifconfig, systemctl, journalctl, etc.
  Make sure that the command flags used are supported by the binaries
  usually available in the current system or shell.
  If a command is not compatible with the
  system or shell, provide a suitable alternative.

  The system information is: $(uname -a) (generated using: uname -a).
  The user is $USER. Use sudo when necessary

  Create a command to accomplish the following task: $QUESTION

  If there is text enclosed in paranthesis, that's what ought to be changed.
  If there's a comment (#), then the stuff after is is the instructions, you should put the stuff there.

  Output only the command as a single line of plain text, with no
  quotes, formatting, or additional commentary. Do not use markdown or any
  other formatting. Do not include the command into a code block.
  Don't include the shell itself (bash, zsh, etc.) in the command.
  "

  # Auto-detect and select backend
  local backend=$(_ll_select_backend) || {
    READLINE_LINE="No LLM backend found (llcat, lms, or llm)"
    return 1
  }

  local model=$(_ll_get_model "$backend")

  echo ""
  echo "$QUESTION ... $model"
  local response=$(_ll_invoke "$backend" "$model" "$PROMPT")
  local COMMAND=$(echo "$response" | sed 's/```//g' | tr -d '\n')
  if [[ -n "$COMMAND" ]]; then
    if [[ -n "$ZUMMONER_SPELL" ]]; then
      [[ "$QUESTION" = *"#"* ]] && QUESTION="${QUESTION#*\# }"
      READLINE_LINE="${COMMAND%%\#*} # $QUESTION"
    else
      READLINE_LINE="$COMMAND"
    fi
    READLINE_POINT=${#READLINE_LINE}
  else
    READLINE_LINE="$QUESTION ... no results"
  fi
}

bind -x '"\C-Xx": bummoner'
