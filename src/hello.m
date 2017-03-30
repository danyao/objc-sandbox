#import <Foundation/Foundation.h>
#import <math.h>
#import <stdio.h>

@interface DWPoint : NSObject
{
  @private
    double x;
    double y;
}

- (id) x: (double) x_value;
- (double) x;
- (id) y: (double) y_value;
- (double) y;
- (double) length;
- (id) add: (DWPoint*) other;
- (bool) isEqualTo: (DWPoint*) other;

@end

@implementation DWPoint

- (id) x: (double) x_value {
  x = x_value;
  return self;
}

- (double) x {
  return x;
}

- (id) y: (double) y_value {
  y = y_value;
  return self;
}

- (double) y {
  return y;
}

- (double) length {
  return sqrt(x * x + y * y);
}

- (id) add: (DWPoint*) other {
  double new_x = x + [other x];
  double new_y = y + [other y];

  DWPoint* sum = [DWPoint new];
  [sum x:new_x];
  [sum y:new_y];

  return sum;
}

- (bool) isEqualTo: (DWPoint*) other {
  return x == [other x] && y == [other y];
}

@end


void print(DWPoint* point) {
  printf("DWPoint(%g, %g) => %g\n", [point x], [point y], [point length]);  
}

int main(void) {
  printf("Hello World!\n");

  DWPoint* a = [DWPoint new];
  [a x:1];
  [a y:2];

  DWPoint* b = [DWPoint new];
  [b x:-1];
  [b y:3];

  // Expects Point(1, 2) => 2.xx
  print(a);

  // Expects Point(-1, 3) => 3.xx
  print(b);

  // Expects Point(0, 5) => 5
  DWPoint* c = [a add: b];
  print(c);

  DWPoint* d = [DWPoint new];
  [[d x:0] y:5];
  print(d);

  bool c_is_equal_to_d = [c isEqualTo: d];
  printf("c is equal to d? %s\n", c_is_equal_to_d ? "true" : "false");

  return 0;
}
