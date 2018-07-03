class Material < ApplicationRecord

  has_many :logs, autosave: true

  before_destroy :check_log

  before_save :create_log, unless: :new_record?

 

  private

def check_log
return true if logs.count == 0
throw(:abort)  
end


  def create_log
    #return if new_record?
    if amount_was > amount
      operacao = "Retirada"
    else
      operacao = "Entrada"
    end

    logs.new({
      operacao: operacao,
      qtd: (amount_was - amount).abs
    })
  end

end

