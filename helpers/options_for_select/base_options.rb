    def ChangeThisPls_options(variable)
      # Create opitons array programatically
      variable.things.sort_or_order.map { |thing| [thing.display, thing.value] }

      # Or
      
      # Create opitons array manually
      [
        # Display and Option will be the same
        'Display and value',
        # Unique display and value with array
        ['display', 'value'],
        # Unique display and value with hash
        { 'display': 'value' }
      ]
    end
