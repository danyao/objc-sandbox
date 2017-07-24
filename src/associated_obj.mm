// Toy code for storing a C++ object in associated object.
// The Objective C wrapper is required. Otherwise, you'll see error like this:
//
// /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.12.sdk/usr/include/objc/runtime.h:1526:18: note: candidate function not viable: no known
// conversion from 'Point *' to 'id' for 3rd argument
// OBJC_EXPORT void objc_setAssociatedObject(id object, const void *key, id value, objc_AssociationPolicy policy)

#import <Foundation/Foundation.h>
#include <memory>
#import <objc/runtime.h>
#import <stdio.h>

static char kPointKey;

class DWPoint {
 public:
  DWPoint(int x, int y) {
    x_ = x;
    y_ = y;
  }

  ~DWPoint() {
    printf("Destructor called.\n");
  }

  void print() {
    printf("DWPoint(%d, %d)\n", x_, y_);
  }

 private:
  int x_;
  int y_;
};

@interface DWOCPoint : NSObject
- (void)set:(std::unique_ptr<DWPoint>)raw_point;
- (std::unique_ptr<DWPoint>)get;

@end

@implementation DWOCPoint
std::unique_ptr<DWPoint> data_;


-(void)set:(std::unique_ptr<DWPoint>)raw_point {
  data_ = std::move(raw_point);
}

-(std::unique_ptr<DWPoint>)get {
  return std::move(data_);
}

@end

void setAssociated(NSObject* obj, std::unique_ptr<DWPoint> p) {
  DWOCPoint* holder = [DWOCPoint alloc];
  [holder set:std::move(p)];
  objc_setAssociatedObject(obj, &kPointKey, holder, OBJC_ASSOCIATION_RETAIN);
}

std::unique_ptr<DWPoint> getAssociated(NSObject* obj) {
  DWOCPoint* holder = objc_getAssociatedObject(obj, &kPointKey);
  return [holder get];
}

int main(void) {

  NSString* hello = [NSString alloc];
  std::unique_ptr<DWPoint> p(new DWPoint(1, 2));

  setAssociated(hello, std::move(p));
  std::unique_ptr<DWPoint> q = getAssociated(hello);
  assert(q != nullptr);
  q->print();

  NSString* hi = [NSString alloc];
  std::unique_ptr<DWPoint> r = getAssociated(hi);
  assert(r == nullptr);

  printf("Exiting...\n");
  return 0;

}
