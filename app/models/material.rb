class Material < ApplicationRecord

  has_many :logs, autosave: true

  before_save :create_log

  conn = ActiveRecord::Base.connection

  def checkneg(id)
    result = conn.execute "SELECT amount from MATERIALS where ID="+id  % conn.quote("' OR 1=1 #");
    puts result
  end

  def create_log
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

