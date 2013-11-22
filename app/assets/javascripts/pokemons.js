lastSearchText = "";

function pokemonSearchFor(searchText) {
  console.log("searching for " + searchText);

  if (searchText === lastSearchText) { return; }

  lastSearchText = searchText;

  if (searchText.length < 2) {
    var resultsHtml = $("#pokemon-results");
    resultsHtml.html("");
    return;
  }

  $.ajax("/pokemons/search", { type: "POST",
    data: { query: searchText },
    success: function(data,textStatus,jqXHR) {
      // console.log("Success");
      console.log(data);

      var resultsHtml = $("#pokemon-results");

      resultsHtml.html("");

      var templateSource = $("#pokemon-index-template").html();
      var template = Handlebars.compile(templateSource);

      $.each(data.pokemons,function(index,elem) {
        var pokemonHtml = template(elem);
        resultsHtml.append(pokemonHtml);

      });

    },
    error: function() {
      // console.log("failure");
    }
  });
}