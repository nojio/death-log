is_debug_mode = false

require("scripts/util")
Informatron = require('scripts/informatron')

local function init_global()
  global.player_death_count = {}
  global.death_history = {}
end

local function reset_global(player)
  global.player_death_count[player.name] = 0
end

script.on_init(function ()
  init_global()
end)

script.on_configuration_changed(function ()
  -- init_global()
end)

script.on_event(defines.events.on_pre_player_died, function(event)
  local player = game.get_player(event.player_index)

  if not global.player_death_count[player.name] then
    global.player_death_count[player.name] = 0
  end

  global.player_death_count[player.name] = global.player_death_count[player.name] + 1

  local cause = "Unknown"
  if event.cause then
    cause = event.cause.name
  end

  if cause == "character" then
    if event.cause.player and event.cause.player.name then
        cause = event.cause.player.name
    end
  end

  local history = {
    id = player.name .. "_" .. event.tick,
    player_name = player.name,
    death_count = global.player_death_count[player.name],
    surface = player.surface,
    position = player.position,
    cause = cause,
    tick = event.tick,
  }

  table.insert(global.death_history, history)
  if is_debug_mode then
    player.print("death count+: "..player.name..", "..global.player_death_count[player.name])
  end
end)

script.on_event(defines.events.on_player_joined_game, function(event)
  local player = game.get_player(event.player_index)
  global.player_death_count[player.name] = global.player_death_count[player.name] or 0
end)

script.on_event(defines.events.on_gui_click, function(event)
    if not (event.element and event.element.valid) then return end
    local element = event.element
    local player = game.get_player(event.player_index)

    for i, _ in pairs(global.death_history) do
      if element.name == "zoom_position_"..global.death_history[i].id or element.name == "hisotry_position_"..global.death_history[i].id then
          player.print("zoom_position pressed")
          player.zoom_to_world(global.death_history[i].position, 0.5)
      end
    end
end)

require('scripts/remote-interface')

if script.active_mods["gvv"] then require("__gvv__.gvv")() end
