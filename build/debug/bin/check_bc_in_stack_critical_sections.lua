local sp = GetSP()
if sp > 0x7FBE and sp < 0x7FFE then return end

local opcode = GetOpcode()
if opcode > 0x4F then return end
if opcode > 0x0E and opcode < 0x40 then return end

local opcodesToSkip = {
    [0x00] = true,
    [0x02] = true,
    [0x07] = true,
    [0x08] = true,
    [0x09] = true,
    [0x0A] = true,
}
if opcodesToSkip[opcode] then return end

if not GetINTE() then return end
if GetByteGlobal(0x38) ~= 0xC3 or GetByteGlobal(0x39) ~= 0x78 or GetByteGlobal(0x3A) ~= 0x05 then return end

print("Warning! Overrideing BC in a stack critical section")
print(string.format("PC = %04X", GetPC()))
print(string.format("Opcode = %02X", GetOpcode()))
Break()

