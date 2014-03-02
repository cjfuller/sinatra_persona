module PersonaJS
  BUTTON_SCRIPT = <<SCRIPT
$(function() {
  $('#persona-login-button').click(function() {
    navigator.id.get(verifyAssertion);
  });

  function verifyAssertion(assertion) {
    $.ajax({
      type: 'POST',
      url: '/auth/persona_verifier',
      data: {assertion: assertion},
      success: function(res, status, xhr) {window.location.reload();},
      failure: function(res, status, xhr) {window.location.reload();}
    });
  }
});
SCRIPT

  def self.scripts_no_jquery
<<SCRIPTS
<script type="text/javascript">
#{BUTTON_SCRIPT}
</script>
<script src="https://login.persona.org/include.js"></script>
SCRIPTS
  end

  def self.scripts
    jquery = '<script src="//ajax.googleapis.com/ajax/libs/jquery/2.1.0/jquery.min.js"></script>'
    jquery + scripts_no_jquery
  end
end
