$(document).ready(function() {
  var ENV = "http://github-badges.heroku.com/yql/github.env?v=1";

  $("#username").autocomplete({
    source: function(request, response) {
      $("#spinner").show();
      $.queryYQL("select * from github.user.search where login = \"" + request.term + "\"", ENV, function(data) {
        var results = $(data.query.results.users.user).map(function() { return this.username; });
        response(results);
        $("#spinner").hide();
      });
    }
  });
});

