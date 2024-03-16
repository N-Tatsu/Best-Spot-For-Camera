import "jquery-jpostal-ja"

// 郵便番号を入力すると自動で住所に変換してくれる
function imo() {
  $('#zipcode').jpostal({
    postcode : ['#zipcode'],
    address : {
      '#post_image_address': '%3%4%5'
    }
  });
}
$(document).on("turbolinks:load", imo);