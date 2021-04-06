    assert_response :success
    assert_template 'core/account_tools/index'
    assert_select 'form[action=?]', "/my_apps/#{@account_tool.id}"
    assert_select 'div[id="error_explanation"]'
    assert_select 'li', text: "Email not found"

    assert_equal @model, assigns(:model)

    assert_raise do
      get edit_namespace_model_path(@model)
    end


    @model.reload
    assert_equal "[updated attribute value]", @model.attribute

    assert flash.any?
    assert flash[:ChangeFlashType].????

    assert_not_equal submitted_attribute_value, assigns(:model).non_permitted_attribute
    assert_equal controller_set_attribute_value, assigns(:model).non_permitted_attribute 

    assert_difference 'NameSpace::Model.count', 1 do
      post namespace_resources_path, params: { namespace_model: { [see create params attributes] } }
    end

        assert_no_difference ['Core::User.count', 'Core::Account.count'], 1 do
            post user_registration_path, params:  { user: {         first_name: "", 
                                                                    last_name: "", 
                                                                    email: "", 
                                                                    password: "", 
                                                                    password_confirmation: ""  }, 
                                                    core_account: { name: "Test Account" } }
        end

    assert_no_difference 'Training::Category.count' do
      post training_categories_path, params: { training_category: { name: "category 1" } }
    end
    
    assert_match "Hi", mail.body.encoded
    
    
    
assert( test, [msg] )	# Ensures that test is true.
assert_not( test, [msg] )	# Ensures that test is false.
assert_equal( expected, actual, [msg] )	# Ensures that expected == actual is true.
assert_not_equal( expected, actual, [msg] )	# Ensures that expected != actual is true.
assert_same( expected, actual, [msg] ) # Ensures that expected.equal?(actual) is true.
assert_not_same( expected, actual, [msg] ) # Ensures that expected.equal?(actual) is false.
assert_nil( obj, [msg] ) # Ensures that obj.nil? is true.
assert_not_nil( obj, [msg] ) # Ensures that obj.nil? is false.
assert_empty( obj, [msg] ) # Ensures that obj is empty?.
assert_not_empty( obj, [msg] ) # Ensures that obj is not empty?.
assert_match( regexp, string, [msg] ) # Ensures that a string matches the regular expression.
assert_no_match( regexp, string, [msg] ) # Ensures that a string doesn't match the regular expression.
assert_includes( collection, obj, [msg] ) # Ensures that obj is in collection.
assert_not_includes( collection, obj, [msg] ) # Ensures that obj is not in collection.
assert_in_delta( expected, actual, [delta], [msg] ) # Ensures that the numbers expected and actual are within delta of each other.
assert_not_in_delta( expected, actual, [delta], [msg] ) # Ensures that the numbers expected and actual are not within delta of each other.
assert_in_epsilon ( expected, actual, [epsilon], [msg] ) # Ensures that the numbers expected and actual have a relative error less than epsilon.
assert_not_in_epsilon ( expected, actual, [epsilon], [msg] ) # Ensures that the numbers expected and actual have a relative error not less than epsilon.
assert_throws( symbol, [msg] ) { block } # Ensures that the given block throws the symbol.
assert_raises( exception1, exception2, ... ) { block } # Ensures that the given block raises one of the given exceptions.
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



assert_difference(expressions, difference = 1, message = nil) {...} # Test numeric difference between the return value of an expression as a result of what is evaluated in the yielded block.
assert_no_difference(expressions, message = nil, &block) # Asserts that the numeric result of evaluating an expression is not changed before and after invoking the passed in block.
assert_changes(expressions, message = nil, from:, to:, &block) # Test that the result of evaluating an expression is changed after invoking the passed in block.
assert_no_changes(expressions, message = nil, &block) # Test the result of evaluating an expression is not changed after invoking the passed in block.
assert_nothing_raised { block } # Ensures that the given block doesn't raise any exceptions.
assert_recognizes(expected_options, path, extras={}, message=nil) # Asserts that the routing of the given path was handled correctly and that the parsed options (given in the expected_options hash) match path. Basically, it asserts that Rails recognizes the route given by expected_options.
assert_generates(expected_path, options, defaults={}, extras = {}, message=nil) # Asserts that the provided options can be used to generate the provided path. This is the inverse of assert_recognizes. The extras parameter is used to tell the request the names and values of additional request parameters that would be in a query string. The message parameter allows you to specify a custom error message for assertion failures.
assert_response(type, message = nil) # Asserts that the response comes with a specific status code. You can specify :success to indicate 200-299, :redirect to indicate 300-399, :missing to indicate 404, or :error to match the 500-599 range. You can also pass an explicit status number or its symbolic equivalent. For more information, see full list of status codes and how their mapping works.
assert_redirected_to(options = {}, message=nil) # Asserts that the response is a redirect to a URL matching the given options. You can also pass named routes such as assert_redirected_to root_path and Active Record objects such as assert_redirected_to @article.

assigns(:ChangeThisPls)
