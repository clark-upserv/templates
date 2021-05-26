      ChangeVariable = upload_fixture_file('ChangePath', 'ChangeContentType')
      # DeleteThisPls - this is custom helper method in test_helper file. Previously was using the fixture_file_upload method,
      #   but that method is only available in ActionDispatch::IntegrationTest. This method is available in all tests.
      # DeleteThisPls - path is full path with file name and extension AFTER 'test/fixtures/files'
      # DeleteThisPls - file type and subtypes:
      #   application/pdf
      #   image/png image/gif image/jpeg
      #   video/mov video/mp4
      #   audio/mpeg audio/wave
      #   text/plain text/csv text/html
      #   see here for more examples: https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/MIME_types
      @ChangeObject.ChangeAttachment.attach(ChangeVariable)
