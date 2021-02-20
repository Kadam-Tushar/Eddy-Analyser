<p align="center">
  <a href="" rel="noopener">
 <img width=200px src="./img/logo.png" alt="chintak-logo"></a>

<h1 align="center">Eddy-Analyser</h1>
<h3 align="center">Real-Time Eddy Visualisation and Analysis.</h3>



- **Eddies** are clockwise or counter-clockwise circular movements of water that play a major role in transporting energy and biogeochemical particles in the ocean.

![Nasa Eddy Visualisation](./img/Perpetual_Ocean.gif)

<div style="text-align: right"> NASA Visualisation Studio</div>

------------------------------------------
This project does visualization of eddies present in red sea and finds interesting statistical measures to study behavior of eddies.

- Given the narrow nature of the basin, many eddies can occupy more than half of the Red Sea width, providing rapid transport of organisms and nutrients along the coastline and between the african and Arabian Peninsula coasts. 
- These marine `whirlpools` are much more frequent than what had been previously thought, profoundly affecting the social and economic lives of people living in the surrounding countries.


<center>
<img src="./img/red_sea_map.png" alt="redsea" width="350"/>
</center>
<div style="text-align: center"> Google Maps Image</div>

- This is a course project of [Graphics and Visualization](https://www.csa.iisc.ac.in/~vijayn/courses/Graphics/index.html) course.
- Problem statement for this project is taken from [IEEE SciVis Contest 2020](https://kaust-vislab.github.io/SciVis2020/index.html)
- This project solves `Eddy Visualization in 3D` and `Interesting Eddy statistics`  tasks like tracking eddies over multiple time intervals, births/deaths of eddis.
  
------------------------------------------
## Contributors:
- [@Kadam-Tushar](https://github.com/Kadam-Tushar)
- [@TanayNarshana](https://github.com/TanayNarshana)

------------------------------------------

## Red Sea Dataset: 
[Ensembles](https://kaust-vislab.github.io/SciVis2020/data.html) red sea data is provided on contest webpage and where each ensembler 

------------------------------------------

## Visualisations Softwares / Dependencies : 
- [Inviwo](https://github.com/inviwo/inviwo) - Open Source Scientific Visualization tool.
- `Matlab` for fast Data processing.
- Visualization libraries like `py-plot`,`networkx`.
- Data processing libraries in matlab/python like pandas.
- 

## Brief Explanation of our Approach:

-   Loosely detected majority of meso-scale eddies using [Okuba-weiss parameter](https://github.com/inviwo/inviwo).
<center>
<img src="./img/Outputs/falseDetections3D.png" alt="redsea" width="350"/>
</center>
<div style="text-align: center"> 3D Eddy Visualisations</div>

   
- Filtered out `false postitive` eddies using Gemotrical constraints mentioned in this [paper](https://www.researchgate.net/publication/260722486_Gulf_Stream_eddy_characteristics_in_a_high-resolution_ocean_model_Gulf_Stream_Eddy_Characteristics).
<center>
<img src="./img/Outputs/ens1T45withGeomConstr.png" alt="redsea" width="350"/>
</center>
<div style="text-align: center"> Surface Level Meso-scale Eddies</div>

- From detected eddy centers from above step we applied `Breadth First Search` over 3D region upto tested threshholds to detect eddies in 3D space and finally this new data is visualized using `Inviwo`.
 
 Here in Inviwo we can interactivly study shapes these eddies in 3D. 

 ```
Green : Eddies.
Pink : Sea Bed from Bathy metry data.
 ```

<center>
<img src="./img/Outputs/eddy_vis_3d.png" alt="redsea" width="350"/>
</center>
<div style="text-align: center"> 3D Eddy Visualisations with Bathymetry Data at Timestep 15</div>
  
- Calculating this eddy information over all ensembles we plotted count of eddies graph.
<center>
<img src="./img/Outputs/numberOfEddies.png" alt="redsea" width="350"/>
</center>
<div style="text-align: center"> Count of Eddies over 7 ensembles</div>

- To validate our detected eddies we tried `stream-line-plots` over same region:
 <center>
<img src="./img/Outputs/stream_with_eddy_radii%20(1).png" alt="redsea" width="350"/>
</center>
<div style="text-align: center"> Streamlines and eddy detection on same graph</div>

- To establish relationship between eddies i.e identify  particular eddy is same in timestep X and X+1 we developed novel algorithm for eddy-tracking using area - overlap. 
Tried  matlab's `SURF` feature to identify same eddies over different time interval:
<center>
<img src="./img/Outputs/SURF.png" alt="redsea" width="350"/>
</center>
<div style="text-align: center"> SURF from matlab</div>

- To get better results and make this as real time as posible we used `Image Processing` to track eddies between images of surface eddies.
<center>
<img src="./img/Outputs/eddy_centroid.png" alt="redsea" width="350"/>
</center>
<div style="text-align: center"> Eddy centroids </div>

- In short we applied object detection algorithms on images of eddies `Contour Detection`​.For each detected objects we can assign features like centroid of eddy, shape of contours, area of contours, After that  we can search for these eddies in next few timesteps with similar features.
- Once tracking is done from previous step now to Visualise eddy-relationships we tried to show it graph format. 
  
<center>
<img src="./img/Outputs/eddy_life_cycle.png" alt="redsea" width="350"/>
</center>
<div style="text-align: center"> Eddy Life Graph </div>

- From this network we visualised Deaths/Births graph , splits /merges of eddies.
  
<center>
<img src="./Outputs/../img/Outputs/BirthsEnsemble1.png" alt="redsea" width="350"/>
</center>
<div style="text-align: center"> Eddy Births </div>


----
- Thanks for Reading ! 
- PR's are welcome, 