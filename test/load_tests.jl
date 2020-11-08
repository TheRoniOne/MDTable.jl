using MDTables
using Test

@testset "Load Tests" begin
    loaded = loadMDTable("file.md")
    @test loaded isa Dict
    @test length(loaded) == 4

    let err = nothing
        try
            loadMDTable("fileErr.md")
        catch err
        end

        @test err isa Exception
        @test sprint(showerror, err) == "The number of values in a line must be the same as the number of headers of the file"
    end
end