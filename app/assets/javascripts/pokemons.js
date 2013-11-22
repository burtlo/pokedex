$(function() {

  lastSearchText = "";

  $("#pokemon-search").keypress(function(e) {
    if(e.which == 13) {
      e.preventDefault();
    }
  });

  $("#pokemon-search").on("keyup",function(eventObj) {
    if (eventObj.which == 13) { return; }
    var searchText = $(this).val();
    pokemonSearchFor(searchText);
  });

  var searchText = $("#pokemon-search").val();

  pokemonSearchFor(searchText);

});

function pokemonSearchFor(searchText) {
  console.log("searching for " + searchText);

  if (searchText === lastSearchText) { return; }

  lastSearchText = searchText;

  if (searchText.length < 2) {
    Pokemon.setPokemon({});
    Pokemon.render();
    return;
  }

  $.ajax("/pokemons/search", { type: "POST",
    data: { query: searchText },
    success: function(data,textStatus,jqXHR) {
      console.log("Search Complete");
      console.log(data);
      Pokemon.setPokemon(data.pokemons);
      Pokemon.render();
    },
    error: function() {
      // console.log("failure");
    }
  });
}

Pokemon = {
  setPokemon: function(pokemon) { this.pokemon = pokemon; },
  setTemplate: function(templateName) { this.templateName = templateName; },
  render: function() {
    this.clearView();

    var template = this.template();
    var resultsHtml = $("#pokemon-results");

    $.each(this.pokemon,function(index,elem) {
      var pokemonHtml = template(elem);
      resultsHtml.append(pokemonHtml);
    });

  },
  clearView: function() {
    var resultsHtml = $("#pokemon-results");
    resultsHtml.html("");
  },
  template: function() {
    var templateSource = $("#pokemon-" + this.templateName + "-template").html();
    return Handlebars.compile(templateSource);
  }
};

Pokemon.setTemplate("evolve");

