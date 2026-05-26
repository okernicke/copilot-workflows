#!/bin/bash

REPO_ROOT="/mnt/c/Users/olive/path/to/your/repo"
SESSION="copilot-agents"
LOG_DIR="$HOME/copilot-logs"

mkdir -p "$LOG_DIR"

unset TMUX

tmux kill-session -t "$SESSION" 2>/dev/null

# =========================
# CREATE LAYOUT
# =========================

# start session (left pane = coordinator)
tmux new-session -d -s "$SESSION" -c "$REPO_ROOT"

# split right column
tmux split-window -t "$SESSION" -h -c "$REPO_ROOT"

# RIGHT side becomes workers
tmux select-pane -t "$SESSION":0.1

tmux split-window -v -t "$SESSION" -c "$REPO_ROOT"
tmux split-window -v -t "$SESSION" -c "$REPO_ROOT"
tmux split-window -v -t "$SESSION" -c "$REPO_ROOT"

tmux select-layout -t "$SESSION" tiled

# =========================
# RUN COMMAND WRAPPER
# =========================


run_agent() {
  local name="$1"
  local agent="$2"

  tmux send-keys -t "$SESSION" \
    "cd $REPO_ROOT; copilot --model auto --agent $agent" C-m
}

# =========================
# START AGENTS
# =========================

run_agent "swarm-coordinator" "swarm-coordinator"
run_agent "tdd-coordinator" "tdd-coordinator"
run_agent "property-test-generator" "property-test-generator"
run_agent "crap-analyzer" "crap-analyzer"
run_agent "git-orchestrator" "git-orchestrator"

# =========================
# ATTACH
# =========================

tmux attach-session -t "$SESSION"