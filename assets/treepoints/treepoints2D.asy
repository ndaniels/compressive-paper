settings.outformat = "pdf";
settings.render = 0;
settings.prc = false;
srand(0);
import stats;

defaultpen(fontsize(20pt));
size(20cm);

currentlight.background=white;

pair[] p=new pair[20];
for (int i=0; i<20; ++i) {p[i]=(0,0);}
path[] z=new path[20];
for (int i=0; i<20; ++i) {z[i]=(0,0);}
real[] w=new real[20];
for (int i=0; i<20; ++i) {w[i]=(unitrand())/1.2;}

p[0]=(1,8);
p[1]=(2,7);
p[2]=(0,7);
p[3]=(4.5,5.5);
p[4]=(1,5.5);
p[5]=(7,6.5);
p[6]=(4,4);
p[7]=(8,5);
p[8]=(5,3);
p[9]=(7,3);
p[10]=(2,3);
p[11]=(0,4);
p[12]=(3,2);
p[13]=(1,2);
p[14]=(0.5,0.5);
p[15]=(4,1);
p[16]=(8,1);
p[17]=(6,1.5);

//p[18]=(0,0);
//p[19]=(9,9);

z[0]=p[8]::p[6]::p[4]::p[2]::p[0]::p[1]::p[3]::p[7]::p[5];
z[1]=p[11]::p[4]::p[10]::p[12]::p[14];
z[2]=p[7]::p[9]::p[16];
z[3]=p[9]{down}..p[17];
z[4]=p[1]::p[5]::p[6];
z[5]=p[10]::p[13];
z[6]=p[12]::p[15];

// Create circles for clustering
path cle=scale(0.5)*unitcircle;
//draw(cle,0.5pt+red);

real dist(pair a, pair b)
{
    return sqrt((a.x - b.x)^2 + (a.y - b.y)^2 );
}

real weight_width(pair x, pair[] A) {
    var ans = 0.0;
    var total_weight=0.0;
    for (int i=0; i<A.length; ++i) {
        total_weight+= 1/(0.0001+dist(A[i],x))^2;
    }
    for (int i=0; i<A.length; ++i) {
        ans += (w[i]/(0.0001+dist(A[i],x))^2)/total_weight;
    }
    return ans;
}

real density_map(pair x) {
    pair gp = (round(x.x),round(x.y));
    return (1 - dist(gp,x))^4;
}

for (int i=0; i < 17; ++i)
{
    path pab = z[i];
    var oldc = (-100,-100);
    if (arclength(pab)>0) {
        for (real j=0; j<=1; j+= (0.001/arclength(pab)))
        {
            var x = relpoint(pab, j);
            if (density_map(x)>unitrand()) {
                x = x + (unitrand()-0.5,unitrand()-0.5)*weight_width(x,p);
                dot(x,linewidth(1));
            }
        }
        for (int j=0; j<=100; ++j)
        {
            var x = relpoint(pab,j/100);
            if (((dist(oldc,x)>0.5)  )||(j==0)||(j==100))
            {
                oldc = x;
                draw(shift(x)*cle,linewidth(1));
            }
        }
    }
    //draw(pab);
}


for (int i=0; i<20; ++i)
{
    //dot(p[i]);
    //label((string) i,(p[i]),N, green);
}
