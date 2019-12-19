README.txt

Author: Bobby Curtis, MBA
Email: curtisbl@gmail.com
Email: bobby.curtis@oracle.com

PURPOSE:
To build a docker image that has Oracle GoldenGate Microservices installed with Oracle Database Instant Client for 18c and 19c.

FILES NEEDED:
Will need the following files:

191004_fbo_ggs_Linux_x64.services_shiphome.zip
instantclient-basic-linux.x64-18.5.0.0.0dbru.zip
instantclient-basic-linux.x64-19.3.0.0.0dbru.zip

Files need to be placed in the ORASoftware directory as zipped files

BUILD:
Use Docker commands:

docker build -t ogg19c:19.1.0.0.4 .

WHAT IS BUILT:
With successful build, you should have an image tagged at ogg19c:19.1.0.0.4.  The image would include Oracle GoldenGate 19c (19.1.0.0.4) with the instant client software for Oracle Database 18c and 19c.

START SERVICEMANAGER:
After the image is running, start the ServiceManager.  The ServiceManager will not start automatically due to Docker missing the D-Sub subsystem.  

$ cd /software/scripts
$ sh ./startServiceManager.sh

ADD DEPLOYMENT:
The initial build will have an inital deployment with ServiceManager and a deployment (default Atlanta).  If you want to add another deployment, make sure the ServiceManager is running and then run the addDeployment.sh script.

$ cd /software/scripts
$ sh ./addDeployment.sh

KNOWN ISSUES:

Nginx Missing:
At the time of the build, Nginx may not install by yum.  In order to use the Reverse Proxy configuration this has to be installed.  Install Nginx manaually
