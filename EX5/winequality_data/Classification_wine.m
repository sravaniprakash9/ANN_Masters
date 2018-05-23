
 fid = fopen('winequality-red.csv','rt');
 
 data = textscan(fid,'%s%s%s%s%s%s%s%s%s%s%s%s','Delimiter', ';','endofline','\n');
 fclose(fid);
 
 tab=table(data(1:12));
 x=zeros(1599,12);
 
 for i=1:size(x,2)
  
     
  Column=tab.Var1{1,i};
  labels=cell2mat(Column{2:1600,:});
  labels_num=str2num(labels);
  x(i,:)=labels_num;
  
 end
 
 %%Merging 4,5 classes
 indL = x(12,:);
 indL(ismember(indL, 5)) = 4;
 ind_no7 = x(12,:) ~=7;
 classes_4and6 = indL(ind_no7);
 
 %%Prepare data by extracting rows with ind_no7
 
 
 