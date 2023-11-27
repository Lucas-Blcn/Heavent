class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  # 1:N
  has_many :interests
  has_many :events, through: :interests
  has_many :reviews, through: :interests

   # VALIDATION
   # validates :status, presence: true
   # validates :pseudo, presence: true, uniqueness: true

  #  validates :status, inclusion: { in: ['étudiant', 'CDI', 'CDD', ''] }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
