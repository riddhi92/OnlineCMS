package process;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Random;
import db.DBConnection;

public class RandomQuestions {

	public static int[] generate(int eid){
		int count = 0;
		int hardness = 1;
		int totalque = 0;
		int noofque[] = new int[5];
		int finalselectedque[] = null;
		try{
			ResultSet rs0 = DBConnection.selectQuery("select TOTAL_QUEST, HARDNESS from examinfo where exam_id="+eid);
			if(rs0.next())
			{
				hardness = rs0.getInt("HARDNESS");			
				totalque = rs0.getInt("TOTAL_QUEST");
				finalselectedque = new int[totalque];
				//-------------------
				if(hardness == 1)
				{
					noofque[0] = Math.round(totalque * 0.3f);
					noofque[1] = Math.round(totalque * 0.3f);
					noofque[3] = Math.round(totalque * 0.1f);
					noofque[4] = Math.round(totalque * 0.1f);
					noofque[2] = totalque -(noofque[0] + noofque[1] + noofque[3] + noofque[4]);
				}
				else if(hardness == 2)
				{
					noofque[0] = Math.round(totalque * 0.2f);
					noofque[1] = Math.round(totalque * 0.3f);
					noofque[3] = Math.round(totalque * 0.2f);
					noofque[4] = Math.round(totalque * 0.1f);
					noofque[2] = totalque -(noofque[0] + noofque[1] + noofque[3] + noofque[4]);
				}
				else if(hardness == 3)
				{
					noofque[0] = Math.round(totalque * 0.2f);
					noofque[1] = Math.round(totalque * 0.2f);
					noofque[3] = Math.round(totalque * 0.2f);
					noofque[4] = Math.round(totalque * 0.2f);
					noofque[2] = totalque -(noofque[0] + noofque[1] + noofque[3] + noofque[4]);
				}
				else if(hardness == 4)
				{
					noofque[0] = Math.round(totalque * 0.1f);
					noofque[1] = Math.round(totalque * 0.2f);
					noofque[3] = Math.round(totalque * 0.3f);
					noofque[4] = Math.round(totalque * 0.2f);
					noofque[2] = totalque -(noofque[0] + noofque[1] + noofque[3] + noofque[4]);
				}
				else
				{
					noofque[0] = Math.round(totalque * 0.1f);
					noofque[1] = Math.round(totalque * 0.1f);
					noofque[3] = Math.round(totalque * 0.30f);
					noofque[4] = Math.round(totalque * 0.30f);
					noofque[2] = totalque -(noofque[0] + noofque[1] + noofque[3] + noofque[4]);
				}
				//-------------------
				int z = 0;
				for(int i = 1; i <=5; i++)
				{
					ResultSet rs1 = DBConnection.selectQuery("select count(*) CNT from qbank where qlevel="+i);
					
					if(rs1.next())
					{
						count = rs1.getInt("CNT");
						int allonelevel[] = new int[count];
						ResultSet rs2 = DBConnection.selectQuery("select qid from qbank where qlevel="+i);
						int j = 0;
						while(rs2.next())
						{
							allonelevel[j] = rs2.getInt("qid");
							j++;
						}
						int k = 0, temp;
						while(k!=noofque[i-1])
						{
					    	Random rand = new Random();
					    	int randomNum = rand.nextInt(((count-1) - 0) + 1);
					    	temp = allonelevel[randomNum];
					    	int y = 0;
					    	boolean flag = true; 
					    	while(true)
					    	{
					    		if(temp == finalselectedque[y])
					    		{
					    			flag = false;
					    			break;
					    		}
					    		y++;
					    		if(y== totalque-1)
					    			break;
					    	}
					    	if(flag){ // <<=================== Looping Problem for less no of questions will arise!
					    		finalselectedque[z] = temp;
					    		z++;
					    		k++;
					    	}
						}
					}
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return finalselectedque;
	}
}
