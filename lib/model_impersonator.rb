class ModelImpersonator
  attr_accessor :values, :error_messages
  def initialize
    @values = {}
    @error_messages = {}
  end
  
  def set_value(attribute, value) 
    self.values[attribute] = value
  end

  def add_error_message(attribute = :base, msg) 
    unless self.error_messages[attribute]
      self.error_messages[attribute] = []
    end
    self.error_messages[attribute] << msg
  end
end

