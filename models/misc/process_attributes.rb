      # DeleteThis - for all, beware of differences in nil, blank, false, etc. and make sure to include logic you actually are looking for
      # DeleteThis - strip before save
      self.ChangeAttribute = ChangeAttribute.try(:strip)
      # DeleteThis - do not allow blank values except false
      self.ChangeAttribute = nil if ChangeValue.blank? && ChangeValue != false 
      # DeleteThis - add or remove formating before save (generic exmaple + exmaple of saving phone number)
      self.ChangeAttribute = ChangeAttribute.tr('-','') if !ChangeAttribute.blank?
      self.ChangeAttribute = '(#{ChangeAttribute[0..2]}) #{ChangeAttribute[3..5]}-#{ChangeAttribute[6..9]}' if !ChangeAttribute.blank? && ChangeAttribute.length == 10
      # DeleteThis - set attribute value if attribute is dependent on another value
      self.ChangeAttribute = nil if ChangeIndedependentAttribute == ChangeValue
      self.ChangeAttribute = nil if ChangeIndedependentAttribute.nil?
