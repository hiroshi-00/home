$(document).on('turbolinks:load', 

  function() { 

    
    
    function appendOption(category) {
      let html = `<option value='${category.id}' data-category='${category.id}'>${category.name}</option>`;
      return html;
    }
  
    function appendChidrenBox(insertHTML) {
      let childrenSelectHtml = '';
      childrenSelectHtml = `
        <div id='children-wrapper' class = "form-group">
          <select id='children-category' class='form-control' name='[children_id]'>
            <option value='---' data-category='---'>---</option>
            ${insertHTML}
          </select>
          <i class='fas fa-chevron-down'></i>
        </div>
      `;
      $('.category-form').append(childrenSelectHtml);
    }
  
    function appendGrandchidrenBox(insertHTML) {
      let grandchildrenSelectHtml = '';
      grandchildrenSelectHtml = `
        <div id='grandchildren-wrapper'>
          <select id='grandchildren-category' class='form-control' name='[grandchildren_id]'>
            <option value='---' data-category='---'>---</option>
            ${insertHTML}
          </select>
        </div>
      `;
      $('.category-form').append(grandchildrenSelectHtml);
    }
   
    // 親カテゴリーが選択された時に発火する。
    $('#parent-category').on('change', function() {
      let parentId = document.getElementById('parent-category').value;
      if (parentId == '104') {
        $('#children-wrapper').remove();
        $('#grandchildren-wrapper').remove();
        $(".dress_form").collapse('show');
      } else if (parentId == '105') {
        $('#children-wrapper').remove();
        $('#grandchildren-wrapper').remove();
        $(".medal_form").collapse('show');
      } else if (parentId != '---') {
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
            $('#grandchildren-wrapper').remove();
            let insertHTML = '';
            children.forEach(function(children) {
              insertHTML += appendOption(children);
            });
            appendChidrenBox(insertHTML);
          })
          .fail(function() {
            alert('ジャンル取得に失敗しました');
          });
      } else {
        $('#child_form_remove').remove();
        $('#grand_form_remove').remove();
        $('#children-wrapper').remove();
        $('#grandchildren-wrapper').remove();
      }
    });
  
    $('.category-form').on('change', '#children-category', function() {
      let childrenId = $('#children-category option:selected').data('category');
      if (childrenId == '96') {
        $('#grandchildren-wrapper').remove();
        $(".touteki_form").collapse('show');
      } else if (childrenId == '79' || childrenId == '83' || childrenId == '84') {
        $('#grandchildren-wrapper').remove();
        $(".weapon_form").collapse('show');
      } else if (childrenId != '---') {
        $.ajax({
          url: '/dashboard/get_category/grandchildren',
          type: 'GET',
          data: {
            children_id: childrenId,
          },
          dataType: 'json',
        })
          .done(function(grandchildren) {
            if (grandchildren.length != 0) {
              $('#grandchildren-wrapper').remove();
              let insertHTML = '';
              grandchildren.forEach(function(grandchildren) {
                insertHTML += appendOption(grandchildren);
              });
              appendGrandchidrenBox(insertHTML);
            }
          })
          .fail(function() {
            alert('ジャンル取得に失敗しました');
          });
      } else {
        $('#grandchildren-wrapper').remove();
      }
    });
    
    $('.category-form').on('change','#grandchildren-category', function() {
      let grandchildrenId = $('#grandchildren-category option:selected').data('category');
      if (grandchildrenId == '81')  {
        console.log("拡散銃・単発");
        $(".kakusann_tannpatu").collapse('show');
      } else if (grandchildrenId == '82') {
        console.log("拡散銃・多発");
        $(".kakusann_tahatu").collapse('show');
      } else if (grandchildrenId == '98' || grandchildrenId == '99'|| grandchildrenId == '100' || grandchildrenId == '101' || grandchildrenId == '102' || grandchildrenId == '103') {
        console.log("設置・人形");
        $(".secchi").collapse('show');
      } else {
        $(".weapon_form").collapse('show');
      }
    });
    
});