<h1 align="center">
  Chubster
</h1>
<div align="center">
  A fully private calorie counter / food journal / health tracker that explicitely <em>does not</em> share your data.
</div>
<br />
<div align="center">
  <img alt="GitHub" src="https://img.shields.io/github/license/hamaluik/chubster?style=flat-square">
</div>

## Motivation

There are a glut of calorie trackers out there: MyFitnessPal, LoseIt, FatSecret, Lifesum, etc. By and large these apps
work well—they are chock full of features, have large communities with very large food databases, etc. The problem I
have with all of them is that they aren't that private—reading their privacy policies indicates that each of them will
collect and share various data about you as they see fit. This is fine for a lot of folks, but I'd rather keep my
data private, especially data related to my health. Ultimately, the point of _Chubster_ is to provide an easy-to-use
app for tracking your nutrition, health, and fitness, without anybody else spying (inadvertantly or not) on what I'm
doing. You may find this app superfluous, but that's fine—you don't have to use it. I'm developing this mainly for my
own needs, and sharing it in case others find it useful as well.

### Privacy

* Chubster doesn't upload information about you, period.
* All data you enter will stay in the app <sup>1</sup>
* You can export all your data at any time as a `.csv` file
* You can import all your data at any time from a `.csv` file (there is no other migration mechanism)
* You can opt-in to download nutrition data from an online database
* You can opt-in to upload nutrition data to an online database
* You can opt-in to download recipes from an online database
* You can opt-in to upload recipes to an online database
* You can host your own online database and use that instead of the mainline _Chubster_ database

<sup>1</sup> with the exception of when you explicitely request to share food nutrition data and/or recipes with the
_Chubster_ server


## Features

The following is a brainstormed list of features, which are currently a mix of _needs_ and _wants_. As the app
progresses, this list will start to separate into either _needs_ or _wants_, which will drive the development and
release schedule.

- [ ] Record data about body metrics
  - [ ] Age
  - [ ] Sex
  - [ ] Height
  - [ ] Track body metrics over time
    - [ ] Self-configurable items, for example: weight, body composition, measurements, etc
    - [ ] Filter the data to smooth out day-to-day variations
    - [ ] Forecast metrics into the future
- [ ] Record data about daily nutritional intake
  - [ ] Enter nutritional information about foods into a local database
  - [ ] Compose foods out of other foods (recipes)
  - [ ] Search foods from local database
  - [ ] Group foods into meals
- [ ] Configure daily targets for nutrition metrics (calories, fats, proteins, carbs, etc)
- [ ] Dashboard to quickly gauge daily progress to nutrition metrics
- [ ] Synchronize foods with an online database
- [ ] Import / export data
  - [ ] Export all data to a series of `.csv` files
  - [ ] Import all data from a series of `.csv` files

## Development

The _Chubster_ app is developed in [Flutter](https://flutter.dev/), using the
[BLoC](https://www.didierboelens.com/2018/08/reactive-programming---streams---bloc/) pattern.
