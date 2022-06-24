-- get the interior id of Import Warehouse
local interiorid = GetInteriorAtCoords(941.82135009766,-2327.0629882813,30.533470153809)

-- load the interior props
--EnableInteriorProp(interiorid, "basic_style_set")
--EnableInteriorProp(interiorid, "branded_style_set")
EnableInteriorProp(interiorid, "urban_style_set")
EnableInteriorProp(interiorid, "car_floor_hatch")
EnableInteriorProp(interiorid, "door_blocker")

-- always refresh the interior or they won't appear
RefreshInterior(interiorid)