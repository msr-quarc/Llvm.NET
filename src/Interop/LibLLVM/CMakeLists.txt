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

target_sources(Ubiquity.NET.LibLlvm PUBLIC 
    "InlinedExports"
    "EXPORTS.g.DEF")

target_sources(Ubiquity.NET.LibLlvm PRIVATE 
    "AnalysisBindings" 
    "AttributeBindings" 
    "ContextBindings" 
    "DIBuilderBindings"
    "ObjectFileBindings"
    "IRBindings" 
    "LibLlvmOrcJitBindings"
    "MetadataBindings" 
    "PassManagerBindings" 
    "ModuleBindings" 
    "TripleBindings" 
    "ValueBindings")

if (NOT APPLE AND NOT WIN32)
    target_link_libraries(Ubiquity.NET.LibLlvm PRIVATE "-Wl,--whole-archive")
endif()

if (NOT APPLE)
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
        "LLVMAnalysis"
        "LLVMARMAsmParser"
        "LLVMARMCodeGen"
        "LLVMARMDesc"
        "LLVMARMDisassembler"
        "LLVMARMInfo"
        "LLVMARMUtils"
        "LLVMAsmParser"
        "LLVMAsmPrinter"
        "LLVMBinaryFormat"
        "LLVMBitReader"
        "LLVMBitstreamReader"
        "LLVMBitWriter"
        "LLVMBPFAsmParser"
        "LLVMBPFCodeGen"
        "LLVMBPFDesc"
        "LLVMBPFDisassembler"
        "LLVMBPFInfo"
        "LLVMCFGuard"
        "LLVMCodeGen"
        "LLVMCore"
        "LLVMCoroutines"
        "LLVMCoverage"
        "LLVMDebugInfoCodeView"
        "LLVMDebugInfoDWARF"
        "LLVMDebugInfoGSYM"
        "LLVMDebugInfoMSF"
        "LLVMDebugInfoPDB"
        "LLVMDemangle"
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
        "LLVMMC"
        "LLVMMCA"
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
        "LLVMRemarks"
        "LLVMRISCVAsmParser"
        "LLVMRISCVCodeGen"
        "LLVMRISCVDesc"
        "LLVMRISCVDisassembler"
        "LLVMRISCVInfo"
        "LLVMRISCVUtils"
        "LLVMRuntimeDyld"
        "LLVMScalarOpts"
        "LLVMSelectionDAG"
        "LLVMSparcAsmParser"
        "LLVMSparcCodeGen"
        "LLVMSparcDesc"
        "LLVMSparcDisassembler"
        "LLVMSparcInfo"
        "LLVMSupport"
        "LLVMSymbolize"
        "LLVMSystemZAsmParser"
        "LLVMSystemZCodeGen"
        "LLVMSystemZDesc"
        "LLVMSystemZDisassembler"
        "LLVMSystemZInfo"
        "LLVMTableGen"
        "LLVMTarget"
        "LLVMTextAPI"
        "LLVMTransformUtils"
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
    )
