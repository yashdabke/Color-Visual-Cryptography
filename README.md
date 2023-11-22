# Color Visual Cryptography (Technique Proposal)

Color Visual Cryptography Scheme using Floyd Steinberg Dithering with Adaptive Local Noise
filtering and Gaussian Smoothing to enhance Image Quality 

## Table of Contents
- [Color Visual Cryptography](#project-name)
  - [Table of Contents](#table-of-contents)
  - [Description](#description)
  - [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [License](#license)
  - [Acknowledgments](#acknowledgments)

## Description

This work is my final year project for my college degree.

Our project deals with the concept of Visual Cryptography for Color Images.

Visual Cryptography is a cryptographic technique that deals with the encryption and 
decryption of an input image which is known as the Secret Image for the obvious reason. 
This secret image can be encrypted and decrypted using various Digital Image Processing 
techniques.

Our Project primarily uses the original cryptographic technique of splitting the Secret
Image into multiple images known as Shares. These Shares are primarily the layers of the
image which when stack together will reveal back the Secret Image.

In its earlier stages the technique was limited to splitting the Image into 2 shares of 
aspect ratios which didn't match the original image and also was primarily done on 
Binary Images.

But now with latest advancements in technology and high reliance on Computers, we can 
perform it on Color Image and obtain back a visually acceptable result.

Our method involves the following.

 **Splitting the Color Image into RGB Components (File: rgbsplit.m)**
 
 Even if its a color image, its highly unfeasible to operate on the color image directly
 since we are dealing with around 16 million pixels, so instead we split the color image
 into its Red, Blue & Green Components so that we can perform DIP operations individually
 on them and later stack them once operations are done. These components are grayscale 
 so we shall instead be dealing with 256 pixels (0 to 255) for each components.
 
 **Converting the Grayscale Components into Binary Images (File: dithering.m)**
 
 Now, we use a popular dithering technique known as Floyd Steinberg dithering in order to
 binarize the components, this dithering technique involves thresholding each pixel and
 simultaneously updating nearby pixel values by the use of an error diffusion matrix. End
 result is an image with pixel values either 0 or 1.
 
 **Generating Shares using reverse XORing (File: sharegenXOR.m)**
 
 Now, we take a given Binary Image and try to obtain n shares which when combined should
 give back the Binary Image. We use the following formula to generate n shares.
 
 Let I be the binary input image where each pixel is either 0 or 1.
 Let Si be the ith share image.
 Let n be the total number of shares to be generated.
 Ri is a random binary noise image of the same dimensions as I. 
 Each pixel in Ri is randomly chosen to be 0 or 1.

 Share generation : Si = (I XOR Ri) mod 2
 
 **AES Encryption and Decryption of Shares (File: AES.py)**
 
 AES is more of an additional security measure, since the shares we generated are binary
 patterns, we use AES as a means to prevent corruption of these files since they are 
 vital in getting back the Secret Image.
 
 **XORing of Shares (File: XORstack.m)**
 
 Once we decrypt the shares, the receiver has to stack the shares by a simple XORing
 process. This will give back the binary image from dithering albeit with slight noise.
 
 **Adaptive Local Noise Filtering (File: adaptivefiltering.m)**
 
 Now we'll use an adaptive local noise filter to update the pixel values from the binary
 image. Here, each pixel value gets updated based on the noise variance and local variance
 obtained for each pixel in order. After which we use Gaussian Smoothing with Sigma Value 
 of around 0.85. This results in a closer depiction of the grayscale  component obtained 
 in the initial stage. Now when we combine these filtered components . We get a visually
 pleasing image which resembles the original by at least around 90-95%
 
 
 **Quality Parameter Test (File: parameters.m)**
 
 We shall measure the various parameters like Mean Square Error(MSE), Peak Signal-to-noise
 Ratio(PSNR), MD(Maximum Difference), SSIM(Structural Similarity Index) & Noramlized 
 Absolute Error(NAE). 
 
 Ideally MSE = 0, PSNR = inf*dB*, MD = 0, SSIM = 1, NAE = 0*dB*.
 
 *End of Description*


## Getting Started

The project primarily involves running a few MATLAB and python files in a specific order 
to achieve the desired result. Do make sure to read the description above to understand
what happens in each stage of the process. Here's just the order of execution of files.

 rgbsplit.m -> dithering.m -> sharegenXOR.m -> AES.py -> XORstack.m -> adaptivefiltering.m
 -> finalview.m -> parameters.m

*End of Getting Started*

## Prerequisites

MATLAB
 Image Processing Toolbox
Python3 
 PyCryptoDome
 

## License

The Project Files are licensed under MIT License.

## Acknowledgments

Team Members

**SIDDHARTH S T** *(B.Tech. Electronics & Communication Engineering, PES University)*

**RISHITHA OTRA** *(B.Tech. Electronics & Communication Engineering, PES University)*

**YASH SANTOSH DABKE** *(B.Tech. Electronics & Communication Engineering, PES University)*

**MANOJ S** *(B.Tech. Electronics & Communication Engineering, PES University)*

Project Guides

**Prof. Prahlad D** 
*(Asst. Professor, Department of Electronics & Communication Engineering, PES University)*

**Prof. Sangam Kumar**
*(Asst. Professor, Department of Electronics & Communication Engineering, PES University)*

