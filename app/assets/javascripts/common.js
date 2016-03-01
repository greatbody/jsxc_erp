//public objects
//by shaotu tech
//written:sunrui 2015-06-18 11:12

if ((typeof pages) == 'undefined') {
  pages = {};
}

var __sto = setTimeout;　　
window.setTimeout = function(callback, timeout, param)　　 {　　
  var args = Array.prototype.slice.call(arguments, 2);　　
  var _cb = function()　　 {　　
    callback.apply(null, args);　　
  }　　
  __sto(_cb, timeout);　　
};

(function(p) {
  //local params
  p.common = {
    initLink: function(name, className) {
      $(document).delegate(name, 'touchstart', function() {
        $(this).addClass(className);
      });

      $(document).delegate(name, 'touchmove', function() {
        $(this).removeClass(className);
      });

      $(document).delegate(name, 'touchend', function() {
        $(this).removeClass(className);
      });
    },
    showFlashText: function(id, text, nheight) {
      var height = nheight || 100;
      var width = 200;
      var clientWidth = document.body.clientWidth;
      var clientHeight = document.body.clientHeight;
      var left = (clientWidth - width) / 2;
      var top = (clientHeight - height) / 2;
      var flashDom = {
        'tagName': 'div',
        'attributes': {
          'id': id,
          'style': 'display: none;z-index: 999;position: fixed;left: ' + left + 'px;top: ' + top + 'px;background-color: #a6a6a6;opacity: 0.9;width: ' + width + 'px;height: ' + height + 'px;border-radius: 5px;'
        },
        'children': [{
          'tagName': 'img',
          'attributes': {
            'src': '/flash-loding.gif',
            'style': 'width: 50px;height: 50px;display: block;margin: auto;margin-top: 10px;'
          }
        }, {
          'tagName': 'div',
          'attributes': {
            'style': 'text-align: center;margin-top: 5px;color: #fff;'
          },
          'content': text
        }]
      };
      $(document.body).append(p.common.json2html(flashDom));
      return {
        close: function() {
          $('#' + id).remove();
        },
        hide: function() {
          $('#' + id).hide();
        },
        show: function(new_content) {
          var loadingLayer = $('#' + id);
          var height = parseFloat(loadingLayer.css('height').replace(/px/,''));
          var width = parseFloat(loadingLayer.css('width').replace(/px/,''));;
          var clientWidth = document.body.clientWidth;
          var clientHeight = document.body.clientHeight;
          var left = (clientWidth - width) / 2;
          var top = (clientHeight - height) / 2;
          loadingLayer.css('left', left);
          loadingLayer.css('top', top);
          loadingLayer.find('div').html(new_content)
          loadingLayer.show();
        }
      };
    },
    /**
     * 设置图像上传前的预览
     * @param  {String} upload_field_id [表单中的上传字段id]
     * @param  {String} preview_img_id  [预览的div的id]
     * @return {void}                 [void]
     */
    imgPreView: function(upload_field_id, preview_img_id, callback) {
      $('#' + upload_field_id).on('change', function(event) {
        var files = event.target.files;
        if (files.length <= 0) {
          return;
        }
        var image = files[0]
        if (image.type.toLocaleString().indexOf('image') < 0) {
          return;
        }
        var reader = new FileReader();
        reader.onload = function(file) {
          var img = new Image();
          img.src = file.target.result;
          if (callback) {
            callback(img);
          }
          $(img).addClass('icon');
          $('#' + preview_img_id).html(img.outerHTML);
        }
        reader.readAsDataURL(image);
      });
    },
    imgView: function(upload_field_id, preview_img_id, callback) {
      $(document).delegate('#' + upload_field_id, 'change', function(event) {
        var files = event.target.files;
        if (files.length <= 0) {
          return;
        }
        var image = files[0]
        if (image.type.toLocaleString().indexOf('image') < 0) {
          return;
        }
        var reader = new FileReader();
        var preview_div = $('#' + preview_img_id)[0];
        reader.onload = function(file) {
          var img = new Image();
          img.src = file.target.result;
          if (callback) {
            callback(img, preview_div);
          }
          $('#' + preview_img_id).html(img.outerHTML);
        }
        reader.readAsDataURL(image);
      });
    },
    setImgCenter: function(img, div) {
      _setImgCenter(img, div);
    },
    initImageCut: function(rate, ratio) {
      //init image cut
      _bindImg(rate, ratio);
    },
    json2html: function(json) {
      return _json_2_html(json);
    },
    getDistance: function(lat1, lng1, lat2, lng2) {
      return _getDistance(lat1, lng1, lat2, lng2);
    },
    bindScroll: function(container) {
      $(container).on('touchmove', function(e) {
        var touch = event.targetTouches[0];
        var content = container;
        content.scrollTop = window.lastScrollTop + (window.lastY - touch.pageY) * 1.5;
        window.lastScrollTop = content.scrollTop
        window.lastY = touch.pageY;
        e.preventDefault();
      });

      $(container).on('touchstart', function(e) {
        var touch = event.targetTouches[0];
        var content = container;
        window.lastScrollTop = content.scrollTop;
        window.lastY = touch.pageY;
      });
    },
    async_loadjs: _async_loadjs,
    data: {
      pictureCut: {
        imgOrigin: 0
      }
    },
    WeiXin: {
      init: function() {
        _init_weixin();
      },
      /**
       * 获取经纬度
       * @param  {[type]} func [回调函数]
       * @return {[type]}      [无返回值]
       */
      getLocation: function(func) {
        wx.getLocation({
          type: 'gcj02',
          success: function(res) {
            var latitude = res.latitude; // 纬度，浮点数，范围为90 ~ -90
            var longitude = res.longitude; // 经度，浮点数，范围为180 ~ -180。
            var speed = res.speed; // 速度，以米/每秒计
            var accuracy = res.accuracy; // 位置精度
            // alert('latitude:' + latitude + '\nlongitude:' + longitude + '\nspeed:' + speed + '\naccuracy:' + accuracy);
            if (typeof func == 'function') {
              func(longitude, latitude);
            }
          },
          fail: function() {
            func(-1, -1);
          }
        });
      },
      showInMap: function(option) {
        //show point using Tencent Map Service
        //longitude, latitude
        wx.openLocation({
          latitude: option.latitude,
          longitude: option.longitude,
          name: option.name,
          address: option.address,
          scale: 19,
          infoUrl: 'http://weixin.qq.com'
        });
      }
    },
    Cookie: {
      getCookie: function(field) {　　　　
        if (document.cookie.length > 0) {
          //先查询cookie是否为空，为空就return ""
          c_start = document.cookie.indexOf(field + "=");
          //通过String对象的indexOf()来检查这个cookie是否存在，不存在就为 -1　　
          if (c_start != -1) {　　　　　　　　
            //最后这个+1其实就是表示"="号啦，这样就获取到了cookie值的开始位置
            c_start = c_start + field.length + 1
              //其实我刚看见indexOf()第二个参数的时候猛然有点晕，后来想起来表示指定的开始索引的位置...这句是为了得到值的结束位置。因为需要考虑是否是最后一项，所以通过";"号是否存在来判断
            c_end = document.cookie.indexOf(";", c_start);
            if (c_end == -1) {
              c_end = document.cookie.length;
            }
            //通过substring()得到了值。想了解unescape()得先知道escape()是做什么的，都是很重要的基础，想了解的可以搜索下，在文章结尾处也会进行讲解cookie编码细节
            return unescape(document.cookie.substring(c_start, c_end))
          }　　　　
        }　　　　
        return "";
      },
      setCookie: function(key, value, expiredays) {
        var exdate = new Date();
        expiredays = (typeof expiredays == 'undefined' ? 1 : expiredays);
        exdate.setDate(exdate.getDate() + expiredays);
        document.cookie = key + "=" + escape(value) + ((expiredays == null) ? "" : ";expires=" + exdate.toGMTString());
      }
    },
    validateFac: {
      create: function() {
        return {
          VarifyList: [],
          varify: function() {
            if (this.VarifyList.length > 0) {
              var i;
              for (i = 0; i < this.VarifyList.length; i++) {
                var oItem = this.VarifyList[i];
                if (typeof oItem.function == 'function') {
                  if (oItem['function'](oItem.data) == false) {
                    return false;
                  }
                } else {
                  if (!oItem.data || oItem.data.length == 0) {
                    alert(oItem.msg + "不能为空！");
                    return false;
                  }
                }
              }
            }
            return true;
          },
          regVar: function(value, message, func) {
            var oItem = {
              "data": value,
              "msg": message,
              "function": func
            };
            this.VarifyList.push(oItem);
          },
          clear: function() {
            this.VarifyList.length = 0;
          }
        };
      }
    }
  };
  p.version = {
    ver: '0.0.1'
  };
  //local function
  function _init_weixin() {
    window.define = null;
    window.require = null;

    //微信预留接口，尚未开放
    // wx.checkJsApi({
    //   jsApiList: [],
    //   success: function(res) {
    //     alert(res);
    //   }
    // });
  }

  function _json_2_html(structure_code) {
    structure_code['tagName'] = structure_code['tagName'] ? structure_code['tagName'] : 'div';
    structure_code['content'] = structure_code['content'] ? structure_code['content'] : '';
    structure_code['attributes'] = structure_code['attributes'] ? structure_code['attributes'] : [];
    structure_code['children'] = structure_code['children'] ? structure_code['children'] : [];
    var baseDom = document.createElement(structure_code.tagName);
    $(structure_code.attributes).each(function() {
      for (var key in this) {
        $(baseDom).attr(key, this[key])
      };
    });
    $(structure_code.children).each(function() {
      $(baseDom).append(_json_2_html(this));
    });
    $(baseDom).append(structure_code.content);
    return baseDom;
  }

  function _setImgCenter(img, div) {
    var css_len = function(jqObject, cssAttr) {
      return parseInt(jqObject.css('border-' + cssAttr + '-width').replace(/px/,''),10);
    }

    var img_jq = $(img);
    var div_jq;
    if (div) {
      div_jq = $(div);
    } else {
      div_jq = $(img.parentNode);
    }

    var img_width = img.naturalWidth;
    var img_height = img.naturalHeight;

    var div_border_width = css_len(div_jq, 'left') + css_len(div_jq, 'right');
    var div_border_height = css_len(div_jq, 'top') + css_len(div_jq, 'bottom');

    var div_height = parseInt(div_jq.css('height').replace(/px/,''),10) - div_border_height;
    var div_width = parseInt(div_jq.css('width').replace(/px/,''),10) - div_border_width;
    //step one:calculate new img width,height

    if ((img_height / img_width) > (div_height / div_width)) {
      //make the height proper
      var new_img_width = (img_width * div_height) / img_height;
      var new_img_height = div_height
    } else {
      //make the width proper
      var new_img_height = (div_width * img_height) / img_width;
      var new_img_width = div_width
    }
    //remove css
    $(img).attr('style','');
    //begin new css
    $(img).css('display', 'block');
    $(img).css('width', new_img_width);
    $(img).css('height', new_img_height);
    //offset
    $(img).css('margin', '0 auto');
    $(img).css('margin-top', (div_height - new_img_height) / 2);
  }

  function _bindImg(rate, ratio) {
    var $image = $('.img-container > img'),
      $dataX = $('#crop_x'),
      $dataY = $('#crop_y'),
      $dataHeight = $('#crop_h'),
      $dataWidth = $('#crop_w'),
      $dataRotate = $('#dataRotate'),
      options = {
        aspectRatio: (rate ? rate : 1),
        preview: '.img-preview',
        crop: function(data) {
          // var ratio = (rate ? (rate['ratio'] ? rate['ratio'] : 1) : 1);
          if (!ratio) {
            ratio = 1;
          }
          ratio = 1;
          $dataX.val(Math.floor(data.x * ratio));
          $dataY.val(Math.floor(data.y * ratio));
          $dataHeight.val(Math.floor(data.height * ratio));
          $dataWidth.val(Math.floor(data.width * ratio));
          $dataRotate.val(Math.floor(data.rotate * ratio));
        }
      };

    //必须有，这个如果没有，无法有拖动效果
    $image.on({
      'build.cropper': function(e) {},
      'built.cropper': function(e) {

      },
      'dragstart.cropper': function(e) {

      },
      'dragmove.cropper': function(e) {

      },
      'dragend.cropper': function(e) {

      },
      'zoomin.cropper': function(e) {

      },
      'zoomout.cropper': function(e) {

      }
    }).cropper(options);
    // 绑定给键盘按键微调使用
    $(document.body).on('click', '[data-method]', function() {
      var data = $(this).data(),
        $target,
        result;

      if (data.method) {
        data = $.extend({}, data); // Clone a new one

        if (typeof data.target !== 'undefined') {
          $target = $(data.target);

          if (typeof data.option === 'undefined') {
            try {
              data.option = JSON.parse($target.val());
            } catch (e) {
              console.log(e.message);
            }
          }
        }

        result = $image.cropper(data.method, data.option);

        if (data.method === 'getCroppedCanvas') {
          $('#getCroppedCanvasModal').modal().find('.modal-body').html(result);
        }

        if ($.isPlainObject(result) && $target) {
          try {
            $target.val(JSON.stringify(result));
          } catch (e) {
            console.log(e.message);
          }
        }

      }
    }).on('keydown', function(e) {
      //这里就是方向键的处理
      switch (e.which) {
        case 37:
          e.preventDefault();
          $image.cropper('move', -1, 0);
          break;

        case 38:
          e.preventDefault();
          $image.cropper('move', 0, -1);
          break;

        case 39:
          e.preventDefault();
          $image.cropper('move', 1, 0);
          break;

        case 40:
          e.preventDefault();
          $image.cropper('move', 0, 1);
          break;
      }
    });
  }

  function _toRad(d) {
    return d * Math.PI / 180;
  }

  function _getDistance(lat1, lng1, lat2, lng2) {
    // alert('myLatitude:' + lat1 + ' myLongitude:' + lng1 + ', latitude:' + lat2 + ', longitude:' + lng2);
    var dis = 0;
    var radLat1 = _toRad(lat1);
    var radLat2 = _toRad(lat2);
    var deltaLat = radLat1 - radLat2;
    var deltaLng = _toRad(lng1) - _toRad(lng2);
    var dis = 2 * Math.asin(Math.sqrt(Math.pow(Math.sin(deltaLat / 2), 2) + Math.cos(radLat1) * Math.cos(radLat2) * Math.pow(Math.sin(deltaLng / 2), 2)));
    return dis * 6378137;
  }

  /**
   * 异步加载代码，加载完成后执行回调函数
   * @param  {[type]}   js_url   [description]
   * @param  {Function} callback [description]
   * @return {[type]}            [description]
   */
  function _async_loadjs(js_url, callback) {
    var _doc = document.getElementsByTagName('script')[0];
    var script = document.createElement('script');
    script.setAttribute('type', 'text/javascript');
    script.setAttribute('src', js_url);
    script.onload = script.onreadystatechange = function() {
      if (!this.readyState || this.readyState == 'loaded' || this.readyState == 'complete') {
        callback();
      };
    }
    _doc.parentNode.insertBefore(script, _doc);
  }
})(pages);
