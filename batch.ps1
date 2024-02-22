
$extension = "gltf"
$files = Get-ChildItem "C:\Projects\HomeOutside ModelsConverterAndUploader\AR models\Destination" -Recurse -Include ('*.gltf', '*.glb')

for ($i = 0; $i -lt $files.Count; $i++) {
   
  $folderFullName = (get-item $files[$i] ).Directory.Parent.FullName.replace('\', '/')  
  $folderName = (get-item $files[$i] ).Directory.Parent

  $fileName = $files[$i].basename
  $fileNameEx = $files[$i].Name


  $newFolder = "$folderFullName/usdz"

  $extension = $files[$i].Extension.replace('.', '')  

  Write-Host  $extension
  Write-Host $folderFullName   
  # Write-Host $fileName
  # Write-Host $newFolder

  $folderExists = Test-Path $newFolder -PathType Container

  if ($folderExists) {
  }
  else {
    New-Item -Path  $newFolder -ItemType Directory
  }


  docker run --rm -v "$($folderFullName):/usr/app"leon/usd-from-gltf:latest "$extension/$fileNameEx" "usdz/$fileName.usdz"

  gltf-pipeline  -i "$($folderFullName)/$extension/$fileNameEx" -o "$($folderFullName)/$extension/$($fileName)_commpressed.glb" -d --draco.compressionLevel=7

  Remove-Item "$($folderFullName)/$extension/$fileNameEx"

  Rename-Item -Path "$($folderFullName)/$extension/$($fileName)_commpressed.glb"  -NewName $fileNameEx
}