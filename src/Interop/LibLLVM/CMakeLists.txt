cmake_minimum_required(VERSION 3.0.0)
project(Ubiquity.NET.LibLlvm VERSION 0.1.0)

if(POLICY CMP0076)
  cmake_policy(SET CMP0076 NEW)
endif()

message("CMAKE version is " ${CMAKE_VERSION})
message("Host system name is " ${CMAKE_HOST_SYSTEM_NAME})
message("Host system processor is " ${CMAKE_HOST_SYSTEM_PROCESSOR})
message("C++ compiler is " ${CMAKE_CXX_COMPILER})
message("C++ compiler ID is " ${CMAKE_CXX_COMPILER_ID})

message(INFO "*** build config: ${CMAKE_BUILD_TYPE}")

set(CMAKE_CXX_STANDARD 14 CACHE STRING "C++ standard to conform to")
set(CMAKE_CXX_STANDARD_REQUIRED YES)
set(CMAKE_CXX_EXTENSIONS NO)

set(CMAKE_VERBOSE_MAKEFILE TRUE)
set(LLVM_VERSION_STRING "10.0.0")
set(LLVM_VERSION_MAJOR "10")
set(LLVM_VERSION_MINOR "0")
set(LLVM_VERSION_PATCH "0")

include(CTest)
enable_testing()

add_library(Ubiquity.NET.LibLlvm SHARED "")

target_include_directories(Ubiquity.NET.LibLlvm PRIVATE "../../../llvm/include")
target_include_directories(Ubiquity.NET.LibLlvm PRIVATE "../../../llvm/lib/ExecutionEngine/Orc")
target_include_directories(Ubiquity.NET.LibLlvm PRIVATE "include")
target_include_directories(Ubiquity.NET.LibLlvm PRIVATE ".")

target_link_directories(Ubiquity.NET.LibLlvm BEFORE PRIVATE "../../../llvm/lib")

add_compile_definitions("NDEBUG" "_USRDLL" "LIBLLVM_EXPORTS" "LibLLVM_EXPORTS")
add_compile_definitions("_ITERATOR_DEBUG_LEVEL=0")

if (NOT WIN32)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fno-rtti -fno-exceptions -pthread")
endif()

target_sources(Ubiquity.NET.LibLlvm PUBLIC "EXPORTS.g.DEF")

target_sources(Ubiquity.NET.LibLlvm PRIVATE 
    "AnalysisBindings" 
    "AttributeBindings" 
    "ContextBindings" 
    "DIBuilderBindings"
    "ObjectFileBindings"
    "InlinedExports" 
    "IRBindings" 
    "LibLlvmOrcJitBindings"
    "MetadataBindings" 
    "PassManagerBindings" 
    "ModuleBindings" 
    "TripleBindings" 
    "ValueBindings")

