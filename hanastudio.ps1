
param (
    
        [string]$baseUri
    )
    
    #Get the bits for the HANA installation and copy them to C:\SAPbits\SAP_HANA_STUDIO\
    $hanadest = "C:\SapBits"
    $sapcarUri = $baseUri + "/SaPBits/SAP_HANA_STUDIO/sapcar.exe" 
    $hanastudioUri = $baseUri + "/SaPBits/SAP_HANA_STUDIO/IMC_STUDIO2_212_4-80000323.SAR" 
    $jreUri = $baseUri + "/SaPBits/SAP_HANA_STUDIO/serverjre-9.0.4_windows-x64_bin.tar.gz" 
    $7zUri = "http://www.7-zip.org/a/7z1701-x64.msi"
    $swpmUri = $baseUri + "/SaPBits/SapBits/SWPM10SP22_2-20009707.SAR"
    $sshUri = $baseUri + "/SaPBits/SapBits/MobaXterm_Installer_v10.4.zip"
    $sapcardest = "C:\SapBits\SAP_HANA_STUDIO\sapcar.exe"
    $hanastudiodest = "C:\SapBits\SAP_HANA_STUDIO\IMC_STUDIO2_212_4-80000323.SAR"
    $jredest = "C:\SapBits\serverjre-9.0.4_windows-x64_bin.tar.gz"
    $swpmdest = "C:\SapBits\SWPM\SWPM10SP22_2-20009707.SAR"
    $sshdest = "C:\SapBits\MobaXterm_Installer_v10.4.zip"
    $7zdest = "C:\SapBits\7z.msi"
    $jrepath = "C:\SapBits"
    $hanapath = "C:\SapBits\SAP_HANA_STUDIO"
    $hanajack = "C:\SapBits\SWPM"
    if((test-path $hanadest) -eq $false)
    {
        New-Item -Path $hanadest -ItemType directory
        New-item -Path $hanapath -itemtype directory
        New-item -Path $hanajack -itemtype directory
    }
    write-host "downloading files"
    Invoke-WebRequest $sapcarUri -OutFile $sapcardest
    Invoke-WebRequest $hanastudioUri -OutFile $hanastudiodest
    Invoke-WebRequest $swpmUri -OutFile $swpmdest
    Invoke-WebRequest $jreUri -OutFile $jredest
    Invoke-WebRequest $7zUri -OutFile $7zdest
    Invoke-WebRequest $sshUri -OutFile $sshdest    
    
    cd $jrepath
    .\7z.msi /quiet
    cd "C:\Program Files\7-Zip\"
    .\7z.exe e -y "C:\SapBits\serverjre-9.0.4_windows-x64_bin.tar.gz" "-oC:\SapBits"
    .\7z.exe x -y "C:\SapBits\serverjre-9.0.4_windows-x64_bin.tar" "-oC:\SapBits"
    .\7z.exe x -y "C:\SapBits\MobaXterm_Installer_v10.4.zip" "-oC:\SapBits"
    cd $jrepath
    .\MobaXterm_installer.msi /quiet
    
    cd $hanapath
    
    .\sapcar.exe -xfv IMC_STUDIO2_212_4-80000323.SAR
    cd $hanajack
    \SapBits\SAP_HANA_STUDIO\sapcar.exe -xvf SWPM10SP22_2-20009707.SAR
    
    set PATH=%PATH%C:\Program Files\jdk-9.0.4\bin;
    set HDB_INSTALLER_TRACE_FILE=C:\Users\testuser\Documents\hdbinst.log
    cd C:\SAPbits\SAP_HANA_STUDIO\SAP_HANA_STUDIO\
    .\hdbinst.exe -a C:\SAPbits\SAP_HANA_STUDIO\SAP_HANA_STUDIO\studio -b --path="C:\Program Files\sap\hdbstudio"

    cd C:\SAPbits\SWPM
    
