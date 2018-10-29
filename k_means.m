clear all
load fisheriris.mat
GlobalMean = mean(meas);
[r,c] = size(meas);


for i=1:c
NormalizedData(:,i) = meas(:,i) - GlobalMean(:,i);
end
CovarianceMatrix = cov(NormalizedData);
[EigenVector, EigenValue] = eig(CovarianceMatrix);
EigenValue = diag(EigenValue);
[EigenValueSorted, index] = sort(EigenValue,'descend');

for i=1:c
PrincipleComponents(:,i)=EigenVector(:,index(i,1));
end

for i=1:2
    ProjectedData(:,i)= NormalizedData*PrincipleComponents(:,i);
end

%scatter(ProjectedData(:,1),ProjectedData(:,2));
%hold on;
Data = ProjectedData;
%a=randi([1 150],1,1);
 %y1=randi([1 2],1,1);
 x1 =Data(6,1);
 y1 =Data(6,2);
 c1 = [x1 y1];
 
% b=randi([1 150],1,1);
 %y2=randi([1 2],1,1);
 x2=Data(66,1);
 y2=Data(66,2);
 c2 = [x2 y2];
 
 %c=randi([1 150],1,1);
 %y2=randi([1 2],1,1);
 x3=Data(58,1);
 y3=Data(58,2);
 c3 = [x3 y3];
 
 
 while 1
      MemberMatrix =zeros(150 ,3);
      c1_members = 0;
      c2_members = 0;
      c3_members = 0;
      
      sumOfx1_c1=0;
      sumOfy1_c1=0;
      
      sumOfx1_c2=0;
      sumOfy1_c2=0;
      
      sumOfx1_c3=0;
      sumOfy1_c3=0;
      
     for i=1:r
     distanceFrom_c1 = ((c1(1,1)-Data(i,1))^2 + (c1(1,2)-Data(i,2))^2)^0.5;
     distanceFrom_c2 = ((c2(1,1)-Data(i,1))^2 + (c2(1,2)-Data(i,2))^2)^0.5;
     distanceFrom_c3 = ((c3(1,1)-Data(i,1))^2 + (c3(1,2)-Data(i,2))^2)^0.5;
        if (distanceFrom_c1 < distanceFrom_c2 && distanceFrom_c1 < distanceFrom_c3)
            MemberMatrix(i,1)=1;
            %MemberMatrix(i,2)=0;
            c1_members = c1_members+1;
        elseif (distanceFrom_c2 < distanceFrom_c1 && distanceFrom_c2 < distanceFrom_c3)
            MemberMatrix(i,2)=1;
            %MemberMatrix(i,1)=0;
            c2_members = c2_members+1;
        else
            MemberMatrix(i,3)=1;
            c3_members = c3_members+1;
        end
     end
     prev_c1 = round(c1);
     prev_c2 = round(c2);
     prev_c3 = round(c3);
     for i=1:r
         if(MemberMatrix(i,1)==1)
             sumOfx1_c1 = sumOfx1_c1+Data(i,1);
             sumOfy1_c1 = sumOfy1_c1+Data(i,2);
         elseif(MemberMatrix(i,2)==1)
             sumOfx1_c2 = sumOfx1_c2+Data(i,1);
             sumOfy1_c2 = sumOfy1_c2+Data(i,2);
         else
             sumOfx1_c3 = sumOfx1_c3+Data(i,1);
             sumOfy1_c3 = sumOfy1_c3+Data(i,2);
         end
     end
     
     c1 = [sumOfx1_c1/c1_members, sumOfy1_c1/c1_members];
     c2 = [sumOfx1_c2/c2_members, sumOfy1_c2/c2_members];
     c3 = [sumOfx1_c3/c3_members, sumOfy1_c3/c3_members];
     
     c1=round(c1);
     c2=round(c2);
     c3=round(c3);
    % if c1==prev_c1 && c2==prev_c2
     %    break;
     %end
     if(isequal(c1,prev_c1) && isequal(c2,prev_c2) && isequal(c3,prev_c3))
         break
     end
 end
 
 for i=1:r
    if(MemberMatrix(i,1)==1)
        c1_class(i,:)=Data(i,:);
    elseif (MemberMatrix(i,2)==1)
        c2_class(i,:)=Data(i,:);
    else
        c3_class(i,:)=Data(i,:);
    end
 end
 
 hold on;       
 scatter(c1_class(:,1), c1_class(:,2), 'r');
 scatter(c1(1,1), c1(1,2), 'r','filled');
 
 scatter(c2_class(:,1), c2_class(:,2), 'b');
 scatter(c2(1,1), c2(1,2), 'b','filled');
 
 scatter(c3_class(:,1), c3_class(:,2), 'k');
 scatter(c3(1,1), c3(1,2), 'k','filled');
