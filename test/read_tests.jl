using MDTables
using Test
using DataFrames: DataFrame, size

@testset "Read Tests" begin
    let loaded = readMDTable("file.md")
        @test loaded isa DataFrame
        @test size(loaded) == (2, 4)
    end

    let err = nothing
        try
            readMDTable("fileErr.md")
        catch err
        end

        @test err isa Exception
        @test sprint(showerror, err) == "The number of values in a line must be the same as the number of headers of the file"
    end
end