$(function() {

  var lastSearchText = $.cookie("last-search") || "";

  $("#pokemon-search").val(lastSearchText);

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
  pokemonSearchFor(searchText,{ force: true });

});

function pokemonSearchFor(searchText,options) {
  console.log("searching for " + searchText);

  var lastSearchText = $.cookie("last-search");

  if (searchText === lastSearchText && !options.force) { return; }

  $.cookie("last-search",searchText);

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
    var templateSource = $("#pokemon-" + this.templateName() + "-template").html();
    return Handlebars.compile(templateSource);
  },
  templateName: function() {
    return $.cookie("pokemon-template") || this.defaultTemplateName;
  },
  defaultTemplateName: "battle",
  setTemplate: function(templateName) {
    $.cookie("pokemon-template",templateName);
  }
};
