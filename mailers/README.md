Best Practices & Notes:
1. Deliver Later & Background jobs - all mailers should be delivered with `deliver_later` which sends it to a background job. Therefore all mailers need to follow best practices for background jobs
2. To whom - often, creating sql query is the most difficult part, espeically for cron jobs. Make sure to really think it through.


Create Mailer / Emails
1. Think through mailer / prep names
  - what emails do you need to send
  - what is logical mailer name

2. Create Mailer & emails
  1. If adding emails to existing mailer, add 2 view files per email
    - `app/views/namespace/some_mailer/some_noun_email.hmtl.erb`
    - `app/views/namespace/some_mailer/some_noun_email.txt.erb`
  2. If creating new mailer
    -  `$ rails g mailer namespace/some_mailer some_noun_email`
    - notes on naming:
      - email should be noun (`.deliver_later` is the verb that will be called on the email)
      - email should end in `_email`
    - examples: 
      - good: `$ rails g mailer core/users_mailer welcome_email`
      - bad (don't make email a verb): `$ rails g mailer core/users_mailer send_welcome_email`
      - bad (email should end in `_email`): `$ rails g mailer core/users_mailer welcome`

3. Create / Update email method in mailer.rb
  - clean initial mailer to fit rubocop standards
  - use template to fill in email method (,raba)

4. Finish HTML first (don't build text till later)

5. Build preview and preview HTML email
  - NOTE: if adding new emails to existing mailer, you will need to add the email methods
  - Preview method SHOULD NOT use any deliver method (`deliver_later`)
  - good: `Namespace/SomeMailer.some_email`
  - good: `Namespace/SomeMailer.some_email`
  - bad: `Namespace/SomeMailer.some_email.deliver_later`

6. Build text email and preview AFTER you feel GREAT about html email

7. QA
  - Create QA list (make QA doc name match file path)
  - create seeds needed for QA
  - Run initial QA

9. Create Tests

10. Deploy to review app, staging and production
  - check mailtrap when testing on review app and staging
  - check actual mail when testing on production