target_link_libraries(Ubiquity.NET.LibLlvm PRIVATE
        "LLVMAArch64AsmParser"
        "LLVMAArch64CodeGen"
        "LLVMAArch64Desc"
        "LLVMAArch64Disassembler"
        "LLVMAArch64Info"
        "LLVMAArch64Utils"
        "LLVMAggressiveInstCombine"
        "LLVMAMDGPUAsmParser"
        "LLVMAMDGPUCodeGen"
        "LLVMAMDGPUDesc"
        "LLVMAMDGPUDisassembler"
        "LLVMAMDGPUInfo"
        "LLVMAMDGPUUtils"
        "LLVMARMAsmParser"
        "LLVMARMCodeGen"
        "LLVMARMDesc"
        "LLVMARMDisassembler"
        "LLVMARMInfo"
        "LLVMARMUtils"
        "LLVMBPFAsmParser"
        "LLVMBPFCodeGen"
        "LLVMBPFDesc"
        "LLVMBPFDisassembler"
        "LLVMBPFInfo"
        "LLVMCFGuard"
        "LLVMCoroutines"
        "LLVMCoverage"
        "LLVMDlltoolDriver"
        "LLVMDWARFLinker"
        "LLVMExecutionEngine"
        "LLVMFrontendOpenMP"
        "LLVMFuzzMutate"
        "LLVMGlobalISel"
        "LLVMHexagonAsmParser"
        "LLVMHexagonCodeGen"
        "LLVMHexagonDesc"
        "LLVMHexagonDisassembler"
        "LLVMHexagonInfo"
        "LLVMInstCombine"
        "LLVMInstrumentation"
        "LLVMInterpreter"
        "LLVMipo"
        "LLVMIRReader"
        "LLVMAsmParser"
        "LLVMAsmPrinter"
        "LLVMDebugInfoCodeView"
        "LLVMDebugInfoDWARF"
        "LLVMDebugInfoGSYM"
        "LLVMDebugInfoMSF"
        "LLVMDebugInfoPDB"
        "LLVMJITLink"
        "LLVMLanaiAsmParser"
        "LLVMLanaiCodeGen"
        "LLVMLanaiDesc"
        "LLVMLanaiDisassembler"
        "LLVMLanaiInfo"
        "LLVMLibDriver"
        "LLVMLineEditor"
        "LLVMLinker"
        "LLVMLTO"
        "LLVMMCDisassembler"
        "LLVMMCJIT"
        "LLVMMCParser"
        "LLVMMipsAsmParser"
        "LLVMMipsCodeGen"
        "LLVMMipsDesc"
        "LLVMMipsDisassembler"
        "LLVMMipsInfo"
        "LLVMMIRParser"
        "LLVMMSP430AsmParser"
        "LLVMMSP430CodeGen"
        "LLVMMSP430Desc"
        "LLVMMSP430Disassembler"
        "LLVMMSP430Info"
        "LLVMNVPTXCodeGen"
        "LLVMNVPTXDesc"
        "LLVMNVPTXInfo"
        "LLVMObjCARCOpts"
        "LLVMObject"
        "LLVMObjectYAML"
        "LLVMOption"
        "LLVMOrcError"
        "LLVMOrcJIT"
        "LLVMPasses"
        "LLVMPowerPCAsmParser"
        "LLVMPowerPCCodeGen"
        "LLVMPowerPCDesc"
        "LLVMPowerPCDisassembler"
        "LLVMPowerPCInfo"
        "LLVMProfileData"
        "LLVMRISCVAsmParser"
        "LLVMRISCVCodeGen"
        "LLVMRISCVDesc"
        "LLVMRISCVDisassembler"
        "LLVMRISCVInfo"
        "LLVMRISCVUtils"
        "LLVMRuntimeDyld"
        "LLVMScalarOpts"
        "LLVMSparcAsmParser"
        "LLVMSparcCodeGen"
        "LLVMSparcDesc"
        "LLVMSparcDisassembler"
        "LLVMSparcInfo"
        "LLVMSymbolize"
        "LLVMSystemZAsmParser"
        "LLVMSystemZCodeGen"
        "LLVMSystemZDesc"
        "LLVMSystemZDisassembler"
        "LLVMSystemZInfo"
        "LLVMTableGen"
        "LLVMTextAPI"
        "LLVMVectorize"
        "LLVMWebAssemblyAsmParser"
        "LLVMWebAssemblyCodeGen"
        "LLVMWebAssemblyDesc"
        "LLVMWebAssemblyDisassembler"
        "LLVMWebAssemblyInfo"
        "LLVMWindowsManifest"
        "LLVMX86AsmParser"
        "LLVMX86CodeGen"
        "LLVMX86Desc"
        "LLVMX86Disassembler"
        "LLVMX86Info"
        "LLVMX86Utils"
        "LLVMXCoreCodeGen"
        "LLVMXCoreDesc"
        "LLVMXCoreDisassembler"
        "LLVMXCoreInfo"
        "LLVMXRay"
        "LLVMSelectionDAG"
        "LLVMCodeGen"
        "LLVMBitReader"
        "LLVMBitWriter"
        "LLVMTransformUtils"
        "LLVMAnalysis"
        "LLVMTarget"
        "LLVMMC"
        "LLVMMCA"
        "LLVMCore"
        "LLVMRemarks"
        "LLVMBinaryFormat"
        "LLVMBitstreamReader"
        "LLVMSupport"
        "LLVMDemangle"
    )

if (NOT WIN32)
    target_link_libraries(Ubiquity.NET.LibLlvm PRIVATE "curses" "pthread")
endif()

if (APPLE)
    target_link_libraries(Ubiquity.NET.LibLlvm PRIVATE "z")
endif()

set(CPACK_PROJECT_NAME ${PROJECT_NAME})
set(CPACK_PROJECT_VERSION ${PROJECT_VERSION})
include(CPack)
