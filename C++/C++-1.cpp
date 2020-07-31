#include<iostream>
#include<cmath>
#include <random>
#include<algorithm>
#include<chrono>
using namespace std;
using namespace std::chrono; 

int main()
{
 random_device rd; // obtain a random number from hardware
 mt19937 gen(rd()); // seed the generator
 uniform_int_distribution<> distr(0,9); // define the range
 auto f = []() -> int { return rand() % 10000; }; 
 for(int i=1;i<10;i++)
 {
       // Get starting timepoint 
       auto start = high_resolution_clock::now(); 
   int a[i],b[i],result[i];
   for(int j=i;j<=i*i;j++)
   {
   a[j]=distr(gen);
   b[j]=distr(gen);
   result[j]=a[i]*b[i];
   cout<<result[i]<<endl;
   }
    // Get ending timepoint 
    auto stop = high_resolution_clock::now(); 
    // Get duration. Substart timepoints to  
    // get durarion. To cast it to proper unit 
    // use duration cast method 
    auto duration = duration_cast<microseconds>(stop - start); 
  
    cout << "Time taken by function: "
         << duration.count() << " microseconds" << endl; 
 }
 return 0;
}
