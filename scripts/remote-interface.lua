remote.add_interface(
    'death_log', {
        informatron_menu = function(data)
            return Informatron.menu(data.player_index)
        end,

        informatron_page_content = function(data)
            return Informatron.page_content(data.page_name, data.player_index, data.element)
        end,

        -- informatron_page_content_update = function(data)
        --   return Informatron.page_content_update(data.page_name, data.player_index, data.element)
        -- end,
    }
)
