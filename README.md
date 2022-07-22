# README

To run this app on your local machine (mac/ubuntu/ any other Linux based):

make sure you got the ruby version installed see (.ruby-version file)

run: bundle install

run: rails db:setup

run: rails s

For test case

run: bundle exec rspec

Now go to Postman and import this API for testing

https://www.getpostman.com/collections/7ee7c9c7d16e230ba404

  POST http://localhost:3000/api/v1/auth

  POST http://localhost:3000/api/v1/sign_in

  POST http://localhost:3000/api/v1/reservations

  PUT http://localhost:3000/api/v1/reservations/{:id}

  PUT http://localhost:3000/api/v1/status

Steps Need to follow

  1 - Create a user using API or use existing(seed) user

  2 - Sign in the user with sign_in API using email and password

  3 - Get client, access_token, uid from the headers of successful sign in request

  4 - Set these three values into environment variable on Postman. Ref: https://learning.postman.com/docs/sending-requests/variables/

  5 - Now you can go to Postman and run "Create reservation" API with the right data(make sure to set the header in an environment variable or manually)

      - Make sure to pass vehicle id that exists in the database, I have created 10 vehicle, you can use any id between 1 - 10 for vechile_id

  6 - If you are going to update reservation, make sure to pass id of the user who created reservation.

Assumptions

  The reservation form will fetch available vehicles model and make from our database using API.

  When someone fills the reservation form, they will select vehicle model from a list of vehicle models. It will return vehicle id on form submission which will later be passed to create reservation API.

  To create a reservation using API, keeping in mind the security aspect of app, added a user sign_in which returns client, uid and access_token in response headers. These headers will be passed in create reservation request to validate authenticity of the request.

  Added a cms_customer_id attribute to customers table assuming our customers might be coming from a CMS. The reason I used term 'cms' to prevent from clash in default rails naming convention.

  I did not use any gem as we have to only give API endpoint for creating, but when we need to work on advance we can use  active_model_serializers, jsonapi-rb or blueprinter and even can make our custom validator for each action upon need

  I have made code generic which will make any model basic API without writing any code in the controller
