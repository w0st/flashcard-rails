# Flashcard Rails
This repo contains a simple rails 5 application to help with learning new words.

### Online version

You can check this app in the action: [here](https://flashcard-rails.herokuapp.com/).
To sign-in you can use below credentials:

|email|password|
|-----|--------|
| **user@domain.com**| **password**| 


### Ruby version and dependencies

I used ruby 2.3.0 . Any other dependencies you can check in Gemfile.

### Database

Database settings you can see/change in database.yml file.
To create database with seeds (sample data for app) type:
```
rake db:setup
rake db:seed
```


### How to run the test suite

For groups and quiz controllers exists rspec test. Moreover I used capybara for functional testing quiz module.
All you need to run test suite is typing: 
```
rspec spec
```

### Angular2 corresponding application
I have prepared json views to supply my another Angular 2 app: [flashcard-angular2](https://github.com/w0st/flashcard-angular2).
For correctly working flashcard-angular2 app you must before log in the rails app.