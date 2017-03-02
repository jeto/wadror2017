var BREWERIES = {};

BREWERIES.show = ()=>{
  $("#breweriestable tr:gt(0)").remove();
  var table = $('#breweriestable');

  $.each(BREWERIES.list, (index,breweries)=>{
    table.append('<tr>'
                  + '<td>'+breweries['name']+'</td>'
                  + '<td>'+breweries['year']+'</td>'
                  + '<td>'+breweries['beers']['count']+'</td>'
                   + '</tr>');
  });
}

BREWERIES.sort_by_name = ()=>{
  BREWERIES.list.sort( (a,b)=>{
    return a.name.toUpperCase().localeCompare(b.name.toUpperCase());
  });
};

BREWERIES.sort_by_year = ()=>{
  BREWERIES.list.sort( (a,b)=>{
    return a.year < b.year;
  });
};

BREWERIES.sort_by_beers = ()=>{
  BREWERIES.list.sort( (a,b)=>{
    return a.beers.count < b.beers.count;
  });
};

$(document).ready(()=>{
  if ( $("#breweriestable").length>0 ){
    $("#name").click((e)=>{
    BREWERIES.sort_by_name();
    BREWERIES.show();
    e.preventDefault();
    });
    $("#year").click((e)=>{
      BREWERIES.sort_by_year();
      BREWERIES.show();
      e.preventDefault();
    });
    $("#beers").click((e)=>{
      BREWERIES.sort_by_beers();
      BREWERIES.show();
      e.preventDefault();
    });
    $.getJSON('breweries.json', (breweries)=>{
      BREWERIES.list = breweries;
      BREWERIES.sort_by_name();
      BREWERIES.show();
    });
  }
});