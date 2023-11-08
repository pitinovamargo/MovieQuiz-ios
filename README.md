# MovieQuiz

## Purpose and goals of the application ##

MovieQuiz is an application with quizzes about films from the top 250 ratings and the most popular films according to IMDb.

Application goals:

- download data about movies from the network;
- calculate game statistics;
- save user game data.

## Description of the application ##
- The one-page application with quizzes about films from the top 250 ratings and the most popular IMDb films. The application user consistently answers questions about the film's rating. At the end of each round of the game, statistics are shown on the number of correct answers and the user’s best results. The goal of the game is to answer all 10 questions correctly in the round.

## Technology stack ##
- Swift, UIKit
- Architecture: MVP
- Storyboard
- URLSession
- Multithreading
- UnitTests, UITests

## Installation ##
Installation and launch via Xcode. Interface elements adapt to iPhone screen resolutions starting from X - layout for SE and iPad is not provided.

Minimum system version iOS 13.0.

## Links ##
[Design Figma](https://www.figma.com/file/l0IMG3Eys35fUrbvArtwsR/YP-Quiz?node-id=34%3A243)

[API IMDb](https://imdb-api.com/api#Top250Movies-header)
