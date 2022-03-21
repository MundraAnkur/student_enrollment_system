class Course < ApplicationRecord
  belongs_to :instructor
  has_many :enrolls, dependent: :delete_all
  has_many :students, through: :enrolls

  # validates :code, presence: true, uniqueness: true, format: { with: '(?=[A-Z]{3}[0-9]{3}).{6}$' }
  validates :code, presence: true, uniqueness: true,
            format: { with: /\A[A-Z]{3}[0-9]{3}\z/, message: 'Format: 3 letters followed by 3 digits, e.g. ECE123, CSA090' }
  validates :name, length: { minimum: 2 }
  validates :instructor_name, presence: true
  validates :description, presence: true
  validates :room, presence: true, length: { minimum: 3 }
  validates :weekday1, presence: true, comparison: { other_than: :weekday2 }
  validates :start_time, presence: true
  validates :end_time, presence: true, comparison: { greater_than: :start_time }
  validates :capacity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :capacity, numericality: { greater_than_or_equal_to: :capacity_was, message: 'can only be increased' },
            on: :update
  validates :waitlist_capacity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :waitlist_capacity,
            numericality: { greater_than_or_equal_to: :waitlist_capacity_was, message: 'can only be increased' },
            on: :update

  def formatted_start_time
    start_time.strftime('%H:%M')
  end

  def formatted_end_time
    end_time.strftime('%H:%M')
  end
end
