A script to generate a PDF file of images and associated text from the current folder.

All images (matching *.jpg) are added on a separate page.

If a text file exists with the same name, its contents are added under the image.

###Options:

 - `-t` — If no text file matching the image name is found, use the image filename (without extension) as the caption
 - `-n` — (Only in conjunction with '-t') Assume filenames are preceded with a number followed by an underscore ('XX_') and remove that from the caption. Allows controlling the order of output
