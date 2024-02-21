param(

     [Parameter()]
     [string]$in,

     [Parameter()]
     [string]$output
 )

 Write-Host "input: $in"
 Write-Host "output: $output"


docker run  --rm -v C:/Projects/USD/usd_from_gilf_docker/docker-gltf-to-udsz/examples:/usr/app leon/usd-from-gltf:latest "$in" "$output.usdz"