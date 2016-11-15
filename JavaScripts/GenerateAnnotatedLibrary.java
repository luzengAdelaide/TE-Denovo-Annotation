import java.io.*;
import java.util.*;

/*************************
GenerateAnnotatedLibrary
	Generates an annotated library of the non-protein coding, non SSR repeating patterns in Pogona (PV)
	Author: Joy Raison
	Data: October 16, 2014
	Updated: October 17, 2014 to remove the insertion of the satellite
	Updated: March 3, 2016 to strip member size and length information from consensus sequence names
	   when reading their fasta file.  
	Inputs: ConsensusSequences.fa (The consensus sequences (fasta format))
		ConsensusSequences.fa.map (The map file from the censor run)
		known.txt (list of censor IR "identified" sequences with name of the library sequence they match)
		notKnown.fa.tewb.gff (gff file of the GB_TE matched sequences)
		GB_TE.01092014.fa (The GB_TE library)
		notKnown.fa.ervwb.gff (gff file of the all_retrovirus matched sequences)
		all_retrovirus.fasta (The all_retrovirus library)
		SSR.txt (list of sequences identified as SSRs, and the SSR they matched)
		protein.txt (list of the sequences identified as proteins and the protein they matched)
		//LA4v2-satellite.fa (a satellite sequence for which no consensus sequence was found)
	Outputs: wantedCSHeaders.txt (for checking individual sequence headers)
		R4_Library.fasta (The annotated library)
***************************/


public class GenerateAnnotatedLibrary {
	private static class Hit {
		private String target;
		private int start;
		private int end;
		
		public Hit (String target, int start, int end) {
			this.target = target;
			this.start = start;
			this.end = end;
			}

		public int getEnd () {return end;}

		public int getLength() {return end - start + 1;}
		
		public int getStart() {return start;}
		
		public String getTarget() {return target;}
		}

		
	private static class HitComparator implements Comparator {
		public int compare (Object o1, Object o2) throws ClassCastException {
			try {
				Hit h1 = (Hit) o1;
				Hit h2 = (Hit) o2;
				int result = h1.getStart() - h2.getStart();
				if (result == 0) result = h2.getEnd() - h1.getEnd();
				return result;
				}
			catch (ClassCastException ce) {
				throw new ClassCastException("Only Hits can be compared in HitComparator");
				}
			}
				
		public boolean equals (Object o) {return o instanceof HitComparator;}
		}
			

	private static class CS {
		private static HitComparator hitComparator = new HitComparator();
		private static double maxOverlap = 0.8;
		private static double minCoverageBP = 0.05;
		private String name;
		private String classification;
		private String annotation;
		private int length;
		private List<Hit> hits = new ArrayList<Hit>();
		
		public CS (String name, Integer len) {
			this.name = name;
			length = len.intValue();
			}

		public void addHit (Hit hit) {hits.add(hit);}

		public void addHits (List<Hit> hits) {this.hits.addAll(hits);}
		
		public void annotateAndClassify(Hashtable<String, String> retroAnnots, Set<String> irs) {
			if (hits.size() == 0) classifyAndAnnotateNone();
			else {
				removeSubHits();
				Hashtable<String, Integer> typeCoverage = new Hashtable<String, Integer>();
				for (Iterator<Hit> iter=hits.iterator(); iter.hasNext();) {
					Hit hit = iter.next();
					String target = hit.getTarget();
					int length = hit.getLength();
					if (typeCoverage.containsKey(target)) length += typeCoverage.get(target).intValue();
					typeCoverage.put(target, new Integer(length));
					}
				double minCoverage = minCoverageBP * length;
				Set<String> tooLittleCoverage = new HashSet<String>();
				for (Enumeration<String> e=typeCoverage.keys(); e.hasMoreElements();) {
					String target = e.nextElement();
					if (typeCoverage.get(target).intValue() < minCoverage) tooLittleCoverage.add(target);
					}
				for (Iterator<String> iter=tooLittleCoverage.iterator(); iter.hasNext();) 
					typeCoverage.remove(iter.next());
				int nTargets = typeCoverage.size();
				if (nTargets == 0) classifyAndAnnotateNone();
				else {
					annotation = getTargetAnnotation(typeCoverage);
					if (getCoverage() < .9*length) classification = "#PartialAnnotation";
					else if (hits.size() > 1 && !irs.contains(name) && !isSatellite()) 
						classification = "#Chimeric";
					else {
						String target = annotation.substring(0, annotation.indexOf(" "));
						if (target.indexOf("|") > 0) {
							classification = "#Retrovirus_like";
							annotation += " " + retroAnnots.get(target);
							}
						else classification = ":" + target;
						}						
					}
				}
			}

