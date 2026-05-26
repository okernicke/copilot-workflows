#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"

SESSION="copilot-swarm"
MODEL="auto"                    # Change to "claude-sonnet-4" if you want

COPILOT_CMD="copilot"

# Check copilot
if ! command -v "$COPILOT_CMD" >/dev/null 2>&1; then
  echo "❌ 'copilot' command not found!" >&2
  echo "Make sure copilot CLI is installed and in your PATH." >&2
  exit 1
fi

if ! command -v tmux >/dev/null 2>&1; then
  echo "❌ tmux not found!" >&2
  exit 1
fi

echo "🚀 Starting Copilot Swarm in tmux session: $SESSION"

# Kill old session if exists
tmux kill-session -t "$SESSION" 2>/dev/null || true

# Create new session with coordinator (main pane)
tmux new-session -d -s "$SESSION" -c "$REPO_ROOT" "bash --login"

# Send first command
tmux send-keys -t "$SESSION":0 "$COPILOT_CMD --model $MODEL --agent swarm-coordinator" Enter

# Create 4 more panes with better strategy to avoid "no space" error
for i in {1..4}; do
    # Split horizontally (stacked) - more reliable than vertical when space is tight
    tmux split-window -v -t "$SESSION" -c "$REPO_ROOT" "bash --login"
    tmux send-keys -t "$SESSION":0.$i "$COPILOT_CMD --model $MODEL --agent $(echo "tdd-coordinator property-test-generator crap-analyzer git-orchestrator" | cut -d' ' -f$i)" Enter
done

# Apply nice layout + resize to prevent cramped panes
tmux select-layout -t "$SESSION" main-vertical
tmux resize-pane -t "$SESSION":0 -x 45%   # Make coordinator bigger
tmux select-layout -t "$SESSION" tiled     # Final balanced layout

# Focus coordinator
tmux select-pane -t "$SESSION":0.0

echo "✅ tmux session created successfully!"
echo "Attaching now..."
tmux attach-session -t "$SESSION"