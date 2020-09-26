# ScilabDataAnalysisTemplate
This is a template for data analysis with scilab.  
It is mainly intended to facilitate use and minimize potential errors by :
* enforcing a consistent directory structure 
For each novel data analysis problem, the idea is to create a novel directory containing *at least*
	* `WRK`: working directory for the data analysis problem 
		* `DAT`: data used as input for analyses
		* `RES`: results of analyses 
		* `PRG`: scripts and functions for the analyses 
		
* compiling all functions in `PRG` when you run `main.sce`   
This is handy, somewhat similar to matlab's way of doing, *though you must re-run main each time you modify a function*  
This is done in `InitTRT.sce`


- providing a minimum set of ingredients for time series processing   
	- `LIB_Signal`
		- `AmplitudeSpectrum.sci`
		- `LowPassButtDouble.sci`
		- `fltsflts.sci`
		- `gradient.sci`
	- `FourrierAnalysis.sce`

## Usage
* (Clone or) download the repository 
* On your computer : 
	* Open `main.sce` with scilab editor (SciNotes)  
	* Run the script (press F5, or click  the button with a triangle)

## Notes : 
* You first need to install [Scilab](http://www.scilab.org)... 
* Double click on `main.sce` might not work... depending on your OS.  
Opening files from SciNotes allways works (File menu -> open). 
* *Do not modify the names and organisation of the directories*   
The DAT+PRG+RES structure is expected when initialising in `InitTRT.sce`