class Material < ApplicationRecord

  has_many :logs, autosave: true

  attr_accessor :whodunnit
  
  before_validation :show_logs 

  before_destroy :check_log

  before_save :create_log, unless: :new_record?

  validates :amount, presence: true

  private

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
      operacao = "Retirada"
    else
      operacao = "Entrada"
    end

    logs.new({
      user_id: whodunnit,
      operacao: operacao,
      qtd: (amount_was - amount).abs
    })
  end

end

