# Scout Master

![Scoutmaster Homepage](https://raw.githubusercontent.com/PHironaka/scout-master/master/app/assets/images/scout-master-screen.jpg)

Producing premium content is difficult, which is made all the more difficult without a proper location. Scout Master is a web application designed to help Producer's around the world find and track THE BEST locations.

Scout Master aims to reduce the pre-produciton time allocated towards location scouting. With a database full of locations (curated by the users), it will hopefully increase overall productivity for teams working on tight timelines.

## User Story List here:  
#### [Trello Board](https://trello.com/b/k6NWe0WJ/project-2)

## Rough Designs
#### [Index Design](https://www.dropbox.com/s/k69nkjdxbak9jon/Scouter-app-Desktop.png?dl=0)
#### [User Profile Design](https://www.dropbox.com/s/mutqxbidaj26q6z/Desktop-UserProfile.png?dl=0)
#### [Location post Design](https://www.dropbox.com/s/od7ym5lo9035g36/Desktop-location-post.png?dl=0)


## Technologies
- `Paperclip`: image upload
- `AWS SDK`: serving images for deploying to heroku
- `friendly_id`: pretty URLS
- `bootstrap_sass`: Bootstrap
- Search functionality for locations
- Comments for users to make on locations
- HTML, Sass
- [Khaled Ipsum](http://khaledipsum.com/)


## Install
- From the command line:
	- cd into your folder of choice.
	- First run`git clone [this repository URL]`
	- Then run `bundle install`
	- Run `rails db:create`
	- Run `rails db:migrate`
	- Then run `rails server`


## Models (so far)
- Locations: representative of each location a user enters
- Users
- Comments


# Leftover to-dos

- Continued redesign
- Better navigation solution
- Static pages (About, Terms & Conditions, Contact, etc)
- Likes on locations
- Incorporating a ranking system for each user based off number of likes
- membership model
- Create a gallery feature so users can include more than one image per location
- Utilize the Google Map API to visualize each location.
- Responsive tweaks w/Bootstrap
