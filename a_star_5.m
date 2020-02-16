close all;
clear all;
clc
% manhatten distance for defining heuristic
%p = input('enter number of rows in grid');
%q = input('enter number of colomn in grid');
grid = zeros(5,6);
%t type obstacle grid
%grid(1,3) = 1;grid(2,3) = 1;grid(4,3) = 1;grid(4,4)=1;
%grid(4,5) = 1;grid(3,5) = 1;grid(5,5) = 1;grid(2,5)=1;

%horizontal z grid
%grid(2,1) = 1;grid(2,2) = 1;grid(2,3) = 1;grid(2,4)=1;
%grid(4,3) = 1;grid(4,5) = 1;grid(4,4) = 1;grid(4,6)=1;

%u type obstacle grid
grid(1,2) = 1;grid(2,2) = 1;grid(3,2) = 1; 
grid(4,2) = 1;grid(5,5) = 1;grid(3,5) = 1;grid(4,5)=1;
start = [1 1];
goal = size(grid);
[p q]=size(grid);
u = [-1 0];
d = [1 0];
r = [0 1];
l = [0 -1];
g = 1;
s = goal;
heu1 = -1*ones(p,q);
heu1(p,q)=0;
z=0;
for i = 1:p
    for j = 1:q
        if grid(i,j) == 1
            heu1(i,j) = 99;
        end
    end
end
while  sum(sum(heu1))~= sum(sum(abs(heu1)))
    if (s(1)>1) && (s(1)<p+1) && (s(2)<q+1) && (s(2)>0)
       su = s+u;
       au = grid(su(1),su(2));
       if au==0 && heu1(su(1),su(2))==-1
           heu1(su(1),su(2)) = g;
           s1=su;
       end
       
    end
    
    if s(1)>0 && s(2)>0 && s(1)<p && s(2)<q+1 
        sd = s+d;
        ad = grid(sd(1),sd(2));
        if ad==0 && heu1(sd(1),sd(2)) == -1
            heu1(sd(1),sd(2)) = g;
            s1=sd;
        end
       
    end
    
     if s(1)>0 && s(1)<p+1 && s(2)<q && s(2)>0
         sr = s+r;
         ar = grid(sr(1),sr(2));
         if ar==0 && heu1(sr(1),sr(2))==-1
            heu1(sr(1),sr(2)) = g;
             s1=sr;
         end
        
     end
     
     if s(1)>0 && s(1)<p+1 && s(2)<q+1 && s(2)>1
        sl = s+l;
        al = grid(sl(1),sl(2));
        if al==0 && heu1(sl(1),sl(2))==-1
            heu1(sl(1),sl(2)) = g;
            s1 = sl;
        end  
     end
     g = g+1;
     z = z+1;
     if s==start | z>500
         break
     else
        s=s1;
     end
    
end

heu = heu1;
pos = -1*ones(goal(1),goal(2));
pos(1,1)=0;
s = start;

g = 0;

while s(1)~=goal(1) | s(2)~=goal(2) 
    
   if (s(1)>1) && (s(1)<p+1) && (s(2)<q+1) && (s(2)>0)
       su = s+u;
       au = grid(su(1),su(2));
       if au==0
           gu = g;
           fu = gu+heu(su(1),su(2));
       elseif au==1
           fu = 1000;
       end
   else
       fu = 1000;
    end
    if s(1)>0 && s(2)>0 && s(1)<p && s(2)<q+1 
        sd = s+d;
        ad = grid(sd(1),sd(2));
        if ad==0
            gd = g;
            fd = gd+heu(sd(1),sd(2));
        elseif ad == 1
            fd = 1000;
        end
    else
        fd = 1000;
    end
     if s(1)>0 && s(1)<p+1 && s(2)<q && s(2)>0
         sr = s+r;
         ar = grid(sr(1),sr(2));
         if ar==0
             gr=g;
             fr = gr+heu(sr(1),sr(2));
         elseif ar == 1
             fr=1000;
         end
     else
        fr=1000; 
     end
    if s(1)>0 && s(1)<p+1 && s(2)<q+1 && s(2)>1
        sl = s+l;
        al = grid(sl(1),sl(2));
        if al==0
            gl = g;
            fl = gl+heu(sl(1),sl(2));
        elseif al ==1
            fl = 1000;
        end    
    else
        fl = 1000;
    end
    
     A = [fu fr fd fl];
    [m,i] = min(A);
    if m==fu  
         s=su;
         g=g+1;
         pos(s(1),s(2))=g;
          heu(s(1),s(2))=99;
    elseif m == fr 
         s=sr;
         g=g+1;
         pos(s(1),s(2))=g;
          heu(s(1),s(2))=99;
    elseif m == fd 
         s=sd;
         g=g+1;
         pos(s(1),s(2))=g;
          heu(s(1),s(2))=99;
    elseif m == fl 
         s=sl;
         g=g+1;
         pos(s(1),s(2))=g;
         heu(s(1),s(2))=99;
    end
     pos; 
end
   