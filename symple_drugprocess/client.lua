local conversionPoint = vec3(-1975.91, -515.8, 17.68)
local pedModel = "mp_m_bogdangoon"
local createdPed = nil

CreateThread(function()
    print('Client: Resource starting')
    RequestModel(pedModel)
    while not HasModelLoaded(pedModel) do
        Wait(0)
    end
   
    createdPed = CreatePed(4, pedModel, conversionPoint.x, conversionPoint.y, conversionPoint.z - 1.0, 180.0, false, true)
    SetEntityHeading(createdPed, 180.0)
    FreezeEntityPosition(createdPed, true)
    SetEntityInvincible(createdPed, true)
    SetBlockingOfNonTemporaryEvents(createdPed, true)
   
    exports.ox_target:addModel(pedModel, {
        {
            name = 'convert_drugs',
            icon = 'fas fa-cannabis',
            label = 'Convert Drug Packages',
            distance = 2.0,
            onSelect = function()
                local success = lib.callback.await('convert_drugs:check', false)
                if success then
                    local menu = {
                        id = 'drug_conversion_menu',
                        title = 'Drug Conversion Menu',
                        options = {
                            {
                                title = 'Convert Weed Brick',
                                description = 'Convert small bags into a brick',
                                icon = 'cannabis',
                                onSelect = function()
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
                                            dict = "special_ped@jessie@michael_1@michael_1a",
                                            clip = "jessie_ig_1_argue_with_michael_1a_001",
                                            flag = 1
                                        }
                                        
                                    }) then
                                        TriggerServerEvent('convert_drugs:process', 'weed')
                                    end
                                end
                            },
                            {
                                title = 'Convert Cocaine Brick',
                                description = 'Convert small bags into a brick',
                                icon = 'pills',
                                onSelect = function()
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
                                            dict = "mp_common",
                                            clip = "givetake1_a",
                                            flag = 1
                                        }
                                        
                                        
                                    }) then
                                        TriggerServerEvent('convert_drugs:process', 'coke')
                                    end
                                end
                            }
                        }
                    }

                    lib.registerContext(menu)
                    lib.showContext('drug_conversion_menu')
                end
            end,
            anim = {
                dict = "mp_common",
                clip = "givetake1_a",
                flag = 1
            },
        }
    })
end)

AddEventHandler('onResourceStop', function(resourceName)
    if resourceName == GetCurrentResourceName() and createdPed then
        DeleteEntity(createdPed)
    end
end)
