QBShared = QBShared or {}
QBShared.ForceJobDefaultDutyAtLogin = false -- true: Force duty state to jobdefaultDuty | false: set duty state from database last saved
QBShared.Jobs = {
	['unemployed'] = {
		label = 'Civilian',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Freelancer',
                payment = 10
            },
        },
	},
	['police'] = {
		label = 'Law Enforcement',
		defaultDuty = false,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Cadet',
                payment = 3.50
            },
			['1'] = {
                name = 'Officer',
                payment = 4.30
            },
			['2'] = {
                name = 'Snr Officer',
                payment = 5.10
            },
			['3'] = {
                name = 'Corporal',
                payment = 6.00
            },
			['4'] = {
                name = 'Sergeant',
                payment = 6.80
            },
            ['5'] = {
                name = 'Lieutenant',
                payment = 7.70
            },
            ['6'] = {
                name = 'Captain',
                payment = 8.50
            },
            ['7'] = {
                name = 'Deputy Chief',
                payment = 9.30
            },
            ['8'] = {
                name = 'Assistant Chief',
                isboss = true,
                payment = 10.10
            },
            ['9'] = {
                name = 'Chief',
                isboss = true,
                payment = 11.11
            },
            ['10'] = {
                name = 'Commissioner',
                isboss = true,
                payment = 12.12
            },
        },
	},
	['ambulance'] = {
		label = 'EMS',
		defaultDuty = false,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Recruit',
                payment = 4.30
            },
			['1'] = {
                name = 'Paramedic',
                payment = 6.80
            },
			['2'] = {
                name = 'Doctor',
                payment = 9.30
            },
			['3'] = {
                name = 'Surgeon',
                payment = 10.10
            },
			['4'] = {
                name = 'Chief',
				isboss = true,
                payment = 11.11
            },
        },
	},
	['realestate'] = {
		label = 'Real Estate',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Recruit',
                payment = 50
            },
			['1'] = {
                name = 'House Sales',
                payment = 75
            },
			['2'] = {
                name = 'Business Sales',
                payment = 100
            },
			['3'] = {
                name = 'Broker',
                payment = 125
            },
			['4'] = {
                name = 'Manager',
				isboss = true,
                payment = 150
            },
        },
	},
	['taxi'] = {
		label = 'Taxi',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Recruit',
                payment = 50
            },
			['1'] = {
                name = 'Driver',
                payment = 75
            },
			['2'] = {
                name = 'Event Driver',
                payment = 100
            },
			['3'] = {
                name = 'Sales',
                payment = 125
            },
			['4'] = {
                name = 'Manager',
				isboss = true,
                payment = 150
            },
        },
	},
     ['bus'] = {
		label = 'Bus',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Driver',
                payment = 6.20
            },
		},
	},
	['cardealer'] = {
		label = 'Vehicle Dealer',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Recruit',
                payment = 50
            },
			['1'] = {
                name = 'Showroom Sales',
                payment = 75
            },
			['2'] = {
                name = 'Business Sales',
                payment = 100
            },
			['3'] = {
                name = 'Finance',
                payment = 125
            },
			['4'] = {
                name = 'Manager',
				isboss = true,
                payment = 150
            },
        },
	},
	['mechanic'] = {
		label = 'Mechanic',
		defaultDuty = true,
		offDutyPay = true,
		grades = {
            ['0'] = {
                name = 'Recruit',
                payment = 5
            },
			['1'] = {
                name = 'Novice',
                payment = 7
            },
			['2'] = {
                name = 'Experienced',
                payment = 8
            },
			['3'] = {
                name = 'Advanced',
                payment = 10
            },
			['4'] = {
                name = 'Manager',
				isboss = true,
                payment = 12
            },
        },
	},
    ['uwu'] = {
		label = 'uWu Cafe',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'DJ',
                payment = 50
            },
			['1'] = {
                name = 'Employee',
                payment = 75
            },
			['2'] = {
                name = 'Supervisor',
                payment = 100
            },
			['3'] = {
                name = 'Manager',
                payment = 125
            },
			['4'] = {
                name = 'Chief',
				isboss = true,
                payment = 150
            },
        },
	},
	['judge'] = {
		label = 'Honorary',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Judge',
                payment = 100
            },
        },
	},
	['lawyer'] = {
		label = 'Law Firm',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Associate',
                payment = 50
            },
        },
	},
	['reporter'] = {
		label = 'Reporter',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Journalist',
                payment = 50
            },
        },
	},
	['trucker'] = {
		label = 'Trucker',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Driver',
                payment = 50
            },
        },
	},
	['tow'] = {
		label = 'Towing',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Driver',
                payment = 50
            },
        },
	},
	['garbage'] = {
		label = 'Garbage',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Collector',
                payment = 50
            },
        },
	},
	['vineyard'] = {
		label = 'Vineyard',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Picker',
                payment = 50
            },
        },
	},
	['hotdog'] = {
		label = 'Hotdog',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Sales',
                payment = 50
            },
        },
	},
    ['redline'] = {
		label = 'Redline',
		defaultDuty = false,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Recruit',
                payment = 5
            },
			['1'] = {
                name = 'Novice',
                payment = 7
            },
			['2'] = {
                name = 'Experienced',
                payment = 8
            },
			['3'] = {
                name = 'Advanced',
                payment = 10
            },
			['4'] = {
                name = 'Manager',
				isboss = true,
                payment = 12
            },
        },
	},
    ["delivery"] = {
		label = "Amazon",
		defaultDuty = true,
		grades = {
            ['0'] = {
                name = "Delivery man",
                payment = 50
            },
        },
	},
    ["gardener"] = {
		label = "Gardener",
		defaultDuty = true,
		grades = {
            ['0'] = {
                name = "Gardener",
                payment = 50
            },
        },
	},
    ["farmer"] = {
		label = "Farmer",
		defaultDuty = true,
		grades = {
            ['0'] = {
                name = "Farmer",
                payment = 50
            },
        },
	},
    ['mcdonalds'] = {
		label = 'Mcdonalds',
		defaultDuty = true,
		grades = {
			['0'] = {
				name = 'DJ',
				 payment = 50
			},
			['1'] = {
				name = 'Employee',
				payment = 75
			},
			['2'] = {
				name = 'Employee',
				payment = 100
			},
			['3'] = {
				name = 'Employee',
				payment = 125
			},
			['4'] = {
				name = 'CEO',
				isboss = true,
				payment = 150
			},
		},
	},
}