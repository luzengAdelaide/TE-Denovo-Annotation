import java.io.*;
import java.util.*;

public class SummarizeChromosomes {
	private static String mDir = "/home/lu/";
	private static String cDir = mDir + "/Chromosomes/";
	private static String dDir = mDir;
	private static String bDir = cDir + "/Size_oana/";
	private static int binSize = 1500000;
	private static Set<String> aa = new HashSet<String>();
	private static Set<String> gcs = new HashSet<String>();

	public static void main (String[] args) {
		processGenome();
		}

    private static void processFile (String dir, String inFile, BufferedWriter outS, BufferedWriter outB) {
	System.out.println("chrID: " + inFile);
	String chrID = inFile.substring(46, inFile.indexOf(".",46));
		System.out.println("Processing Chromosome: " + chrID); 
		String id = null;
		try {
			BufferedReader in = new BufferedReader(new FileReader(dir + inFile));
			String line = line = in.readLine();
			int sSize = 0;
			int bin = 1;
			int gc = 0;
			int known = 0;
			int bSize = 0;
			while (line != null) {
				if (id != null) {
					outS.write(chrID + " " + id + " " + sSize + "\n");
					if (bSize > 0) {
						int binTo = bin*binSize;
						if (binTo > sSize) binTo = sSize;
						outB.write(id + " " + ((bin-1)*binSize+1) + " " + binTo + " " + gc + " " + known + "\n");
						}
					sSize = 0;
					bin = 1;
					gc = 0;
					known = 0;
					bSize = 0;
					}
				id =  "";
				System.out.println("  Sequence: " + id); 
				while ((line = in.readLine()) != null && line.charAt(0) != '>') {
					char[] chars = line.toCharArray();
					sSize += chars.length;
					int from = 0;
					if (bSize + chars.length > binSize) {
						int to = binSize - bSize;
						for (int i=0; i<to; i++) 
							if (aa.contains("" + chars[i])) {
								known++;
								if (gcs.contains("" + chars[i])) gc++;
								}
						outB.write(id + " " + ((bin-1)*binSize+1) + " " + bin*binSize + " " + gc + " " + known + "\n");
						bin++;
						gc = 0;
						known = 0;
						bSize = 0;	
						from = to;
						}
					for (int i=from; i<chars.length; i++) 
						if (aa.contains("" + chars[i])) {
							known++;
							if (gcs.contains("" + chars[i])) gc++;
							}
					bSize += (chars.length - from);
					} 
				} 
			in.close();
			outS.write(chrID + " " + id + " " + sSize + "\n");
			outS.flush();
			if (bSize > 0) {
				int binTo = bin*binSize;
				if (binTo > sSize) binTo = sSize;
				outB.write(id + " " + ((bin-1)*binSize+1) + " " + binTo + " " + gc + " " + known + "\n");
				}
			outB.flush();
			}
		catch (IOException ie) {ie.printStackTrace();}
		}

	private static void processGenome() {
		setConstants(); 
		try {
			BufferedWriter outS = new BufferedWriter(new FileWriter(dDir + "CSSize.txt"));
			outS.write("Chromosome Sequence Size\n");
			BufferedWriter outB = new BufferedWriter(new FileWriter(bDir + "GCCount.txt"));
			outB.write("Sequence Start End GC Known\n");
			String[] files = new File(cDir).list();
			for (int i=0; i<files.length; i++) if (!files[i].startsWith("Size")) processFile (cDir, files[i], outS, outB);
			outS.close();
			outB.close();
			}
		catch (IOException ie) {ie.printStackTrace();}
		}


	private static void setConstants() {
		char[] kaa = {'G','g','C','c','A','a','T','t'};
		for (int i=0; i<kaa.length; i++) {
			aa.add("" + kaa[i]);
			if (i<4) gcs.add("" + kaa[i]);
			}
		}
/*
	public void processGenome (int binSize, String outDir) {
		this.binSize = binSize;
		bDir = outDir;
		processGenome();
		}
*/
	} 
