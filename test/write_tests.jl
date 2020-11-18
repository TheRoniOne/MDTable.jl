using MDTables
using Test

@testset "Write Tests" begin
    let loaded = readMDTable("file.md")
        writeMDTable("fileTest.md", loaded)
        checking = readMDTable("fileTest.md")

        @test loaded == checking
    end

    let err = nothing
        try
            writeMDTable("fileTest.md", ("a", "b", "c"))
        catch err
        end

        @test err isa Exception
        @test sprint(showerror, err) == "ArgumentError: 'Tuple{String,String,String}' iterates 'String' values, which doesn't satisfy the Tables.jl `AbstractRow` interface"
    end
end