		public String getFastaHeader() {return ">" + name + classification + " " + annotation + "\n";}
			
		private void classifyAndAnnotateNone() {
			classification = "#Unclassified";
			annotation = "Matches no similar sequence";
			}

		private int getCoverage() {
			int coverage = 0;
			Hit lastHit = null;
			for (Iterator<Hit> iter=hits.iterator(); iter.hasNext();) {
				Hit hit = iter.next();
				if (lastHit == null) coverage = hit.getLength();
				else {
					if (hit.getStart() > lastHit.getEnd()) coverage += hit.getLength();
					else coverage += hit.getEnd() - lastHit.getEnd();
					}
				lastHit = hit;
				}
			return coverage;
			}
			
		private String getTargetAnnotation (Hashtable<String, Integer> typeCoverage) {
			int n = typeCoverage.size();
			String[] targets = new String[n];
			double[] coveragePC = new double[n];
			double pcDivisor = length / 100.;
			for (Enumeration<String> e=typeCoverage.keys(); e.hasMoreElements();) {
				String target = e.nextElement();
				double pcCoverage = typeCoverage.get(target).intValue() / pcDivisor;
				boolean inserted = false;
				for (int i=0; !inserted && i<n; i++)	
					if (pcCoverage > coveragePC[i]) {
						for (int j=n-2; j>=i; j--) {
							coveragePC[j+1] =coveragePC[j];
							targets[j+1] = targets[j];
							}
						coveragePC[i] = pcCoverage;
						targets[i] = target;
						inserted = true;
						}	
				}
			String anno = "";
			for (int i=0; i<n; i++) anno += (i>0?"; ":"") + targetAnnotation (targets[i], coveragePC[i]);
			return anno;
			}

		private boolean isSatellite () {
			String[] fields = annotation.split(" ");
			return fields.length == 2 && fields[0].indexOf("SAT") >= 0;
			}
													
		private void removeSubHits() {
			Collections.sort(hits, hitComparator);
			List<Hit> subHits = new ArrayList<Hit>();
			Hit lastHit = null;
			for (Iterator<Hit> iter=hits.iterator(); iter.hasNext();) {
				Hit hit = iter.next();
				if (lastHit == null) lastHit = hit;
				else 
					if (hit.getEnd() < lastHit.getEnd()) subHits.add(hit);
					else if (hit.getStart() > lastHit.getEnd()) lastHit = hit;
					else {
						double minLengthLimit = (lastHit.getEnd() - hit.getStart() + 1)/maxOverlap;
						int lastLength = lastHit.getLength();
						int hitLength = hit.getLength();
						if (lastLength < hitLength) {
							if (lastLength < minLengthLimit) subHits.add(lastHit);
							lastHit = hit;
							}
						else if (hitLength < minLengthLimit) subHits.add(hit);	
						else lastHit = hit;						
						}					
				}
			hits.removeAll(subHits);
			}
			
		private String targetAnnotation (String target, double pc) {
			return target + " (" + ((int) (pc + .5)) + ")"; 
			}
		}


	private static String iDir = "/scratch/luAnalysis/for_joy_pogona/";
	private static String oDir = "library/";
	private static String library = oDir + "R4_Pogona_Library.fasta";
	private static String headers = oDir + "wantedCSHeaders.txt";
	//private static String satFile = sDir + "LA4v2-satellite.fa";//File moved to all-repeats
	private static String CSFile = iDir + "ConsensusSequences.fa";
	private static String TEgff = iDir + "notKnown.fa.tewb.gff";
	private static String GBTE = iDir + "GB_TE.01092014.fa";
	private static String ERVgff = iDir + "notKnown.fa.ervwb.gff";
	private static String ALLR = iDir + "all_retrovirus.fasta";
	private static String SSR = iDir + "SSR.txt";
	private static String Proteins = iDir + "protein.txt";
	private static String IRS = iDir + "ConsensusSequences.fa.map"; 
	private static String IRM = iDir + "known.txt";
	private static boolean debug = false;

