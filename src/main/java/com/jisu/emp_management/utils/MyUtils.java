package com.jisu.emp_management.utils;

import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.zip.Inflater;
import javax.imageio.ImageIO;

public class MyUtils {

    public static byte[] compressImage(byte[] originalImageBytes, String formatName, float quality) throws IOException {
        BufferedImage originalImage = ImageIO.read(new ByteArrayInputStream(originalImageBytes));

        // Create a ByteArrayOutputStream to store the compressed image
        try (ByteArrayOutputStream outputStream = new ByteArrayOutputStream()) {
            // Use ImageIO to write the compressed image to the ByteArrayOutputStream
            ImageIO.write(originalImage, formatName, outputStream);

            // Get the compressed image bytes from the ByteArrayOutputStream
            return outputStream.toByteArray();
        }
    }

    public static byte[] decompressImage(byte[] compressedImageBytes) throws IOException {
        // Create a ByteArrayInputStream from the compressed image bytes
        try (ByteArrayInputStream inputStream = new ByteArrayInputStream(compressedImageBytes)) {
            // Use ImageIO to read the compressed image into a BufferedImage
            BufferedImage compressedImage = ImageIO.read(inputStream);

            // Create a ByteArrayOutputStream to store the decompressed image
            try (ByteArrayOutputStream outputStream = new ByteArrayOutputStream()) {
                // Use ImageIO to write the decompressed image to the ByteArrayOutputStream
                ImageIO.write(compressedImage, "jpg", outputStream);

                // Get the decompressed image bytes from the ByteArrayOutputStream
                return outputStream.toByteArray();
            }
        }
    }
}