else()
    target_link_libraries(Ubiquity.NET.LibLlvm PRIVATE
        "-force_load LLVMAArch64AsmParser"
        "-force_load LLVMAArch64CodeGen"
        "-force_load LLVMAArch64Desc"
        "-force_load LLVMAArch64Disassembler"
        "-force_load LLVMAArch64Info"
        "-force_load LLVMAArch64Utils"
        "-force_load LLVMAggressiveInstCombine"
        "-force_load LLVMAMDGPUAsmParser"
        "-force_load LLVMAMDGPUCodeGen"
        "-force_load LLVMAMDGPUDesc"
        "-force_load LLVMAMDGPUDisassembler"
        "-force_load LLVMAMDGPUInfo"
        "-force_load LLVMAMDGPUUtils"
        "-force_load LLVMAnalysis"
        "-force_load LLVMARMAsmParser"
        "-force_load LLVMARMCodeGen"
        "-force_load LLVMARMDesc"
        "-force_load LLVMARMDisassembler"
        "-force_load LLVMARMInfo"
        "-force_load LLVMARMUtils"
        "-force_load LLVMAsmParser"
        "-force_load LLVMAsmPrinter"
        "-force_load LLVMBinaryFormat"
        "-force_load LLVMBitReader"
        "-force_load LLVMBitstreamReader"
        "-force_load LLVMBitWriter"
        "-force_load LLVMBPFAsmParser"
        "-force_load LLVMBPFCodeGen"
        "-force_load LLVMBPFDesc"
        "-force_load LLVMBPFDisassembler"
        "-force_load LLVMBPFInfo"
        "-force_load LLVMCFGuard"
        "-force_load LLVMCodeGen"
        "-force_load LLVMCore"
        "-force_load LLVMCoroutines"
        "-force_load LLVMCoverage"
        "-force_load LLVMDebugInfoCodeView"
        "-force_load LLVMDebugInfoDWARF"
        "-force_load LLVMDebugInfoGSYM"
        "-force_load LLVMDebugInfoMSF"
        "-force_load LLVMDebugInfoPDB"
        "-force_load LLVMDemangle"
        "-force_load LLVMDlltoolDriver"
        "-force_load LLVMDWARFLinker"
        "-force_load LLVMExecutionEngine"
        "-force_load LLVMFrontendOpenMP"
        "-force_load LLVMFuzzMutate"
        "-force_load LLVMGlobalISel"
        "-force_load LLVMHexagonAsmParser"
        "-force_load LLVMHexagonCodeGen"
        "-force_load LLVMHexagonDesc"
        "-force_load LLVMHexagonDisassembler"
        "-force_load LLVMHexagonInfo"
        "-force_load LLVMInstCombine"
        "-force_load LLVMInstrumentation"
        "-force_load LLVMInterpreter"
        "-force_load LLVMipo"
        "-force_load LLVMIRReader"
        "-force_load LLVMJITLink"
        "-force_load LLVMLanaiAsmParser"
        "-force_load LLVMLanaiCodeGen"
        "-force_load LLVMLanaiDesc"
        "-force_load LLVMLanaiDisassembler"
        "-force_load LLVMLanaiInfo"
        "-force_load LLVMLibDriver"
        "-force_load LLVMLineEditor"
        "-force_load LLVMLinker"
        "-force_load LLVMLTO"
        "-force_load LLVMMC"
        "-force_load LLVMMCA"
        "-force_load LLVMMCDisassembler"
        "-force_load LLVMMCJIT"
        "-force_load LLVMMCParser"
        "-force_load LLVMMipsAsmParser"
        "-force_load LLVMMipsCodeGen"
        "-force_load LLVMMipsDesc"
        "-force_load LLVMMipsDisassembler"
        "-force_load LLVMMipsInfo"
        "-force_load LLVMMIRParser"
        "-force_load LLVMMSP430AsmParser"
        "-force_load LLVMMSP430CodeGen"
        "-force_load LLVMMSP430Desc"
        "-force_load LLVMMSP430Disassembler"
        "-force_load LLVMMSP430Info"
        "-force_load LLVMNVPTXCodeGen"
        "-force_load LLVMNVPTXDesc"
        "-force_load LLVMNVPTXInfo"
        "-force_load LLVMObjCARCOpts"
        "-force_load LLVMObject"
        "-force_load LLVMObjectYAML"
        "-force_load LLVMOption"
        "-force_load LLVMOrcError"
        "-force_load LLVMOrcJIT"
        "-force_load LLVMPasses"
        "-force_load LLVMPowerPCAsmParser"
        "-force_load LLVMPowerPCCodeGen"
        "-force_load LLVMPowerPCDesc"
        "-force_load LLVMPowerPCDisassembler"
        "-force_load LLVMPowerPCInfo"
        "-force_load LLVMProfileData"
        "-force_load LLVMRemarks"
        "-force_load LLVMRISCVAsmParser"
        "-force_load LLVMRISCVCodeGen"
        "-force_load LLVMRISCVDesc"
        "-force_load LLVMRISCVDisassembler"
        "-force_load LLVMRISCVInfo"
        "-force_load LLVMRISCVUtils"
        "-force_load LLVMRuntimeDyld"
        "-force_load LLVMScalarOpts"
        "-force_load LLVMSelectionDAG"
        "-force_load LLVMSparcAsmParser"
        "-force_load LLVMSparcCodeGen"
        "-force_load LLVMSparcDesc"
        "-force_load LLVMSparcDisassembler"
        "-force_load LLVMSparcInfo"
        "-force_load LLVMSupport"
        "-force_load LLVMSymbolize"
        "-force_load LLVMSystemZAsmParser"
        "-force_load LLVMSystemZCodeGen"
        "-force_load LLVMSystemZDesc"
        "-force_load LLVMSystemZDisassembler"
        "-force_load LLVMSystemZInfo"
        "-force_load LLVMTableGen"
        "-force_load LLVMTarget"
        "-force_load LLVMTextAPI"
        "-force_load LLVMTransformUtils"
        "-force_load LLVMVectorize"
        "-force_load LLVMWebAssemblyAsmParser"
        "-force_load LLVMWebAssemblyCodeGen"
        "-force_load LLVMWebAssemblyDesc"
        "-force_load LLVMWebAssemblyDisassembler"
        "-force_load LLVMWebAssemblyInfo"
        "-force_load LLVMWindowsManifest"
        "-force_load LLVMX86AsmParser"
        "-force_load LLVMX86CodeGen"
        "-force_load LLVMX86Desc"
        "-force_load LLVMX86Disassembler"
        "-force_load LLVMX86Info"
        "-force_load LLVMX86Utils"
        "-force_load LLVMXCoreCodeGen"
        "-force_load LLVMXCoreDesc"
        "-force_load LLVMXCoreDisassembler"
        "-force_load LLVMXCoreInfo"
        "-force_load LLVMXRay"
    )
endif()

if (APPLE)
    target_link_libraries(Ubiquity.NET.LibLlvm PRIVATE "z")
elseif (UNIX)
    target_link_libraries(Ubiquity.NET.LibLlvm PRIVATE "-Wl,--no-whole-archive")
endif()

if (NOT WIN32)
    target_link_libraries(Ubiquity.NET.LibLlvm PRIVATE "ncurses" "pthread")
endif()


set(CPACK_PROJECT_NAME ${PROJECT_NAME})
set(CPACK_PROJECT_VERSION ${PROJECT_VERSION})
include(CPack)
