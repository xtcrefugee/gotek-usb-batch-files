# gotek-usb-batch-files
These are some very quick and dirty Windows batch files for extracting and updating disk images made from the USB sticks of Gotek floppy drive emulators. They use the values and dd commands specified by Gough Lui, see http://goughlui.com/2013/04/24/review-unbranded-1-44mb-usb-100-floppy-emulator/ and http://goughlui.com/2013/05/19/review-gotek-system-sfr1m44-u100k-usb-1000-floppy-disk-emulator/

The batch files do some validation of input, but you should still be careful as they will overwrite files without warning. They should work on Windows Vista/7/8x.

Required:
* Software to create a raw image of your USB stick. I recommend HDD Raw Copy: http://hddguru.com/
* John Newbigin's Windows port of dd: http://www.chrysocome.net/dd
* Software for editing the generated floppy images. I recommend WinImage: http://www.winimage.com/
* A 1.44MB/IBM format Gotek floppy emulator that uses the partitions/raw filesystem as mentioned by Gough Lui. This includes the SFR1M44-U100K.

Procedure:
* Format your USB stick using the Gotek floppy emulator if you have not already done so. This is usually done by holding down both buttons as you connect the power lead, and will delete all data on the USB stick inserted. 
* Use HDD Raw Copy to make a raw (NOT compressed) image of the USB stick.
* Place the 'extract' and 'update' scripts in a directory with the windows executable for dd.
* Open a command prompt and run "extract usb.img 1000" where usb.img is the image you made with HDD Raw Copy and the following number is the amount of floppy disk images you want to extract (1-1000). Gotek models with 2 digit displays only support 100 floppy images.
* The batch file will create up to 1000 floppy image files in the directory, numbered according to their slot position.
* You can now use WinImage or similar software to drag and drop files to/from each of these images.
* When finished, run "update usb.img" which will copy the modified floppy images back into the raw USB stick image file.
* You can now use HDD Raw Copy to copy this modified image back to the USB stick.
* I STRONGLY recommend you create another image of the USB stick (which can be compressed if you like) as a backup before writing the modified image file back to it, I am not responsible for data loss, etc. etc.
