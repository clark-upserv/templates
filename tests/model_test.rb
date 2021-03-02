replace:
fodel (because "models" is in the test command line reference)
Fodel
resources
namespace
NameSpace



# rails t test/models/namespace/fodel_test.rb


  #--- Setup ---#
  def setup
    @fodel = namespace_resources(:fodel_1)
    # only if you are testing uniqueness for some attribute
    # @second_fodel = namespace_resources(:fodel_2)
  end

  #--- Before methods ---#
    # [see below]

  #--- Gems / other ---#
  #--- Validations ---#
  # initial valid test
  test "fodel should be valid" do
    assert @fodel.valid?
  end

  # Attribute
  test "Attribute should be present" do
    @fodel.attribute = nil
    assert_not @fodel.valid?
    assert_equal ["Attribute must exist", "Attribute can't be blank"], @fodel.errors.full_messages
  end

  test "Attribute should be <= 255 characters" do
    a = "a"*256
    @fodel.attribute = a 
    assert_not @fodel.valid?
    assert_equal ["Attribute is too long (maximum is 255 characters)"], @fodel.errors.full_messages
  end

  test "Attribute should be unique" do
    @fodel.attribute = @second_fodel.attribute 
    assert_not @fodel.valid?
    assert_equal ["Attribute has already been taken"], @fodel.errors.full_messages
  end



  #--- Class Methods --#
  # search tests
  test "fodel Attribute search with results" do
    # set search quiery
    @queiry = "XXX"
    #search resources based
    results = NameSpace::Fodel.search(@queiry)
    # set to true as a starting point
    all_results_are_true = true
    # set up block to test that each search result contains queiry 
    # 1) if you are testing an attribute on the same table 
    results.pluck(:attribute).each do |attribute|
    # 2) if you need to concatenate 2 attributes on the same table (ex. user.first_name & user.last_name), you need to use concat AND user Arel.sql (otherwise quiery will be unsafe)::
    # results.pluck(Arel.sql("CONCAT_WS(' ', tables.attribute_1, tables.attribute_2)")).each do |attribute|
    # 3) if you are searching an attribute on a related table:
    # results.joins(:relationship).pluck('other_tables.attribute_1').each do |attribute|
    # 4) if you are searching and concatenating attributes on another table, you have to joins AND user Arel.sql (otherwise quiery will be unsafe):
    # results.joins(:relationship).pluck(Arel.sql("CONCAT_WS(' ', tables.attribute_1, tables.attribute_2)")).each do |attribute|
      # for each result, check that their attribute contains the search queiry
      all_results_are_true = false if !(attribute =~ /#{@quiery}/i)
    end
    # assert each item in the list has the search queiry within it
    assert all_results_are_true
  end

  test "fodel search with zero results" do
    # set search that will return 0 results
    @queiry = "abcdefghijklmnopqrstuvwxyz1234567890"
    # run the search
    results = NameSpace::Fodel.search(@queiry)
    # assert no results
    assert_equal 0, results.count
  end
  #--- Instance Methods ---#
  #--- Before methods ---#
  #--- Validate methods ---#
