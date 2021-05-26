    test 'ChangeEmail' do
      mail = ChangeThisMailer.ChangeEmail
      # DeleteThis - REMEMBER: do not test things that could easily change (ex. text in source code)
      assert_equal 'ChangeSubject', mail.subject
      assert_equal ['ChangeMailTo'], mail.to
      assert_equal ['ChangeMailFrom'], mail.from
      assert_match 'ChangeSomeContent', mail.body.encoded
    end
