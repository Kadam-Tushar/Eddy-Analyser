<p align="center">
  <a href="" rel="noopener">
 <img width=200px src="./img/logo.png" alt="chintak-logo"></a>

<h1 align="center">Eddy-Analyser</h1>
<h3 align="center">Real-Time Eddy Visualisation and Analysis.</h3>



- **Eddies** are clockwise or counter-clockwise circular movements of water that play a major role in transporting energy and biogeochemical particles in the ocean.
<p align="center">
  <a href="" rel="noopener">
 <img width=500px src="./img/Perpetual_Ocean.gif" alt="NASA"></a>


<div style="text-align: center"> NASA Visualisation Studio</div>

------------------------------------------
This project does visualization of eddies present in red sea and finds interesting statistical measures to study behavior of eddies.

- Given the narrow nature of the basin, many eddies can occupy more than half of the Red Sea width, providing rapid transport of organisms and nutrients along the coastline and between the african and Arabian Peninsula coasts. 
- These marine `whirlpools` are much more frequent than what had been previously thought, profoundly affecting the social and economic lives of people living in the surrounding countries.


<p align="center">
<a href="" rel="noopener">
<img src="./img/red_sea_map.png" alt="redsea" width="350px"/></a>

<div style="text-align: center">Red Sea - Google Maps</div>

- This is a course project of [Graphics and Visualization](https://www.csa.iisc.ac.in/~vijayn/courses/Graphics/index.html) course.
- Problem statement for this project is taken from [IEEE SciVis Contest 2020](https://kaust-vislab.github.io/SciVis2020/index.html)
- This project solves `Eddy Visualization in 3D ` and `Interesting Eddy statistics`  tasks of contest. like tracking eddies over multiple time intervals, births/deaths of eddies.
  
------------------------------------------
## Contributors:
- [@Kadam-Tushar](https://github.com/Kadam-Tushar)
- [@TanayNarshana](https://github.com/TanayNarshana)

------------------------------------------

## Red Sea Dataset: 
[Ensembled](https://kaust-vislab.github.io/SciVis2020/data.html) data of red sea is provided on contest webpage.

------------------------------------------

## Visualisations Softwares / Dependencies : 
- [Inviwo](https://github.com/inviwo/inviwo) - Open Source Scientific Visualization tool.
- `Matlab` for fast Data processing.
- Visualization libraries like `py-plot`,`networkx`.
- Data processing libraries in matlab/python like pandas.
- `OpenCV` for Image Processing. 
  

## Brief Explanation of our Approach:

- Detected meso-scale eddies using [Okuba-weiss parameter](https://github.com/inviwo/inviwo) from `velocity field` in  dataset.
<p align="center">
<a href="" rel="noopener">
<img src="./img/Outputs/falseDetections3D.png" alt="redsea" width="500px"/></a>

<div style="text-align: center"> 3D Eddy Visualisations</div>
<br>
   
- Filtered out `false postitive` eddies using Gemotrical constraints mentioned in this [paper](https://www.researchgate.net/publication/260722486_Gulf_Stream_eddy_characteristics_in_a_high-resolution_ocean_model_Gulf_Stream_Eddy_Characteristics).
<p align="center">
<a href="" rel="noopener">
<img src="./img/Outputs/ens1T45withGeomConstr.png" alt="redsea" width="500px"/></a>

<div style="text-align: center"> Surface Level Meso-scale Eddies</div>
<br>

- Applied `Bredth First Search` algorithm on detected eddy centers from above step  over 3D region till threshhold value of Okuba-weiss parameter is reached.
- Generated possible regions of Eddies in 3D space and then this new data is visualized using `Inviwo` tool.
 
 Here in Inviwo we can interactivly study shapes of these eddies in 3D. 

 ```
Green : Eddies.
Pink : Sea Bed from Bathy metry data.
 ```

<p align="center">
<a href="" rel="noopener">
<img src="./img/Outputs/eddy_vis_3d.png" alt="redsea" width="500"/></a>

<div style="text-align: center"> 3D Eddy Visualisations with Bathymetry Data at Timestep 15</div>
  

<br>

- Calculating this eddy information over all ensembles we plotted count of eddies graph.

<p align="center">
<a href="" rel="noopener">
<img src="./img/Outputs/numberOfEddies.png" alt="redsea" width="500"/></a>

<div style="text-align: center"> Eddy Count over 7 ensembles</div>
<br>

- To validate our detected eddies we tried `stream-line-plots` over same regions:
 
<p align="center">
<a href="" rel="noopener">

<img src="./img/Outputs/stream_with_eddy_radii%20(1).png" alt="redsea" width="500px"/>
</a>

<div style="text-align: center"> Streamlines and eddy detection on same graph</div>
<br>

- To establish relationship between eddies i.e identify  particular eddy is same in timestep X and X+1 we developed algorithm (see report for details) for eddy-tracking using area - overlap method. 
Also tried  matlab's `SURF` feature to identify same eddies over different time interval:
<center>
<img src="./img/Outputs/SURF.png" alt="redsea" width="500"/>
</center>
<div style="text-align: center"> SURF from matlab</div>

<br>


- To make this anaylysis as real time as posible we used `Image Processing` to track eddies between images of surface eddies.

<p align="center">
<a href="" rel="noopener">
<img src="./img/Outputs/eddy_centroid.png" alt="redsea" width="500"/></a>
<div style="text-align: center"> Eddy Detection from images and their centroids</div>
<br>

- Applied object detection algorithms on images of eddies using `Contour Detection`​.For each detected objects we can assign features like centroid of eddy, shape of contours, area of contours, After that  we can search for eddies with same features in next few timesteps.
- Once tracking is done from previous step now to Visualise eddy-relationships we tried to show it graph format as below. 
  
<p align="center">
<a href="" rel="noopener">
<img src="./img/Outputs/eddy_life_cycle.png" alt="redsea" width="500"/></a>

<div style="text-align: center"> Eddy Life Graph  </div>
Each Column of nodes represents eddies from that timestep and edge  between node represents these two eddies are same just at present at different timestep.
<br>
<br>

- From this network we visualised Deaths/Births graph and splits/merges of eddies.
  
<p align="center">
<a href="" rel="noopener">
<img src="./Outputs/../img/Outputs/BirthsEnsemble1.png" alt="redsea" width="500px"/></a>
<div style="text-align: center"> Eddy Births </div>


----
- PR's are welcome, 
- Detailed [ Report](./Report.pdf) of Work.
- [PPT](https://indianinstituteofscience-my.sharepoint.com/:p:/g/personal/tanayn_iisc_ac_in/EVK5ONb0xZxPhPe2M9f-Kk0Bxvx2NOX_0W1nUUdQd0rmXQ?e=XhJACi) for better understadning.