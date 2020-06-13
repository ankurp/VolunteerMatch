class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :masqueradable, :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :omniauthable

  has_person_name

  belongs_to :location
  has_one :organization, through: :location
  has_many :notifications, foreign_key: :recipient_id
  has_many :services
  has_many :comment

  has_rich_text :bio
  has_one_attached :avatar

  enum role: [:volunteer, :organizer]

  accepts_nested_attributes_for :location

  delegate :posts, to: :location

  def initialize(args)
    super(args)
    self.role ||= :volunteer
  end

  def is_same_as?(user)
    self.id == user.try(:id)
  end
end
