$files = @('index.html','quadruped.html','rouv.html','photogrammetry.html','amr.html')

$oldCss = '@media (hover:hover){.card:hover{transform:translateY(-3px);border-color:var(--blue)}.shot:hover{border-color:var(--red)}}'

$newCss = @'
/* play button overlay */
.play-btn{position:absolute;top:50%;left:50%;transform:translate(-50%,-50%);width:72px;height:72px;border-radius:50%;background:rgba(230,57,70,.9);border:none;cursor:pointer;display:grid;place-items:center;transition:transform .15s,background .15s;z-index:2}
.play-btn:hover{background:var(--red);transform:translate(-50%,-50%) scale(1.08)}
.play-btn.hidden{display:none}
@media (hover:hover){.card:hover{transform:translateY(-3px);border-color:var(--blue)}.shot:hover{border-color:var(--red)}}
'@

$oldJs = @'
(function(){
  var shots=[].slice.call(document.querySelectorAll('.shot')),lb=document.getElementById('lb'),box=document.getElementById('lbBox'),i=0,sx=0;
'@

$newJs = @'
(function(){
  // Video play button
  var vid=document.getElementById('projVideo'),btn=document.getElementById('playBtn');
  if(vid&&btn){
    btn.addEventListener('click',function(){vid.play();btn.classList.add('hidden');vid.setAttribute('controls','')});
    vid.addEventListener('click',function(){if(vid.paused){vid.play();btn.classList.add('hidden')}});
    vid.addEventListener('play',function(){btn.classList.add('hidden')});
    vid.addEventListener('pause',function(){btn.classList.remove('hidden')});
  }
})();
(function(){
  var shots=[].slice.call(document.querySelectorAll('.shot')),lb=document.getElementById('lb'),box=document.getElementById('lbBox'),i=0,sx=0;
'@

foreach ($f in $files) {
  $content = Get-Content $f -Raw
  $updated = $content.Replace($oldCss, $newCss).Replace($oldJs, $newJs)
  Set-Content $f $updated -NoNewline
  Write-Host "Updated $f"
}
