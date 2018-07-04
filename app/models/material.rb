class Material < ApplicationRecord

  has_many :logs, autosave: true

  attr_accessor :whodunnit

  before_destroy :check_log

  before_save :create_log, unless: :new_record?

  before_save :check_td, unless: :new_record?

  before_save :check_qtd

  before_save :check_unique, if: :new_record?

  validates :amount, presence: true

  private
  
  def check_unique
    if Material.where(:name => name).blank?
      
    else
    errors.add :base, "Material's name must be exclusive. There's a registered material with that name already."
    throw(:abort) 
  end
  end

  def check_td
  t = Time.now
  if amount_was > amount
  if t.wday>=1 && t.wday<=5 && t.hour>=9 && t.hour<=18

  else
     errors.add :base, "Materials can't be taken away at this time AND/OR day. Please try again between 09:00 and 18:00, from Monday to Friday."
    throw(:abort)
  end
  end
  end

  def check_qtd
  if amount >= 0
    
  else
    errors.add :base, "Material's amount can't be negative."
    throw(:abort)
  end  
  end
  
  def check_log
    if logs.count > 0
      errors.add :base, "Material has logs attached to it."
      throw(:abort)
    end
  end

def show_logs
  @logs = logs
end

  def create_log
    #return if new_record?
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

