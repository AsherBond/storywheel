$(".build-your-own").live "click", (e) ->
  SW.setState("connect")
  e.preventDefault()


$ () ->
  $("ul.all-images").scroll (e) ->
    scrolledToEnd = $(this)[0].scrollHeight - $(this).scrollTop() <= $(this).height()
    if scrolledToEnd
      SW.loadInstagramPictures(SW.instagramAccessToken, SW.instagramMaxId)

$("ul.all-images li").live "click", (e) ->
  empties = $("ul.selection li.empty")
  if empties.length < 2
    empties.first().clone().appendTo("ul.selection")
  empties.first().replaceWith($(this))

$(".goToStep2").live "click", (e) ->
  if $("ul.selection li.image").length > -1
    $("ul.selection li.image").appendTo("ul.step2-selection");
  else
    alert("Pick some photos first")
  SW.setState("prerecord")
  e.preventDefault()

$(window).keyup (e) ->
  spaceKeyCode = 32
  if e.keyCode == spaceKeyCode && SW.getState() == "record"
    SW.showNextImageFromSelection()
    e.preventDefault()

$("#recordStatus").live "click", (e) ->
  SW.showNextImageFromSelection()
  e.preventDefault()

$(".startRecording").live "click", (e) -> 
  SW.updateTimer(0);  
  SW.track("Create", "wantRecord")

  SC.record
    start: () ->
      SW.track("Create", "recording")
      SW.setState("record")
      SW.showNextImageFromSelection()

    progress: (ms, avgPeak) ->
      SW.updateTimer(ms);

    cancel: () ->
      SW.track("Create", "recordDeny")

  e.preventDefault()

$("#goToStep3").live "click", (e) ->
  SW.track("Create", "recorded")
  e.preventDefault()
  
$("#uploadButton").live "click", (e) ->
  SW.track("Create", "wantUpload")
  e.preventDefault()
  SC.connect
    connected: ->
      SW.track("Create", "connected")
      title = $("#title").val()
      title = "A story" if title == ""
      tags = []
      tags.push("storywheel:image=" + SW.slides[0].imageUrl) # TODO use 150_150
      tags.push("storywheel:backgroundTrackId=" + ($("#backgroundTrackId").val() || ""));
      
      options =
        track: 
          title: title
          tag_list: tags.join(" ") 
          shared_to: {connections: [no: 0]}
      SW.setState("upload")
      $(".progress #wheel", window).addClass("rotate")
      $("#progressMessage").text("Uploading...")
      SC.recordUpload options, (track) ->
        SW.track("Create", "uploaded")
        $("#progressMessage").text("Processing...")
        $.each SW.slides, ->
          SW.Helpers.createCommentForSlide(track, this)

        SC.put "/groups/" + SW.options.soundcloudGroupId + "/contributions/" + track.id, (contribution) ->
          SW.track("Create", "contributed")


        if history.pushState
          history.pushState({}, "StoryWheel", track.permalink_url.replace("soundcloud.com", window.location.host));

        SW.Helpers.waitTillTrackIsFinished track.uri, (track) ->
          SW.track("Create", "processed")
          window.location = track.permalink_url.replace("soundcloud.com", window.location.host)
    
$(".connectInstagram").live 'click', (e) ->
  e.preventDefault()
  instagramUrl = "/connect-instagram"
  SW.instagramPopup = SC.Helper.openCenteredPopup(instagramUrl, 1024, 370)

$(".cancel").live "click", (e) ->
  $(this).closest(".reset").addClass("really")
  e.preventDefault()

$(".reset .no").live "click", (e) ->
  $(this).closest(".reset").removeClass("really")
  e.preventDefault()
