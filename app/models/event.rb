require "csv"

class Event < ApplicationRecord
  enum :category, { entertainment: 0, dining: 1, business: 2, sports: 3, education: 4 }
  validates :title, :date, :location, :time, :category, presence: true
  has_many :registrations, dependent: :destroy
  has_many :users, through: :registrations
  has_one_attached :photo
  scope :past, -> { where("date < ?", Date.current) }
  scope :active, -> { where("date >= ?", Date.current) }
  scope :tomorrow, -> { where(date: Date.tomorrow) }
  scope :entertainment, -> { active.where(category: "entertainment") }
  scope :dining, -> { active.where(category: "dining") }
  scope :business, -> { active.where(category: "business") }
  scope :sports, -> { active.where(category: "sports") }
  scope :education, -> { active.where(category: "education") }

  def self.generate_csv
    CSV.generate(headers: true) do |csv|
      csv << [ "ID", "Title", "Date", "Location", "Category", "Participant Count" ]
      all.includes(:registrations).find_each do |event|
        category = event.category.to_s.capitalize
        csv << [
          event.id,
          event.title,
          event.date,
          event.location,
          category,
          event.registrations.count
        ]
      end
    end
  end
end
