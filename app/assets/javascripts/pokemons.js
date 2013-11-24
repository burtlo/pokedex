$(function() {
  $(".brand").on("click",function(eventObj) {
    eventObj.preventDefault();
    var filter = $(this).data("template");
    Pokemon.setTemplate(filter);
    Pokemon.render();
  });

  $("ul.nav li").on("click",function(eventObj) {
    var filter = $(this).data("template");
    Pokemon.setTemplate(filter);
    Pokemon.render();
  });

  $("#pokemon-search").val(Pokemon.filter());

  $("#pokemon-search").keypress(function(e) {
    if(e.which == 13) {
      e.preventDefault();
      $(this).blur();
      console.log("enter was pressed");
    }
  });

  $("#pokemon-search").on("keyup",function(eventObj) {
    if (eventObj.which == 13) { return; }
    var searchText = $(this).val();
    Pokemon.search(searchText);
  });

  Pokemon.fetch();
});

Pokemon = {
  fetch: function() {

    $.retrieveJSON("/pokemons",function(json) {
      Pokemon.setPokemon(json.pokemons);
      Pokemon.render();
    });

  },
  reset: function() {
    $.clearJSON("/pokemons");
  },
  search: function(searchText) {
    if (searchText === this.filter()) { return; }
    this.setFilter(searchText);
    this.render();
  },
  setFilter: function(filter) {
    $.cookie("pokemon-filter",filter);
  },
  filter: function() {
    return $.cookie("pokemon-filter") || "";
  },
  pokemon: function() {
    var filteredPokemon = [];

    var filterBy = this.filter();

    if (filterBy === "") {
      return this.pokemonData;
    }

    console.log("Pokemon filtered: " + filterBy);

    var filterRegex = new RegExp(filterBy,"i");

    $.each(this.pokemonData,function(index,obj) {
      if ( obj.name.match(filterRegex) ) {
        filteredPokemon.push(obj);
      }
    });

    return filteredPokemon;
  },
  setPokemon: function(pokemon) {
    this.pokemonData = pokemon;
  },
  render: function() {
    console.log("Rendering");
    this.clearView();

    var template = this.template();
    var resultsHtml = $("#pokemon-results");

    $.each(this.pokemon(),function(index,obj) {
      var pokemonHtml = template(obj);
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
