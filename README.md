# EECS583_Unroll_ML
`clean_description2code.py` transforms description2code into a more workable format and randomly selects one solution per problem to be our example code.

*After running script dataset looks like:*

bash
```
description2code_clean
├── problem_1
├── problem_2
│   ├── deccription.txt
│   ├── solution.cpp
│   ├── samples
│   │   ├── 1_input.txt
│   │   ├── 1_output.txt
│   │   ├── ...
├── ...
```
Please Note: CSV is in form: Name,Operations,Operands,MemoryOps,FPOps,Branch,resMII,frequentBBs,nestDepth,tripcount

### Instructions for model.ipynb 
A shared, working model.ipynb is shared in the 'EECS583 Project' folder on Google Drive and is here on GitHub. It's probably useful for all of us to have our own copy to run our own tests, so you can make a copy in Google Drive, for example, and open your copy in Colab to run your experiments.  

To train/validate the model, you will need to drag/drop training and validation csvs into the filesystem and possibly modify the csv paths in the cell that sets up the dataloaders. By default, it is setup to look for ```train_norm.csv``` and ```val_norm.csv``` on the same level as (not inside) ```sample_data/``` in the file system.  

Two things of note are commented out by default:
  * The ```scheduler``` variable, which decreases the learning rate by ```gamma``` every ```step_size``` epochs. You can pass this into the ```mlp.train_model()``` function.  
  * The ```class_weights``` tensor and its corresponding ```criterion```. These were calculated according to the label distribution with the formula ```w_j = n_samples / (n_classes * n_samples_j)``` to help the model learn the minority classes.
