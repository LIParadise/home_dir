param(
   [string]$source,
   [string]$output,
   [int]$fps,
   [int]$width
)

Function Show-Help-And-Exit {
   Write-Host "Usage: .\create_gif.ps1 -source <file> -output <gif> -fps <fps> -width <width>"
   [Environment]::Exit(255)
}

if ( [system.io.file]::exists($source) ) {
   if ( ( $fps -le 240 ) -and ( $fps -ge 5 ) ) {
      if (($width -ge 240) -and ($width -le 3940 )) {
         F:\misc_programs\ffmpeg-n5.0-latest-win64-gpl-5.0\ffmpeg-n5.0-latest-win64-gpl-5.0\bin\ffmpeg.exe `
         -i $source `
         -vf "fps=$($fps),scale=$($width):-1:flags=lanczos,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" `
         -loop 0 `
         $output
         [Environment]::Exit(0)
      }
   }
}

Show-Help-And-Exit