replace:
fodel
Fodel
resources
Fpp
fpp


  #--- Relationships ---#
  #-- Core Relationships --#
  # [Some Fpp Model]

  #-- Fpp Relationships --#
  # [Some App Model]

  # NOTE: model should not have relationships outside of Fpp and Core apps, unless model is a core model, then it can have relationships with any app
  # NOTE: if relationship is to model in a different app, INCLUDE THE APP NAMESPACE IN THE RELATIONSHIP (NOTE: foreign key should also include app name, but that's managed through the migration, not the model)
  # NOTE: it is recomended to explicitly include inverse_of if any options are used. Rails will automatically try to set inverse of and several options will prevent it from being set (ex. if foriegn key OR through OR as in polyimorphic are used). Not all options will prevent it from being set, but to be safe, it is recommended to go ahead and manually set it if any option is used

  # [standard belongs to]
  belongs_to :parent_model, inverse_of: :relationship_name_in_parent_mod, class_name: 'Fpp::ParentMod', optional: true
  # NOTE: foriegn key should ALWAY be relationship_name + '_id'. If for some  crazy reason (and  there most likely should not be) they need to be different, then you must include the foreign_key option

  # [standard had many]
  has_many :child_resources, inverse_of: :relationship_name_in_child_model, class_name: 'Fpp::ChildMod', dependent: :destroy
  # [if referring to table in different app and therefore including that app fpp in relationship name, foreign_key option is required (because foreign key is not parent_model_name + '_id') 
  has_many :other_space_child_resources, inverse_of: :relationship_name_in_child_mod, class_name: 'OtherSpace::ChildMod', foreign_key: 'custom_foreign_key_id', dependent: :destroy
  # [if foreign key is not parent_model_name + '_id' foreign_key option is requried (exact same as when including a different apps fpp)
  has_many :some_non_standard_name, inverse_of: :relationship_name_in_child_mod, class_name: 'Fpp::ChildMod', foreign_key: 'other_space_fodel_id', dependent: :destroy
  # [if accepts_nested_attributes_for]
  accepts_nested_attributes_for :child, allow_destroy: true,  reject_if: proc {|attributes| attributes['specific_attribute'].blank?  }, update_only: true 

  # [has_one through - same app]
  has_one :relationships, inverse_of: :relationship_name_in_final_model, through: :some_already_defined_relationship_to_another_model, source: :relationship_name_in_other_model
  # [has_many through - same app]
  has_many :relationships, inverse_of: :relationship_name_in_final_model, through: :some_already_defined_relationship_to_another_model, source: :relationship_name_in_other_model

  # [has_one through - different app]
  has_one :relationship, inverse_of: :relationship_name_in_other_model, through: :some_already_defined_relationship_to_another_model, source: :relationship_name_in_other_model
  # NOTE: if final model is in different app, include app name in relationships name
  # [has_many through - different app]
  has_many :relationships, inverse_of: :relationship_name_in_other_model, through: :some_already_defined_relationship_to_another_model, source: :relationship_name_in_other_model
  # NOTE: if final model is in different app, include app name in relationships name

  # Rich Text
  has_rich_text :content  
  # One Attached
  has_one_attached :attachment
  # Many Attached
  has_many_attached :attachments

  #--- Class Methods needed for validations ---# 
  class << self
    # valid types for a specific attribute
    def valid_attribute_types
      ['Some Type', 'Other Type']
    end
  end

  #--- scopes ---#
  # refinements for index load
  scope :index, -> (attribute_1, attribute_2) { where(attribute_1: attribute_1, attribute_2: attribute_2, deactivated: false).order(:attribute).joins(:relationship).order("LOWER(some_table.some_attribute)") } 
  
  # [Sub User Scopes]
  # filters to only show resources whose core_user is still active
  scope :active, -> { joins(:core_user).where("core_users.deactivated = :deactivated AND core_users.confirmed_at IS NOT :confirmed_at", deactivated: false, confirmed_at: nil) }
  # NOTE: for "active" to work, there must be a core_user relationship
  # filters to only show resources who have a specific role through user roles
  scope :with_role, -> (role) { joins(:core_roles).where("core_roles.name = ?", role.to_s) }
  # NOTE: for "with_role" to work, there must be a core_roles relationship
  # filters to show resources who belong to a user who belong to an account that has the fpp tool
  scope :with_tool, -> (tool) { joins(:core_tools).where("core_tools.name = ?", tool.to_s) }
  # NOTE: with_tool should almost never be needed because if the current user doesn't have access to the tool, they would never be able to access the page where this scope would be used anyways
  # NOTE: for "with_tool" to work, there must be a core_tools relationship
  
  # [Search Scopes]
  # returns resources based on specified attributes ([insert here]) and value from "query" argument
  # [delete this comment] Options / dimesions = single attribute, multiple attributes, multiple attributes concatenated, same fodel, different fodels. Mix and match and have fun!
  # [delete this comment] simple example - single attribute on same fodel 
  scope :query, -> (query) { where("fpp_resources.attribute ILIKE :query", query: "%#{query}%") }
  # [delete this comment] more complex - multiple attributes attribute on same fodel 
  scope :query, -> (query) { where("fpp_resources.attribute_1 ILIKE :query OR fpp_resources.attribute_2 ILIKE :query", query: "%#{query}%") }
  # [delete this comment] more complex - multiple attributes concatenated on same fodel 
  scope :query, -> (query) { joins(:relationship).where("CONCAT_WS(' ', fpp_resources.attribute_1, fpp_resources.attribute_2) ILIKE :query", query: "%#{query}%") }
  # [delete this comment] more complex - single attribute on different fodel 
  scope :query, -> (query) { joins(:relationship).where("fpp_resources.attribute ILIKE :query", query: "%#{query}%") }
  # [delete this comment] more complex - concatenated attributes on different fodel
  scope :query, -> (query) { joins(:relationship).where("CONCAT_WS(' ', fpp_resources.attribute_1, fpp_resources.attribute_2) ILIKE :query", query: "%#{query}%") }
  

  #--- Virtual / Additional Attributes ---# 
  # attribute - does ?!>!
  attribute :attribute
  # attr_acccessor - does?!??!
  attr_accessor :attribute

  #--- Callbacks ---#
  # NOTE: if any validation differentiates nil vs. "" or [] or {}, then you may need to move nil_blank_attributes to before_save instead of before_validation
  before_validation :process_attributes, :strip_attributes, :nil_blank_attributes, :nil_dependent_attributes
  before_destroy :nil_parent_on_orphanable_children, 
  before_destroy :nil_child_parent, prepend: true # ?!?!?!

  #--- Gems / other ---#
  #--- Validations ---#
  validates :attribute_1, <insert some validation>, unless: Proc.new { |record| record.attribute_1.nil? }
  validates :attribute_1, presence: true, presence: { message: 'Please add attribute' }
  validates :attribute_1, length: { maximum: 255, message: 'Attribute is too long (maximum is 255 characters)' }
  validates :attribute_1, uniqueness: { case_sensitive: false, scope: [:attribute_2, :attribute_3], message: 'Attribute already has attribute_2 and attribute_3' }
  validates :attribute_is_unique_among_active_resources
  validates :attribute_1, numericality: { message: 'Please use numbers only' }
  validates :attribute_1, numericality: { only_integer: true, message: 'Please use numbers only' }
  validates :attribute_1, numericality: { allow_nil: true, less_than: 100, less_than_or_eqaul_to: 100; equal_to: 100, greater_than: 100, greater_than_or_equal_to: 100, other_than: 100, odd: true, even: true }
  validates :attribute_1, valid_type: true, valid_type: {valid_types: Fpp::Fodel.valid_attribute_types }, valid_type: { valid_types: ['some', 'array', 'of', 'types'] } 
  validates :attribute_1, parent_type: true
  validates :attribute_1, child_type: true
  validates :attribute_1, dependent_on: { independent_path: [], dependent_path: [<OPTIONAL FIELD>], if_independent_is: [], if_independent_is_not: [], dependent_can_be: [], dependent_cannot_be: [], equal_values: true, not_equal_values: true, message: '' }
  validates :attached, size: { less_than: 10.megabytes, message: "Attached should be less than 10MB" }
  validates :attached, attached: true
  validates :attached_image_or_pdf, content_type: { in: %w[image/jpeg image/gif image/png application/pdf], message: "Attached must be a valid format. Valid formats are: jpeg, gif, png, pdf" }
  validates :attached_video, content_type: { in: %w[video/quicktime video/mp4 video/webm audio/ogg], message: "Attached must be a valid image video format. Valid formats are:  mp4, mov, webm, ogg" }
  validate :custom_validation 

  #--- Class Methods ---#
  class << self
    
    # search method based on query scope
    def search(search)
      # only search if there are search params. Otherwise, show all
      if search
        # set resources to load        
        Fpp::Fodel.query(search.try(:strip))
      else
        # show all when search is nil - Note: this will still be passed through all filters in the index load so the user won't be able to see all resources... This is basically saying, "hey if there are no search params, we are not adding any EXTRA filters"
        Fpp::Fodel.all
      end
    end
    
    # set valid types for model. This is the standard list of types for any model that has types. Also used in is_type valid_type validation. If it's a parent with multiple has_one relationships but only one at a time, then types should match the titleized childred class names after any namespacing (ex. 'child.class.name.underscore.split('/').last.tr('_', ' ').titleize') 
    def valid_types
      ['Some Type', 'Other Type']
    end

  end

  #--- Instance Methods ---#
 
  # For processing sized of attached attributes NOTE: this is only to limit the file size of the attached attribute (in case you want quicker page loading or want to prevent user from having access to the full resolution image. The size of the dissplay (regardless of file size) should be managed with max-width, max-height, width & height (and min-width and min-height if necessary) in the view
  def processed_attached
    attached.variant(resize_to_limit: [1000, 1000])
  end
  
  #--- Private Methods ---#
    private
    #-- Misc. Private methods --#
    #-- Callbacks --#
    # make orphanable children foreign keys nil
    def nil_parent_on_orphanable_children
      # SomeSpace Orphanable References
        # [Descriptive word] [some other models]
        self.children.each do |child|
          child.update(foreign_key_id: nil)
        end
    end 

    # NOTE: This is still very much WIP. I think you have to actually update it on the db or else when you try to destroy the children, the "child parent" here on the db still is referenced by the parent. So you have to update the parent.child_parent to nil on the db and not just in memory. This also means the db cannot have null: false for the parent.child_parent attrubute
    # sets child_parent to nil in parent so that the child parent can be destroyed without db foreign_key reference error
    def nil_child_parent
      self.child_parent = nil
    end
    
    #-- Validate Methods --#
    # [description of validation]
    def custom_validation
      # First: if you are validating an attribute that is also stripped on a before action, then you need to add strip here (because strip doesn't happen til after the validation is run... so attribute has not yet been stripped). Otherwise, remove strip here
      # Then: have to check that any attributes used in the 'path_to' are not nil otherwise the validation will actually error (which is different than failing the validation - which failing the validation provides error messages which is what we want. If the validion actually errors, there will be no error messages). Also, this validation is not meant to check precence of those attributes. There are sepeate validations for presence (above). Also, we need to make sure the attribute itseld is not nil (or else strip will error if you are using those... also there is a different validation for presence so we don't need to check that here). Finally, if none are nil, then check if there are any active resources with the same attribute value
      # [explanation of logic]
      if !any_attribute_in_path_to.nil? && !attribute.nil? && attribute_instance.strip.additional_logic
        # add error if validation does not pass
        errors[:attribute] << 'Message'
      end
    end

    # validates unique only among active resources
    def attribute_is_unique_among_active_resources
      # nil attribute prep; logic for unique among active resources
      if !any_attribute_in_path_to.nil? && !attribute.nil? && path_to.resources.where.not(id: id).where(deactivated: false).pluck(:attribute_1).include?(attribute_1.strip)
        # add error if not unique among active resources
        errors[:attribute] << 'The name \'#{attribute_1.strip}\' has already been taken by another active fodel. Please try a different attribute_1'
      end
    end
    
