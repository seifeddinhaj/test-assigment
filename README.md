# Reward System


My solution based simply on tow arrays , which we keep into memory while calculation.

I put most the work of this task into services: `app/services`.
I created tow arrays "requests"  and "rewards" and based on the accepted requests we calculate the score of the reward for each item(member of the system) based on every record in "requests" that have attribute "items_to_reward".And I added some more work about the validation of input data, and parsing it.
I used only rails to implement this task (for webservice)
I added some tests for the rewards_controller(rspec)

Instructions for setup, tests, run, and you can contact me if you have any questions.

### Requirements:
 RUBY VERSION
   ruby >= 2.5.1

### Install:
 - `bundle install`

 ### Tests:
 - `bundle exec rspec`


### Run:
 - `rails s`
 - `curl -X POST localhost:3000/rewards --data-binary @input_data.txt -H "Content-Type: text/plain"`


### link github:
  `https://github.com/seifeddinhaj/test-assigment`