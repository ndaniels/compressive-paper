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

pair[] p2=new pair[1000];
for (int i=0; i<1000; ++i) {
        p2[i]=(unitrand()*10,unitrand()*10);
        dot(p2[i],linewidth(4));
}
real grid = 10;
for (int i=0; i<=grid; ++i) {
        draw((0,i)--(grid,i));
        draw((i,0)--(i,grid));
}
