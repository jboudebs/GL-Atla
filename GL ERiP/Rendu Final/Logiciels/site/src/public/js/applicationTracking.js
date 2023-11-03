$(document).ready(function()
{
  $("a[href$='/applicationTracking']").css("color","white");

  $.get('/api/user_files').then(function(files)
  {
    if( (files.CV==0) && (files.ID==0) && (files.LM==0) )
    {
      $('.member-status').text('En attente de vos documents');
    }
    if( files.CV==0 )
    {
      $('.member-status').text('Il vous manque les documents suivant : ');
      $('.filesMissing').append('<li>Votre CV</li>');
    }
    if( files.ID==0 )
    {
      $('.member-status').text('Il vous manque les documents suivant : ');
      $('.filesMissing').append('<li>Votre carte d\'identité</li>');
    }
    if( files.LM==0)
    {
      $('.member-status').text('Il vous manque les documents suivant : ');
      $('.filesMissing').append('<li>Votre lettre de motivation</li>');
    }
    if( (files.CV==1) && (files.ID==1) && (files.LM==1) )
    {
      $.get("/api/user_status").then(function(data)
      {
        if( data.status === 'undefined' )
        {
          $(".member-status").text('En attente de validation de vos documents');
        }
        else
        {
          $(".member-status").text('Votre statut est : ' + data.status);
          if( data.status === 'Admissible')
          {
            $('.info').text("Veuillez vérifiez quotidiennement la page de suivi des entretiens");
          }
        }
      });
    }
  });
});
