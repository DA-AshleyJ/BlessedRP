Config = {}

Config.LeftAlign = false -- true = left side | false = right side

Config.Types = {
	success = {
		highlightColor = '#47cf73', -- Any CSS color value can be used here (rgb(), rgba(), hsl(), etc)
		icon = { -- Icon names can be found at https://fontawesome.com/
			'fas',
			'fa-check-circle'
		}
	},
	info = {
		highlightColor = '#2f83ff',
		icon = {
			'fas',
			'fa-info-circle'
		}
	},
	warning = {
		highlightColor = '#ffc107',
		icon = {
			'fas',
			'fa-exclamation-circle'
		}
	},
	error = {
		highlightColor = '#dc3545',
		icon = {
			'fas',
			'fa-times-circle'
		}
	},
	phonemessage = {
		highlightColor = '#f38847',
		icon = {
			'fas',
			'fa-phone'
		}
	},
	neutral = {
		highlightColor = '#6c757d',
		icon = {
			'fas',
			'fa-keyboard'
		}
	},
	--[[example = {
		highlightColor = 'red',
		icon = 'bootstrap-fill'
	},]]--
}