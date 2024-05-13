# Load the library
const libt5 = "./libt5.dylib"  # Use "path/to/libt5.so" on Linux

# Define a Julia struct corresponding to the C struct
struct T5
    a::UInt8
    b::UInt16
    c::UInt8
    d::UInt32
    e::UInt64
end

# Call the function
function display_t5()
    ccall((:display_t5, libt5), Cvoid, ())
end

# Use the function
display_t5()

println("sizeof T5 in Julia: ", sizeof(T5))

ret = ccall((:create_t5, libt5), NTuple{16,UInt8}, (Cchar, Cshort, Cchar, Cint, Clong), 0x12, 0x1234, 0x56, 0x12345678, 0x123456789ABCDEF0)

dat = Ref(T5(0,0,0,0,0))

ptrt5 = convert(Ptr{T5}, pointer_from_objref(dat))

input_ptr = convert(Ptr{NTuple{16, UInt8}}, pointer_from_objref(Ref(ret)))

Base._copyfrompacked!(ptrt5, input_ptr)

dat[]

using BenchmarkTools
@benchmark Base._copyfrompacked!(ptrt5, $input_ptr)

using AllocCheck

check_allocs(Base._copyfrompacked!, (Ptr{T5}, Ptr{NTuple{16, UInt8}}))