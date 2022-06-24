Citizen.CreateThread(function()


RequestIpl("tunergarage_milo_")

	interiorID = GetInteriorAtCoords(810.46170000,-962.07540000,25.30295000)

	
	if IsValidInterior(interiorID) then
    EnableInteriorProp(interiorID, "entity_set_bedroom") 
    DisableInteriorProp(interiorID, "entity_set_bedroom_empty") 
    EnableInteriorProp(interiorID, "entity_set_bombs") 
    DisableInteriorProp(interiorID, "entity_set_box_clutter") 
    EnableInteriorProp(interiorID, "entity_set_cabinets") 
    DisableInteriorProp(interiorID, "entity_set_car_lift_cutscene") 
    EnableInteriorProp(interiorID, "entity_set_car_lift_default") 
    EnableInteriorProp(interiorID, "entity_set_car_lift_purchase") 
    EnableInteriorProp(interiorID, "entity_set_chalkboard") 
    EnableInteriorProp(interiorID, "entity_set_container") 
    EnableInteriorProp(interiorID, "entity_set_cut_seats") 
    EnableInteriorProp(interiorID, "entity_set_def_table") 
    EnableInteriorProp(interiorID, "entity_set_drive") 
    EnableInteriorProp(interiorID, "entity_set_ecu") 
    EnableInteriorProp(interiorID, "entity_set_IAA") 
    EnableInteriorProp(interiorID, "entity_set_laptop") 
    EnableInteriorProp(interiorID, "entity_set_lightbox") 
    EnableInteriorProp(interiorID, "entity_set_methLab") 
    EnableInteriorProp(interiorID, "entity_set_plate") 
    EnableInteriorProp(interiorID, "entity_set_scope") 
    DisableInteriorProp(interiorID, "entity_set_style_1") 
    DisableInteriorProp(interiorID, "entity_set_style_2") 
    DisableInteriorProp(interiorID, "entity_set_style_3") 
    DisableInteriorProp(interiorID, "entity_set_style_4") 
    DisableInteriorProp(interiorID, "entity_set_style_5") 
    EnableInteriorProp(interiorID, "entity_set_style_6") 
    DisableInteriorProp(interiorID, "entity_set_style_7") 
    DisableInteriorProp(interiorID, "entity_set_style_8") 
    DisableInteriorProp(interiorID, "entity_set_style_9") 
    DisableInteriorProp(interiorID, "entity_set_table") 
    EnableInteriorProp(interiorID, "entity_set_thermal") 
    EnableInteriorProp(interiorID, "entity_set_tints") 
    EnableInteriorProp(interiorID, "entity_set_train") 
    EnableInteriorProp(interiorID, "entity_set_virus") 
	
	RefreshInterior(interiorID)
	
	end
	
end)
