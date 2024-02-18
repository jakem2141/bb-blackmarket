RegisterNetEvent('blackmarket:server:RepairWeapon', function(data)
    local currentWeapon = exports.ox_inventory:GetCurrentWeapon(source)

    if exports.ox_inventory:RemoveItem(source, Config.MoneyItem, data.args.RepairCost) then
        exports.ox_inventory:SetDurability(source, currentWeapon.slot, 100)
        lib.notify(source, {
            title = 'Attention',
            description = "Your weapon has been fully repaired!",
            type = 'inform'
        })
    end
end)

-------------
--Callbacks--
-------------

lib.callback.register('blackmarket:server:CheckWeaponData', function()
    local currentWeapon = exports.ox_inventory:GetCurrentWeapon(source)

    if currentWeapon == nil or currentWeapon.name == 'WEAPON_UNARMED' then
        lib.notify(source, {
            title = 'Unable',
            description = "You're not holding a weapon",
            type = 'inform'
        })
        return
    end

    return currentWeapon.metadata
end)