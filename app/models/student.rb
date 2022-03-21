class Student < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  has_many :enrolls, dependent: :delete_all
  has_many :courses, through: :enrolls

  validates :name, presence: true, length: { minimum: 3, maximum: 20 }, allow_blank: false
  validates :phone, presence: true, uniqueness: true, numericality: { only_integer: true }, length: { is: 10 }
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :dob, presence: true, allow_blank: false
  validates :student_id, presence: true, uniqueness: true, allow_blank: false,
            numericality: { only_integer: true, greater_than: 0, message: 'Id should be numerical' },
            length: { maximum: 10 }
  validates :major, presence: true, length: { minimum: 2 }, allow_blank: false
end
