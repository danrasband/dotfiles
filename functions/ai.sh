function qwen {
  local model="unsloth/Qwen3.5-9B-GGUF:UD-Q4_K_XL";
  if [ ! -z "$LLAMA_MODEL" ]; then
    model="$LLAMA_MODEL";
  fi

  llama serve -hf ${LLAMA_MODEL} --reasoning off --alias gpt-4.1 -ag -lv 2 --max-iterations 0;
}

function qwen-proxy {
  if [ ! -d "${HOME}/src/claude-code-proxy" ]; then
    mkdir -p "${HOME}/src";
    pushd "${HOME}/src";
    git clone git@github.com:danrasband/claude-code-proxy.git;
    popd;
  fi;

  pushd "${HOME}/src/claude-code-proxy";
  dc up -d;
}

function qlaude {
  export ANTHROPIC_BASE_URL=http://127.0.0.1:8082;
  unset ANTHROPIC_AUTH_TOKEN;
  export ANTHROPIC_MODEL=claude-sonnet-5
  export ANTHROPIC_SMALL_FAST_MODEL=claude-sonnet-5;
  claude $@;
  exit;
}
