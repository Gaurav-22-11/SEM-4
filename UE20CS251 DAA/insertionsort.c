#include<stdio.h>
#include<stdlib.h>
#include<limits.h>
int main()
{
    int n=5;
    int a[]={INT_MIN,7,3,5,2};
    int i,j;
    int ele;
    for(int i=0;i<n;i++)
    {
        j=i-1;
        ele=a[i];
        while(j>=0 && a[j]>ele)
        {
            a[j+1]=a[j];
            j--;
        }
        a[++j]=ele;
    }
    printf("The sorted array is:");
    for(i=0;i<n;i++)
    {
        
        printf("\t%d",a[i]);
    }

}