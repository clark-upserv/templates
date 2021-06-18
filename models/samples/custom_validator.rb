class SampleValidationValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    # options: humanized_attribute, message 

    # humanized_attribute
    humanized_attribute = options.fetch(:humanized_attribute, attribute.to_s.humanize)
    # message 
    message = options.fetch(:message, "Some message without period at end" )
    # dont' waste your time if the value is blank - presence should be validated elsewhere
    if !value.blank?
      # add error [based on logic]
      if [logic]
        record.errors.add(attribute, message)
      end
    end 
  end
end
