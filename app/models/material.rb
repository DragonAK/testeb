class Material < ApplicationRecord

  has_many :logs, autosave: true

  attr_accessor :whodunnit

  before_destroy :check_log

  before_save :create_log

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :name, uniqueness: true
  validate :check_td

  private


  def check_td #Checks if both the time and date are appropriate for taking out materials
    t = Time.now

    if (amount_was || 0) > amount
      if !(t.wday>=1 && t.wday<=5 && t.hour>=9 && t.hour<=18)
        errors.add :base, "Materials can't be taken away at this time AND/OR day. Please try again between 09:00 and 18:00, from Monday to Friday."
      end
    end
  end
  
  def check_log #Detects if there are any logs related to the material. If so, it can't be deleted.
    if logs.count > 0
      errors.add :base, "Material has logs attached to it."
      throw(:abort)
    end
  end

  def create_log #Create a log for each material update (UPDATE ONLY)
    #return if new_record?
    amount_was ||= 0 
    if amount_was > amount
      operacao = "Out"
    else
      operacao = "In"
    end

    logs.new({
      user_id: whodunnit,
      operacao: operacao,
      qtd: (amount_was - amount).abs
    })
  end

end

