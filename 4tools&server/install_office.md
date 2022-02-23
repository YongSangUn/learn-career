# Custom install office

1. Downloader odt.exe
   [Office Deployment Tool](https://www.microsoft.com/en-us/download/office.aspx), after running the file, specify the file to unzip the directory and then just focus on the `setup.exe` file.

2. Go to MICROSOFT to customize your configuration
   [Apps Admin Center](https://config.office.com/deploymentsettings), Download the tool to activate the office.

   - Products : Office Pro Plus 2021 Vol, all others choose none
   - Apps: **Here is the point**, choose what you need, such as Word, Excel and PowerPoint
   - Language: Select Chinese,
   - Installation: CDN+to user, upgrade Select to uninstall all previous versions.
   - Licensing: Auto accepte EULA = yes,

   The rest is whatever, finally, save the Configuration.xml file in the upper right corner.

3. Download offices by configuration.xml
   Run in terminal: `setup.exe /download Configuration.xml`, Since it downloads silently, you can check if Explorer is downloading.

4. Install offices
   Run in terminal: `setup.exe /configure Configuration.xml`, When installing, the prompt screen displays icons for the components being installed

5. Download the tool to activate the office
   Go to github and download the latest version of [Microsoft-Activation-Scripts](https://github.com/massgravel/Microsoft-Activation-Scripts/releases/) and unzip the file into a folder you want(password: 1234), `e.g D:\`

6. Activation office (e.g tool's version: 1.5)
   - Run `D:\MAS_1.5_Password_1234\MAS_1.5\All-In-One-Version\MAS_1.5_AIO_CRC32_21D20776.cmd`
   - Select `online Kms` (enter 3) according to the output below.

```cmd
       ______________________________________________________________

                 Activation Methods:

             [1] HWID        |  Permanent  |  Win 10-11
             [2] KMS38       |  Till 2038  |  Win 10-11-Server
             [3] Online KMS  |  180 Days   |  Win / Office
             __________________________________________________

             [4] Check Activation Status [vbs]
             [5] Check Activation Status [wmi]
             [6] Extras
             __________________________________________________

             [7] Read Me
             [8] Exit
       ______________________________________________________________

         Enter a menu option in the Keyboard [1,2,3,4,5,6,7,8] :
```

Okay, have fun!
