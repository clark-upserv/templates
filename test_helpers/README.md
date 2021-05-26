1. Create test helper file: `test/test_helpers/some_path/some_file_test_helper.rb`
2. Create helper methods 
3. Require helper file in any test files that need the helper methods - add `require 'test_helpers/some_path/some_file_test_helper'` just under `require 'test_helper'`
4. Test the test helper by making file with same path + `_test`: `test/test_helpers/some_path/some_file_test_helper_test'`
5. Require helper file in test helper test file - add `require 'test_helpers/some_path/some_file_test_helper'` just under `require 'test_helper'`
6. Use base template and create tests
