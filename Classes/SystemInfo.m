// SystemInfo.m

#import "SystemInfo.h"
#import <sys/types.h>
#import <sys/sysctl.h>
#import <sys/time.h>

// Note: The UIKIt import is handled conditionally in the header.

// --- Internal Helper Functions ---

// Helper function to safely query and return a string value from sysctlbyname.
static NSString *_SISStringForSpecifier(const char *specifier) {
	size_t size;
	// 1. Determine the required buffer size
	if (sysctlbyname(specifier, NULL, &size, NULL, 0) != 0) {
		NSLog(@"[SystemInfo] Error determining size for specifier: %s", specifier);
		return nil;
	}
	
	// 2. Allocate the buffer
	char *answer = malloc(size);
	if (!answer) {
		NSLog(@"[SystemInfo] Failed to allocate memory for specifier: %s", specifier);
		return nil;
	}
	
	// 3. Get the model string
	if (sysctlbyname(specifier, answer, &size, NULL, 0) != 0) {
		NSLog(@"[SystemInfo] Error retrieving value for specifier: %s", specifier);
		free(answer);
		return nil;
	}
	
	// 4. Convert C-string to NSString
	NSString *result = [NSString stringWithCString:answer 
																				encoding:NSUTF8StringEncoding];
	
	// 5. Clean up
	free(answer);
	return result;
}

// Helper function to safely query and return a 32-bit integer (uint32_t) value.
static uint32_t _SISInt32ForSpecifier(const char *specifier) {
	uint32_t value = 0;
	size_t size = sizeof(value);
	
	if (sysctlbyname(specifier, &value, &size, NULL, 0) != 0) {
		// Log an error if the call fails
		NSLog(@"[SystemInfo] Error retrieving 32-bit integer for specifier: %s", specifier);
		return 0;
	}
	return value;
}

// Helper function to safely query and return a 64-bit integer (uint64_t) value.
static uint64_t _SISInt64ForSpecifier(const char *specifier) {
	uint64_t value = 0;
	size_t size = sizeof(value);
	
	if (sysctlbyname(specifier, &value, &size, NULL, 0) != 0) {
		// Log an error if the call fails
		NSLog(@"[SystemInfo] Error retrieving 64-bit integer for specifier: %s", specifier);
		return 0;
	}
	return value;
}

// Helper function to convert the compile-time version integer (e.g., 170000) into a 
// formatted string (e.g., "17.0.0").
static NSString *_SISFormattedVersionString(NSInteger version) {
	if (version == 0) return @"0.0.0"; // Or another sensible default if the version macro was 0
	
	// Version integer format is Major*10000 + Minor*100 + Patch
	NSInteger major = version / 10000;
	NSInteger minor = (version % 10000) / 100;
	NSInteger patch = version % 100;
	
	return [NSString stringWithFormat:@"%ld.%ld.%ld", (long)major, (long)minor, (long)patch];
}


// --- Public API Implementations ---

// Hardware Specifiers (sysctl)

NSString *SISGetHWMachine(void) {
	// Specifier: "hw.machine"
	return _SISStringForSpecifier("hw.machine");
}

NSString *SISGetHWModel(void) {
	// Specifier: "hw.model"
	return _SISStringForSpecifier("hw.model");
}

uint32_t SISGetHWNCPU(void) {
	// Specifier: "hw.ncpu".
	return _SISInt32ForSpecifier("hw.ncpu");
}

uint64_t SISGetHWMemSize(void) {
	// TODO: Confirm why this is 0 but other uses of _ function are not 0
	// Specifier: "hw.memsize"
	return _SISInt64ForSpecifier("hw.memsize");
}

uint64_t SISGetHWPageSize(void) {
	// Specifier: "hw.pagesize"
	return _SISInt64ForSpecifier("hw.pagesize");
}


// Kernel Specifiers (sysctl)

NSString *SISGetKernOSRelease(void) {
	// Specifier: "kern.osrelease"
	return _SISStringForSpecifier("kern.osrelease");
}

NSString *SISGetKernOSVersion(void) {
	// Specifier: "kern.osversion"
	return _SISStringForSpecifier("kern.osversion");
}

NSString *SISGetKernHostname(void) {
	// Specifier: "kern.hostname"
	return _SISStringForSpecifier("kern.hostname");
}

NSDate *SISGetKernBootTime(void) {
	// Specifier: "kern.boottime" returns a struct timeval
	struct timeval boottime;
	size_t size = sizeof(boottime);
	
	// Query the kernel for the boot time structure
	if (sysctlbyname("kern.boottime", &boottime, &size, NULL, 0) != 0) {
		NSLog(@"[SystemInfo] Error retrieving boot time.");
		return nil;
	}
	
	// Convert the seconds component of the struct timeval to an NSDate
	NSTimeInterval bootInterval = (NSTimeInterval)boottime.tv_sec;
	return [NSDate dateWithTimeIntervalSince1970:bootInterval];
}


// --- Compile-Time Macro/Environment Checks ---

BOOL SISIsTargetSimulator(void) {
#if TARGET_IPHONE_SIMULATOR
	return YES;
#else
	return NO;
#endif
}

BOOL SISIsArchPPCFamily(void) {
	// Checks for 32-bit (__ppc__) OR 64-bit (__ppc64__). The uppercase macro (__PPC__) is kept for legacy compatibility.
#if defined(__ppc__) || defined(__ppc64__) || defined(__PPC__)
	return YES;
#else
	return NO;
#endif
}

BOOL SISIsArchIntelFamily(void) {
	// Checks for 32-bit i386 (__i386__) OR 64-bit x86_64 (__x86_64__).
#if defined(__i386__) || defined(__x86_64__)
	return YES;
#else
	return NO;
#endif
}

BOOL SISIsArchARMFamily(void) {
	// Checks for 32-bit ARM (__arm__) OR 64-bit ARM (__arm64__).
#if defined(__arm__) || defined(__arm64__)
	return YES;
#else
	return NO;
#endif
}

NSString *SISGetCompileTimeMinOSVersion(void) {
	// Uses preprocessor directives to select the correct minimum required version macro.
#if TARGET_OS_IPHONE
	// iOS/tvOS macro (e.g., 170000)
	return _SISFormattedVersionString(__IPHONE_OS_VERSION_MIN_REQUIRED);
#else
	// macOS macro (e.g., 101500)
	return _SISFormattedVersionString(__MAC_OS_X_VERSION_MIN_REQUIRED);
#endif
}

NSString *SISGetCompileTimeMaxOSVersion(void) {
	// Uses preprocessor directives to select the correct maximum allowed version macro.
#if TARGET_OS_IPHONE
	// iOS/tvOS macro (e.g., 170000)
	return _SISFormattedVersionString(__IPHONE_OS_VERSION_MAX_ALLOWED);
#else
	// macOS macro (e.g., 140300 for 14.3)
	return _SISFormattedVersionString(__MAC_OS_X_VERSION_MAX_ALLOWED);
#endif
}


// --- Runtime System Information ---

NSString *SISGetCurrentOSVersion(void) {
	// This function uses conditional compilation to select the appropriate API 
	// for the target OS (iOS/tvOS vs. macOS/Others).
	
#if TARGET_OS_IPHONE
	// iOS/tvOS: Use UIDevice
	// The conditional import of UIKit is handled in the header file.
	return [[UIDevice currentDevice] systemVersion];
#else
	// macOS/Other: Use NSProcessInfo (available via Foundation)
	return [[NSProcessInfo processInfo] operatingSystemVersionString];
#endif
}