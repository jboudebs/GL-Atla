$(document).ready(function()
{
    $("a[href$='/filesDeposit']").css("color","white");

    const allForms = document.querySelectorAll('.uploadForm');

    /* Prevent every forms to change the page */
    allForms.forEach( option =>
    {
        $(option).submit( event =>
        {
            event.preventDefault();
            
            var formAction = $(option).attr('action');
            var formData = new FormData(option);
            
            $.ajax(
            {
                type: "POST",
                url: formAction,
                data: formData,
                processData: false,
                contentType: false,
                success: function(r)
                {
                    switch( formAction )
                    {
                        case '/api/uploadID':
                            $(option).children('.ID').text('Votre carte d\'identité a été déposée.');
                            $('#label-span-ID').text("Choissisez votre carte d\'identité");
                            break;
                        case '/api/uploadCV':
                            $(option).children('.CV').text('Votre CV a été déposé.');
                            $('#label-span-CV').text("Choissisez votre CV");
                            break;
                        case '/api/uploadMotivationLetter':
                            $(option).children('.LM').text('Votre lettre de motivation a été déposée.');
                            $('#label-span-LM').text("Choissisez votre lettre de motivation");
                            break;
                        case '/api/uploadSchoolReport':
                            $(option).children('.SR').text('Votre relevé de notes a été déposé.');
                            $('#label-span-SR').text("Choissisez votre relevé de notes");
                            break;
                    }
                },
                error: function (e)
                {
                    console.log("some error", e);
                }
            });
        });
    });
       

    $.get("/api/user_files").then(function(data)
    {
        if(data.CV == 1)
        {
            $('.CV').text('Votre CV est déposé.');
        }
        if(data.ID == 1)
        {
            $('.ID').text('Votre carte d\'identité est déposée.');
        }
        if(data.LM == 1)
        {
            $('.LM').text('Votre lettre de motivation est déposée.');
        }
        if(data.SR == 1)
        {
            $('.SR').text('Votre relevé de note est déposé.');
        }
    });


    $('#inputID').on('change',(e)=>
    {
        var fileName = e.target.value.split('\\').pop();
        $('#label-span-ID').text(fileName);
    });

    $('#inputCV').on('change',(e)=>
    {
        var fileName = e.target.value.split('\\').pop();
        $('#label-span-CV').text(fileName);
    });

    $('#inputLM').on('change',(e)=>
    {
        var fileName = e.target.value.split('\\').pop();
        $('#label-span-LM').text(fileName);
    });

    $('#inputSR').on('change',(e)=>
    {
        var fileName = e.target.value.split('\\').pop();
        $('#label-span-SR').text(fileName);
    });

 });