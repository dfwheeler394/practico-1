class UsersChallenge < ApplicationRecord
  belongs_to :user
  belongs_to :challenge

  has_many :check_ins, dependent: :destroy
  has_many :events, dependent: :destroy

  after_create :create_events

  private

  def create_events
    challenge = self.challenge
    if challenge.count_type == 'in a row' && challenge.time_type == 'days'
      self.update(scheduled: true)
      date = challenge.starting_date
      challenge.milestone.times do
        Event.create(start_time: date, users_challenge: self, user: user)
        date += 1
      end
    end
  end
end
