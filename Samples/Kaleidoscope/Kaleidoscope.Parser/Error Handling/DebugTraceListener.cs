﻿// -----------------------------------------------------------------------
// <copyright file="DebugTraceListener.cs" company="Ubiquity.NET Contributors">
// Copyright (c) Ubiquity.NET Contributors. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------

using System.Diagnostics;

using Antlr4.Runtime;
using Antlr4.Runtime.Tree;

using Kaleidoscope.Grammar.ANTLR;

using Ubiquity.ArgValidators;

namespace Kaleidoscope.Grammar
{
    /// <summary>Provides debug <see cref="Trace.TraceInformation(string)"/> notification of all rule processing while parsing</summary>
    internal class DebugTraceListener
        : IParseTreeListener
    {
        /// <summary>Initializes a new instance of the <see cref="DebugTraceListener"/> class.</summary>
        /// <param name="parser">Parser to use to resolve names when generating messages</param>
        public DebugTraceListener( KaleidoscopeParser parser )
        {
            Parser = parser;
        }

        /// <inheritdoc/>
        public virtual void EnterEveryRule( ParserRuleContext ctx )
        {
            ctx.ValidateNotNull( nameof( ctx ) );
            Trace.TraceInformation( $"enter[{ctx.SourceInterval}] {Parser.RuleNames[ ctx.RuleIndex ]} [{ctx.GetType( ).Name}] Lt(1)='{( ( ITokenStream )Parser.InputStream ).Lt( 1 ).Text}'" );
        }

        /// <inheritdoc/>
        public virtual void ExitEveryRule( ParserRuleContext ctx )
        {
            ctx.ValidateNotNull( nameof( ctx ) );
            Trace.TraceInformation( $"exit[{ctx.SourceInterval}] {Parser.RuleNames[ ctx.RuleIndex ]} [{ctx.GetType( ).Name}] Lt(1)='{( ( ITokenStream )Parser.InputStream ).Lt( 1 ).Text}'" );
        }

        /// <inheritdoc/>
        public virtual void VisitErrorNode( IErrorNode node )
        {
            node.ValidateNotNull( nameof( node ) );
            Trace.TraceInformation( "Error: '{0}'", node.ToStringTree( ) );
        }

        /// <inheritdoc/>
        public virtual void VisitTerminal( ITerminalNode node )
        {
            node.ValidateNotNull( nameof( node ) );
            var parserRuleContext = ( ParserRuleContext )node.Parent.RuleContext;
            IToken symbol = node.Symbol;
            Trace.TraceInformation( "Terminal: '{0}' rule {1}", symbol, Parser.RuleNames[ parserRuleContext.RuleIndex ] );
        }

        private readonly KaleidoscopeParser Parser;
    }
}
