A script to generate a PDF file of images and associated text from the current folder.

Each image (matching *.jpg) is added on a separate page of the resulting PDF.

Captions can optionally be included using either the image file name or a separate text file.

### Options:

 * `-t` — If no text file matching the image name is found, use the image filename (without extension) as the caption
 * `-n` — (Only in conjunction with '-t') Assume filenames are preceded with a number followed by an underscore ('XX_') and remove that from the caption. Allows controlling the order of output.

### TODO

 * Integrate the single-file captions script.
