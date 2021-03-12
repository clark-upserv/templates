# basic params
params.require('user').permit(:name)

# params for when multiple unrelated objects are submitted
params.require('application').require('user').permit(:name)
params.require('application').require('school').permit(:mascot)

# params for simple array
#   - empty array is needed to note that object is an array
#   - [:ids] at end makes strong params an array of permitted params
#     which is exactly what we want
params.require('user').permit(ids: [])[:ids]

# params for array of hashes
#   - array with symbols is needed to note what is permitted for each
#     hash instance that is submitted
#   - [:users_list] at end makes strong params an array of strong params
#     which is exactly what we want
params.require('users').permit(users_list: [:name, :email])[:users_list]

# accepts nested attributes for single child
params.require('user').permit(home_attributes: [:color])

# accepts nested attributes for multiple children
params.require('user').permit(friends_attributes: [:name, :is_cool])
