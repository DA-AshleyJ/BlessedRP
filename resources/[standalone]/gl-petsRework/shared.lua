Config = {}

Config.SearchableItems = {
	['IllegalItems'] = {
		['weed_brick'] = 10,
		['cocoke_brickke'] = 1,
		['sandwich'] = 1,
		['water_bottle'] = 1,
	},
}

Config.DoghousePrice = 1000
Config.TennisBallPrice = 50
Config.FrisbeePrice = 50
Config.PetfoodPrice = 100


Config.Pets = {

{type = 'Dogs', model = 'a_c_husky', variations = 0, price = 5000, label = 'Husky'},
{type = 'Dogs', model = 'a_c_poodle', variations = 0, price = 4000, label = 'Poodle'},
{type = 'Dogs', model = 'a_c_pug', variations = 4, price = 2000, label = 'Pug'},
{type = 'Dogs', model = 'a_c_retriever', variations = 0, price = 4000, label = 'Retriever'},
{type = 'Dogs', model = 'a_c_rottweiler', variations = 3, price = 5000, label = 'Rottweiler'},
{type = 'Dogs', model = 'a_c_shepherd', variations = 0, price = 5000, label = 'Shepherd'},
{type = 'Dogs', model = 'a_c_westy', variations = 3, price = 5000, label = 'Westy'},
{type = 'Other', model = 'a_c_cat_01', variations = 0, price = 3000, label = 'Cat'},
{type = 'Other', model = 'a_c_pig', variations = 0, price = 5000, label = 'Pig'},
{type = 'Other', model = 'a_c_rat', variations = 0, price = 3000, label = 'Rat'},
{type = 'Other', model = 'a_c_hen', variations = 0, price = 3000, label = 'Hen'},
{type = 'Other', model = 'a_c_rabbit_01', variations = 0, price = 3000, label = 'Rabbit'},
}


Config.PetAnimations = {

{
	model = 1832265812, --a_c_pug
	SitDict = "creatures@pug@amb@world_dog_sitting@idle_a",
	SitAnim = "idle_b",
	BarkDict = "creatures@pug@amb@world_dog_barking@idle_a",
	BarkAnim = "idle_a"
},
{
	model = 1125994524, --a_c_poodle
	SitDict = "creatures@pug@amb@world_dog_sitting@idle_a",
	SitAnim = "idle_b",
	BarkDict = "creatures@pug@amb@world_dog_barking@idle_a",
	BarkAnim = "idle_a"
},
{
	model = -1788665315, --a_c_rottweiler
	SitDict = "creatures@retriever@amb@world_dog_sitting@idle_a",
    SitAnim = "idle_b",
    BarkDict = "creatures@rottweiler@amb@world_dog_barking@idle_a",
    BarkAnim = "idle_a",
    SleepDict = "creatures@rottweiler@amb@sleep_in_kennel@",
    SleepAnim = "sleep_in_kennel",
    BegDict = "creatures@rottweiler@tricks@",
    BegAnim = "beg_loop",
    PawDict = "creatures@rottweiler@tricks@",
    PawAnim = "paw_right_loop",
},
{
	model = 1318032802, --a_c_husky
	SitDict = "creatures@retriever@amb@world_dog_sitting@idle_a",
    SitAnim = "idle_b",
    BarkDict = "creatures@rottweiler@amb@world_dog_barking@idle_a",
    BarkAnim = "idle_a",
    SleepDict = "creatures@rottweiler@amb@sleep_in_kennel@",
    SleepAnim = "sleep_in_kennel",
    BegDict = "creatures@rottweiler@tricks@",
    BegAnim = "beg_loop",
    PawDict = "creatures@rottweiler@tricks@",
    PawAnim = "paw_right_loop",
},
{
	model = 882848737, --a_c_retriever
	SitDict = "creatures@retriever@amb@world_dog_sitting@idle_a",
    SitAnim = "idle_b",
    BarkDict = "creatures@rottweiler@amb@world_dog_barking@idle_a",
    BarkAnim = "idle_a",
    SleepDict = "creatures@rottweiler@amb@sleep_in_kennel@",
    SleepAnim = "sleep_in_kennel",
    BegDict = "creatures@rottweiler@tricks@",
    BegAnim = "beg_loop",
    PawDict = "creatures@rottweiler@tricks@",
    PawAnim = "paw_right_loop",
},
{
	model = 1126154828, --a_c_shepherd
	SitDict = "creatures@retriever@amb@world_dog_sitting@idle_a",
    SitAnim = "idle_b",
    BarkDict = "creatures@rottweiler@amb@world_dog_barking@idle_a",
    BarkAnim = "idle_a",
    SleepDict = "creatures@rottweiler@amb@sleep_in_kennel@",
    SleepAnim = "sleep_in_kennel",
    BegDict = "creatures@rottweiler@tricks@",
    BegAnim = "beg_loop",
    PawDict = "creatures@rottweiler@tricks@",
    PawAnim = "paw_right_loop",
},
{
	model = 1462895032, --a_c_cat_01
    SitDict = "creatures@cat@amb@world_cat_sleeping_ground@base",
    SitAnim = "base",
    SleepDict = "creatures@cat@amb@world_cat_sleeping_ground@base",
    SleepAnim = "base",
},
{
	model = -541762431, -- a_c_rabbit_01
    BarkDict = "creatures@rabbit@amb@world_rabbit_eating@base",
    BarkAnim = "base",
},
{
	model = 307287994, --a_c_mtlion
    SitDict = "creatures@cougar@amb@world_cougar_rest@base",
    SitAnim = "base",
},
{
	model = 1794449327, --a_c_hen
    SitDict = "creatures@hen@amb@world_hen_standing@idle_a",
    SitAnim = "idle_a",
    BarkDict = "creatures@hen@amb@world_hen_pecking@base",
    BarkAnim = "base",
},
{
	model = -1384627013, --a_c_westy
	SitDict = "creatures@pug@amb@world_dog_sitting@idle_a",
	SitAnim = "idle_b",
	BarkDict = "creatures@pug@amb@world_dog_barking@idle_a",
	BarkAnim = "idle_a"
},
{
	model = -1323586730, --a_c_pig
	BarkDict = "creatures@pig@amb@world_pig_grazing@base",
    BarkAnim = "base",
},

}