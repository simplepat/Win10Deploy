# REQUIRES ANACONDA3 TO BE INSTALLED IN %LOCALAPPDATA% PATH

Write-Host "Installing Spark..."
python .\install_spark.py

Write-Host "Setting HADOOP_HOME..."
[Environment]::SetEnvironmentVariable("HADOOP_HOME", ($env:LOCALAPPDATA+'\spark\winutils-master\hadoop-2.7.1'), "User")

Write-Host "Setting PYSPARK DRIVERS..."
[Environment]::SetEnvironmentVariable("PYSPARK_DRIVER_PYTHON", "ipython", "User")
[Environment]::SetEnvironmentVariable("PYSPARK_DRIVER_PYTHON_OPTS", "notebook", "User")
refreshenv

$sparkhome = [Environment]::GetEnvironmentVariable("SPARK_HOME", "User")

Write-Host "Adding Spark executables to PATH..."
[Environment]::SetEnvironmentVariable("PATH", ($env:Path + (';'+$sparkhome+'\bin')), "User")

Write-Host "Creating pyspark kernel for Jupyter Notebooks..."
$py4j = ls $sparkhome\python\lib\py4j-* | %{ $_.Name.Split('-')[1]; }
mkdir -p $env:LOCALAPPDATA\Anaconda3\share\jupyter\kernels\pyspark
Copy-Item -Path $env:LOCALAPPDATA\Anaconda3\share\jupyter\kernels\python3\kernel.json -Destination $env:LOCALAPPDATA\Anaconda3\share\jupyter\kernels\pyspark
$kernel = Get-Content $env:LOCALAPPDATA\Anaconda3\share\jupyter\kernels\pyspark\kernel.json | Out-String | ConvertFrom-Json
$kernel.display_name = "pyspark"
$subenv += [PSCustomObject]@{
    'SPARK_HOME'=$sparkhome;
    'PYTHONPATH'=$env:PYTHONPATH+";"+$sparkhome+"\python;"+$sparkhome+"\python\lib\py4j-"+$py4j+"-src.zip";
    'PYTHONSTARTUP'=$sparkhome+"\python\pyspark\shell.py";
    'PYSPARK_SUBMIT_ARGS'="--master local[*] --driver-memory 3g --executor-memory 2g pyspark-shell";
    'PYSPARK_PYTHON'=$kernel.argv[0]
}
$kernel | Add-Member -Type NoteProperty -Name 'env' -Value $subenv
$kerneljson = $kernel | ConvertTo-Json
$Utf8NoBomEncoding = New-Object System.Text.UTF8Encoding $False
[System.IO.File]::WriteAllLines(($env:LOCALAPPDATA+'\Anaconda3\share\jupyter\kernels\pyspark\kernel.json'), $kerneljson, $Utf8NoBomEncoding)
