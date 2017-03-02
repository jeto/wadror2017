var BREWERIES = {};

BREWERIES.show = function(){
  $("#breweriestable tr:gt(0)").remove();
  var table = $('#breweriestable');

  $.each(BREWERIES.list, function(index,breweries){
    table.append('<tr>'
                  + '<td>'+breweries['name']+'</td>'
                  + '<td>'+breweries['year']+'</td>'
                  + '<td>'+breweries['beers']['count']+'</td>'
                   + '</tr>');
  });
}

BREWERIES.sort_by_name = function(){
  BREWERIES.list.sort( function(a,b){
    return a.name.toUpperCase().localeCompare(b.name.toUpperCase());
  });
};

BREWERIES.sort_by_year = function(){
  BREWERIES.list.sort( function(a,b){
    return a.year < b.year;
  });
};

BREWERIES.sort_by_beers = function(){
  BREWERIES.list.sort( function(a,b){
    return a.beers.count < b.beers.count;
  });
};

$(document).ready(function(){
  if ( $("#breweriestable").length>0 ){
    $("#name").click(function(e){
    BREWERIES.sort_by_name();
    BREWERIES.show();
    e.preventDefault();
    });
    $("#year").click(function(e){
      BREWERIES.sort_by_year();
      BREWERIES.show();
      e.preventDefault();
    });
    $("#beers").click(function(e){
      BREWERIES.sort_by_beers();
      BREWERIES.show();
      e.preventDefault();
    });
    $.getJSON('breweries.json', function(breweries){
      BREWERIES.list = breweries;
      BREWERIES.sort_by_name();
      BREWERIES.show();
    });
  }
});