	public static void main (String[] arg) {
		//debug = true;
		boolean headersOnly = false;
		try {
			BufferedWriter out = new BufferedWriter(new FileWriter(headersOnly?headers:library));
			//This was not needed as it was from all-repeats
			//writeSatellite(out, satFile, "family011387#Satellite", headersOnly);
			writeConsensusSequences(out, headersOnly);
			out.close();
			}
		catch (IOException ie) {ie.printStackTrace();}
		}


	private static void addIRHits (Hashtable<String, CS> wantedCS) {
		String line = null;
		try {
			StringTokenizer st = null;
			BufferedReader in = new BufferedReader(new FileReader(IRS));
			while ((line = in.readLine()) != null) {
				st = new StringTokenizer(line);
				String seq = st.nextToken();
				if (wantedCS.containsKey(seq)) {
					int start = Integer.parseInt(st.nextToken());
					int end = Integer.parseInt(st.nextToken());
					wantedCS.get(seq).addHit(new Hit(st.nextToken(), start, end));
					}
				}
				in.close();
			}
		catch (IOException ie) {ie.printStackTrace();}
		catch (NumberFormatException ne) {System.out.println("Could not parse: " + line);}
		}
		
	private static void addRetroHits(Hashtable<String, List<Hit>> hits, String gffFile) {
		String line = null;
		try {
			BufferedReader in = new BufferedReader(new FileReader(gffFile));
			String[] fields = null;
			while ((line = in.readLine()) != null) {
				fields = line.split("\t");
				if (!hits.containsKey(fields[0])) {
					hits.put(fields[0], new ArrayList<Hit>());
					//trace("Adding Sequence: " + fields[0]);
					}
				int i1 = fields[8].indexOf(" ") + 1;
				int i2 = fields[8].indexOf(" ", i1);
				String target = fields[8].substring(i1, i2);
				hits.get(fields[0]).add(new Hit(target, Integer.parseInt(fields[3]), 
					Integer.parseInt(fields[4])));
				}
			in.close();
			trace("There are " + hits.size() + " RetroHits after adding " + gffFile);
			}
		catch (IOException ie) {ie.printStackTrace();}
		catch (NumberFormatException ne) {System.out.println("Could not parse: " + line);}
		}

	private static Hashtable<String, String> getAllRetroAnnotations() {
		String[] files = {GBTE, ALLR};
		Hashtable<String, String> annos = new Hashtable<String, String>();
		String line = null;
		BufferedReader in = null;
		for (int i=0; i<files.length; i++) 
			try {
				in = new BufferedReader(new FileReader(files[i]));
				while ((line = in.readLine()) != null) 
					if (line.length() > 0 && line.charAt(0) == '>') {
						int i1 = line.indexOf("|", 4) + 1;
						int i2 = line.indexOf("|", line.indexOf("|", i1)+1);
						annos.put(line.substring(i1, i2), line.substring(i2+2));
						}
				in.close();
				trace("There are " + annos.size() + " uniquely identified sequences after " + files[i]); 
				}
			catch (IOException ie) {ie.printStackTrace();}
		return annos;
		}

	private static Set<String> getFamilies(String inFile) {
		Set<String> families = new HashSet<String>();
		try {
			BufferedReader in = new BufferedReader(new FileReader(inFile));
			in.readLine();
			String line = null;
			while ((line = in.readLine()) != null) families.add(line.substring(0, line.indexOf(" ")));
			in.close();
			}
		catch (IOException ie) {ie.printStackTrace();}
		trace("There are " + families.size() + " families");
		return families;
		}
		
	private static Hashtable<String, Integer> getLengths (String inFile) {
		Hashtable<String, Integer> lengths = new Hashtable<String, Integer>();
		try {
			BufferedReader in = new BufferedReader(new FileReader(inFile));
			int length = 0;
			String id = null;
			String line = null;
			while ((line = in.readLine()) != null) 
				if (line.charAt(0) == '>') {
					if (id != null) lengths.put(id, new Integer(length));
					int index = line.indexOf(" ");
					id = index<0?line.substring(1):line.substring(1, index);
					length = 0;
					}
				else length += line.length();
			lengths.put(id, new Integer(length));
			in.close();
			}
		catch (IOException ie) {ie.printStackTrace();}
		trace("There are " + lengths.size() + " consensus sequence lengths");
		return lengths;
		}

