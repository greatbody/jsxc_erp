/*
  since:2016-12-30
 */
$(function() {
  $('div.contact-box').each(function() {
    var $ctx = $(this);
    $ctx.html('...');
    $ctx.show();
    setTimeout(asynLog, 500, $ctx);
  });

  function asynLog($contaxt) {
    $.post('/students/' + $contaxt.data('id') + '/has_contact_task', {
    }).success(function(data) {
      if (data && data.msg_code == 'success') {
        if (data.msg_text) {
          $contaxt.html(data.msg_text);
          $contaxt.show();
        } else {
          $contaxt.hide();
        }
      } else {
        $contaxt.hide();
      }
    }).error(function(data) {
      console.log('发送消息错误，请联系管理员！');
    });
  }
});
