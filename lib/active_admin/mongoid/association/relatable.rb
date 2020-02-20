Mongoid::Association::Relatable.module_eval do
  def macro
    self.class.name.split('::').last.underscore.to_sym
  end

  def embeds?
    [:embeds_one, :embeds_many].include?(macro)
  end

  def foreign_key
    return if embeds?
    foreign_key.to_sym rescue nil
  end
end
