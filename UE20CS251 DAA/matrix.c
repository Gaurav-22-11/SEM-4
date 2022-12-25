#include<stdio.h>
#include<time.h>
int main()
{
    struct timespec start,end;
    clock_gettime(CLOCK_REALTIME,&start);
    long int s=0;
    for(int i=0;i<1000;i++)
    {
        for(int j=0;j<1000;j++)
        {
            ++s;
        }
    }
    clock_gettime(CLOCK_REALTIME,&end);
    double t;
    t=end.tv_sec-start.tv_sec;
    t+=(end.tv_nsec-start.tv_nsec)*0.000000001;
    printf("time = %lf",t);
    printf("\ns=%ld",s);
} 