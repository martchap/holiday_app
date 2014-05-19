module HolidaysHelper

	def accepted_icon_for_holidays(holiday)
	content_tag :i, '', class: "icon-#{holiday.accepted ? 'ok' : 'remove'}",
	                    title: (holiday.accepted ? 'Yes' : 'No')
	end
end
