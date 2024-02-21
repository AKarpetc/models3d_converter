


$extension="fbx"
$files = Get-ChildItem "C:\Projects\HomeOutside ModelsConverterAndUploader\models04012024" -Recurse -Include ('*.fbx')

for ($i=0; $i -lt $files.Count; $i++) {
   
    $folderFullName= (get-item $files[$i] ).Directory.Parent.FullName.replace('\','/')  
    $folderName= (get-item $files[$i] ).Directory.Parent

    $fileName=$files[$i].basename
    $fileNameEx=$files[$i].Name
    $fileFullName=$files[$i].FullName

    $newFolder="$folderFullName/glb"

    $extension=$files[$i].Extension.replace('.','')  

    Write-Host $extension
    Write-Host $fileFullName 
    Write-Host $fileName
    Write-Host $newFolder

     $folderExists = Test-Path $newFolder -PathType Container

    if ($folderExists) {
    } else {
            New-Item -Path  $newFolder -ItemType Directory
     }

     .\FBX2glTF-windows-x64.exe  --input $fileFullName  `
                                 --output "$newFolder/$fileName" `
                                 -b  --khr-materials-unlit  --blend-shape-tangents --blend-shape-normals    

  }