using MDTables
using Test
using DataFrames: DataFrame, size, names

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

    let noHeader = readMDTable("fileNoHeader.md", header=false)
        @test noHeader isa DataFrame
        @test names(noHeader) == ["x1", "x2", "x3", "x4"]
    end
end
