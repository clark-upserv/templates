# Welcome!
This is how to set up google recaptcha v3 on your rails site
##Setup
* set up gmail or gsuite account and create recaptcha instance
  - go to: https://www.google.com/recaptcha/admin/create
  - NOTE: this is different than recaptcha enterprise. You should not have to go to console.cloud.google.com 
  - RATHER: you should go here to see your recaptcha instances: https://www.google.com/u/3/recaptcha/admin/
* have way to use environment variables locally (suggestion: dot-env gem)
* copy recaptcha_v3 folder into lib/google (so you will have lib/google/recaptcha_v3/...)
* move everything under lib/google/recaptcha_v3/views into app/views (so you will have app/views/google/recaptcha_v3/...)
* delete lib/google/recaptcha/views (ie all the files you just moved)
* add the following method in your layout head (if it does not already exist)
  * `<%= yield :head %>`

## Application
#### Per page with form(s) using reCAPTCHA
add recaptcha js to any page with a form that needs recapcha: 
  ```
  <%= content_for :head do %>
    <%= render(partial: 'google/recaptcha/recaptcha_js') %>
  <% end %>
  ```
#### Per form using reCAPTCHA
* add the execute_recaptcha partial (which adds an hidden input and short js method to send send data to google) at end of any form (preferably after the submit button). NOTE: The "action_and_id" needs to be unique for ALL inputs on the page (even if you have multiple forms) because it will create an html input and the js will break if there are multiple inputs with the same id
  ```
  <%= render(partial: 'google/recaptcha/execute_recaptcha', locals: { action_and_id: 'contact_us'" }) %>
  ```
#### Per controller recieving form(s) using reCAPTCHA
* add verify_recaptcha method (which verifies if the user is suspicious or not) to the private section of the controller receiving the form
    ```
    private

    def verify_recaptcha(action)
      Google::RecaptchaV3.verify_recaptcha?(params[:recaptcha_token], action)
    end
    ```
#### Per controller action recieving form using reCAPTCHA
* manage control flow for the action recieving the form in whatever approach you prefer (see example below). NOTE: the 'action' in verify_recaptcha('action') MUST BE the same as the "action_and_id" text used in the execute_recaptcha partial above (this allows us to make sure google is evaluating the same form we are recieving - we don't want to check googles evaulation of a different form). Example control flow: 
      ```
      if !verify_recaptcha('action') 
        flash.now[:error] = 'Google reCAPTCHA authorization failed or timed out. Please try again.'
        render 'some_template' 
      else 
        # valid response
      end
      ```
