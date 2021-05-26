      ChangeVariable = upload_fixture_file('ChangePath', 'ChangeContentType')
      # DeleteThisPls - this is custom helper method in test_helper file. Previously was using the fixture_file_upload method,
      #   but that method is only available in ActionDispatch::IntegrationTest. This method is available in all tests.
      # DeleteThisPls - path is full path with file name and extension AFTER 'test/fixtures/files'
      # DeleteThisPls - file type and subtypes:
      #   application/pdf
      #   video/mov
      #   etc.
      @ChangeObject.ChangeAttachment.attach(ChangeVariable)
