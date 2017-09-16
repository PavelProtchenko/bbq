class Subscription < ApplicationRecord
  belongs_to :event
  belongs_to :user, optional: true

  validates :event, presence: true

  # проверки выполняются только если user не задан (незареганные приглашенные)
  validates :user_name, presence: true, unless: 'user.present?'
  validates :user_email, presence: true, format: /\A[a-zA-Z0-9\-_.]+@[a-zA-Z0-9\-_.]+\z/, unless: 'user.present?'

  validates :user, uniqueness: {scope: :event_id}, if: 'user.present?'
  validates :user_email, uniqueness: {scope: :event_id}, unless: 'user.present?'
  validate :email_exist, unless: 'user.present?'
  validate :self_event_subscription

  def user_name
    if user.present?
      user.name
    else
      super
    end
  end

  def user_email
    if user.present?
      user.email
    else
      super
    end
  end

  def email_exist
    errors.add(:user_email, I18n.t('activerecord.errors.messages.email_exist')) if User.where(email: user_email).exists?
  end

  def self_event_subscription
    errors.add(:user, I18n.t('activerecord.errors.messages.self_event_subscription')) if user == event.user
  end
end
