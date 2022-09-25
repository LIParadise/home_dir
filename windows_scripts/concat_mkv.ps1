param(
   [Parameter(Mandatory = $True)]
   [string]$output,
   [Parameter(Mandatory = $True)]
   [string[]]$sources
)

Function Show-Help-And-Exit {
   Write-Host "Usage: .\concat_mkv.ps1 -output <output.mkv> -sources <first.mkv>[,second.mkv][,third.mkv][,...]"
   Write-Host "Try the following if weird things happen"
   Write-Host "powershell -executionpolicy bypass -command <concat_mkv.ps1> (ry)"
   [Environment]::Exit(255)
}

Function Test-Filename {
   param (
      [Parameter(Mandatory = $True)][string[]]$sources,
      [Parameter(Mandatory = $True)][string]$output
   )
   foreach ($source in $sources) {
      if ( (-not [system.io.file]::exists($source) ) -or (-not $source -match '\.mkv$') -or (-not $output -match '\.mkv$' ) ) {
         return $false
      }
   }
   return $true
}

if ( Test-Filename -sources $sources -output $output) {
   # Shamelessly stolen from [reddit](https://www.reddit.com/r/PowerShell/comments/qrl5cy/comment/hk7crhs)
   try {
      # TempFileCollection manages your temp files and deletes them when it is disposed. 
      $tempFiles = [CodeDom.Compiler.TempFileCollection]::new()
      
      # TempFileCollection doesn't create your temp files for you, you gotta do that yourself. 
      $file = New-TemporaryFile
      
      # and you gotta remember to tell TempFileCollection about this new file. 
      $tempFiles.AddFile($file.FullName, $false)

      # now you can use $file
      $sources = $sources | ForEach-Object { "file '$_'" }
      $sources | out-file -encoding ascii -append $file
      #get-content $file
      F:\misc_programs\ffmpeg-2022-08-25-git-9bf9d42d01-full_build\bin\ffmpeg.exe `
         -v verbose -hide_banner `
         -threads 4 -hwaccel nvdec `
         -hwaccel_output_format cuda `
         -loglevel info -f concat -safe 0 -i $file -c copy -y $output
   }
   finally {
      # when you dispose the TempFileCollection, it will delete all the files you added to it. 
      if ($null -ne $tempFiles) {
         $tempFiles.Dispose() #Deletes all temp files
      } 
   }
}
else {
   Show-Help-And-Exit
}