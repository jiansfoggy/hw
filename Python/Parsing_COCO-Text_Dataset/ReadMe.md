# Parsing COCO-Text Dataset

Target: get the following values  
> Part A: img_id, file_name, width, height bbox and transcription  
> Part B: trainset, validset, testset

## Step 0 Create Directory  
Choose a good place in your PC or server, and create a folder called COCO_Tex.  

Click the following link to download essential python file, coco_text.py.   
*https://github.com/andreasveit/coco-text/blob/master/coco_text.py*

Save the just downloaded file under new created directory.  
Now all the operations will be done within this folder.

## Step 1 Download COCO-Text dataset  
Click the following link to download COCO-Text annotations 2017 v1.4  
*https://vision.cornell.edu/se3/coco-text-2/*  
Then, unzip it to your target directory

Click the following link to download COCO train2014 dataset  
*https://cocodataset.org/#download*  
Then, unzip it to your target directory.  
> Note: the size of this file is 13GB, it requires more space.

## Step 2 Select one method to parse it

**[Method 1](https://github.com/jiansfoggy/CODE-SHOW/tree/master/Python/Parsing_COCO-Text_Dataset/Method1)**  
This method returns 2 parts separately.  
Get values in Part A via get_ann.py;  
Get values in Part B via assign_img.py.

**[Method 2](https://github.com/jiansfoggy/CODE-SHOW/tree/master/Python/Parsing_COCO-Text_Dataset/Method2)**  
This method returns 2 parts at the same time.

**[Method 3](https://github.com/jiansfoggy/CODE-SHOW/tree/master/Python/Parsing_COCO-Text_Dataset/Method3)**  
This methid does the following 4 tasks:  
1. create a new folder called images, and save splitted train. test, valid image set under this directory.
2. create a new folder called labels, and save annotation information for train set, test set and valid set under this directory.
3. create 3 text files to save specific images path for each image in train set, test set and valid set.
4. create a new file classes.names to save all unique labels here.
* Note: annotations include the index of class, bbox[x,y,width,height]
* Note: this file can serve to train yolo-v3

## Step 3 Run Code  
**Method 1**:  
```  
#Part A
CUDA_VISIBLE_DEVICES=2,3 python3 get_ann.py

#Part B
CUDA_VISIBLE_DEVICES=2,3 python3 assign_img.py --ann_path ./train_anns --img_path ./train2014/ --folder2save ./coco_train/

CUDA_VISIBLE_DEVICES=2,3 python3 assign_img.py --ann_path ./test_anns --img_path ./train2014/ --folder2save ./coco_test/

CUDA_VISIBLE_DEVICES=2,3 python3 assign_img.py --ann_path ./val_anns --img_path ./train2014/ --folder2save ./coco_valid/
```

**Method 2**:  
`CUDA_VISIBLE_DEVICES=2,3 python3 assign_img.py --COCO_path ./COCO_Text.json --img_path ./train2014/`

**Method 3**:  
`CUDA_VISIBLE_DEVICES=1,3 python3 yolo_split.py --COCO_path ./COCO_Text.json --img_path ./train2014/`

## Step 4 Output  
Now, there should be six or even more files. Three for new splitted annotations, three for new splitted image sets

Next, you can play this dataset with your models.
