var BEERS = {};

BEERS.show = ()=>{
  $("#beertable tr:gt(0)").remove();
  var table = $('#beertable');

  $.each(BEERS.list, (index,beer)=>{
    table.append('<tr>'
                  + '<td>'+beer['name']+'</td>'
                  + '<td>'+beer['style']['name']+'</td>'
                  + '<td>'+beer['brewery']['name']+'</td>'
                   + '</tr>');
  });
}

BEERS.sort_by_name = ()=>{
  BEERS.list.sort( (a,b)=>{
    return a.name.toUpperCase().localeCompare(b.name.toUpperCase());
  });
};

BEERS.sort_by_style = ()=>{
  BEERS.list.sort( (a,b)=>{
    return a.style.name.toUpperCase().localeCompare(b.style.name.toUpperCase());
  });
};

BEERS.sort_by_brewery = ()=>{
  BEERS.list.sort( (a,b)=>{
    return a.brewery.name.toUpperCase().localeCompare(b.brewery.name.toUpperCase());
  });
};

$(document).ready(()=>{
  if ( $("#beertable").length>0 ){
    $("#name").click((e)=>{
    BEERS.sort_by_name();
    BEERS.show();
    e.preventDefault();
    });
    $("#style").click((e)=>{
      BEERS.sort_by_style();
      BEERS.show();
      e.preventDefault();
    });
    $("#brewery").click((e)=>{
      BEERS.sort_by_brewery();
      BEERS.show();
      e.preventDefault();
    });
    $.getJSON('beers.json', (beers)=>{
      BEERS.list = beers;
      BEERS.sort_by_name();
      BEERS.show();
    });
  }
});