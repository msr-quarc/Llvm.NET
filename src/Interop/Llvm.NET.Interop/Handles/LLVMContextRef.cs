// ------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version: 2.17941.31104.49410
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
// ------------------------------------------------------------------------------

using System;
using System.CodeDom.Compiler;
using System.Runtime.InteropServices;
using System.Security;
using System.Threading;

namespace Llvm.NET.Interop
{
    [SecurityCritical]
    [GeneratedCode("LlvmBindingsGenerator","2.17941.31104.49410")]
    public class LLVMContextRef
        : LlvmObjectRef
    {
        public LLVMContextRef( IntPtr handle, bool owner )
            : base( owner )
        {
            SetHandle( handle );
        }

        public static LLVMContextRef Zero { get; } = new LLVMContextRef(IntPtr.Zero, false);

        [SecurityCritical]
        protected override bool ReleaseHandle( )
        {
            // ensure handle appears invalid from this point forward
            var prevHandle = Interlocked.Exchange( ref handle, IntPtr.Zero );
            SetHandleAsInvalid( );

            if( prevHandle != IntPtr.Zero )
            {
                LLVMContextDispose( handle );
            }
            return true;
        }

        private LLVMContextRef( )
            : base( true )
        {
        }

        [DllImport( NativeMethods.LibraryPath, CallingConvention = CallingConvention.Cdecl )]
        private static extern void LLVMContextDispose( IntPtr p );
    }

    [GeneratedCode("LlvmBindingsGenerator","2.17941.31104.49410")]
    public class LLVMContextRefAlias
        : LLVMContextRef
    {
        private LLVMContextRefAlias()
            : base( IntPtr.Zero, false )
        {
        }
    }
}