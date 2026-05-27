local wezterm = require 'wezterm'
local mux = wezterm.mux

wezterm.on('gui-startup', function(cmd)

  local args = cmd or {}
  local project_dir = args.cwd or "C:\\projekte\\copilot-workflows"
  local tab, pane, window = mux.spawn_window({cwd = project_dir,})

  -- LEFT column (implicitly 1/3)
  local left = pane

  -- MIDDLE column (1/3)
  local middle = left:split { direction = "Right", size = 0.6  }

  -- RIGHT column (1/3)
  local right = middle:split { direction = "Right", size = 0.5  }

  -- Now split MIDDLE + RIGHT into 2 rows each
  local middle_bottom = middle:split { direction = "Bottom", size = 0.5 }
  local right_bottom = right:split { direction = "Bottom", size = 0.5 }

  left:send_text("copilot --model auto --agent swarm-coordinator --allow-all-tools\n\r")
  middle:send_text("copilot --model auto --agent tdd-coordinator --allow-all-tools\n\r")
  right:send_text("copilot --model auto --agent property-test-generator  --allow-all-tools\n\r")
  middle_bottom:send_text("copilot --model auto --agent quality-guardian  --allow-all-tools\n\r")
  right_bottom:send_text("copilot --model auto --agent git-orchestrator  --allow-all-tools\n\r")
  
  local gui = window:gui_window()

  -- fixed size (width is your "dock width")
  local width = 1920
  local height = 1000

  -- move to right side (adjust X for your screen)
  local screen_width = 3840  -- adjust if needed
  local x = screen_width - width
  local y = 30

  gui:set_inner_size(width, height)
  gui:set_position(x, y)
  
end)

return {
  color_scheme = "GitHub Dark",
  enable_tab_bar = false,
  window_decorations = "RESIZE",
  initial_cols = 120,
  initial_rows = 40,
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