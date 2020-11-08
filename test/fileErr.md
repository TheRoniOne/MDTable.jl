| Format Name | extensions | IO library | detection or magic number |
| ----------- | ---------- | ---------- | ---------- |
| JLD | .jld | loads and saves on **all** platforms with [JLD](http:///github.com/JuliaLang/JLD.jl.git)  | Julia data file (HDF5) | extra value |
| PBMBinary | .pbm | loads and saves on **all** platforms with [ImageMagick](http:///github.com/JuliaIO/ImageMagick.jl.git)  | UInt8[0x50,0x34] |