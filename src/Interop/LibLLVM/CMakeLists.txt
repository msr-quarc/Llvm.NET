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
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMAArch64AsmParser.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMAArch64CodeGen.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMAArch64Desc.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMAArch64Disassembler.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMAArch64Info.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMAArch64Utils.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMAggressiveInstCombine.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMAMDGPUAsmParser.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMAMDGPUCodeGen.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMAMDGPUDesc.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMAMDGPUDisassembler.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMAMDGPUInfo.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMAMDGPUUtils.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMAnalysis.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMARMAsmParser.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMARMCodeGen.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMARMDesc.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMARMDisassembler.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMARMInfo.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMARMUtils.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMAsmParser.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMAsmPrinter.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMBinaryFormat.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMBitReader.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMBitstreamReader.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMBitWriter.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMBPFAsmParser.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMBPFCodeGen.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMBPFDesc.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMBPFDisassembler.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMBPFInfo.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMCFGuard.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMCodeGen.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMCore.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMCoroutines.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMCoverage.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMDebugInfoCodeView.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMDebugInfoDWARF.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMDebugInfoGSYM.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMDebugInfoMSF.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMDebugInfoPDB.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMDemangle.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMDlltoolDriver.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMDWARFLinker.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMExecutionEngine.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMFrontendOpenMP.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMFuzzMutate.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMGlobalISel.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMHexagonAsmParser.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMHexagonCodeGen.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMHexagonDesc.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMHexagonDisassembler.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMHexagonInfo.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMInstCombine.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMInstrumentation.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMInterpreter.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMipo.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMIRReader.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMJITLink.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMLanaiAsmParser.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMLanaiCodeGen.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMLanaiDesc.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMLanaiDisassembler.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMLanaiInfo.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMLibDriver.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMLineEditor.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMLinker.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMLTO.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMMC.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMMCA.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMMCDisassembler.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMMCJIT.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMMCParser.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMMipsAsmParser.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMMipsCodeGen.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMMipsDesc.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMMipsDisassembler.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMMipsInfo.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMMIRParser.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMMSP430AsmParser.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMMSP430CodeGen.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMMSP430Desc.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMMSP430Disassembler.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMMSP430Info.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMNVPTXCodeGen.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMNVPTXDesc.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMNVPTXInfo.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMObjCARCOpts.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMObject.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMObjectYAML.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMOption.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMOrcError.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMOrcJIT.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMPasses.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMPowerPCAsmParser.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMPowerPCCodeGen.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMPowerPCDesc.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMPowerPCDisassembler.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMPowerPCInfo.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMProfileData.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMRemarks.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMRISCVAsmParser.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMRISCVCodeGen.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMRISCVDesc.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMRISCVDisassembler.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMRISCVInfo.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMRISCVUtils.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMRuntimeDyld.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMScalarOpts.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMSelectionDAG.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMSparcAsmParser.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMSparcCodeGen.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMSparcDesc.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMSparcDisassembler.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMSparcInfo.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMSupport.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMSymbolize.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMSystemZAsmParser.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMSystemZCodeGen.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMSystemZDesc.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMSystemZDisassembler.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMSystemZInfo.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMTableGen.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMTarget.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMTextAPI.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMTransformUtils.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMVectorize.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMWebAssemblyAsmParser.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMWebAssemblyCodeGen.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMWebAssemblyDesc.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMWebAssemblyDisassembler.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMWebAssemblyInfo.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMWindowsManifest.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMX86AsmParser.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMX86CodeGen.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMX86Desc.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMX86Disassembler.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMX86Info.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMX86Utils.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMXCoreCodeGen.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMXCoreDesc.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMXCoreDisassembler.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMXCoreInfo.a"
        "-force_load $(TARGET_BUILD_DIR)/../../../llvm/lib/libLLVMXRay.a"
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
