from skimage import io, color
from skimage.external import tifffile
from skimage.filters.edges import convolve
from skimage.filters import sobel
from matplotlib import pyplot as plt
from random import seed
from random import random
import os

T = 15
MASK = [[-1, -2, -1], [-1, 12, -2], [-1, -2, -1]]

def main():
    seed(324242)

    # load dataset in YCbCr format
    I = loadImages("../../MDSDataset/dev-dataset/dev-dataset-forged")
    # showRandomImages(I)
    
    # select Cb chroma level 
    I_Cb = I[:,:,1]

    # extract edge information 
    E = convolute(MASK, I_Cb)
    print("Edge Information Shape: " + str(E.shape))

    E = threshold(E)


    

def loadImages(folder):
    print("Loading images from " + folder)
    imgs = []
    c = [0,0]

    for subdir, dirs, files in os.walk(folder, topdown=False):

        for file in files:
            if len(imgs) > 5:
                break

            filename = os.path.join(subdir, file)

            if file.endswith('.tif') == True:
                img = tifffile.imread(filename)
                c[0] = c[0] + 1

            else:
                img = io.imread(filename)
                c[1] = c[1] + 1

            imgs.append(img)
            img = color.convert_colorspace(img, 'RGB', 'YCbCr')

    imgs = io.concatenate_images(imgs)
    print("Images " + str(imgs.shape) + " - (" + str(c[0]) +" TIF, " + str(c[1]) + " JPG)")
    return imgs

def convolute(mask, images):
    convolvedImages = []
    for img in images:
        cImg = convolve(img, mask)
        # cImg = sobel(img)
        convolvedImages.append(cImg)
    convolvedImages = io.concatenate_images(convolvedImages)
    return convolvedImages

def threshold(images):
    thresholdedImages = []
    for img in images:
        [dimX, dimY] = img.shape
        x = 0
        y = 0
        while x < dimX:
            while y < dimY:
                if img[x,y] > T:
                    img[x,y] = T
                y = y + 1
            thresholdedImages.append(img)
            x = x + 1
    return io.concatenate_images(thresholdedImages)

def showRandomImages(images, tif=False):
    randomIndex = int(random() * len(images))
    fig = plt.figure(figsize=(8, 8))
    randomImg = images[randomIndex]
    fig.suptitle("IMG SIZE = " + str(randomImg.shape))

    fig.add_subplot(2, 3, 1)
    plt.imshow(randomImg[:,:,0])
    fig.add_subplot(2, 3, 2)
    plt.imshow(randomImg[:,:,1])
    fig.add_subplot(2, 3, 3)
    plt.imshow(randomImg[:,:,2])

    if tif:
        fig.add_subplot(2, 3, 5)
        plt.imshow(randomImg[:,:,3])

    plt.show()
    
def showImage(image):
    fig = plt.figure(figsize=(8, 8))
    fig.suptitle("IMG SIZE = " + str(image.shape))
    fig.add_subplot(1, 1, 1)
    plt.imshow(image)
    plt.show()

if __name__== "__main__":
    main()

