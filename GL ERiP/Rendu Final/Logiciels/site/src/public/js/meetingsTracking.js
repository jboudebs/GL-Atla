$(document).ready(function()
{
  $("a[href$='/meetingsTracking']").css("color","white");

  var meetingsList = $(".meetingsList");
    
  
  moment.locale('fr');
  
  $.get("/api/user_meetings").then(function(data)
  {
    if(data.dateDebut === 'undefined' )
    {
      $(".member-meetings").text('Pas d\'entretiens prochainement');
    }
    else
    {
      
      $(".member-meetings").text('Vos prochains entretiens : ');
      data.forEach(element =>
      {
        meetingsList.append('<li>Le ' + moment.utc(element.dateDebut).format('LL'+' à '+'HH'+':'+'mm') + ' dans la salle n°' + element.fk_idSalle + ' avec le jury n°' + element.Jury_idJury + '</li>');
      });
    }
    
  });
});
