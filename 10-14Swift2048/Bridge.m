
#import "Bridge.h"
#import "sqlite3.h"

@implementation Bridge

+(NSString *)esc:(NSString *)str {
	if (!str || [str length] == 0) {
		return @"''";
	}
	NSString *buf = @(sqlite3_mprintf("%q", [str cStringUsingEncoding:NSUTF8StringEncoding]));
	return buf;
}

@end
