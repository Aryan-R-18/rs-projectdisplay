$files = @('index.html','quadruped.html','rouv.html','photogrammetry.html','amr.html')

$old = @'
        <video controls playsinline poster="assets/poster.jpg" src="assets/demo.mp4">Your browser does not support the video tag.</video>
'@

$new = @'
        <video id="projVideo" playsinline src="assets/demo.mp4" style="position:absolute;inset:0;width:100%;height:100%;cursor:pointer;">Your browser does not support the video tag.</video>
        <button class="play-btn" id="playBtn" aria-label="Play video">
          <svg viewBox="0 0 24 24" width="32" height="32"><path d="M6 4l14 8-14 8z" fill="#fff"/></svg>
        </button>
'@

foreach ($f in $files) {
  $content = Get-Content $f -Raw
  $updated = $content.Replace($old, $new)
  Set-Content $f $updated -NoNewline
  Write-Host "Updated $f"
}
