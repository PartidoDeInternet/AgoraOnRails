// Playing with classes for overlay labels
// 
$.fn.overlayfield = function() {
  return this.each(function (i) {
    var _fadetime = 170,
        _self = $(this),
        _input = new Array,
        _label = new Array;

    _input[i] = $("input", _self),
    _label[i] = $("label", _self);
    
    if(_input[i].val() != "") _label[i].animate({"opacity": "0"}, 0);
    
    _input[i].focus(function(){
      if($(this).val() == "") _label[i].animate({"opacity": "0.5"}, _fadetime);
    });
    
    _input[i].blur(function(){
      if($(this).val() == "") _label[i].animate({"opacity": "1"}, _fadetime);
    });
    
    _input[i].keydown(function(){
      _label[i].animate({"opacity": "0"}, _fadetime);
    });
  });
};

$(function(){
  
  // Vote vote!
  $("form.vote button").click(function(e) { 
    e.preventDefault();
    $("#overlay iframe").attr("src", $("form.vote").attr("action") + "?value=" + $(this).attr("value"));
    $("#overlay").overlay({ 
      expose: { 
        color: '#fff', 
        loadSpeed: 200, 
        opacity: 0.7 
      }, 
      closeOnClick: false, 
      api: true 
    }).load();
  });
  
  // Home!
  var hot_proposals = $("#hot_proposals"),
  recently_closed =  $("#recently_closed"),
  hot_proposals_link = $("#hot_proposals_link");
  
  if(hot_proposals.length > 0 && recently_closed.length > 0){
    recently_closed.addClass("accessible");
    hot_proposals_link.addClass("active");
    $(".navlinks").click(function(e){
      e.preventDefault();
      $(".navlinks").toggleClass("active");
      $(".proposals").toggleClass("accessible");
    });
  }
  
  $(".overlayfield").overlayfield();
});
