class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :masqueradable, :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :omniauthable

  has_person_name

  belongs_to :location
  has_one :organization, through: :location
  has_many :notifications, foreign_key: :recipient_id
  has_many :services

  enum user_type: [ :volunteer, :staff ]

  accepts_nested_attributes_for :location

  def initialize(args)
    super(args)
    self.user_type ||= :volunteer
  end
end
