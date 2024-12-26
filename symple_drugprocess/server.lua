local function CreateConversionZone(coords)
    exports.ox_target:addBoxZone({
        coords = coords,
        size = vec3(2, 2, 2),
        rotation = 45,
        debug = false,
        options = {
            {
                name = 'convert_drugs',
                icon = 'fas fa-cannabis',
                label = 'Convert Drug Packages',
                distance = 2.0,
                onSelect = function()
                    local success = lib.callback.await('convert_drugs:check', false)
                    if success then
                        if lib.progressBar({
                            duration = 5000,
                            label = 'Converting Packages...',
                            useWhileDead = false,
                            canCancel = true,
                            disable = {
                                car = true,
                                move = true,
                                combat = true
                            },
                            anim = {
                                dict = "anim@amb@business@weed@weed_sorting_seated@",
                                clip = "sorter_right_sort_v3_sorter02",
                                flag = 1
                            },
                        }) then

                            TriggerServerEvent('convert_drugs:process', 'weed')
                        end
                    end
                end
            }
        }
    })
end

-- Example usage:
-- CreateConversionZone(vector3(x, y, z))
local weedTypes = {
    'weed_white-widow',
    'weed_skunk',
    'weed_purple-haze',
    'weed_og-kush',
    'weed_amnesia',
    'weed_ak47',
}

lib.callback.register('convert_drugs:check', function(source)
    return true
end)

RegisterNetEvent('convert_drugs:process', function(selected)
    local source = source

    if selected == 'weed' then
        local weedBrick = exports.ox_inventory:Search(source, 'count', 'weed_brick')
        if weedBrick > 0 then
            if exports.ox_inventory:RemoveItem(source, 'weed_brick', 1) then
                local totalBags = 500
                while totalBags > 0 do
                    local randomType = weedTypes[math.random(#weedTypes)]
                    local randomAmount = math.random(1, math.min(totalBags, 250))
                    exports.ox_inventory:AddItem(source, randomType, randomAmount)
                    totalBags = totalBags - randomAmount
                end
            end
        end
    elseif selected == 'coke' then
        local cokeBrick = exports.ox_inventory:Search(source, 'count', 'coke_brick')
        if cokeBrick > 0 then
            if exports.ox_inventory:RemoveItem(source, 'coke_brick', 1) then
                exports.ox_inventory:AddItem(source, 'cokebaggy', 250)
            end
        end
    end

    lib.notify(source, {
        title = 'Success',
        description = 'Packages converted successfully',
        type = 'success'
    })
end)
