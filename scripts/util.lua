function make_gps_tag(position)
    return '[gps='..math.floor(position.x)..','..math.floor(position.y)..']'
end

function format_tick_to_time(tick)
    local seconds = math.floor(tick / 60)
    local days = math.floor(seconds/3600/24)
    local hours = math.floor(seconds/3600 - days*24)
    local mins = math.floor(seconds/60 - hours*60 - days*1440)
    local secs = math.floor(seconds - mins *60 - hours*3600  - days*86400)
    local s_hours = string.format("%02.f",hours);
    local s_mins = string.format("%02.f", mins);
    local s_secs = string.format("%02.f", secs);

    return days..":"..s_hours..":"..s_hours..":"..s_mins..":"..s_secs
end
