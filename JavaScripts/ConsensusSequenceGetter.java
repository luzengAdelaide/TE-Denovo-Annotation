import java.io.*;
import java.util.*;

public class ConsensusSequenceGetter {
	private static String dir = "../Data/MuscleOutput/";
	private static String aDir = dir + "LA4v2-all-repeats/";
	private static String nDir = dir + "LA4v2-nocontainers-repeats/";
	
	public static void main(String[]args) {
		writeConsensusSequences(aDir);
		writeConsensusSequences(nDir);
		}


	private static void writeConsensusSequence(BufferedWriter out, String file) {
		try {
			BufferedReader in = new BufferedReader(new FileReader(file));
			String line = in.readLine();
			out.write(">" + line.substring(1, line.indexOf(" ")) + "\n");
			StringBuffer buff = new StringBuffer(in.readLine());
			while (buff.length() >0) {
				int to = Math.min(buff.length(), 100);
				line = buff.substring(0, to);
				out.write(line + "\n");
				buff.delete(0, to);
				}
			in.close();
			}
		catch (IOException ie) {ie.printStackTrace();}
		}
		
	private static void writeConsensusSequences(String dDir) {
		try {
			BufferedWriter out = new BufferedWriter(new FileWriter(dDir + "ConsensusSequences.fa"));
			String[] files = new File(dDir).list();
			for (int i=0; i<files.length; i++) 
				if (files[i].endsWith(".fq")) writeConsensusSequence(out, dDir + files[i]);
			out.close();
			}
		catch (IOException ie) {ie.printStackTrace();}
		}
		
	}
