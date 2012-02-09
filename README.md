# Story Wheel
## Introduction

Story Wheel lets you record a story around your Instragram pictures and share it on the web as a nostalgic slideshow. It was started by Johannes Wagener & Katharina Birkenbach during the Music Hack Day Boston in 2011 and is now part of the SoundCloud Labs, where we showcase a number of experimental projects, features and apps built using SoundCloud’s API.

## Technical Details

The application is built as a client-side javascript app. Ruby on Rails is only used to provide facebook open graph tags, precache some of the SoundCloud API requests and to have nice links for the stories.

The audio recording when creating a new storywheel is implemented using the SoundCloud Javascript SDK and then uploaded to SoundCloud. Timed comments are then created to reference each picture to a specific time position in this recording.

A moderated group is used to currate the stories shown on the landing page.

## Custom Story Wheels

Due to the fact that all stories are basically just SoundCloud tracks with timed comments to trigger the next slide/picture it is possible to turn already existing tracks on SoundCloud into stories without having to use the recording flow on storywheel.cc. This also allows to use pictures that are not stored on Instagram (non-square images will be cropped). 

The followings steps are necessary to do that:

1) You have to create a timed comment for each picture that you want to show at the specific position.
The comment needs to be created by the owner of the track and has to match the following pattern:

    <a href=http://storywheel.cc/{username}/{trackname}#{direct link to the picture}>{some link text}</a>

For Example:

    <a href=http://storywheel.cc/alex-eric/soundcloud-story#http://distilleryimage3.s3.amazonaws.com/8f03ffce15ab11e19896123138142014_7.jpg>StoryWheel Picture</a>

2) (optional) You can customize the StoryWheel experience by setting various machine tags on the track. These are the supported tags:

* __storywheel:slideSound=0__ to turn of the slide sound.
* __storywheel:backgroundTrackId={track id}__ to play an additional track  while playing the story wheel.
* __storywheel:backgroundTrackVolume=25__ to adjust the background track volume.
* __storywheel:image={url to an image}__ to show an alternative image in the preview on storywheel.cc
* __storywheel:backgroundImage={url to an image}__ to show an alternative background image.

To set these machine tags through the SoundCloud track edit interface best prepare them in a text editor, surround them by quotes and then copy and paste them into the tag textarea.

For example: __"storywheel:backgroundTrackId=293"__

https://skitch.com/e-jwagener/8yycp/edit-test-on-soundcloud-create-record-and-share-your-sounds-for-free

3) To view the story on storywheel, just replace soundcloud.com with storywheel.cc in the track link and open it. For example:

http://soundcloud.com/alex-eric/soundcloud-story
to 
http://storywheel.cc/alex-eric/soundcloud-story

## Embedding

Stories can be embedded into other websites using iframes.
Just replace the link in this code and embed it in your website:

    <iframe width="400" height="400" scrolling="no" frameborder="no" src="http://storywheel.cc/jwagener-test/not-boston"></iframe>



