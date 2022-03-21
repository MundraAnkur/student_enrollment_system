class Instructor < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :name, presence: true, uniqueness: true, length: { minimum: 3 }, allow_blank: false
  validates :department, presence: true, length: { minimum: 2 }, allow_blank: false
  has_many :courses, dependent: :destroy
end
