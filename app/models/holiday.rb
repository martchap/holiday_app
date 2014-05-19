class Holiday < ActiveRecord::Base
	belongs_to :user

	validate :user_has_holiday_remaining
	validates :start_date, presence: true
	validates :end_date,   presence: true
    validate :start_date_before_end_date



	def total_length
		return 0 unless start_date && end_date
		(end_date - start_date).to_i
	end

	def work_days
		return 0 unless start_date && end_date
		date_range = start_date..end_date

		date_range.sum { |d| ([0,6].include? d.wday) ? 0 : 1 }
	end

	def user_has_holiday_remaining
		return unless total_length > user.remaining_holiday_allowance

		errors.add(:base, "You have used up your holiday allowance")
	end

	def start_date_before_end_date
		return unless start_date > end_date
		errors.add(:base, "Start date cannot be later than the End date")
	end

	def accept!
      self.accepted = true
      save
    end
    def decline!
      self.accepted = false
      save
    end
end
