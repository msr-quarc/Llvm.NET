#ifndef _INLINED_EXPORTS_H_
#define _INLINED_EXPORTS_H_

#include "llvm-c/Support.h"

#ifdef __cplusplus
extern "C" {
#endif
    // exportable wrappers around static inlined functions
    // EXPORTS.DEF uses aliasing to export these as the standard name
    // (e.g. dropping the trailing "Export" from the name.) This
    // mechanism is needed since the inlined functions are marked static
    // and therefore the linker doesn't see them as externally visible
    // so it can't export them.

    /** LLVMInitializeAllTargetInfos - The main program should call this function if
    it wants access to all available targets that LLVM is configured to
    support. */
    void LLVMInitializeAllTargetInfosEx( void );

    /** LLVMInitializeAllTargets - The main program should call this function if it
    wants to link in all available targets that LLVM is configured to
    support. */
    void LLVMInitializeAllTargetsEx( void );

    /** LLVMInitializeAllTargetMCs - The main program should call this function if
    it wants access to all available target MC that LLVM is configured to
    support. */
    void LLVMInitializeAllTargetMCsEx( void );

    /** LLVMInitializeAllAsmPrinters - The main program should call this function if
    it wants all asm printers that LLVM is configured to support, to make them
    available via the TargetRegistry. */
    void LLVMInitializeAllAsmPrintersEx( void );

    /** LLVMInitializeAllAsmParsers - The main program should call this function if
    it wants all asm parsers that LLVM is configured to support, to make them
    available via the TargetRegistry. */
    void LLVMInitializeAllAsmParsersEx( void );

    /** LLVMInitializeAllDisassemblers - The main program should call this function
    if it wants all disassemblers that LLVM is configured to support, to make
    them available via the TargetRegistry. */
    void LLVMInitializeAllDisassemblersEx( void );

    LLVMBool LLVMInitializeNativeTargetEx(void);
    LLVMBool LLVMInitializeNativeAsmParserEx(void);
    LLVMBool LLVMInitializeNativeAsmPrinterEx(void);
    LLVMBool LLVMInitializeNativeDisassemblerEx(void);
#ifdef __cplusplus
}
#endif

#endif
