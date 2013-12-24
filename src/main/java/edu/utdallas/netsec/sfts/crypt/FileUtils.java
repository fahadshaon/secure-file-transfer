package edu.utdallas.netsec.sfts.crypt;

import java.io.*;

/**
 * @author Fahad Shaon
 */
public class FileUtils {

    public static byte[] readFileBinary(String filename) throws IOException {

        File file = new File(filename);
        byte[] data = new byte[(int) file.length()];
        DataInputStream dis = new DataInputStream(new BufferedInputStream(new FileInputStream(file)));
        dis.readFully(data);
        dis.close();

        return data;
    }

    public static void writeFileBinary(String filename, byte[]... dataArrays) throws IOException {

        DataOutputStream dos = new DataOutputStream(new BufferedOutputStream(new FileOutputStream(filename)));

        for (byte[] data : dataArrays) {
            dos.write(data);
        }

        dos.flush();
        dos.close();
    }

    public static boolean isFileInDirectory(String basePath, String requestedPath) {

        try {

            String absBasePath = new File(basePath).getAbsoluteFile().getCanonicalPath();
            String absRequestedPath = new File(absBasePath + "/" + requestedPath).getAbsoluteFile().getCanonicalPath();

            return absRequestedPath.startsWith(absBasePath);

        } catch (IOException e) {
            return false;
        }
    }

    public static String getNonExistingFilename(String originalFilename) {

        String filename = originalFilename;
        int i = 1;
        while (new File(filename).exists()) {
            filename = originalFilename + "." + i++;
        }

        return filename;
    }

}
