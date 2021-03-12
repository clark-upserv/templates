# basic params
params.require('ChangeThisPls').permit(:ChangeThisPls)

# params for when multiple unrelated objects are submitted
params.require('ChangeThisPls').require('ChangeThisPls').permit(:ChangeThisPls)
params.require('ChangeThisPls').require('ChangeThisPls').permit(:ChangeThisPls)

# params for simple array
#   - empty array is needed to note that object is an array
#   - [:ChangeThisPls] at end makes strong params an array of permitted params
#     which is exactly what we want
params.require('ChangeThisPls').permit(ChangeThisPls: [])[:ChangeThisPls]

# params for array of hashes
#   - array with symbols is needed to note what is permitted for each
#     hash instance that is submitted
#   - [:ChangeThisPls] at end makes strong params an array of strong params
#     which is exactly what we want
params.require('ChangeThisPls').permit(ChangeThisPls: [:ChangeThisPls])[:ChangeThisPls]

# accepts nested attributes for single child
params.require('user').permit(home_attributes: [:ChangeThisPls])

# accepts nested attributes for multiple children
params.require('user').permit(friends_attributes: [:ChangeThisPls])
