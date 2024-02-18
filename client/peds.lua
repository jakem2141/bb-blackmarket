CreateThread(function()
    if Config.UseMoneyLaundering then
        for _, shop in pairs(Config.Laundering) do
            lib.requestModel(shop.PedModel)
    
            local shopKeeper = CreatePed(1, shop.PedModel, shop.PedSpawn, false, true)
            SetEntityInvincible(shopKeeper, true)
            SetBlockingOfNonTemporaryEvents(shopKeeper, true)
            FreezeEntityPosition(shopKeeper, true)
    
            exports.ox_target:addSphereZone({
                coords = vec3(shop.PedSpawn.x, shop.PedSpawn.y, shop.PedSpawn.z+1),
                radius = 1,
                debug = Config.Debug,
                options = {
                    {
                        event = 'blackmarket:LaunderMenu',
                        label = "Speak to "..shop.ShopName.." owner",
                        args = shop,
                        icon = "fa-solid fa-basket-shopping",
                        iconColor = "white",
                        distance = 2,
                        debug = Config.Debug, 
                    },
                },
            })
            TriggerServerEvent('blackmarket:server:UpdateStores', shop)
        end
    end

    for k, v in pairs(Config.MarketPeds) do
        lib.requestModel(v.Model)
        local marketPeds = CreatePed(1, v.Model, v.Location, false, true)
        SetEntityInvincible(marketPeds, true)
        SetBlockingOfNonTemporaryEvents(marketPeds, true)
        FreezeEntityPosition(marketPeds, true)

        if Config.UseAnims then
            lib.requestAnimDict(v.AnimationDict)
            TaskPlayAnim(marketPeds, v.AnimationDict, v.AnimationClip, 1.0, 1.0, -1, 1, 1, false, false, false)
        end
        
        local coords = v.Location

        exports.ox_target:addSphereZone({
            coords = vec3(coords.x, coords.y, coords.z+1),
            radius = 1,
            debug = Config.Debug,
            options = {
                {
                    event = 'blackmarket:BuyMenu',
                    label = "Trade "..v.Name,
                    args = v,
                    icon = "fa-solid fa-box-archive",
                    iconColor = "yellow",
                    distance = 2, 
                    debug = Config.Debug,
                },
            },
        })
    end
end)

CreateThread(function()
    local entrance = Config.BlackMarketAccess.EntranceInfo
    local randomLocation = math.random(1, #entrance.EntrancePedLocations)
    local dropoffLocation = entrance.EntrancePedLocations[randomLocation]

    lib.requestModel(entrance.EntrancePedModel)
    local entrancePed = CreatePed(1, entrance.EntrancePedModel, dropoffLocation, false, true)
    SetEntityInvincible(entrancePed, true)
    SetBlockingOfNonTemporaryEvents(entrancePed, true)
    FreezeEntityPosition(entrancePed, true)
    
    if Config.UseAnims then
        lib.requestAnimDict(entrance.EntrancePedAnimationDict)
        TaskPlayAnim(entrancePed, entrance.EntrancePedAnimationDict, entrance.EntrancePedAnimationClip, 1.0, 1.0, -1, 1, 1, false, false, false)
    end

    exports.ox_target:addSphereZone({
        coords = vec3(dropoffLocation.x, dropoffLocation.y, dropoffLocation.z+1),
        radius = 1,
        debug = Config.Debug,
        options = {
            {
                event = 'blackmarket:EntranceMenu',
                label = "Speak to "..entrance.EntrancePedName,
                args = entrance.EntrancePedName,
                icon = "fa-solid fa-box-archive",
                iconColor = "yellow",
                distance = 2, 
                debug = Config.Debug,
            },
        },
    })
end)

CreateThread(function()
    local exit = Config.BlackMarketAccess.ExitInfo
    local pedCoords = exit.ExitPedLocation

    lib.requestModel(exit.ExitPedModel)
    local exitPed = CreatePed(1, exit.ExitPedModel, exit.ExitPedLocation, false, true)
    SetEntityInvincible(exitPed, true)
    SetBlockingOfNonTemporaryEvents(exitPed, true)
    FreezeEntityPosition(exitPed, true)

    if Config.UseAnims then
        lib.requestAnimDict(exit.ExitPedAnimationDict)
        TaskPlayAnim(exitPed, exit.ExitPedAnimationDict, exit.ExitPedAnimationClip, 1.0, 1.0, -1, 1, 1, false, false, false)
    end

    exports.ox_target:addSphereZone({
        coords = vec3(pedCoords.x, pedCoords.y, pedCoords.z+1),
        radius = 1,
        debug = Config.Debug,
        options = {
            {
                label = "Speak to "..exit.ExitPedName,
                onSelect = function()
                    LeavingMarket()
                end,
                icon = "fa-solid fa-box-archive",
                iconColor = "yellow",
                distance = 2, 
            },
        },
    })
end)

CreateThread(function()
    local repair = Config.BlackMarketAccess.RepairsInfo

    lib.requestModel(repair.RepairsPedModel)
    local repairPed = CreatePed(1, repair.RepairsPedModel, repair.RepairsPedLocation, false, true)
    SetEntityInvincible(repairPed, true)
    SetBlockingOfNonTemporaryEvents(repairPed, true)
    FreezeEntityPosition(repairPed, true)

    if Config.UseAnims then
        lib.requestAnimDict(repair.RepairsPedAnimationDict)
        TaskPlayAnim(repairPed, repair.RepairsPedAnimationDict, repair.RepairsPedAnimationClip, 1.0, 1.0, -1, 1, 1, false, false, false)
    end

    exports.ox_target:addSphereZone({
        coords = vec3(repair.RepairsPedLocation.x, repair.RepairsPedLocation.y, repair.RepairsPedLocation.z+1),
        radius = 1,
        debug = Config.Debug,
        options = {
            {
                event = 'blackmarket:RepairMenu',
                label = "Speak to "..repair.RepairsPedName,
                args = repair,
                icon = "fa-solid fa-box-archive",
                iconColor = "yellow",
                distance = 2, 
                debug = Config.Debug,
            },
        },
    })
end)

CreateThread(function()
    local sales = Config.ItemSelling.SalesPed
    local pedCoords = sales.SalesPedLocation
    local sellingData = Config.ItemSelling.ItemInfo

    lib.requestModel(sales.SalesPedModel)
    local salesPed = CreatePed(1, sales.SalesPedModel, sales.SalesPedLocation, false, true)
    SetEntityInvincible(salesPed, true)
    SetBlockingOfNonTemporaryEvents(salesPed, true)
    FreezeEntityPosition(salesPed, true)

    if Config.UseAnims then
        lib.requestAnimDict(sales.SalesPedAnimationDict)
        TaskPlayAnim(salesPed, sales.SalesPedAnimationDict, sales.SalesPedAnimationClip, 1.0, 1.0, -1, 1, 1, false, false, false)
    end

    exports.ox_target:addSphereZone({
        coords = vec3(pedCoords.x, pedCoords.y, pedCoords.z+1),
        radius = 1,
        debug = Config.Debug,
        options = {
            {
                event = 'blackmarket:SellingMenu',
                label = "Speak to "..sales.SalesPedName,
                args = sellingData,
                icon = "fa-solid fa-box-archive",
                iconColor = "yellow",
                distance = 2, 
                debug = Config.Debug,
            },
        },
    })
end)