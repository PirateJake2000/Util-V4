---@class UtilTimer
---@field duration number
---@field callback function
---@field time integer time elapsed in ticks

---@param duration number
---@param callback function
function Util.Timers.Create(duration, callback)
    local timer = {
        duration = duration,
        callback = callback,
        time = 0
    }

    table.insert(Util.Timers.List, timer)
end

function Util.Timers.Update()
    for i, timer in pairs(Util.Timers.List) do
        timer.time = timer.time + 1

        if timer.time >= timer.duration then
            timer.callback()
            table.remove(Util.Timers.List, i)
        end
    end
end

---@type table<integer, UtilTimer>
Util.Timers.List = {}