# Story Wheel
## Introduction

Story Wheel was created by Johannes Wagener and Katharina Birkenbach during MusicHackDay Boston 2011.
It lets people record a story around their Instagram pictures and share it as a nostalgic slideshow on the web.

## Technical Details

The application is built as a client-side javascript app.

Ruby on Rails is only used to provide facebook open graph tags, precache some of the SoundCloud API requests and to have nice links for the stories.

The audio recording when creating a new storywheel is provided by the SoundCloud Javascript SDK using Adobe Flash and then uploaded and stored on SoundCloud.

Timed comments are then created to reference each Instagram picture to a specific time position in this recording.

Aside from that a moderated group on SoundCloud is used to currate the tracks shown on the landing page.

## Custom Story Wheels

Due to the fact that all stories are basically just SoundCloud tracks with timed comments to trigger the next slide/picture it is possible to turn already existing tracks on SoundCloud into stories without having to use the recording flow on storywheel.cc.

The followings steps are necessary to do that:

1) You have to create a timed comment for each picture that you want to show at the specific position.
The comment needs to be created by the owner of the track and has to match the following pattern:

<a href=http://storywheel.cc/{username}/{trackname}#{direct link to the picture}>{some link text}</a>

For Example:
<a href=http://storywheel.cc/alex-eric/soundcloud-story#http://distilleryimage3.s3.amazonaws.com/8f03ffce15ab11e19896123138142014_7.jpg>StoryWheel Picture</a>

2) (optional) You can customize the StoryWheel experience by setting various machine tags on the track. These are the supported tags:

* storywheel:slideSound=0 to turn of the slide sound.
* storywheel:backgroundTrackId={track id} to play an additional track (usually music) in the background while playing the story wheel.
* storywheel:backgroundTrackVolume=25 to adjust the background track volume.
* storywheel:image={url to an image} to show an alternative image in the preview on storywheel.cc
* storywheel:backgroundImage={url to an image} to show an alternative background image.

To set these machine tags through the SoundCloud track edit interface best prepare them in a text editor, surround them by quotes and then copy and paste them into the tag textarea.

For example: "storywheel:backgroundTrackId=293"
https://skitch.com/e-jwagener/8yycp/edit-test-on-soundcloud-create-record-and-share-your-sounds-for-free

3) To view the story on storywheel, just replace soundcloud.com with storywheel.cc in the track link and open it. For example:

http://soundcloud.com/alex-eric/soundcloud-story
to 
http://storywheel.cc/alex-eric/soundcloud-story

## Embedding

The storywheel can be embedded into a different site using an iframe.
Just adjust this code to your link:

      <iframe width="500" height="300" scrolling="no" frameborder="no" src="http://storywheel.cc/jwagener-test/not-boston"></iframe>
