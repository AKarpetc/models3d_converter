
$extension = "gltf"
$files = Get-ChildItem "C:\My\Projects\Models\CenteredModels" -Recurse -Include ('*.gltf', '*.glb')

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
    # New-Item -Path  $newFolder -ItemType Directory
  }

  #AR uzdz converter
  docker run --rm -v "$($folderFullName):/usr/app"leon/usd-from-gltf:latest "$extension/$fileNameEx" "usdz/$fileName.usdz"

  gltf-transform optimize "$($folderFullName)/$extension/$fileNameEx" "$($folderFullName)/$extension/$($fileName)_commpressed2.glb"  --texture-compress webp


  Rename-Item -Path "$($folderFullName)/$extension/$fileNameEx"  -NewName "$($fileNameEx)_not_Compressed"
  Rename-Item -Path "$($folderFullName)/$extension/$($fileName)_commpressed2.glb"  -NewName $fileNameEx
}