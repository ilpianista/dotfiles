#!javascript

var regex = new RegExp("https?://www.youtube.com/watch\\?(.*&)*v=.*");

signals.connect("navigation", function (wv, frame, request) {
  if (wv.mainFrame == frame && regex.test(request.uri))
    system.spawn("sh -c 'cvlc \"$(youtube-dl -g " + request.uri + ")\"'");
  return false;
});
