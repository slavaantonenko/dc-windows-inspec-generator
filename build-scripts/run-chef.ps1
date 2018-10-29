$cookbook=$args[0]
$recipe=$args[1]
Add-Type -A 'System.IO.Compression.FileSystem'
New-Item -ItemType Directory -Path "C:\inspec-gen\$cookbook" | Out-Null
[IO.Compression.ZipFile]::ExtractToDirectory("C:\inspec-gen\mount\$cookbook.zip", "c:\inspec-gen\$cookbook\")
#Copy-Item -Path "C:\inspec-gen\$args\Cheffile" -Destination "C:\inspec-gen\Cheffile"
#Copy-Item -Path "C:\inspec-gen\$args\Berksfile" -Destination "C:\inspec-gen\Berksfile"
cd C:\inspec-gen\$cookbook
berks vendor ../cookbooks
#Move-Item -Path "berks-cookbooks" -Destination "C:\inspec-gen\cookbooks"
cd C:\inspec-gen
#Move-Item C:\inspec-gen\$args -Destination "C:\inspec-gen\cookbooks"
#librarian-chef install

$jsonfile=Get-Content "C:\inspec-gen\mount\$cookbook.json" 
if ($jsonfile.Contains("NOJSON")) {
  #$json_command=""
  chef-solo -c solo.rb -o "recipe[$cookbook::$recipe]" -W --no-color -L c:\tmp\chef.log 
}
else {
  #$json_command = "-j " + '"'+ "C:\inspec-gen\mount\$cookbook.json" + '"'
  chef-solo -c solo.rb -o "recipe[$cookbook::$recipe]" -j "C:\inspec-gen\mount\$cookbook.json" -W --no-color -L c:\tmp\chef.log 
} 

