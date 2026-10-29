$files = @('index.html','quadruped.html','rouv.html','photogrammetry.html','amr.html')

$old = @'
        <!-- EDIT: delete .ph below and use ONE of these:
          <video controls playsinline poster="assets/poster.jpg" src="assets/demo.mp4"></video>
          <iframe src="https://www.youtube.com/embed/VIDEO_ID" title="Project demo" allowfullscreen loading="lazy"></iframe>
        -->
        <video controls playsinline poster="assets/poster.jpg" src="assets/demo.mp4" style="position:absolute;inset:0;width:100%;height:100%;">Your browser does not support the video tag.</video>
'@

$new = @'
        <video controls playsinline poster="assets/poster.jpg" src="assets/demo.mp4">Your browser does not support the video tag.</video>
'@

foreach ($f in $files) {
  $content = Get-Content $f -Raw
  $updated = $content.Replace($old, $new)
  Set-Content $f $updated -NoNewline
  Write-Host "Updated $f"
}
