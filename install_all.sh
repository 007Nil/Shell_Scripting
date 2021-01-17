#!/bin/bash
#===============================================================================
#
#          FILE:  install_all.sh
# 
#         USAGE:  ./install_all.sh 
# 
#   DESCRIPTION:  
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  install my requried software for ubuntu
#        AUTHOR:  Sagnik Sarkar
#        EMAIL:   sagniksarkar@ymail.com  
#       COMPANY:  
#       VERSION:  1.0
#       CREATED:  17/01/21 03:22:29 PM IST IST
#      REVISION:  ---
#===============================================================================

function run_update ()
{
   sudo apt-get update > /dev/null
   sudo apt-get install software-properties-common apt-transport-https wget -y > /dev/null

}
   # ----------  end of function run_update  ----------
function install_vscode ()
{

   wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
   sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
   sudo apt install code -y

}
   # ----------  end of function install_vscode  ----------


function install_atom ()
{
   wget -q https://packagecloud.io/AtomEditor/atom/gpgkey -O- | sudo apt-key add -
   sudo add-apt-repository "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main"
   sudo apt-get install atom -y

}
   # ----------  end of function install_atom  ----------


function install_oracle_java ()
{
   sudo mkdir /usr/lib/jvm
   cd /usr/lib/jvm
   sudo tar -xvzf ~/jdk-8u271-linux-x64.tar.gz
   sudo tee -a greetings.txt > /dev/null <<EOT
PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/usr/lib/jvm/jdk1.8.0_271/bin:/usr/lib/jvm/jdk1.8.0_271/db/bin:/usr/lib/jvm/jdk1.8.0_271/jre/bin"
J2SDKDIR="/usr/lib/jvm/jdk1.8.0_271"
J2REDIR="/usr/lib/jvm/jdk1.8.0_271/jre*
JAVA_HOME="/usr/lib/jvm/jdk1.8.0_271"
DERBY_HOME="/usr/lib/jvm/jdk1.8.0_271/db"
EOT
   sudo update-alternatives --install "/usr/bin/java" "java" "/usr/lib/jvm/jdk1.8.0_271/bin/java" 0
   sudo update-alternatives --install "/usr/bin/javac" "javac" "/usr/lib/jvm/jdk1.8.0_271/bin/javac" 0
   sudo update-alternatives --set java /usr/lib/jvm/jdk1.8.0_271/bin/java
   sudo update-alternatives --set javac /usr/lib/jvm/jdk1.8.0_271/bin/javac

   update-alternatives --list java
   update-alternatives --list javac

}
   # ----------  end of function install_oracle_java  ----------


# Main section of sxripr executation

echo "Running apt update"
run_update
vscode_status=`which code`
if test -z "$vscode_status";then
   install_vscode
else
   echo "vscode already installed in system \n seach for code and start the program \n the code is installed on $vscode_status"
fi

atom_status=`which atom`
if test -z "$atom_status";then
   install_atom
else
   echo "atom already installed in system \n seach for atom and start the program \n the code is installed on $atom_status"
fi

java_status=`which java`
if test -z "$java_status";then
   install_oracle_java
else
   echo "java 8 already installed in system \n the java is installed on $java_status"
fi
