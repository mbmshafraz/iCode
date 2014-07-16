//
//  NSData+iCode.m
//  iCode
//
/*
 
 Copyright (c) 2012, Shafraz Buhary
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 
 Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 Neither the name of the Copyright holder  nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 */

#import "NSData+iCode.h"

@implementation NSData (iCode)

- (NSString *)base64EncodedString
{
    const unsigned char *dataBytes = [self bytes];
    
    if (dataBytes == nil) return nil;
    
    const char lookup[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
    
    unsigned long dataLength = [self length];
    unsigned long maxOutputLength = ((dataLength + 2) / 3) * 4;
    unsigned char *outputBuffer = (unsigned char *)malloc(maxOutputLength);
    unsigned char *outputPointer = outputBuffer;
    
    
    while (dataLength > 2) { // keep going until we have less than 24 bits
		*outputPointer++ = lookup[dataBytes[0] >> 2];
		*outputPointer++ = lookup[((dataBytes[0] & 0x03) << 4) | (dataBytes[1] >> 4)];
		*outputPointer++ = lookup[((dataBytes[1] & 0x0F) << 2) | (dataBytes[2] >> 6)];
		*outputPointer++ = lookup[dataBytes[2] & 0x3F];
		
		// we just handled 3 octets (24 bits) of data
		dataBytes  += 3; // Moving pointer to next block (24 bits) of data
		dataLength -= 3;
	}
    
    // now deal with the tail end of things
	if (dataLength != 0) {
		*outputPointer++ = lookup[dataBytes[0] >> 2];
		if (dataLength > 1) { //= 2
			*outputPointer++ = lookup[((dataBytes[0] & 0x03) << 4) | (dataBytes[1] >> 4)];
			*outputPointer++ = lookup[(dataBytes[1] & 0x0F) << 2];
			*outputPointer++ = '=';
		} else { //=1
			*outputPointer++ = lookup[(dataBytes[0] & 0x03) << 4];
			*outputPointer++ = '=';
			*outputPointer++ = '=';
		}
	}
    
    return  [[NSString alloc] initWithBytesNoCopy:outputBuffer length:outputPointer - outputBuffer
                                         encoding:NSASCIIStringEncoding freeWhenDone:YES];
}

+ (NSData *)dataWithBase64EncodedString:(NSString *)base64EncodedString
{
    
    const short lookup[] = {
        -2, -2, -2, -2, -2, -2, -2, -2, -2, -1, -1, -2, -1, -1, -2, -2,
        -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
        -1, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, 62, -2, -2, -2, 63,
        52, 53, 54, 55, 56, 57, 58, 59, 60, 61, -2, -2, -2, -2, -2, -2,
        -2,  0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14,
        15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, -2, -2, -2, -2, -2,
        -2, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40,
        41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, -2, -2, -2, -2, -2,
        -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
        -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
        -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
        -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
        -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
        -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
        -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
        -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2
    };
    
    const char * inputBytes = [base64EncodedString cStringUsingEncoding:NSASCIIStringEncoding];
	if (inputBytes == NULL)  return nil;
	size_t intputLength = strlen(inputBytes);
	int intCurrent;
	int i = 0, j = 0, k;
    
	unsigned char *outputBuffer = malloc(intputLength);
    
	while ( ((intCurrent = *inputBytes++) != '\0') && (intputLength-- > 0) ) {
		if (intCurrent == '=') {
			if (*inputBytes != '=' && ((i % 4) == 1)) {
				free(outputBuffer);
				return nil;
			}
			continue;
		}
        
		intCurrent = lookup[intCurrent];
		if (intCurrent == -1) {
			// we're at a whitespace -- simply skip over
			continue;
		} else if (intCurrent == -2) {
			// we're at an invalid character
			free(outputBuffer);
			return nil;
		}
        
		switch (i % 4) {
			case 0:
				outputBuffer[j] = intCurrent << 2;
				break;
                
			case 1:
				outputBuffer[j++] |= intCurrent >> 4;
				outputBuffer[j] = (intCurrent & 0x0f) << 4;
				break;
                
			case 2:
				outputBuffer[j++] |= intCurrent >>2;
				outputBuffer[j] = (intCurrent & 0x03) << 6;
				break;
                
			case 3:
				outputBuffer[j++] |= intCurrent;
				break;
		}
		i++;
	}
    
	// mop things up if we ended on a boundary
	k = j;
	if (intCurrent == '=') {
		switch (i % 4) {
			case 1:
				// Invalid state
				free(outputBuffer);
				return nil;
                
			case 2:
				k++;
				// flow through
			case 3:
				outputBuffer[k] = 0;
		}
	}
    
	// Cleanup and setup the return NSData
	return [[NSData alloc] initWithBytesNoCopy:outputBuffer length:j freeWhenDone:YES];
}

@end
