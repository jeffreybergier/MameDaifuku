// SystemInfo.h
// Provides C function wrappers for low-level sysctlbyname calls and compile/runtime checks.

#import <Foundation/Foundation.h>
#import <sys/types.h>
#import <sys/sysctl.h>
#import <sys/time.h> // Needed for struct timeval

// Import UIKit for runtime device information (only available on iOS/tvOS targets)
#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

// --- Hardware (hw) Specifiers (sysctl) ---

// Returns the device model identifier (specifier: "hw.machine").
NSString *SISGetHWMachine(void);

// Returns the machine model (specifier: "hw.model").
NSString *SISGetHWModel(void);

// Returns the number of physical CPU cores (specifier: "hw.ncpu").
NSUInteger SISGetHWNCPU(void);

// Returns the total physical memory (RAM) in bytes (specifier: "hw.memsize").
NSUInteger SISGetHWMemSize(void);

// Returns the memory page size in bytes (specifier: "hw.pagesize").
NSUInteger SISGetHWPageSize(void);


// --- Kernel (kern) Specifiers (sysctl) ---

// Returns the kernel release version (specifier: "kern.osrelease").
NSString *SISGetKernOSRelease(void);

// Returns the OS build version (specifier: "kern.osversion").
NSString *SISGetKernOSVersion(void);

// Returns the network hostname for the device (specifier: "kern.hostname").
NSString *SISGetKernHostname(void);

// Returns the date and time the device last booted (specifier: "kern.boottime").
NSDate *SISGetKernBootTime(void);


// --- Compile-Time Macro/Environment Checks ---

// Returns YES if the code is being compiled for the iOS/tvOS simulator.
BOOL SISIsTargetSimulator(void);

// Returns YES if the code is compiled for any PowerPC architecture (32-bit or 64-bit).
BOOL SISIsArchPPCFamily(void);

// Returns YES if the code is compiled for any Intel architecture (i386 or x86_64).
BOOL SISIsArchIntelFamily(void);

// Returns YES if the code is compiled for any ARM architecture (arm or arm64).
BOOL SISIsArchARMFamily(void);

// Returns the minimum required iOS version defined in the build settings as a formatted string (e.g., "17.0.0").
NSString *SISGetCompileTimeMinOSVersion(void);

// Returns the maximum allowed iOS version defined in the SDK used for building as a formatted string (e.g., "17.0.0").
NSString *SISGetCompileTimeMaxOSVersion(void);


// --- Runtime System Information ---

// Returns the actual running OS version as a string (e.g., "17.4" on iOS, "Version 14.3" on macOS).
// Uses [UIDevice systemVersion] on iOS/tvOS and [NSProcessInfo operatingSystemVersionString] elsewhere.
NSString *SISGetCurrentOSVersion(void);


#ifdef __cplusplus
}
#endif