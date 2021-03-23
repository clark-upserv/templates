# General Guidelines:
# - have one param per action or form submission
# - make sure to account for all params - DO NOT have any unpermitted params
# - it can have multople objects and however much complexity you want
# - then use [:some_item] in controller to get what you want from the params
# - be carefule for chains and nil - ex:
#   - create_params[:user][:name] will error if create_params[:user] is nil

# basic params
def create_params
  params.require('user').permit(:name)
end

# complext params
# - use hash for complex params. Hash must be at end of params OR otherwise must be surrounded by {} in order to prevent
#   syntax error
# - use hash with value of empty array for param that can be an array
# - use hash with value of filled array for single child model (array simple)
# - use hash with value of array with hash with value of filled array for multiple child models (array hash)
def create_params
  params.require('user').permit(:name,
                                favorite_colors: [],
                                car: %i[make model],
                                friends: [friend: %i[name favorite_color]])
end

# params where require could be nil
# - if using submit button, make sure to include :commit so that there are not any unpermitted params
def create_params
  params.permit(:commit, user: [:name])
end

# params for array simple (because user could be nil if no favorite_colors are selected
# - if using submit button, make sure to include :commit so that there are not any unpermitted params
def create_params
  params.permit(:commit, user: [favorite_colors: []])
end

# params for array hash
def create_params
  params.require('user').permit(friends: [friend: %i[name favorite_color]])
end

# accepts nested attributes for single child
def create_params
  params.require('user').permit(home_attributes: [:color])
end

# accepts nested attributes for multiple children
def create_params
  params.require('user').permit(friends_attributes: %i[name is_cool])
end
