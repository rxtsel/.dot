/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20260408 (64-bit version)
 * Copyright (c) 2000 - 2026 Intel Corporation
 * 
 * Disassembling to symbolic ASL+ operators
 *
 * Disassembly of SSDT-DDNT.aml
 *
 * Original Table Header:
 *     Signature        "SSDT"
 *     Length           0x0000005B (91)
 *     Revision         0x02
 *     Checksum         0x76
 *     OEM ID           "RXTS"
 *     OEM Table ID     "DDNTFIX"
 *     OEM Revision     0x00000001 (1)
 *     Compiler ID      "INTL"
 *     Compiler Version 0x20260408 (539362312)
 */
DefinitionBlock ("", "SSDT", 2, "RXTS", "DDNTFIX", 0x00000001)
{
    External (_SB_.PC00.RP09.PEGP, DeviceObj)

    Scope (\_SB.PC00.RP09.PEGP)
    {
        Method (DDNT, 1, NotSerialized)
        {
            Return (Zero)
        }
    }
}

