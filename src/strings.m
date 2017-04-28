#import <Foundation/Foundation.h>
#import <math.h>
#import <stdio.h>

NSString* prettyPrint(id obj);

NSString* prettyPrintString(NSString* value) {
  return value;
}

NSString* prettyPrintKeyValue(NSString* key, id value) {
  return [NSString stringWithFormat:@"(key: %@ value: %@)",key,prettyPrint(value)];
}

NSString* prettyPrintDict(NSDictionary* dict) {
  NSString *result = @"{";
  for (NSString* key in dict) {
    result = [result stringByAppendingString:prettyPrintKeyValue(key, dict[key])];
  }
  return [result stringByAppendingString:@"}"];
}

NSString* prettyPrint(id obj) {
  if ([obj isKindOfClass:[NSString class]]) {
    return prettyPrintString((NSString*) obj);
  } else if ([obj isKindOfClass:[NSDictionary class]]) {
    return prettyPrintDict((NSDictionary*) obj);
  }
  return @"Unknown type";
}

const char* toCString(NSString* s) {
  return [s cStringUsingEncoding:NSASCIIStringEncoding];
}

int main(void) {
  printf("Pretty print various objects.\n");

  NSDictionary* inner_dict = @{
    @"country" : @"Canada",
      @"capital" : @"Ottawa"
  };

  NSDictionary* dict = @{
    @"name" : @"Name of dict",
      @"body" : inner_dict
  };

  printf("%s\n", toCString(prettyPrint(dict)));
  return 0;
}
