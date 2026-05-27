local wezterm = require 'wezterm'
local mux = wezterm.mux

wezterm.on('gui-startup', function(cmd)
  local tab, pane, window = mux.spawn_window(cmd or {})

  -- LEFT column (implicitly 1/3)
  local left = pane

  -- MIDDLE column (1/3)
  local middle = left:split { direction = "Right", size = 0.6  }

  -- RIGHT column (1/3)
  local right = middle:split { direction = "Right", size = 0.5  }

  -- Now split MIDDLE + RIGHT into 2 rows each
  local middle_bottom = middle:split { direction = "Bottom", size = 0.5 }
  local right_bottom = right:split { direction = "Bottom", size = 0.5 }

  left:send_text("copilot --model auto --agent swarm-coordinator\n\r")
  middle:send_text("copilot --model auto --agent tdd-coordinator\n\r")
  right:send_text("copilot --model auto --agent property-test-generator\n\r")
  middle_bottom:send_text("copilot --model auto --agent crap-analyzer\n\r")
  right_bottom:send_text("copilot --model auto --agent git-orchestrator\n\r")
end)

return {
  font_size = 9.0,
  mouse_bindings = {
    {
      event = { Up = { streak = 1, button = 'Right' } },
      mods = 'NONE',
      action = wezterm.action_callback(function(window, pane)
        window:perform_action(
          wezterm.action.PasteFrom 'Clipboard',
          pane
        )
      end),
    },
  },
}