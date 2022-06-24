local Translations = {
    error = {
        ['owner_not_found'] = 'Owner not found',
        ['not_nearby_house'] = 'You are not near a house',
        ['no_perms'] = 'You have no permission to do this',
        ['not_keyholder'] = 'You have no keys for this house',
        ['target_not_found'] = 'Target not found',
        ['cant_give_keys_to_self'] = 'You can\'t give yourself keys',
        ['cant_remove_keys_from_self'] = 'You can\'t remove yourself',
        ['not_in_car'] = 'Not inside of a car',
        ['dont_park_here'] = 'This vehicle doesn\'t belong here',
        ['no_vehicles'] = 'There are no vehicles here',
        ['not_owner_car'] = 'This vehicle isn\'t owned by anyone',
    },
    success = {
        ['create_house'] = 'Succesfully created %{house} for %{owner}',
        ['create_stash'] = 'Succesfully created stash inside of %{house}',
        ['create_outfit'] = 'Succesfully created wardrobe inside of %{house}',
        ['create_logout'] = 'Succesfully created bed inside of %{house}',
        ['create_garage'] = 'Succesfully created garage inside of %{house}',
        ['create_door'] = 'Succesfully created a door inside of %{house}',
        ['give_keys'] = 'Gave keys to %{target}',
        ['remove_keys'] = 'Removed keys from %{target}',
        ['deleted_house'] = 'Succesfully deleted %{house}',
    },
    info = {
        ['deleted_houses'] = 'Deleted %{amount} house(s)',
    },
    text = {
        ['open_stash'] = 'Open Stash',
        ['change_outfit'] = 'Change Outfit',
        ['change_char'] = 'Change Character',
        ['open_door'] = 'Open Door',
        ['close_door'] = 'Close Door',
        ['store_car'] = 'Store Car',
        ['retrieve_car'] = 'Retrieve Car',
        ['vehicle_info'] = 'Plate: %{plate} | Engine: %{engine} | Fuel: %{fuel}',
        ['all_houses'] = 'All houses',
        ['house_info'] = 'Owner: %{owner} | Location: %{center}',
    },
    command = {
        ['create_house'] = 'Create an open interior house. Your current location should be the center of the house',
        ['name_of_house'] = 'The name of the house (Unique)(Case sensitive)',
        ['owner_cid'] = 'The citizenid of the owner (Case sensitive) or server id',
        ['delete_all'] = 'Delete all the houses there are',
        ['create_stash'] = 'Create a stash at your current location in your house',
        ['create_outfit'] = 'Create a wardrobe at your current location in your house',
        ['create_logout'] = 'Create a bed at your current location in your house',
        ['create_garage'] = 'Create a garage at your current location in your house',
        ['create_door'] = 'Create a door at your current location in your house',
        ['door_name'] = 'The name of the door inside of your doorlock resource (IMPORTANT)',
        ['give_keys'] = 'Give keys to someone else at the current house you are at',
        ['target_keys'] = 'The citizenid of the target (Case sensitive) or server id',
        ['remove_keys'] = 'Remove keys from someone else at the current house you are at',
        ['delete_house'] = 'Delete a specific house',
        ['viewallhouses'] = 'View all the houses on this server',
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
