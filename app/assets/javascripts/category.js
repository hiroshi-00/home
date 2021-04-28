$(document).on('turbolinks:load', 

  function() { 
    
    function appendOption(category) {
      let html = `<option value='${category.id}' data-category='${category.id}'>${category.name}</option>`;
      return html;
    }
    
    function appendChidrenBox(insertHTML) {
      let childrenSelectHtml = '';
      childrenSelectHtml = `
        <div id='children-wrapper' class = "form-group mt-3">
          <label>子カテゴリー</label>
          <input id='children-category' class='form-control' name='[name]'>
        </div>
      `;
      $('.category-form').append(childrenSelectHtml);
    }
     
    // 親カテゴリーが選択された時に発火する。
    $('#parent-category').on('change', function() {
      let parentId = document.getElementById('parent-category').value;
      if (parentId != '---') {
        $.ajax({
          url: ' /dashboard/get_category/children',
          type: 'GET',
          data: {
            parent_id: parentId,
          },
          dataType: 'json',
        })
          .done(function(children) {
            $('#children-wrapper').remove();
            
            let insertHTML = '';
            children.forEach(function(children) {
              insertHTML += appendOption(children);
            });
            appendChidrenBox(insertHTML);
          })
          .fail(function() {
            alert('ジャンル取得に失敗しました');
          });
      }
    });
  
  
    
  }
);