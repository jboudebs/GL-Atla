$(document).ready(function()
{
  // Getting references to our form and input
  const signUpForm = $("form.signup");
  const emailInput = $("input#email-input");
  const passwordInput = $("input#password-input");
  const firstNameInput = $('input#firstname-input');
  const lastNameInput = $('input#lastname-input');

  // When the signup button is clicked, we validate the email and password are not blank
  signUpForm.on("submit", function(event) 
  {
    event.preventDefault();
    var userData =
    {
      lastName: lastNameInput.val().trim(),
      firstName: firstNameInput.val().trim(),
      email: emailInput.val().trim(),
      password: passwordInput.val().trim()
    };

    if (!userData.lastName || !userData.firstName ||!userData.email || !userData.password)
    {
      return;
    }
    // If we have an email and password, run the signUpUser function
    signUpUser(userData);
    firstNameInput.val('');
    lastNameInput.val('');
    emailInput.val('');
    passwordInput.val('');
  });

  
  // Does a post to the signup route. If succesful, we are redirected to the members page
  // Otherwise we log any errors
  function signUpUser(userData)
  {
    $.post("/api/signup",
    {
      lastName: userData.lastName,
      firstName: userData.firstName,
      email: userData.email,
      password: userData.password
    })
    .then(function(data)
    {
      if(data.error != undefined)
      {
        handleLoginErr(data.error);
        return
      }
      
      window.location.replace(data);
      // If there's an error, handle it by throwing up a boostrap alert
    });
  }

  function handleLoginErr(errorMessage)
  {
    console.log('>>>> ' + errorMessage);
    $("#alert .msg").text(errorMessage);
    $("#alert").fadeIn(500);
    
  }
});