	private static Hashtable<String, List<Hit>> getRetroHits() {
		Hashtable<String, List<Hit>> retroHits = new Hashtable<String, List<Hit>>();
		String[] retroHitFiles = {TEgff, ERVgff};
		for (int i=0; i<retroHitFiles.length; i++) addRetroHits(retroHits, retroHitFiles[i]);
		trace("There are " + retroHits.size() + " sequences with hits after TEs and all Retrovirus");
		return retroHits;
		}
		
	private static Hashtable<String, CS> getWantedCSs (Hashtable<String, List<Hit>> retroHits) {
		Hashtable<String, Integer> lengths = getLengths(CSFile);
		trace("There are " + lengths.size() + " sequence lengths from " + CSFile);
		removeFamilies(lengths, getFamilies(SSR));
		trace("There are " + lengths.size() + " sequence lengths after removing " + SSR + " sequences");
		Set<String> proteins = getFamilies(Proteins);
		proteins.removeAll(retroHits.keySet());
		removeFamilies(lengths, proteins);
		Hashtable<String, CS> wantedCS = new Hashtable<String, CS>();
		for (Enumeration<String> e=lengths.keys(); e.hasMoreElements();) {
			String key = e.nextElement();
			CS cs = new CS(key, lengths.get(key));
			if (retroHits.containsKey(key)) cs.addHits(retroHits.get(key));
			wantedCS.put(key, cs);
			}
		trace("There are " + wantedCS.size() + " wanted consensus sequences"); 
		return wantedCS;
		}


	private static void removeFamilies (Hashtable<String, Integer> lengths, Set<String> set) {
		for (Iterator iter=set.iterator(); iter.hasNext();) lengths.remove(iter.next());
		}

	private static void trace (String text) {if (debug) System.out.println(text);}
								
	private static void writeConsensusSequences (BufferedWriter out, boolean headersOnly) {
		//get wanted
		Hashtable<String, CS> wantedCS = getWantedCSs(getRetroHits());
		//get IR annots for wanted
		addIRHits(wantedCS);
		//process wanted and output them to library
		Hashtable<String, String> retroAnno = getAllRetroAnnotations();
		Set<String> irs = getFamilies(IRM);
		for (Enumeration<CS> e=wantedCS.elements(); e.hasMoreElements();) 
			e.nextElement().annotateAndClassify(retroAnno, irs);
		if (headersOnly) writeHeaders(out, wantedCS);
		else writeWantedSequences(out, CSFile, wantedCS);
		}

	private static void writeHeaders(BufferedWriter out, Hashtable<String, CS> wantedCS) {
		try {
			for (Enumeration<CS> e=wantedCS.elements(); e.hasMoreElements();) 
				out.write(e.nextElement().getFastaHeader());			
			}
		catch (IOException ie) {ie.printStackTrace();}
		}
				
	private static void writeSatellite(BufferedWriter out, String inFile, String id, boolean headersOnly) 
		{
		try {
			out.write(">" + id + "\n");
			if (!headersOnly) {
				BufferedReader in = new BufferedReader(new FileReader(inFile));
				in.readLine();
				String line = null;
				while ((line = in.readLine()) != null) out.write(line + "\n");
				in.close();
				}
			}
		catch (IOException ie) {ie.printStackTrace();}
		}
		
	private static void writeWantedSequences (BufferedWriter out, String seqFile, 
						  Hashtable<String, CS> wantedCS) {
	    try {
		BufferedReader in = new BufferedReader(new FileReader(seqFile));
			String line = null;
			boolean wanted = false;
			while ((line = in.readLine()) != null) 
			    if (line.charAt(0) == '>') {
				int index = line.indexOf(" ");
				String name = index<0?line.substring(1):line.substring(1,index);
				wanted = wantedCS.containsKey(name);
				if (wanted) out.write(wantedCS.get(name).getFastaHeader());
			    }
			    else if (wanted) out.write(line + "\n");
		}
		catch (IOException ie) {ie.printStackTrace();}
	}		
}

