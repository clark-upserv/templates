    def ChangeThisPls_helper_ChangeThisPls_grouped_options(variable)
      # Create opitons array programatically
      # group the things
      hash_of_grouped_things = variable.things.group_by { |thing| thing.group }
      # create nested array of grouped things for select
      array_of_grouped_options_for_select = hash_of_grouped_things.map { |group, things| [group, things.sort.map { |thing| [thing.display, thing.value] }] }
      # sort final array 
      sorted_array_grouped_options_for_select = array_of_grouped_options_for_select.sort

      # Or
      
      # Create opitons array manually
      [
        # grouped options
        [
          'Group 1',
          [
            # Display and Option will be the same
            'Display and value',
            # Unique display and value with array
            ['display', 'value'],
            # Unique display and value with hash
            { 'display': 'value' }
          ]
        ],
        [
          'Group 2',
          [
            # Display and Option will be the same
            'Display and value',
            # Unique display and value with array
            ['display', 'value'],
            # Unique display and value with hash
            { 'display': 'value' }
          ]
        ]
      ]
    end

