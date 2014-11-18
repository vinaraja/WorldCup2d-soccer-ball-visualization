WorldCup
========
World Cup is a 2d application that is developed in Open Exhibits

Getting Started
---------------
Clone the repo to the directory of your choice. Install the Open Exhibits SDK from http://openexhibits.org/.
You may use any development tools you wish, but these instructions will use the open-source IDE FlashDevelop from http://www.flashdevelop.org/. Install the latest version of FlashDevelop and follow any configuration instructions on the site in order to build Flash applications with Air.


Building the application
------------------------
After opening the project in FlashDevelop, you should be able to build and run the application by pressing F5. Make sure you are in Debug mode if you want to see trace commands in the console.

To build for release, change to Release mode, and build with F8. This will generate a new swf in /bin.

Next, you will need to package the Air installer. To do so, run the PackageApp.bat script (double-click or run from the command prompt. This will generate a new collectionviewer3.air file in the /air directory.
Double-clicking the air file will install the Collection Viewer as a native application in the Program Files directory.


Troubleshooting
---------------
** Error While loading initial content 

I receieved this problem when installing the flexSDK seperate from flashdevelop. 
The CollectionViewer project uses AIR 3.9, by default, the new flexSDK will try to initialize an 
swf version of 24. Within your flexSDK directory/frameworks/ change the air-config.xml file to 
use swf-version 22. 

Here is a table of what the versions need to be set to depening on versions. 

 -swf-version  | Flash Player |  AIR
=======================================
       9       |      9      |  2.0 ?
      10       |   10, 10.1  |  2.5 ?
      11       |     10.2    |  2.6
      12       |     10.3    |  2.7
      13       |     11.0    |  3.0
      14       |     11.1    |  3.1
      15       |     11.2    |  3.2
      16       |     11.3    |  3.3
      17       |     11.4    |  3.4
      18       |     11.5    |  3.5
      19       |     11.6    |  3.6
      20       |     11.7    |  3.7
      21       |     11.8    |  3.8
      22       |     11.9    |  3.9
      23       |     12.0    |  4.0
      24       |     13.0    |  13.0

Please make sure the above table is followed correctly because any mismatch will prevent the program from working.


** Error: Comparison method violates its general contract!
Build halted with errors (fcsh).

Fix: reopen flashdevelop, if problems persist reinstall java

** Error:Blank Screen Coming Up after its compiled Properly

Fix: Please install the correct FlashPlayerDebugger from this link http://helpx.adobe.com/flash-player/kb/archived-flash-player-versions.html


** Error:Its not able to open the gestures.gml file and shows Io error

Fix:Please manually add the Gestures.gml file to the correct directory


Notes
-----
All development should be done with the sample content provided in the repo. To construct a new Collection Viewer with different content, copy the contents of the directory installed in Program Files. Paste that directory somewhere else, then modify the CML and add your new content to customize the application.
