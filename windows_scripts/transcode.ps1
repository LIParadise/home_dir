param(
   [string]$source,
   [string]$output,
   [int]$b,
   [int]$maxrate,
   [int]$width
)

Function Show-Help-And-Exit {
   Write-Host "Usage: .\transcode.ps1 -source -output -b -maxrate -width"
   [Environment]::Exit(255)
}

if ( [system.io.file]::exists($source) ) {
   if ( $maxrate -ge $b ) {
      if (($width -ge 240) -and ($width -le 3940 )) {
         F:\misc_programs\ffmpeg-2022-08-25-git-9bf9d42d01-full_build\bin\ffmpeg.exe `
            -v verbose -hide_banner `
            -threads 1 -hwaccel nvdec `
            -hwaccel_output_format cuda `
            -i $($source) `
            -vf "scale_cuda=`"$($width):-1:interp_algo=lanczos`"" `
            -c:a copy `
            -c:v hevc_nvenc -preset slow -rc vbr -rc-lookahead 120 -multipass 2 -b:v $($b) -maxrate:v $($maxrate) `
            -movflags +faststart -f matroska `
         $($output) -y
         [Environment]::Exit(0)
      }
   }
}
Show-Help-And-Exit