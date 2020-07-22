class Company < ApplicationRecord
  has_rich_text :description

  validates :email, allow_blank: true, format: {
    with: /\A[\w+\-.]+@getmainstreet\.com\z/i,
    message: 'not valid'
  }
end
