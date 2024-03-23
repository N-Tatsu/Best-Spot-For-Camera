// ブートストラップ ローダ
(g=>{var h,a,k,p="The Google Maps JavaScript API",c="google",l="importLibrary",q="__ib__",m=document,b=window;b=b[c]||(b[c]={});var d=b.maps||(b.maps={}),r=new Set,e=new URLSearchParams,u=()=>h||(h=new Promise(async(f,n)=>{await (a=m.createElement("script"));e.set("libraries",[...r]+"");for(k in g)e.set(k.replace(/[A-Z]/g,t=>"_"+t[0].toLowerCase()),g[k]);e.set("callback",c+".maps."+q);a.src=`https://maps.${c}apis.com/maps/api/js?`+e;d[q]=f;a.onerror=()=>h=n(Error(p+" could not load."));a.nonce=m.querySelector("script[nonce]")?.nonce||"";m.head.append(a)}));d[l]?console.warn(p+" only loads once. Ignoring:",g):d[l]=(f,...n)=>r.add(f)&&u().then(()=>d[l](f,...n))})({
  key: process.env.API_KEY
});


// ライブラリの読み込み
let map;

async function initMap() {
  const { Map } = await google.maps.importLibrary("maps");

  // 地図の中心と倍率は公式から変更しています。
  map = new Map(document.getElementById("map"), {
    center: { lat: 35.681236, lng: 139.767125 },
    zoom: 15,
    mapTypeControl: false
  });

  // マーカーの表示
  const response = await fetch("/post_images.json").then((res) => res.json()).catch(error => console.error(error))
  console.log(response.ok)
  if (response) {
    const items = response.data.items
   items.forEach((item) => {

    const marker = new google.maps.Marker({
      position: new google.maps.LatLng(item.latitude, item.longitude),
      map,
      title: item.address
    });
    // 以下、追記
    const information = new google.maps.InfoWindow({
      content: `
        <div class="information container p-0">
          <div class="mb-3 d-flex align-items-center">

            <p class="lead m-0 font-weight-bold">${item.user.name}</p>
          </div>
          <div class="mb-3">
            <img class="thumbnail" src="${item.image}" loading="lazy" width="150" height="150">
          </div>
          <div>
            <p class="text-muted">${item.address}</p>
            <p class="lead">${item.body}</p>
          </div>
        </div>
      `,
      ariaLabel: item.address,
    });
    marker.addListener("click", () => {
      information.open({
        anchor: marker,
        map,
      })
    })
  })
}
}

initMap()