if Config['enable_print'] then
    --[[if Config['use_database'] then
        print('DataBase Enabled')
        if Config['database'] == 'new' then
            print('Database Config Set To New (1.9 or newer)')
        elseif Config['database'] == 'old' then
            print('Database Config Set To Old (Pre 1.9)')
        else
            print('Invalid Database Config')
        end
    else
        print('DataBase Disabled')
    end]]

    if Config['require_turbo'] then
        print('Turbo Requirement Enabled')
    else
        print('Turbo Requirement Disabled')
    end

    if Config['using_custom_mechanic'] then
        print('Extra - Custom Mechanic Enabled')
    else
        print('Extra - Custom Mechanic Disabled')
    end

    if Config['multi_nitrous_item'] then
        print('Multi-Bottle System Enabled')
    else
        print('Multi-Bottle System Disabled')
    end

    if Config['enable_nitrous'] then
        print('Nitrous Boost Enabled')
    else
        print('Nitrous Boost Disabled')
    end

    if Config['enable_tablet'] then
        print('Tuner Tablet Enabled')
    else
        print('Tuner Tablet Disabled')
    end

    if Config['enable_purge'] then
        print('Nitrous Purge Enabled')
    else
        print('Nitrous Purge Disabled')
    end
end