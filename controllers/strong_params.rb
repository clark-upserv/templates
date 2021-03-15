# basic params
def create_params
  params.require('user').permit(:name)
end

# params for when multiple unrelated objects are submitted
def user_params
  params.require('application').require('user').permit(:name)
end

def school_params
  params.require('application').require('school').permit(:mascot)
end

# params for simple array
#   - empty array is needed to note that object is an array
#   - [:ids] at end makes strong params an array of permitted params
#     which is exactly what we want
#   - add rescue from to manage if it is possible for none to be selected
def update_params
  params.require('user').permit(ids: [])[:ids]
end
rescue_from ActionController::ParameterMissing do
  if exception.param == 'user'
    # ChangeThisPls - insert value if user is nil OR insert logic when user is nil - ex. [] or nil
  end
end

# params for array of hashes
#   - array with symbols is needed to note what is permitted for each
#     hash instance that is submitted
#   - [:users_list] at end makes strong params an array of strong params
#     which is exactly what we want
params.require('users').permit(users_list: %i[name email])[:users_list]

# accepts nested attributes for single child
params.require('user').permit(home_attributes: [:color])

# accepts nested attributes for multiple children
params.require('user').permit(friends_attributes: %i[name is_cool])

# params when it is possible for required item to be nil
def update_params
  params.require('user').permit(:name, :email)
end
rescue_from ActionController::ParameterMissing do
  # ChangeThisPls - insert value if user is nil OR insert logic when user is nil - ex. [] or nil
end
