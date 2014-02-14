class User < ActiveRecord::Base
  has_many :holidays

	STANDARD_WEEK_HOURS = 40.0

	STANDARD_HOLIDAY = 25.0

	HOLIDAYS_PER_MONTH = 25 / 12.0

	has_many :holidays, dependent: :destroy

	before_save { self.email = email.downcase }
	before_create :create_remember_token
	validates :name, presence: true, length: { maximum: 50}
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, 
                      uniqueness: { case_sensitive: false }
    has_secure_password
    validates :password, length: { minimum: 6 }, unless: Proc.new { |u| u.password.blank? }

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def total_holidays
		holidays.sum &:work_days
	end

	def holiday_allowance
    (standard_holiday + long_service_holiday).round
  end

  def remaining_holiday_allowance 
    (holiday_allowance - total_holidays)
  end

	def standard_holiday
		if start_date > Time.now.beginning_of_year
		  ((12 - start_month) * HOLIDAYS_PER_MONTH).round
		else
		  hours_per_week / STANDARD_WEEK_HOURS * STANDARD_HOLIDAY
		end
	end

  def long_service_holiday
    if start_date < 7.years.ago.beginning_of_year
      5 * hours_per_week / STANDARD_WEEK_HOURS
    elsif start_date < 6.years.ago.beginning_of_year
      4 * hours_per_week / STANDARD_WEEK_HOURS
    elsif start_date < 5.years.ago.beginning_of_year
      3 * hours_per_week / STANDARD_WEEK_HOURS
    elsif start_date < 4.years.ago.beginning_of_year
      2 * hours_per_week / STANDARD_WEEK_HOURS
    elsif start_date < 3.years.ago.beginning_of_year
      1 * hours_per_week / STANDARD_WEEK_HOURS
    else
      0
    end
  end

  def start_month
    start_date.month.to_i
  end
end

