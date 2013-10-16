jQuery ->
 isGraphic =-> $('.list-graphic')?
 if isGraphic()
   $('.list-graphic__result').each(->
    bar = $(this).find('strong')
    #take percent of each element
    percent = bar.attr('data-width')
    #animate bg to give live
    bar.animate {'width': percent }, 1500
   )