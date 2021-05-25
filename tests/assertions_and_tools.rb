assert( test, [msg] )	# Ensures that test is true.
assert_not( test, [msg] )	# Ensures that test is false.
assert_equal( expected, actual, [msg] )	# Ensures that expected == actual is true.
  assert_equal "ChangeThisPls", @model.attribute
assert_not_equal( expected, actual, [msg] )	# Ensures that expected != actual is true.
assert_same( expected, actual, [msg] ) # Ensures that expected.equal?(actual) is true.
assert_not_same( expected, actual, [msg] ) # Ensures that expected.equal?(actual) is false.
assert_nil( obj, [msg] ) # Ensures that obj.nil? is true.
assert_not_nil( obj, [msg] ) # Ensures that obj.nil? is false.
assert_empty( obj, [msg] ) # Ensures that obj is empty?.
assert_not_empty( obj, [msg] ) # Ensures that obj is not empty?.
assert_match( regexp, string, [msg] ) # Ensures that a string matches the regular expression.
  assert_match "Hi", mail.body.encoded
assert_no_match( regexp, string, [msg] ) # Ensures that a string doesn't match the regular expression.
assert_includes( collection, obj, [msg] ) # Ensures that obj is in collection.
assert_not_includes( collection, obj, [msg] ) # Ensures that obj is not in collection.
assert_in_delta( expected, actual, [delta], [msg] ) # Ensures that the numbers expected and actual are within delta of each other.
assert_not_in_delta( expected, actual, [delta], [msg] ) # Ensures that the numbers expected and actual are not within delta of each other.
assert_in_epsilon ( expected, actual, [epsilon], [msg] ) # Ensures that the numbers expected and actual have a relative error less than epsilon.
assert_not_in_epsilon ( expected, actual, [epsilon], [msg] ) # Ensures that the numbers expected and actual have a relative error not less than epsilon.
assert_throws( symbol, [msg] ) { block } # Ensures that the given block throws the symbol.
assert_raises( exception1, exception2, ... ) { block } # Ensures that the given block raises one of the given exceptions.
assert_raise # same as assert_raises
  assert_raise do
    get edit_namespace_model_path(@model)
  end
assert_instance_of( class, obj, [msg] ) # Ensures that obj is an instance of class.
assert_not_instance_of( class, obj, [msg] ) # Ensures that obj is not an instance of class.
assert_kind_of( class, obj, [msg] ) # Ensures that obj is an instance of class or is descending from it.
assert_not_kind_of( class, obj, [msg] ) # Ensures that obj is not an instance of class and is not descending from it.
assert_respond_to( obj, symbol, [msg] ) # Ensures that obj responds to symbol.
assert_not_respond_to( obj, symbol, [msg] ) # Ensures that obj does not respond to symbol.
assert_operator( obj1, operator, [obj2], [msg] ) # Ensures that obj1.operator(obj2) is true.
assert_not_operator( obj1, operator, [obj2], [msg] ) # Ensures that obj1.operator(obj2) is false.
assert_predicate ( obj, predicate, [msg] ) # Ensures that obj.predicate is true, e.g. assert_predicate str, :empty?
assert_not_predicate ( obj, predicate, [msg] ) # Ensures that obj.predicate is false, e.g. assert_not_predicate str, :empty?
flunk( [msg] ) # Ensures failure. This is useful to explicitly mark a test that isn't finished yet.

assert_difference(expressions, difference = 1, message = nil) { block } # Test numeric difference between the return value of an expression as a result of what is evaluated in the yielded block.
  assert_difference 'NameSpace::Model.count', 1 do
    post namespace_resources_path, params: { ChangeThisPls }
  end
assert_no_difference(expressions, message = nil) { block } # Asserts that the numeric result of evaluating an expression is not changed before and after invoking the passed in block.
  assert_no_difference 'Training::Category.count' do
    post training_categories_path, params: { ChangeThisPls }
  end
assert_changes(expressions, message = nil, from:, to:, &block) # Test that the result of evaluating an expression is changed after invoking the passed in block.
assert_no_changes(expressions, message = nil, &block) # Test the result of evaluating an expression is not changed after invoking the passed in block.
assert_nothing_raised { block } # Ensures that the given block doesn't raise any exceptions.
assert_recognizes(expected_options, path, extras={}, message=nil) # Asserts that the routing of the given path was handled correctly and that the parsed options (given in the expected_options hash) match path. Basically, it asserts that Rails recognizes the route given by expected_options.
assert_generates(expected_path, options, defaults={}, extras = {}, message=nil) # Asserts that the provided options can be used to generate the provided path. This is the inverse of assert_recognizes. The extras parameter is used to tell the request the names and values of additional request parameters that would be in a query string. The message parameter allows you to specify a custom error message for assertion failures.
assert_response(type, message = nil) # Asserts that the response comes with a specific status code. You can specify :success to indicate 200-299, :redirect to indicate 300-399, :missing to indicate 404, or :error to match the 500-599 range. You can also pass an explicit status number or its symbolic equivalent. For more information, see full list of status codes and how their mapping works.
  assert_response :success
  assert_response :redirect
  assert_response :missing
  assert_response :error
assert_redirected_to(options = {}, message=nil) # Asserts that the response is a redirect to a URL matching the given options. You can also pass named routes such as assert_redirected_to root_path and Active Record objects such as assert_redirected_to @article.
assert_template(path) # asserts template found at app/views/path was rendered
  assert_template 'core/account_tools/index'

assert_select(selector, optional_value) # Asserts HTML is present based on selector
  assert_select 'form[action=?]', "/my_apps/#{@account_tool.id}"
  assert_select 'div[id="error_explanation"]'
  assert_select 'li', text: "Email not found"
assert_select_email #	Allows you to make assertions on the body of an e-mail.
assert_select_encoded #	Allows you to make assertions on encoded HTML. It does this by un-encoding the contents of each element and then calling the block with all the un-encoded elements.
css_select(selector) # Returns an array of all the elements selected by the selector. If there are no matches returns an empty array.
css_select(element, selector)	#  Matches the base element and tries to match the selector expression on any of its children. If there are no matches returns an empty array.
assert_dom_equal(expected, actual) # asserts HTML dom expected is equal to actual
  assert_dom_equal '<a href="/user/#{user.id}">David Heinemeier Hansson</a>', some_customer_helper_method(user)

assigns(:ChangeThisPls)
follow_redirect!

cookies # Any cookies that are set
flash # Any objects living in the flash
  assert flash.any?
  assert flash[:ChangeFlashType].present?
session # Any object living in session variables
@controller # The controller processing the request; methods: .action._name, ???
@request # The request object; methods: .body, ???
@response # The response object; methods: .body, ???



assert_difference ['ActionMailer::Base.deliveries.size'], 1 do
  ...
end

