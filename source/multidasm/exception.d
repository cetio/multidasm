/// Exception types raised by assembler blocks during emission and finalization.
module multidasm.exception;

import std.exception : basicExceptionCtors;
import std.format : format;

/// Base type for every error raised by a Block.
class BlockException : Exception
{
    mixin basicExceptionCtors;
}

/// A branch, jump, or switch referenced a label that was never defined.
class NoSuchLabelException : BlockException
{
    /// The label that was referenced but never defined.
    string label;

    /**
     * Constructs a NoSuchLabelException.
     *
     * Params:
     *  label = The referenced label name.
     *  file = The file where the error was raised.
     *  line = The line where the error was raised.
     */
    this(string label, string file = __FILE__, size_t line = __LINE__)
    {
        super("Label not defined: "~label, file, line);
        this.label = label;
    }
}

/// A value cannot be represented in the instruction's encoding field.
class OutOfRangeException : BlockException
{
    /// The value that was supplied.
    long value;
    /// The inclusive minimum the field supports.
    long min;
    /// The inclusive maximum the field supports.
    long max;

    /**
     * Constructs an OutOfRangeException.
     *
     * Params:
     *  what = The name of the value that was out of range.
     *  value = The supplied value.
     *  min = The inclusive minimum the field supports.
     *  max = The inclusive maximum the field supports.
     *  file = The file where the error was raised.
     *  line = The line where the error was raised.
     */
    this(string what, long value, long min, long max,
        string file = __FILE__, size_t line = __LINE__)
    {
        super(format!"%s out of range: %d (field supports %d to %d)"(what, value, min, max),
            file, line);
        this.value = value;
        this.min = min;
        this.max = max;
    }
}

/// The operand combination cannot be encoded for the instruction.
class InvalidOperandException : BlockException
{
    mixin basicExceptionCtors;
}

/// The mnemonic does not name a known instruction.
class UnknownMnemonicException : BlockException
{
    /// The unrecognized mnemonic.
    string mnemonic;

    /**
     * Constructs an UnknownMnemonicException.
     *
     * Params:
     *  mnemonic = The unrecognized mnemonic.
     *  file = The file where the error was raised.
     *  line = The line where the error was raised.
     */
    this(string mnemonic, string file = __FILE__, size_t line = __LINE__)
    {
        super("Unknown mnemonic: "~mnemonic, file, line);
        this.mnemonic = mnemonic;
    }
}
