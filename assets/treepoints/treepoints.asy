settings.outformat = "pdf";
settings.render = 0;
settings.prc = false;
import three;
srand(0);
import stats;
import solids;

defaultpen(fontsize(5pt));
size(20cm);

currentlight.background=grey;

//label("Hello world!", (0,0));
//draw((-.1,0,0) -- (2,0,1));
//draw((0, -.1,0) --(0,1,-1));

draw(O -- 10X, green, EndArrow3);
draw(O -- 10Y, red, EndArrow3);
draw(O -- 10Z, blue, EndArrow3);

triple[] p=new triple[20];
for (int i=0; i<20; ++i) {p[i]=(0,0,0);}
pair[] z=new pair[20];
for (int i=0; i<20; ++i) {z[i]=(0,1);}

p[0]=(1,1,8);
p[1]=(1,2,7);
p[2]=(3,0,7);
p[3]=(2,4.5,5.5);
p[4]=(5,0,5);
p[5]=(10,7,6.5);
p[6]=(9,4,4);
p[7]=(7,8,5);
p[8]=(9,0,2);
p[9]=(1,6,2);
p[10]=(4,2,4);
p[11]=(9,2,4);
p[12]=(0,2,2);
p[13]=(5,2,2);
p[14]=(0,0.5,0.5);
p[15]=(0,4,1);

z[0]=(0,1);
z[1]=(0,2);
z[2]=(2,4);
z[3]=(1,3);
z[4]=(4,6);
z[5]=(3,7);
z[6]=(4,10);
z[7]=(7,5);
z[8]=(6,8);
z[9]=(7,9);
z[10]=(6,5);
z[11]=(4,11);
z[12]=(1,5);
z[13]=(10,12);
z[14]=(10,13);
z[15]=(12,14);
z[16]=(12,15);


// Create circles for clustering
path3 cle=rotate(90,X)*scale3(0.3)*unitcircle3;
triple cam=unit(currentprojection.camera);
real a=degrees(xypart(cam),false)-90;
real b=-sgn(cam.z)*aCos(sqrt(cam.x^2+cam.y^2)/abs(cam));
cle=rotate(b,cross(Z,cam))*rotate(a,Z)*cle;
//draw(cle,0.5pt+red);

real dist(triple a, triple b)
{
    return sqrt((a.x - b.x)^2 + (a.y - b.y)^2 + (a.z - b.z)^2 );
}

for (int i=0; i < 17; ++i)
{
    var a = p[(int) z[i].x];
    var b = p[(int) z[i].y];
    //draw(a--b);
    var ndots = 500;
    for (int j=0; j<=ndots; ++j)
    {
        for(int k=0; k<3; ++k)
        {
            var x = a*(1-j/ndots) + b*(j/ndots) + (unitrand()-0.5,unitrand()-0.5,unitrand()-0.5)/4;
            var xrgb=x/10;
            dot(x,rgb(xrgb.y,xrgb.x,xrgb.z)+linewidth(1));
        }
    }
    var oldc = (-100,-100,-100);
    var oldj = -100;
    for (int j=0; j<=ndots; ++j)
    {
        var x = a*(j/ndots) + b*(1-j/ndots);
        var xrgb=x/10;
        dot(x,rgb(xrgb.y,xrgb.x,xrgb.z)+linewidth(1));
        if (((dist(oldc,x)>0.5)&&(j>oldj+90)  )||(j==ndots))
        {
            oldc = x;
            oldj = j;
            draw(shift(x)*cle,1pt+rgb(xrgb.y,xrgb.x,xrgb.z));
        }
    }
}


for (int i=0; i<20; ++i)
{
    //dot(p[i]);
    //label((string) i,(p[i]),N, white);
}
