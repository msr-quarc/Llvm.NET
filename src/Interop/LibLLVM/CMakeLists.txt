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
        "-force_load libLLVMAArch64AsmParser.a"
        "-force_load libLLVMAArch64CodeGen.a"
        "-force_load libLLVMAArch64Desc.a"
        "-force_load libLLVMAArch64Disassembler.a"
        "-force_load libLLVMAArch64Info.a"
        "-force_load libLLVMAArch64Utils.a"
        "-force_load libLLVMAggressiveInstCombine.a"
        "-force_load libLLVMAMDGPUAsmParser.a"
        "-force_load libLLVMAMDGPUCodeGen.a"
        "-force_load libLLVMAMDGPUDesc.a"
        "-force_load libLLVMAMDGPUDisassembler.a"
        "-force_load libLLVMAMDGPUInfo.a"
        "-force_load libLLVMAMDGPUUtils.a"
        "-force_load libLLVMAnalysis.a"
        "-force_load libLLVMARMAsmParser.a"
        "-force_load libLLVMARMCodeGen.a"
        "-force_load libLLVMARMDesc.a"
        "-force_load libLLVMARMDisassembler.a"
        "-force_load libLLVMARMInfo.a"
        "-force_load libLLVMARMUtils.a"
        "-force_load libLLVMAsmParser.a"
        "-force_load libLLVMAsmPrinter.a"
        "-force_load libLLVMBinaryFormat.a"
        "-force_load libLLVMBitReader.a"
        "-force_load libLLVMBitstreamReader.a"
        "-force_load libLLVMBitWriter.a"
        "-force_load libLLVMBPFAsmParser.a"
        "-force_load libLLVMBPFCodeGen.a"
        "-force_load libLLVMBPFDesc.a"
        "-force_load libLLVMBPFDisassembler.a"
        "-force_load libLLVMBPFInfo.a"
        "-force_load libLLVMCFGuard.a"
        "-force_load libLLVMCodeGen.a"
        "-force_load libLLVMCore.a"
        "-force_load libLLVMCoroutines.a"
        "-force_load libLLVMCoverage.a"
        "-force_load libLLVMDebugInfoCodeView.a"
        "-force_load libLLVMDebugInfoDWARF.a"
        "-force_load libLLVMDebugInfoGSYM.a"
        "-force_load libLLVMDebugInfoMSF.a"
        "-force_load libLLVMDebugInfoPDB.a"
        "-force_load libLLVMDemangle.a"
        "-force_load libLLVMDlltoolDriver.a"
        "-force_load libLLVMDWARFLinker.a"
        "-force_load libLLVMExecutionEngine.a"
        "-force_load libLLVMFrontendOpenMP.a"
        "-force_load libLLVMFuzzMutate.a"
        "-force_load libLLVMGlobalISel.a"
        "-force_load libLLVMHexagonAsmParser.a"
        "-force_load libLLVMHexagonCodeGen.a"
        "-force_load libLLVMHexagonDesc.a"
        "-force_load libLLVMHexagonDisassembler.a"
        "-force_load libLLVMHexagonInfo.a"
        "-force_load libLLVMInstCombine.a"
        "-force_load libLLVMInstrumentation.a"
        "-force_load libLLVMInterpreter.a"
        "-force_load libLLVMipo.a"
        "-force_load libLLVMIRReader.a"
        "-force_load libLLVMJITLink.a"
        "-force_load libLLVMLanaiAsmParser.a"
        "-force_load libLLVMLanaiCodeGen.a"
        "-force_load libLLVMLanaiDesc.a"
        "-force_load libLLVMLanaiDisassembler.a"
        "-force_load libLLVMLanaiInfo.a"
        "-force_load libLLVMLibDriver.a"
        "-force_load libLLVMLineEditor.a"
        "-force_load libLLVMLinker.a"
        "-force_load libLLVMLTO.a"
        "-force_load libLLVMMC.a"
        "-force_load libLLVMMCA.a"
        "-force_load libLLVMMCDisassembler.a"
        "-force_load libLLVMMCJIT.a"
        "-force_load libLLVMMCParser.a"
        "-force_load libLLVMMipsAsmParser.a"
        "-force_load libLLVMMipsCodeGen.a"
        "-force_load libLLVMMipsDesc.a"
        "-force_load libLLVMMipsDisassembler.a"
        "-force_load libLLVMMipsInfo.a"
        "-force_load libLLVMMIRParser.a"
        "-force_load libLLVMMSP430AsmParser.a"
        "-force_load libLLVMMSP430CodeGen.a"
        "-force_load libLLVMMSP430Desc.a"
        "-force_load libLLVMMSP430Disassembler.a"
        "-force_load libLLVMMSP430Info.a"
        "-force_load libLLVMNVPTXCodeGen.a"
        "-force_load libLLVMNVPTXDesc.a"
        "-force_load libLLVMNVPTXInfo.a"
        "-force_load libLLVMObjCARCOpts.a"
        "-force_load libLLVMObject.a"
        "-force_load libLLVMObjectYAML.a"
        "-force_load libLLVMOption.a"
        "-force_load libLLVMOrcError.a"
        "-force_load libLLVMOrcJIT.a"
        "-force_load libLLVMPasses.a"
        "-force_load libLLVMPowerPCAsmParser.a"
        "-force_load libLLVMPowerPCCodeGen.a"
        "-force_load libLLVMPowerPCDesc.a"
        "-force_load libLLVMPowerPCDisassembler.a"
        "-force_load libLLVMPowerPCInfo.a"
        "-force_load libLLVMProfileData.a"
        "-force_load libLLVMRemarks.a"
        "-force_load libLLVMRISCVAsmParser.a"
        "-force_load libLLVMRISCVCodeGen.a"
        "-force_load libLLVMRISCVDesc.a"
        "-force_load libLLVMRISCVDisassembler.a"
        "-force_load libLLVMRISCVInfo.a"
        "-force_load libLLVMRISCVUtils.a"
        "-force_load libLLVMRuntimeDyld.a"
        "-force_load libLLVMScalarOpts.a"
        "-force_load libLLVMSelectionDAG.a"
        "-force_load libLLVMSparcAsmParser.a"
        "-force_load libLLVMSparcCodeGen.a"
        "-force_load libLLVMSparcDesc.a"
        "-force_load libLLVMSparcDisassembler.a"
        "-force_load libLLVMSparcInfo.a"
        "-force_load libLLVMSupport.a"
        "-force_load libLLVMSymbolize.a"
        "-force_load libLLVMSystemZAsmParser.a"
        "-force_load libLLVMSystemZCodeGen.a"
        "-force_load libLLVMSystemZDesc.a"
        "-force_load libLLVMSystemZDisassembler.a"
        "-force_load libLLVMSystemZInfo.a"
        "-force_load libLLVMTableGen.a"
        "-force_load libLLVMTarget.a"
        "-force_load libLLVMTextAPI.a"
        "-force_load libLLVMTransformUtils.a"
        "-force_load libLLVMVectorize.a"
        "-force_load libLLVMWebAssemblyAsmParser.a"
        "-force_load libLLVMWebAssemblyCodeGen.a"
        "-force_load libLLVMWebAssemblyDesc.a"
        "-force_load libLLVMWebAssemblyDisassembler.a"
        "-force_load libLLVMWebAssemblyInfo.a"
        "-force_load libLLVMWindowsManifest.a"
        "-force_load libLLVMX86AsmParser.a"
        "-force_load libLLVMX86CodeGen.a"
        "-force_load libLLVMX86Desc.a"
        "-force_load libLLVMX86Disassembler.a"
        "-force_load libLLVMX86Info.a"
        "-force_load libLLVMX86Utils.a"
        "-force_load libLLVMXCoreCodeGen.a"
        "-force_load libLLVMXCoreDesc.a"
        "-force_load libLLVMXCoreDisassembler.a"
        "-force_load libLLVMXCoreInfo.a"
        "-force_load libLLVMXRay.a"
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
