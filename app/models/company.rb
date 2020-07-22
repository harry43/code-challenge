class Company < ApplicationRecord
  has_rich_text :description

  validates :zip_code, :name, presence: true

  validates :email, allow_blank: true, format: {
    with: /\A[\w+\-.]+@getmainstreet\.com\z/i,
    message: 'not valid'
  }

  before_save :update_city_state, if: :will_save_change_to_zip_code?

  private

  def update_city_state
    identified_zip = ZipCodes.identify(zip_code)

    if identified_zip
      self.state = identified_zip[:state_code]
      self.city = identified_zip[:city]
    else
      self.state = nil
      self.city = nil
    end
  end
end
