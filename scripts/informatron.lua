local Informatron = {}

function Informatron.menu(player_index)
    -- local menu = {
    --     death_log_history = 1,
    -- }
    -- return menu
    return {}
end

function Informatron.page_content(page_name, player_index, element)
    local player = game.get_player(player_index)
    if is_debug_mode then
        player.print("function function Informatron.page_content(: " .. player.name)
    end

    if page_name == "death_log" then
        local text = element.add{type="label", name="death_count_text", caption={"death_log.death_count_text", global.player_death_count[player.name] or 0}}
        text.style.bottom_margin = 20

        element.add{type="label", name="history_title", caption={"death_log.history_title"}, style="heading_1_label"}

        local history_table = element.add{type="table", name="history_table", column_count=3, draw_horizontal_lines=false, draw_horizontal_line_after_headers=false}
        history_table.style.horizontally_stretchable = true
        history_table.style.column_alignments[1] = "middle-center"
        history_table.style.column_alignments[2] = "left"
        history_table.style.column_alignments[3] = "middle-center"

        -- header
        local history_tick_header = history_table.add{type='label',caption=""}
        local history_text_header = history_table.add{type='label',caption=""}
        local history_position_header = history_table.add{type='label',caption=""}

        -- header style
        history_tick_header.style.width = 150
        history_text_header.style.width = 300
        history_position_header.style.width = 200

        history_tick_header.style.horizontal_align = "center"
        history_text_header.style.horizontal_align = "left"
        history_position_header.style.horizontal_align = "center"

        -- record
        for i = #global.death_history, 1, -1 do
        -- for i, _ in pairs(global.death_history) do
            local history_tick_cell = history_table.add{type='label',caption={"death_log.history_tick_cell", format_tick_to_time(global.death_history[i].tick)}}
            local history_text_cell = history_table.add{type='label',caption={"death_log.history_text_cell",
                global.death_history[i].player_name,
                global.death_history[i].cause,
            }}
            local history_position_cell = history_table.add{type='button', name="zoom_position_"..global.death_history[i].id, style="button", caption={"death_log.history_position_cell"}}

            -- record style
            history_tick_cell.style.top_margin = 15
            history_text_cell.style.top_margin = 15
            history_position_cell.style.top_margin = 15

            history_tick_cell.style.bottom_margin = 15
            history_text_cell.style.bottom_margin = 15
            history_position_cell.style.bottom_margin = 15

            history_tick_cell.style.vertical_align = "center"
            history_text_cell.style.vertical_align = "center"
            history_position_cell.style.vertical_align = "center"
        end
    end
end

return Informatron
