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
  
  $("form.vote button").click(function(e) { 
    e.preventDefault();
    $("#overlay iframe").attr("src", $("form.vote").attr("action") + "?value=" + $(this).attr("value"));
    $("#overlay").overlay({ 
      expose: { 
        color: '#fff', 
        loadSpeed: 200, 
        opacity: 0.5 
      }, 
      closeOnClick: false, 
      api: true 
    }).load();
  });
  
  $(".overlayfield").overlayfield();
  
});
