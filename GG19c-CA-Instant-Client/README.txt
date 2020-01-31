README.txt

Author: Bobby Curtis, MBA
Email: curtisbl@gmail.com
Email: bobby.curtis@oracle.com

PURPOSE:
To build a docker image that has Oracle GoldenGate Classic installed with Oracle Database Instant Client for 18c and 19c.

FILES NEEDED:
Will need the following files:

191004_fbo_ggs_Linux_x64_shiphome.zip
instantclient-basic-linux.x64-18.5.0.0.0dbru.zip
instantclient-basic-linux.x64-19.3.0.0.0dbru.zip

Files need to be placed in the ORASoftware directory as zipped files

BUILD:
Use Docker commands:

docker build -t ogg19cca:19.1.0.0.4 .

WHAT IS BUILT:
With successful build, you should have an image tagged at ogg19cca:19.1.0.0.4.  The image would include Oracle GoldenGate 19c (19.1.0.0.4) with the instant client software for Oracle Database 18c and 19c.
